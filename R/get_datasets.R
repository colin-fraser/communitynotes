DATASETS <- c("notes", "ratings", "noteStatusHistory", "userEnrollment")

#' Generate the URL to download a Community Notes data set
#' @export
cnd_url <- function(year, month, day, dataset, number, date = NULL) {
  if (!is.null(date)) {
    year <- lubridate::year(date)
    month <- lubridate::month(date)
    day <- lubridate::day(date)
  }
  filename <- filename(dataset, number)
  if (dataset == "ratings") dataset <- "noteRatings"
  paste("https://ton.twimg.com/birdwatch-public-data",
    year,
    format_month_or_day(month),
    format_month_or_day(day),
    dataset,
    filename,
    sep = "/"
  )
}

#' Get the URL for the Community Notes download page
#' @export
download_page_url <- function() {
  "https://twitter.com/i/communitynotes/download-data"
}

#' Open the Commmunity Notes download page in your browser
#' @export
go_to_download_page <- function() {
  browseURL(download_page_url())
}

#' Find the latest data set
#' @export
latest_data <- function(dataset =c("notes", "ratings", "noteStatusHistory", "userEnrollment"), start_search = Sys.Date() + 2) {
  dataset <- match.arg(dataset)
  start_search <- as.Date(start_search)

  max_iter <- 10
  iterations <- 0
  status <- httr::http_error(cnd_url(dataset = dataset, number = 0, date = start_search))
  if (!status) {
    rlang::warn(glue::glue("Found on first iteration using date {start_search}. You might want to set `start_search` further date in the future just to be sure."))
    return(start_search)
  }

  date <- start_search - 1
  while (status && iterations < max_iter) {
    status <- httr::http_error(cnd_url(dataset = dataset, number = 0, date = date))
    if (!status) {
      return(date)
    }
    date <- date - 1
    iterations <- iterations + 1
  }
  rlang::abort(stringr::str_glue("No latest data found after {max_iter} tries."))
}

filename <- function(dataset, number) {
  paste0(dataset, "-", format_file_number(number), ".tsv")
}

dir_name <- function(year, month, day) {
  paste(year, format_month_or_day(month), format_month_or_day(day), sep = "-")
}

zeropad <- function(s, n) {
  stringr::str_pad(s, n, pad = "0")
}

format_file_number <- function(n) {
  zeropad(n, 5)
}

format_month_or_day <- function(n) {
  zeropad(n, 2)
}

filename_template <- function(year, month, day, dataset, number = 0) {
  paste(year, format_month_or_day(month), format_month_or_day(day), dataset, format_file_number(number),
    sep = "-"
  )
}

fetch <- function(url, write_to, verbose, overwrite) {
  if (verbose) {
    rlang::inform("Attempting to download from URL:", body = url)
  }
  resp <- httr::GET(url, httr::write_disk(write_to, overwrite))
  if (!httr::http_error(resp) && verbose) {
    rlang::inform("Success. Saved to:", body = write_to)
  } else if (httr::http_error(resp)) {
    fs::file_delete(write_to)
  }
  resp
}

#' Download a community notes dataset
#' @export
download_dataset <- function(year,
                             month,
                             day,
                             dataset = c("notes", "ratings", "noteStatusHistory", "userEnrollment"),
                             number = 0,
                             download_to = NULL,
                             increment = FALSE,
                             overwrite = FALSE,
                             verbose = TRUE,
                             is_increment = FALSE) {
  dataset <- match.arg(dataset, DATASETS)
  download_to <- (download_to %||% dir_name(year, month, day)) |>
    fs::dir_create()
  url <- cnd_url(year, month, day, dataset, number)
  write_to <- fs::path(download_to, filename_template(year, month, day, dataset, number), ext = "tsv")
  resp <- fetch(url, write_to, verbose, overwrite)
  if (!is_increment) {
    httr::stop_for_status(resp)
  } else {
    if (httr::http_error(resp) && verbose) {
      message(paste0("No dataset at ", url, ". This probably means you've downloaded all the datasets."))
      return(invisible(resp))
    }
  }
  if (increment) {
    if (verbose) rlang::inform("Attempting the next number...")
    download_dataset(year, month, day, dataset, number + 1, download_to, increment, overwrite, verbose, is_increment = TRUE)
  }
  invisible(resp)
}

#' Download all datasets for a given date
#' @export
download_all_data <- function(date = Sys.Date(), download_to = NULL, verbose = TRUE, overwrite = FALSE) {
  for (dataset in DATASETS) {
    download_dataset(lubridate::year(date),
                     lubridate::month(date),
                     lubridate::day(date),
                     dataset,
                     download_to = download_to,
                     verbose = verbose,
                     overwrite = overwrite,
                     increment = TRUE)
  }
}