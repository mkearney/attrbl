
#' @export
atbl <- function(length = 0L) UseMethod("atbl")

`%===%` <- function(lhs, rhs) isTRUE(lhs == rhs)

#' @export
atbl.default <- function(length) {
  if (missing(length) || length %===% 0 || length %===% 1) {
    return(set_class(data.frame(), "atbl"))
  }
  lapply(seq_len(length), function(x) set_class(data.frame(), "atbl"))
}

#' @export
atbl.data.frame <- function(.x) {
  set_class(.x, c("atbl", "tbl_df", "data.frame"))
}
