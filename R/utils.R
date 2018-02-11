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
