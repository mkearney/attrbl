
#' @export
attbl <- function(length = 0L) UseMethod("attbl")

#' @export
attbl.default <- function(length) {
  set_class(data.frame(), "attbl")
}

#' @export
attbl.data.frame <- function(.x) {
  set_class(.x, "attbl")
}