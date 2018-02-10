set_class <- function(x, ..., inherit = FALSE) {
  dots <- c(...)
  if (inherit) {
    dots <- c(dots, class(x))
  }
  class(x) <- unique(dots)
  x
}
