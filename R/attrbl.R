
#' @export
attrbl <- function(length = 0L) UseMethod("attrbl")

#' @export
attrbl.default <- function(length) {
  if (missing(length) || length %===% 0 || length %===% 1) {
    return(set_class(data.frame(), c("attrbl", "tbl_df", "data.frame")))
  }
  lapply(seq_len(length), function(x)
    set_class(data.frame(), c("attrbl", "tbl_df", "data.frame")))
}

#' @export
attrbl.data.frame <- function(.x) {
  set_class(.x, c("attrbl", "tbl_df", "data.frame"))
}

#' Convert to attrbl
#'
#' @param .x Data to be converted
#' @return An attrbl (attribute data frame)
#' @export
as_attrbl <- function(.x) UseMethod("as_attrbl")

#' @export
as_attrbl.data.frame <- function(.x) {
  .x <- tibble::as_data_frame(.x)
  attrbl(.x)
}

as_attrbl.attrbl <- function(.x) {
  .x <- tibble::as_data_frame(.x)
  attrbl(.x)
}


#' @export
as_attrbl.list <- function(.x) {
  .x <- as_attrbl(.x)
  attrbl(.x)
}
