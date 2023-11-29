test_that("cnd_url generates correct URLs", {
  # Test case 1: Valid inputs without date
  url1 <- cnd_url(2023, 1, 15, "notes", 0)
  expect_equal(url1, "https://ton.twimg.com/birdwatch-public-data/2023/01/15/notes/notes-00000.tsv")

  # Test case 2: Valid inputs with date
  url2 <- cnd_url(dataset = "ratings", number = 1, date = as.Date("2023-02-20"))
  expect_equal(url2, "https://ton.twimg.com/birdwatch-public-data/2023/02/20/noteRatings/ratings-00001.tsv")
})

# Mock functions
cnd_url <- function(year, month, day, dataset, number) {
  return(paste("https://example.com/dataset", year, month, day, dataset, number, sep = "/"))
}

fetch <- function(url, write_to, verbose, overwrite) {
  # Simulate a successful download
  cat("Simulated download content", file = write_to)
  # Return a mock response object
  return(httr::response(status_code = 200))
}

# Test cases
test_that("download_dataset downloads and handles datasets correctly", {
  # mock fetch
  mock_fetch <- function(url, write_to, verbose, overwrite) {
    cat("Simulated download content", file = write_to)
    if (url %in% c(
      "https://ton.twimg.com/birdwatch-public-data/2023/01/15/notes/notes-00000.tsv",
      "https://ton.twimg.com/birdwatch-public-data/2023/01/15/noteRatings/ratings-00000.tsv",
      "https://ton.twimg.com/birdwatch-public-data/2023/01/15/noteRatings/ratings-00001.tsv",
      "https://ton.twimg.com/birdwatch-public-data/2023/01/15/noteRatings/ratings-00002.tsv"
    )) {
      return(200L)
    } else {
      return(400L)
    }
  }

  local_mocked_bindings(fetch = mock_fetch)

  temp_dir <- tempdir()

  # Test case 1: Download a dataset without incrementing
  response1 <- download_dataset(2023, 1, 15, "notes", download_to = temp_dir, verbose = FALSE)
  expect_true(file.exists(file.path(temp_dir, "2023-01-15-notes-00000.tsv")))

  # Test case 2: Download a dataset incrementally (simulate 3 attempts)
  response2 <- download_dataset(2023, 1, 15, "ratings", increment = TRUE, download_to = temp_dir, verbose = FALSE)
  expect_true(file.exists(file.path(temp_dir, "2023-01-15-ratings-00000.tsv")))
  expect_true(file.exists(file.path(temp_dir, "2023-01-15-ratings-00001.tsv")))
  expect_true(file.exists(file.path(temp_dir, "2023-01-15-ratings-00002.tsv")))
})
