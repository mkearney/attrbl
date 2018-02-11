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
  tibble::as_data_frame(lapply(x, function(x) list(x)), validate = FALSE)
}


#' @importFrom magrittr %>%
#' @export
magrittr::`%>%`

#' as tibble shorthand
#' @importFrom tibble as_tibble
#' @export
as_tbl <- function(x) {
  tibble::as_tibble(x, validate = FALSE)
}

