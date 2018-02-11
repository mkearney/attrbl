#' select attributes
#'
#' @param .x Data object containing attributes
#' @param ... Name of attributes to select
#' @return Selected attributes
#' @export
atselect <- function(.x, ...) {
  .x <- attributes(.x)
  vars <- rlang::names2(.x)
  vars <- tidyselect::vars_select(vars, ...)
  .x[vars]
}

