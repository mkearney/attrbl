atselect <- function(.x, ...) {
  .x <- attributes(.x)
  select_list(.x, ...)
}

#' @export
setMethod("atselect",
  signature(.x = "list"),
  function(.x, ...) callGeneric(.x, ...))

#' An S4 class to represent an atselect method
#' @export
setMethod("atselect",
  signature(.x = "list"),
  function(.x, ...) select_list(.x, ...)
)

select_list <- function(.x, ...) {
  vars <- rlang::names2(.x)
  vars <- tidyselect::vars_select(vars, ...)
  .x[vars]
}


