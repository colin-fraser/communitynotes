#' Convert millisecond timestamp to datetime
#' @export
millis_to_datetime <- function(x, tz = 'UTC') {
  lubridate::as_datetime(x / 1000, tz = tz)
}

#' Convert datetime to millisecond timestamp
#' @export
datetime_to_millis <- function(x) {
  as.integer(x) * 1000
}

#' Convert a Twitter Snowflake ID to the associated create date
#' @export
id_to_datetime <- function(x, tz = 'UTC') {
  lubridate::as_datetime((as.numeric(x) / 2 ^ 22 + 1288834974657) / 1000, tz = tz)
}

#' Generate a URL for a tweetId
#' @export
tweet_url <- function(x) {
  paste0("https://twitter.com/twitter/status/", x)
}

#' Go to a Tweet in your browser
#' @export
go_to_tweet <- function(x) {
  stopifnot(length(x) == 1)
  browseURL(tweet_url(x))
}

#' Read the notes file
#' @export
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

#' Read the ratings file
#' @export
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
       userEnrollment = read_user_enrollment_file)
}

#' Read any community notes data file
#' @export
read_community_notes_file <- function(filename) {
  filetype <- stringr::str_extract(filename, "notes|noteStatusHistory|ratings|userEnrollment")
  choose_reader(filetype)(filename)
}

#' Read all the community notes data set files of a certain type out of a directory, concatenating
#' multiple files together
#' @export
read_and_concat <- function(directory, filetype = c('notes',  'ratings', 'noteStatusHistory', 'userEnrollment'),
                            warn_for_filesize = 1e9) {
  filetype <- match.arg(filetype)
  files <- fs::dir_ls(directory, regexp = filetype)
  if (warn_for_filesize < Inf) {
    filesize <- sum(fs::file_size(files))
    if (filesize > warn_for_filesize) {
      n <- length(files)
      stopifnot("User cancel" = usethis::ui_yeah("The {n} files in '{directory}' matching {filetype} take up {filesize}, which might be more data than you want to load into memory at once. Do you want to continue? (Suppress this message in the future by setting warn_for_filesize = Inf)",
                       shuffle = FALSE, n_no = 1))
    }
  }
  read_func <- switch(filetype,
                      notes = read_notes_file,
                      ratings = read_ratings_file,
                      noteStatusHistory = read_note_status_history_file,
                      userEnrollment = read_user_enrollment_file)
  purrr::map(files, read_func) |>
    purrr::list_rbind(names_to = 'file')
}

#' Automatically format community notes data set files using preset transformations
#'
#' Adds columns for tweet create dates, tweet URLs, and datetime columns for all 'Millis' columns
#'
#' @export
auto_format <- function(x, tz = NULL) {
  x |>
    dplyr::mutate(
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
