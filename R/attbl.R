

attbl <- function(length = 0L) UseMethod("attbl")

attbl.default <- function(length) {
  set_class(data.frame(), "attbl")
}
