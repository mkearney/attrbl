as_attbl <- function(data) UseMethod("as_attbl")
as_attbl.default <- function(.x) {
  .x <- tibble::as_data_frame(.x)
  attbl(.x)
}
