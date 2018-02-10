# Hello, world!
#
# This is an example function named 'hello'
# which prints 'Hello, world!'.
#
# You can learn more about package authoring with RStudio at:
#
#   http://r-pkgs.had.co.nz/
#
# Some useful keyboard shortcuts for package authoring:
#
#   Build and Reload Package:  'Cmd + Shift + B'
#   Check Package:             'Cmd + Shift + E'
#   Test Package:              'Cmd + Shift + T'

#' @docType class
#' ?`@ class`
#' ?@docType

## methods for plotting track objects
tibble:::tibble


?quos

dplyr::tbl

character


as_attbl <- function(data) UseMethod("as_attbl")
as_attbl.default <- function(data) {

  tibble::as_data_frame(data)
}
data <- mtcars
attributes(mtcars)

get_att_data <- function(x) {
  atts <- attributes(data)
  dfs <- has_atts(atts) & are_df(atts)
  if (!any(dfs)) {
    return(NULL)
  }
  atts[dfs]
}
data <- mtcars
attr(data, "attdf") <- mtcars
str(as.list(list(mtcars, mtcars)), 1)
names(attributes(data))

has_atts <- function(x) {
  !names(x) %in% c("names", "row.names", "class")
}
are_df <- function(x) {
  vapply(x, is.data.frame, logical(1), USE.NAMES = FALSE)
}
library(rlang)

as.data.frame(attributes(data))
lapply(attributes(data), c)
list(attributes(data))
lapply(attributes(data), list)
as.pairlist(attributes(data))

names(attributes(mtcars))
dplyr:::select.default

attr(mtcars, "test") <- "asdf"


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

foo(mtcars, test, row.names)

select_attr(mtcars, test, row.names)
with_data(mtcars, test, row.names)

dplyr:::select_.data.frame

fn <- function(eval_fn) {
  list(
    returned_env = middle(eval_fn),
    actual_env = get_env()
  )
}

fn(mtcars)
with_data(mtcars, test, row.names)

with_data(data, list(apple, kiwi))
eval(expr, data)
eval_tidy(expr, data)

pick_atts(mtcars, row.names, test)

all_atts <- function(x) {
  atts <- tibble::lst(attributes(x))
  atts <- atts[names(atts) %in% c("row.names", "names", "class")]
}

select.attbl <- function(data, ..., atts = ) {
  atts <- quos(...)
  data <- attributes(data)
  att_nms <- names(data)
  data <- lapply(data, list)
  data <- tibble::as_tibble(data)
  dplyr::select(data, !!!atts)
}

foo <- function(...) as.character(exprs(...))
foo <- function(...) list(...)
names(foo(a = mtcars, data))

add_att <- function(data, att) {
  att <- quos(att)
  attr(data, !!att) <- att
  data
}

add_att(mtcars, mtcars)

do.call("structure", add_att(mtcars, mtcars))
add_att(mtcars, mtcars)

args <- list(x = 1:3, y = ~var)
quos(!!! args, z = 10L)

?`!!`

data.frame(add_att(mtcars, mtcars))

names(atts) <- "mtcars"
atts <- list(mtcars)

add_att(mtcars, mtcars)

names(add_att(mtcars, mtcars))
attributes()
?`attributes<-`


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

inherits(mtcars, c("tbl_df", "data.frame"))

dplyr::as.tbl
dplyr:::as.data.frame.tbl_df
dplyr:::as_regular_df

#' An S4 class to represent a bank account.
#'
#' @slot balance A length-one numeric vector
Account <- setClass("Account",
  slots = list(balance = "numeric")
)
?setMethod

#' An S4 class to represent a bank account.
#'
#' @slot balance A length-one numeric vector
Account <- setMethod("Account",
  slots = list(balance = "numeric")
)

#' An S4 class to represent a bank account.
#'
#' @slot balance A length-one numeric vector
Account <- setClass("Account",
  slots = list(balance = "numeric")
)



## There are two points of view when it comes to capturing an expression:
##
## You can capture the expressions supplied by the user of your function. This
## is the purpose of ensym(), enexpr() and enquo() and their plural variants.
## These functions take an argument name and capture the expression that was
## supplied to that argument. You can capture the expressions that you supply.
## To this end use expr() and quo() and their plural variants exprs() and
## quos().
##
## Capture raw expressions
##
## enexpr() and expr() capture a single raw expression.
##
## enexprs() and exprs() capture a list of raw expressions including expressions
## contained in ....
##
## ensym() and ensyms() are variants of enexpr() and enexprs() that check the
## captured expression is either a string (which they convert to symbol) or a
## symbol. If anything else is supplied they throw an error.
##
## In terms of base functions, enexpr(arg) corresponds to base::substitute(arg)
## (though that function has complex semantics) and expr() is like quote() (and
## bquote() if we consider unquotation syntax). The plural variant exprs() is
## equivalent to base::alist(). Finally there is no function in base R that is
## equivalent to enexprs() but you can reproduce its behaviour with
## eval(substitute(alist(...))).

d <- mtcars
attr(d, "d") <- "test"

foo <- function(.x, ...) {
  .x <- attributes(.x)
  attr <- rlang::dots_list(...)
  with_env(.x, attr)
}

listdf <- function(x) {
  as.data.frame(lapply(x, function(x) I(list(x))))
}

f <- function(data, ...) {
  var <- enquo(data)
  dots <- quos(...)
  if (length(dots) == 0L) return(list())
  x <- listdf(attributes(data))
  dflist(dplyr::select(x, !!!dots))
}

dflist <- function(x) {
  x <- lapply(x, unlist, recursive = FALSE)
  lapply(x, unclass)
}

select_atts <- function(data, ...) {
  dots <- quos(...)
  if (length(dots) == 0L) return(list())
  x <- listdf(attributes(data))
  dflist(dplyr::select(x, !!!dots))
}
set_attr <- function(.x, ...) {
  nm <- names(c(...))
  attr(.x, nm) <- list(...)
  .x
}
set_attr(mtcars, y = 10)

set_attrs <- function(.x, ...) {
  dots <- list(...)
  dots <- dots[names(dots) != ""]
  nm <- names(dots)
  atts <- dots
  for (i in seq_along(atts)) {
    attr(.x, nm[[i]]) <- atts[[i]]
  }
  .x
}
select.attbl <- function(data, ...) {
  atts <- attributes(data)
  vars <- quos(...)
  x <- dplyr::select(tibble::as_tibble(unclass(data)), !!!vars)
  set_attrs(x, atts)
}

select(d, cyl)

x <- f(d, d, row.names)
str(x)
x
