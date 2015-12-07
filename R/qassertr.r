#' @title Quick recursive arguments checks on lists and data frames
#'
#' @description
#' These functions are the tuned counterparts of \code{\link{qtest}},
#' \code{\link{qassert}} and \code{\link{qexpect}} tailored for recursive
#' checks of list elements or data frame columns.
#'
#' @param x [\code{list} or \code{data.frame}]\cr
#'   List or data frame to check for compliance with at least one of \code{rules}.
#'   See details of \code{\link{qtest}} for rule explanation.
#' @param rules [\code{character}]\cr
#'   Set of rules. See \code{\link{qtest}}
#' @param .var.name [\code{logical(1)}]\cr
#'  Argument name to print in error message. If missing,
#'  the name of \code{x} will be retrieved via \code{\link[base]{substitute}}.
#' @return See details of \code{\link{qassert}}.
#' @seealso \code{\link{qtest}}, \code{\link{qassert}}
#' @useDynLib checkmate c_qassert
#' @export
#' @examples
#' qtestr(as.list(1:10), "i+")
#' qtestr(iris, "n")
qassertr = function(x, rules, .var.name) {
  res = .Call("c_qassert", x, rules, TRUE, PACKAGE = "checkmate")
  if (!isTRUE(res))
    mstop(qamsg(x, res, vname(x, .var.name), recursive = TRUE))
  invisible(x)
}


#' @rdname qassertr
#' @useDynLib checkmate c_qtest
#' @export
qtestr = function(x, rules) {
  .Call("c_qtest", x, rules, TRUE, PACKAGE = "checkmate")
}

#' @useDynLib checkmate c_qassert
#' @template expect
#' @rdname qassertr
#' @export
qexpectr = function(x, rules, info = NULL, label = NULL) {
  res = .Call("c_qassert", x, rules, TRUE, PACKAGE = "checkmate")
  makeExpectation(res, info = info, label = vname(x, label))
}
