fetch_publications <- function(users) {
  publications <- tibble::tibble()

  for (i in 1:nrow(users)) {
    id <- users[[i, 1]]
    name <- users[[i, 2]]
    tmp <- scholar::get_publications(id = id)
    tmp$id <- id
    tmp$name <- name

    publications <- dplyr::bind_rows(publications, tmp)
  }

  return(publications)
}
