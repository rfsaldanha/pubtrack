#' @export
read_users <- function(file) {
  readr::read_csv2(file = file)
}
