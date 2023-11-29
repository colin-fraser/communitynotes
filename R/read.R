#' Convert between millisecond timestamp and datetime
#'
#'
#' @rdname millis-datetime-conversion
#'
#'
#' @param x For `millis_to_datetime`, the millisecond timestamp to convert.
#'          For `datetime_to_millis`, the datetime object to convert.
#' @param tz The time zone to apply to the resulting datetime.
#'           Relevant only for `millis_to_datetime`.
#'
#' @return For `millis_to_datetime`, a datetime object.
#'         For `datetime_to_millis`, a millisecond timestamp.
#'
#' @examples
#' millis_to_datetime(1609459200000) # Converts to datetime
#' datetime_to_millis(as.POSIXct("2021-01-01 UTC")) # Converts to millis
#' 1609459200000 == datetime_to_millis(millis_to_datetime(1609459200000)) # TRUE
#'
#' @export millis_to_datetime
#' @export datetime_to_millis
millis_to_datetime <- function(x, tz = NULL) {
  lubridate::as_datetime(x / 1000, tz = tz)
}

datetime_to_millis <- function(x) {
  as.integer(x) * 1000
}

#' Convert a Twitter Snowflake ID to the associated creation date
#'
#' This function converts a Twitter Snowflake ID to the datetime of its creation.
#'
#' @param x The Twitter Snowflake ID to convert.
#' @param tz The time zone to apply to the resulting datetime.
#'
#' @return A datetime object representing the creation time of the Twitter Snowflake ID.
#'
#' @export
id_to_datetime <- function(x, tz = NULL) {
  lubridate::as_datetime((as.numeric(x) / 2^22 + 1288834974657) / 1000, tz = tz)
}

#' Generate a URL for a tweetId
#'
#' Note that this won't be the direct URL for the tweet, but it will provide a URL that
#' you can follow to get to the tweet. This is more of a convenience function for investigation
#' rather than a canonical URL for the tweet.
#'
#' @param x tweetId
#' @export
tweet_url <- function(x) {
  paste0("https://twitter.com/twitter/status/", x)
}

#' Go to a Tweet in your browser
#'
#' Opens a tweet in your browser
#'
#' @param x a tweetId
#' @export
go_to_tweet <- function(x) {
  stopifnot(length(x) == 1)
  browseURL(tweet_url(x))
}

#' Read community notes datasets
#'
#' Reads and correctly formats the data files. You probably just want to use read_comunity_notes_file.
#'
#' @param filename the filename of the file to read
#' @param filetype either 'detect' to automatically detect, or one of 'notes', 'ratings', 'userEnrollment'
#'   or 'noteStatusHistory'
#'
#' @import readr
#'
#' @export read_community_notes_file
#' @export read_note_status_history_file
#' @export read_user_enrollment_file
#' @export read_notes_file
#' @export read_ratings_file
read_notes_file <- function(filename) {
  readr::read_tsv(
    filename,
    col_types = cols(
      noteId = col_character(),
      noteAuthorParticipantId = col_character(),
      createdAtMillis = col_number(),
      tweetId = col_character(),
      classification = col_character(),
      believable = col_character(),
      harmful = col_character(),
      validationDifficulty = col_character(),
      misleadingOther = col_double(),
      misleadingFactualError = col_double(),
      misleadingManipulatedMedia = col_double(),
      misleadingOutdatedInformation = col_double(),
      misleadingMissingImportantContext = col_double(),
      misleadingUnverifiedClaimAsFact = col_double(),
      misleadingSatire = col_double(),
      notMisleadingOther = col_double(),
      notMisleadingFactuallyCorrect = col_double(),
      notMisleadingOutdatedButNotWhenWritten = col_double(),
      notMisleadingClearlySatire = col_double(),
      notMisleadingPersonalOpinion = col_double(),
      trustworthySources = col_double(),
      summary = col_character(),
      isMediaNote = col_double()
    )
  )
}

read_ratings_file <- function(filename) {
  readr::read_tsv(
    filename,
    col_types = cols(
      noteId = col_character(),
      raterParticipantId = col_character(),
      createdAtMillis = col_double(),
      version = col_double(),
      agree = col_double(),
      disagree = col_double(),
      helpful = col_double(),
      notHelpful = col_double(),
      helpfulnessLevel = col_character(),
      helpfulOther = col_double(),
      helpfulInformative = col_double(),
      helpfulClear = col_double(),
      helpfulEmpathetic = col_double(),
      helpfulGoodSources = col_double(),
      helpfulUniqueContext = col_double(),
      helpfulAddressesClaim = col_double(),
      helpfulImportantContext = col_double(),
      helpfulUnbiasedLanguage = col_double(),
      notHelpfulOther = col_double(),
      notHelpfulIncorrect = col_double(),
      notHelpfulSourcesMissingOrUnreliable = col_double(),
      notHelpfulOpinionSpeculationOrBias = col_double(),
      notHelpfulMissingKeyPoints = col_double(),
      notHelpfulOutdated = col_double(),
      notHelpfulHardToUnderstand = col_double(),
      notHelpfulArgumentativeOrBiased = col_double(),
      notHelpfulOffTopic = col_double(),
      notHelpfulSpamHarassmentOrAbuse = col_double(),
      notHelpfulIrrelevantSources = col_double(),
      notHelpfulOpinionSpeculation = col_double(),
      notHelpfulNoteNotNeeded = col_double(),
      ratedOnTweetId = col_character()
    )
  )
}

#' Read the note status history file
#' @export
read_note_status_history_file <- function(filename) {
  readr::read_tsv(
    filename,
    col_types = cols(
      noteId = col_character(),
      noteAuthorParticipantId = col_character(),
      createdAtMillis = col_double(),
      timestampMillisOfFirstNonNMRStatus = col_double(),
      firstNonNMRStatus = col_character(),
      timestampMillisOfCurrentStatus = col_double(),
      currentStatus = col_character(),
      timestampMillisOfLatestNonNMRStatus = col_double(),
      mostRecentNonNMRStatus = col_character(),
      timestampMillisOfStatusLock = col_double(),
      lockedStatus = col_character(),
      timestampMillisOfRetroLock = col_double(),
      currentCoreStatus = col_character(),
      currentExpansionStatus = col_character(),
      currentGroupStatus = col_character(),
      currentDecidedBy = col_character(),
      currentModelingGroup = col_double()
    )
  )
}

#' Read the user enrollment file
#' @export
read_user_enrollment_file <- function(filename) {
  readr::read_tsv(
    filename,
    col_types = cols(
      participantId = col_character(),
      enrollmentState = col_character(),
      successfulRatingNeededToEarnIn = col_double(),
      timestampOfLastStateChange = col_double(),
      timestampOfLastEarnOut = col_double(),
      modelingPopulation = col_character(),
      modelingGroup = col_double()
    )
  )
}

choose_reader <- function(filetype) {
  switch(filetype,
    notes = read_notes_file,
    ratings = read_ratings_file,
    noteStatusHistory = read_note_status_history_file,
    userEnrollment = read_user_enrollment_file
  )
}

#' Read any community notes data file
#' @export
read_community_notes_file <- function(filename, filetype = c('detect', 'notes', 'ratings', 'noteStatusHistory', 'userEnrollment')) {
  filetype <- match.arg(filetype)
  if (filetype == 'detect') {
    filetype <- stringr::str_extract(filename, "notes|noteStatusHistory|ratings|userEnrollment")
  }
  choose_reader(filetype)(filename)
}

#' Read and Concatenate Community Notes Data Files
#'
#' Reads all community notes data set files of a specified type from a directory,
#' concatenating multiple files into a single data frame. You'll be warned if the resulting
#' file will be quite large. To disable the warning, set warn_for_filesize = Inf.
#'
#' @param directory The directory from which to read the files.
#' @param filetype Type of the files to read, one of "notes", "ratings", "noteStatusHistory", "userEnrollment".
#' @param warn_for_filesize Threshold file size in bytes for warning the user.
#'                          Defaults to 1e9 (1 GB). Set to Inf to disable warning.
#'
#' @return A data frame with all data from the specified file type concatenated.
#'
#' @export
read_and_concat <- function(directory, filetype = c("notes", "ratings", "noteStatusHistory", "userEnrollment"),
                            warn_for_filesize = 1e9) {
  filetype <- match.arg(filetype)
  files <- fs::dir_ls(directory, regexp = filetype)
  if (warn_for_filesize < Inf) {
    filesize <- sum(fs::file_size(files))
    if (filesize > warn_for_filesize) {
      n <- length(files)
      stopifnot("User cancel" = usethis::ui_yeah("The {n} files in '{directory}' matching {filetype} take up {filesize}, which might be more data than you want to load into memory at once. Do you want to continue? (Suppress this message in the future by setting warn_for_filesize = Inf)",
        shuffle = FALSE, n_no = 1
      ))
    }
  }
  read_func <- choose_reader(filetype)
  purrr::map(files, read_func) |>
    purrr::list_rbind(names_to = "file")
}

#' Automatically Format Community Notes Data Set Files
#'
#' Automatically formats community notes data set files with preset transformations.
#' This function adds columns for tweet creation dates, tweet URLs, and datetime columns for all 'Millis' columns.
#'
#' @param x The data frame to be formatted.
#' @param tz The time zone to apply to the datetime conversions.
#'
#' @return A formatted data frame with additional columns.
#'
#' @export
#' @import dplyr
auto_format <- function(x, tz = NULL) {
  x |>
    mutate(
      across(
        contains("tweetId"),
        list(
          "create_datetime" = \(y) id_to_datetime(y, tz),
          "url" = tweet_url
        ),
        .names = "{stringr::str_remove(.col, 'Id')}_{.fn}"
      ),
      across(
        contains("Millis"),
        list("datetime" = \(y) millis_to_datetime(y, tz)),
        .names = "{stringr::str_remove(.col, 'Millis')}_{.fn}"
      )
    )
}
