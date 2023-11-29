test_that("millis_to_datetime converts millisecond timestamp to datetime", {
  millis_timestamp <- 1701287745000
  expected_datetime <- lubridate::ymd_hms("2023-11-29 11:55:45", tz = 'Canada/Pacific')
  converted_datetime <- millis_to_datetime(millis_timestamp, tz = 'Canada/Pacific')
  expect_equal(converted_datetime, expected_datetime)
  expect_equal(datetime_to_millis(expected_datetime), millis_timestamp)
})

test_that("tweet_url generates correct URL", {
  expect_equal(tweet_url("12345"), "https://twitter.com/twitter/status/12345")
})
