
#' @export
do_call_rbind <- function(...) UseMethod("do_call_rbind")

#' @export
do_call_rbind.default <- function(...) {
  dots <- c(...)
  is_ats <- vapply(dots, inherits, "atbl", FUN.VALUE = logical(1))
  if (sum(is_ats) > 0L) {
    ats <- get_all_ats(dots)
    ats <- do.call("c", ats)
    ats_names <- unique(names(ats))
    ats <- lapply(ats_names, function(i) rcbind(ats[names(ats) == i]))
    names(ats) <- ats_names
    dots <- lapply(dots, as_tbl)
    .x <- dplyr::bind_rows(dots)
    add_ats(.x, ats)
  } else {
    dplyr::bind_rows(dots)
  }
}


uq_row_names <- function(.x) !identical(.x, as.character(1:length(.x)))

get_all_ats_ <- function(.x) {
  ats <- attributes(.x)
  if (uq_row_names(.x)) {
    ats <- ats[!names(ats) %in% c("class", "names")]
  } else if (any(!names(ats) %in% c("names", "class", "row.names"))) {
    ats <- ats[!names(ats) %in% c("class", "names", "row.names")]
  } else {
    ats <- NULL
  }
  ats
}

unlist_bind <- function(x) {
  x <- unlist(x, recursive = FALSE)
  if (is.list(x)) {
    x <- dplyr::bind_rows(x)
  }
  x
}


get_all_ats <- function(.x) lapply(.x, get_all_ats_)




rcbind <- function(x) UseMethod("rcbind")

rcbind.default <- function(x) x

rcbind.list <- function(x) {
  isdf <- vapply(x, is.data.frame, FUN.VALUE = logical(1), USE.NAMES = FALSE)
  if (all(isdf)) {
    dplyr::bind_rows(x)
  } else {
    unlist(x, recursive = FALSE, use.names = FALSE)
  }
}
