notify <- function(publications, ntfy_topic = "icict_new_publications") {
  for (i in 1:nrow(publications)) {
    title <- publications[[i, 1]]
    author <- publications[[i, 2]]
    journal <- publications[[i, 3]]
    year <- publications[[i, 5]]
    researcher <- publications[[i, 10]]

    ntfy::ntfy_send(
      message = glue::glue(
        stringi::stri_escape_unicode(
          "O pesquisador {researcher} tem uma nova publica\\u00e7\\u00e3o!! T\\u00edtulo: '{title}', Autores: '{author}', Peri\\u00f3dico: '{journal}', Ano: '{year}'"
        )
      ),
      tags = ntfy::tags$partying_face,
      topic = ntfy_topic
    )
  }
}
