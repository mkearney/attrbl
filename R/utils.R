#' @importFrom magrittr %>%
#' @export
magrittr::`%>%`

#' @importFrom tibble as_tibble
as_tbl <- function(x) {
  tibble::as_tibble(x, validate = FALSE)
}


`%===%` <- function(lhs, rhs) isTRUE(lhs == rhs)

set_class <- function(x, ..., inherit = FALSE) {
  dots <- c(...)
  if (inherit) {
    dots <- c(dots, class(x))
  }
  class(x) <- unique(dots)
  x
}

listdf <- function(x) {
  tibble::as_data_frame(lapply(x, list), validate = FALSE)
}
