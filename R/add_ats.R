
#' Add attributes to data object
#'
#' @param .x Data object on which to add attributes.
#' @param ... Named elements to be attached to .x as attributes.
#' @export
add_ats <- function(.x, ...) {
  ats <- list(...)
  if (length(ats) == 1L && !is.null(names(ats[[1]]))) {
    ats <- ats[[1]]
  }
  if (is.null(names(ats))) {
    stop("attributes must be named")
  }
  atnames <- names(ats)
  for (i in seq_along(ats)) {
    attr(.x, atnames[i]) <- ats[[i]]
  }
  atbl(.x)
}
