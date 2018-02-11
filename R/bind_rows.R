
#' @export
bind_rows <- function(...) UseMethod("bind_rows")

#' @export
bind_rows.default <- function(...) {
  dots <- list(...)
  is_ats <- vapply(dots, inherits, "atbl", FUN.VALUE = logical(1))
  if (sum(is_ats) > 0L) {
    ats <- get_all_ats(dots)
    ats <- lapply(ats, listdf)
    ats <- lapply(as_tbl(do.call("rbind", ats)), unlist, recursive = FALSE)
    dots <- lapply(dots, as_tbl)
    .x <- dplyr::bind_rows(dots)
    add_ats(.x, ats)
  } else {
    dplyr::bind_rows(dots)
  }
}


uq_row_names <- function(.x) !identical(.x, as.character(1:length(.x)))

get_all_ats_ <- function(.x) {
  .x <- as_tbl(.x)
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


get_all_ats <- function(.x) lapply(.x, get_all_ats_)

