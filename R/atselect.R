

#' @importFrom magrittr %>%
#' @export
magrittr::`%>%`


#' @export
select_list <- function(.x, ...) {
  vars <- rlang::names2(.x)
  vars <- tidyselect::vars_select(vars, ...)
  .x[vars]
}

#' as tibble shorthand
#' @export
as_tbl <- function(x) {
  tibble::as_tibble(x, validate = FALSE)
}

#' convert list to single row data frame
listdf <- function(x) {
  as_tbl(lapply(x, function(x) list(x)))
}

#' unnest list
unnest_list <- function(x) {
  lapply(x, unlist, recursive = FALSE)
}


get_att_data <- function(x) {
  atts <- attributes(data)
  dfs <- has_atts(atts) & are_df(atts)
  if (!any(dfs)) {
    return(NULL)
  }
  atts[dfs]
}

has_atts <- function(x) {
  !names(x) %in% c("names", "row.names", "class")
}

are_df <- function(x) {
  vapply(x, is.data.frame, logical(1), USE.NAMES = FALSE)
}


with_data <- function(data, ...) {
  data[as.character(exprs(...))]
}

select_attr <- function(data, ...) {
  with_data(attributes(data), ...)
}

foo <- function(data, ...) {
  vars <- quote(list(...))
  eval(vars, data)
}



all_atts <- function(x) {
  atts <- tibble::lst(attributes(x))
  atts <- atts[names(atts) %in% c("row.names", "names", "class")]
}

select.attbl <- function(data, ...) {
  atts <- quos(...)
  data <- attributes(data)
  att_nms <- names(data)
  data <- lapply(data, list)
  data <- tibble::as_tibble(data)
  dplyr::select(data, !!!atts)
}

add_att <- function(data, att) {
  att <- quos(att)
  attr(data, !!att) <- att
  data
}



att_df <- function(data) {
  atts <- get_att_data(data)
  if (!inherits(data, "tbl_df")) {
    data <- tibble::as_tibble(data, validate = FALSE)
  }
  if (!is.null(atts)) {
    atts <- lapply(atts, tibble::as_tibble, validate = FALSE)

  }
  atts <- attributes(data)
  if (length(atts) == 0L) {
    return(NULL)
  }
  atts <- atts[!names(atts) %in% c("names", "row.names", "class")]
  if (length(atts) == 0L) {
    return(NULL)
  }

}


#' An S4 class to represent a tbl with attribute(s)
#'
#' @slot att A list of attributes not contained in data frame.
#attbl <- setClass("attbl",
#  slots = list(att = "list"),
#  contains = "data.frame"
#)

atselect <- function(.x, ...) {
  .x <- attributes(x)
  select_list(.x, ...)
}

setMethod("atselect", signature(.x = "list"),
  function(.x, ...) callGeneric(.x, ...))

#' An S4 class to represent an atselect method
#'
#' @slot balance A length-one numeric vector
setMethod("atselect",
  signature(.x = "list"),
  function(.x, ...) select_list(.x, ...)
)

