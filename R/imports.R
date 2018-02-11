#' @importFrom magrittr %>%
#' @export
magrittr::`%>%`

#' as tibble shorthand
#' @importFrom tibble as_tibble
#' @export
as_tbl <- function(x) {
  tibble::as_tibble(x, validate = FALSE)
}

