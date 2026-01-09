test_that("update_database works", {
  users <- read_users()

  publications <- fetch_publications(users = users)

  temp_database <- tempfile()

  res <- update_database(publications = publications, database = temp_database)

  # Simulate a new publication
  new_pub <- tibble::tibble(
    title = "Aaa",
    author = "Aaa",
    journal = "AAA",
    number = "Aaaa",
    cites = 123,
    year = 2025,
    cid = "aaaa",
    pubid = "aaaa-aaaa-aaaa",
    id = "aaaa",
    name = "aaaa"
  )

  publications <- dplyr::bind_rows(publications, new_pub)

  res <- update_database(publications = publications, database = temp_database)

  unlink(temp_database)

  expect_true(any(class(res) %in% c("data.frame", "tibble")))
})
