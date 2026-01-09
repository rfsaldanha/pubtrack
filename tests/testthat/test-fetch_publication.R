test_that("fetch_publication works", {
  users <- read_users()
  res <- fetch_publications(users)

  expect_true(any(class(res) %in% c("data.frame", "tibble")))
})
