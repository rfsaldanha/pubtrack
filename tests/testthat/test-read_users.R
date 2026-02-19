test_that("read_user works", {
  res <- read_users()

  expect_true(any(class(res) %in% c("data.frame", "tibble")))
})
