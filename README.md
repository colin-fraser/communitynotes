
<!-- README.md is generated from README.Rmd. Please edit that file -->

# communitynotes

<!-- badges: start -->
<!-- badges: end -->

Simple package for working with the public Community Notes datsaets.

## Installation

You can install the development version of communitynotes from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("colin-fraser/communitynotes")
```

## Downloading the datasets

Simple functions for downloading the datasets. The easiest thing is to
just use `download_all_data`. This will automatically save all the
latest datasets to a directory.

``` r
library(communitynotes)
dir <- tempdir()
download_all_data(date = Sys.Date(), download_to = dir)
#> Attempting to download from URL:
#> https://ton.twimg.com/birdwatch-public-data/2023/12/10/notes/notes-00000.tsv
#> Success. Saved to:
#> /var/folders/5n/lpqd3xbs5kxb09wmyd2t8k740000gn/T/RtmprMgMbN/2023-12-10-notes-00000.tsv
#> Attempting the next number...
#> Attempting to download from URL:
#> https://ton.twimg.com/birdwatch-public-data/2023/12/10/notes/notes-00001.tsv
#> No dataset at https://ton.twimg.com/birdwatch-public-data/2023/12/10/notes/notes-00001.tsv. This probably means you've downloaded all the notes datasets for today.
#> Attempting to download from URL:
#> https://ton.twimg.com/birdwatch-public-data/2023/12/10/noteRatings/ratings-00000.tsv
#> Success. Saved to:
#> /var/folders/5n/lpqd3xbs5kxb09wmyd2t8k740000gn/T/RtmprMgMbN/2023-12-10-ratings-00000.tsv
#> Attempting the next number...
#> Attempting to download from URL:
#> https://ton.twimg.com/birdwatch-public-data/2023/12/10/noteRatings/ratings-00001.tsv
#> Success. Saved to:
#> /var/folders/5n/lpqd3xbs5kxb09wmyd2t8k740000gn/T/RtmprMgMbN/2023-12-10-ratings-00001.tsv
#> Attempting the next number...
#> Attempting to download from URL:
#> https://ton.twimg.com/birdwatch-public-data/2023/12/10/noteRatings/ratings-00002.tsv
#> Success. Saved to:
#> /var/folders/5n/lpqd3xbs5kxb09wmyd2t8k740000gn/T/RtmprMgMbN/2023-12-10-ratings-00002.tsv
#> Attempting the next number...
#> Attempting to download from URL:
#> https://ton.twimg.com/birdwatch-public-data/2023/12/10/noteRatings/ratings-00003.tsv
#> Success. Saved to:
#> /var/folders/5n/lpqd3xbs5kxb09wmyd2t8k740000gn/T/RtmprMgMbN/2023-12-10-ratings-00003.tsv
#> Attempting the next number...
#> Attempting to download from URL:
#> https://ton.twimg.com/birdwatch-public-data/2023/12/10/noteRatings/ratings-00004.tsv
#> No dataset at https://ton.twimg.com/birdwatch-public-data/2023/12/10/noteRatings/ratings-00004.tsv. This probably means you've downloaded all the ratings datasets for today.
#> Attempting to download from URL:
#> https://ton.twimg.com/birdwatch-public-data/2023/12/10/noteStatusHistory/noteStatusHistory-00000.tsv
#> Success. Saved to:
#> /var/folders/5n/lpqd3xbs5kxb09wmyd2t8k740000gn/T/RtmprMgMbN/2023-12-10-noteStatusHistory-00000.tsv
#> Attempting the next number...
#> Attempting to download from URL:
#> https://ton.twimg.com/birdwatch-public-data/2023/12/10/noteStatusHistory/noteStatusHistory-00001.tsv
#> No dataset at https://ton.twimg.com/birdwatch-public-data/2023/12/10/noteStatusHistory/noteStatusHistory-00001.tsv. This probably means you've downloaded all the noteStatusHistory datasets for today.
#> Attempting to download from URL:
#> https://ton.twimg.com/birdwatch-public-data/2023/12/10/userEnrollment/userEnrollment-00000.tsv
#> Success. Saved to:
#> /var/folders/5n/lpqd3xbs5kxb09wmyd2t8k740000gn/T/RtmprMgMbN/2023-12-10-userEnrollment-00000.tsv
#> Attempting the next number...
#> Attempting to download from URL:
#> https://ton.twimg.com/birdwatch-public-data/2023/12/10/userEnrollment/userEnrollment-00001.tsv
#> No dataset at https://ton.twimg.com/birdwatch-public-data/2023/12/10/userEnrollment/userEnrollment-00001.tsv. This probably means you've downloaded all the userEnrollment datasets for today.
```

## Working with the datasets

The datasets are saved as `.tsv` files, so you can easily just work with
them directly like any other file. However, the package has some helpers
for working with these datasets more effectively.

If you read a file with `read_community_notes_file` it will
automatically choose good column types, for example leaving IDs as
character columns.

``` r
library(dplyr)
#> 
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union
notes <- read_community_notes_file(paste(dir, "2023-12-10-notes-00000.tsv", sep = '/'))
glimpse(notes)
#> Rows: 389,214
#> Columns: 23
#> $ noteId                                 <chr> "1537142913737428992", "1537145…
#> $ noteAuthorParticipantId                <chr> "5684B38EB58FD8BE75ABA37F0BE040…
#> $ createdAtMillis                        <dbl> 1.655318e+12, 1.655319e+12, 1.6…
#> $ tweetId                                <chr> "1377030478167937024", "1536848…
#> $ classification                         <chr> "MISINFORMED_OR_POTENTIALLY_MIS…
#> $ believable                             <chr> "BELIEVABLE_BY_MANY", NA, "BELI…
#> $ harmful                                <chr> "CONSIDERABLE_HARM", NA, "LITTL…
#> $ validationDifficulty                   <chr> "EASY", NA, "EASY", "EASY", "EA…
#> $ misleadingOther                        <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0…
#> $ misleadingFactualError                 <dbl> 1, 0, 0, 1, 1, 0, 0, 0, 1, 0, 0…
#> $ misleadingManipulatedMedia             <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0…
#> $ misleadingOutdatedInformation          <dbl> 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0…
#> $ misleadingMissingImportantContext      <dbl> 1, 0, 1, 1, 1, 0, 0, 0, 0, 1, 1…
#> $ misleadingUnverifiedClaimAsFact        <dbl> 1, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0…
#> $ misleadingSatire                       <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1…
#> $ notMisleadingOther                     <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0…
#> $ notMisleadingFactuallyCorrect          <dbl> 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0…
#> $ notMisleadingOutdatedButNotWhenWritten <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0…
#> $ notMisleadingClearlySatire             <dbl> 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0…
#> $ notMisleadingPersonalOpinion           <dbl> 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0…
#> $ trustworthySources                     <dbl> 1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 0…
#> $ summary                                <chr> "Forbes has a good rundown of t…
#> $ isMediaNote                            <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0…
```

The Community Notes datasets have dates formatted as milliseconds since
the epoch; there’s a function for reading these.

``` r
notes |> 
  transmute(createdAtMillis, createdAt_datetime = millis_to_datetime(createdAtMillis))
#> # A tibble: 389,214 × 2
#>    createdAtMillis createdAt_datetime 
#>              <dbl> <dttm>             
#>  1   1655318404027 2022-06-15 11:40:04
#>  2   1655318986910 2022-06-15 11:49:46
#>  3   1655319460217 2022-06-15 11:57:40
#>  4   1655333070821 2022-06-15 15:44:30
#>  5   1656100269455 2022-06-24 12:51:09
#>  6   1667150391800 2022-10-30 10:19:51
#>  7   1670082213627 2022-12-03 07:43:33
#>  8   1680031214479 2023-03-28 12:20:14
#>  9   1668583052022 2022-11-15 23:17:32
#> 10   1654838151541 2022-06-09 22:15:51
#> # ℹ 389,204 more rows
```

There’s also a function implementing a little-known trick for extracting
create dates from `tweetId`s.

``` r
notes |> 
  transmute(tweetId, tweet_created_at = id_to_datetime(tweetId))
#> # A tibble: 389,214 × 2
#>    tweetId             tweet_created_at   
#>    <chr>               <dttm>             
#>  1 1377030478167937024 2021-03-30 15:50:24
#>  2 1536848327979016193 2022-06-14 16:09:29
#>  3 1537080831751102467 2022-06-15 07:33:22
#>  4 1537196168953974784 2022-06-15 15:11:41
#>  5 1540087463099736065 2022-06-23 14:40:39
#>  6 1586411168880807936 2022-10-29 10:34:31
#>  7 1598827733072560129 2022-12-02 15:53:31
#>  8 1640773789679230977 2023-03-28 10:52:10
#>  9 1592776673891581952 2022-11-15 23:08:46
#> 10 1535062308426510337 2022-06-09 17:52:29
#> # ℹ 389,204 more rows
```

If you apply `auto_format` to a Community Notes dataset, it will
automatically apply these mutations to the relevant columns. It will
also provide a handy tweet URL which, while not the canonical tweet URL,
will lead you to the correct tweet due to some funky server logic that
Twitter does for tweet ID URLs.

``` r
notes |> 
  auto_format() |> 
  select(noteId, tweetId, createdAt_datetime, tweet_create_datetime, tweet_url)
#> # A tibble: 389,214 × 5
#>    noteId            tweetId createdAt_datetime  tweet_create_datetime tweet_url
#>    <chr>             <chr>   <dttm>              <dttm>                <chr>    
#>  1 1537142913737428… 137703… 2022-06-15 11:40:04 2021-03-30 15:50:24   https://…
#>  2 1537145358521839… 153684… 2022-06-15 11:49:46 2022-06-14 16:09:29   https://…
#>  3 1537147343715282… 153708… 2022-06-15 11:57:40 2022-06-15 07:33:22   https://…
#>  4 1537204430730211… 153719… 2022-06-15 15:44:30 2022-06-15 15:11:41   https://…
#>  5 1540422295029551… 154008… 2022-06-24 12:51:09 2022-06-23 14:40:39   https://…
#>  6 1586769867381669… 158641… 2022-10-30 10:19:51 2022-10-29 10:34:31   https://…
#>  7 1599066819402162… 159882… 2022-12-03 07:43:33 2022-12-02 15:53:31   https://…
#>  8 1640795953472114… 164077… 2023-03-28 12:20:14 2023-03-28 10:52:10   https://…
#>  9 1592778879885709… 159277… 2022-11-15 23:17:32 2022-11-15 23:08:46   https://…
#> 10 1535128588818653… 153506… 2022-06-09 22:15:51 2022-06-09 17:52:29   https://…
#> # ℹ 389,204 more rows
```

## Working with the huge ratings dataset

In the last few months the Community Notes data has started to get quite
large. The ratings file now comes in chunks. There is a function for
reading these chunks and concatenating them into a single data frame. As
of this writing, these take up over 3 gigabytes, so you may want to be
careful using this.

``` r
ratings <- read_and_concat(dir, "ratings", warn_for_filesize = Inf) # `warn_for_filesize = Inf` disables a check that would prevent the user from loading an enormous file into memory.
```

As an alternative to loading this enormous data frame into memory, there
is (currently experimental) support for loading it into a duckdb
database.

``` r
duck_db_connection <- build_cn_db(dir)
#> Building table:
#> • notes
#> Reading files
#> /var/folders/5n/lpqd3xbs5kxb09wmyd2t8k740000gn/T/RtmprMgMbN/2023-12-10-notes-00000.tsv
#> Building table:
#> • ratings
#> Reading files
#> /var/folders/5n/lpqd3xbs5kxb09wmyd2t8k740000gn/T/RtmprMgMbN/2023-12-10-ratings-00000.tsv
#> /var/folders/5n/lpqd3xbs5kxb09wmyd2t8k740000gn/T/RtmprMgMbN/2023-12-10-ratings-00001.tsv
#> /var/folders/5n/lpqd3xbs5kxb09wmyd2t8k740000gn/T/RtmprMgMbN/2023-12-10-ratings-00002.tsv
#> /var/folders/5n/lpqd3xbs5kxb09wmyd2t8k740000gn/T/RtmprMgMbN/2023-12-10-ratings-00003.tsv
#> Building table:
#> • noteStatusHistory
#> Reading files
#> /var/folders/5n/lpqd3xbs5kxb09wmyd2t8k740000gn/T/RtmprMgMbN/2023-12-10-noteStatusHistory-00000.tsv
#> Building table:
#> • userEnrollment
#> Reading files
#> /var/folders/5n/lpqd3xbs5kxb09wmyd2t8k740000gn/T/RtmprMgMbN/2023-12-10-userEnrollment-00000.tsv
```

As an example, here’s how to use this to find the 20 notes which
received the most ratings on 2023-12-07 and its associated tweet.

``` r
library(DBI)
top_notes <- dbGetQuery(duck_db_connection, 
"select 
noteId,  
tweetId, 
notes.createdAtMillis,
summary,
count(*) as ratings
from notes inner join ratings
using(noteId)
where notes.createdAtMillis between 1701907200000 and 1701993600000
group by 1, 2, 3, 4
order by ratings desc
limit 20
"
)
top_notes |> 
  mutate(across(c(noteId, tweetId), format, digits = 20)) |> 
  auto_format() |> 
  gt::gt()
#> Warning: There was 1 warning in `mutate()`.
#> ℹ In argument: `across(c(noteId, tweetId), format, digits = 20)`.
#> Caused by warning:
#> ! The `...` argument of `across()` is deprecated as of dplyr 1.1.0.
#> Supply arguments directly to `.fns` through an anonymous function instead.
#> 
#>   # Previously
#>   across(a:b, mean, na.rm = TRUE)
#> 
#>   # Now
#>   across(a:b, \(x) mean(x, na.rm = TRUE))
```

<div id="bkrrrnvhrb" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    &#10;    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="noteId">noteId</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="tweetId">tweetId</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="createdAtMillis">createdAtMillis</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="summary">summary</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="ratings">ratings</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="tweet_create_datetime">tweet_create_datetime</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="tweet_url">tweet_url</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="createdAt_datetime">createdAt_datetime</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="noteId" class="gt_row gt_right">1732574552226456064</td>
<td headers="tweetId" class="gt_row gt_right">1732549608230863104</td>
<td headers="createdAtMillis" class="gt_row gt_right">1.701913e+12</td>
<td headers="summary" class="gt_row gt_left">President Magill’s statement is a lie.  University of Pennsylvania practices viewpoint discrimination as a matter of policy.  While faculty, staff and students are free to call for a genocide of Jewish people (https://x.com/HouseGOP/status/1732064188980146642?s=20), a professor is being fired for expressing her views (https://x.com/aaronsibarium/status/1721629218641961237?s=20).  </td>
<td headers="ratings" class="gt_row gt_center">1111</td>
<td headers="tweet_create_datetime" class="gt_row gt_right">2023-12-06 15:56:30</td>
<td headers="tweet_url" class="gt_row gt_left">https://twitter.com/twitter/status/1732549608230863104</td>
<td headers="createdAt_datetime" class="gt_row gt_right">2023-12-06 17:35:37</td></tr>
    <tr><td headers="noteId" class="gt_row gt_right">1732569384407757056</td>
<td headers="tweetId" class="gt_row gt_right">1732457928496496896</td>
<td headers="createdAtMillis" class="gt_row gt_right">1.701912e+12</td>
<td headers="summary" class="gt_row gt_left">Mr Guterres mentions the 'Occupied Palestinian Territories' as if Israel did not unilaterally withdraw from Gaza in 2005.    As anyone can read on Wikipedia, this is how the UN and 'humanitarian' organisations roll: Israel is the occupier, even if it does not occupy.    https://en.m.wikipedia.org/wiki/Israeli_disengagement_from_Gaza</td>
<td headers="ratings" class="gt_row gt_center">1026</td>
<td headers="tweet_create_datetime" class="gt_row gt_right">2023-12-06 09:52:12</td>
<td headers="tweet_url" class="gt_row gt_left">https://twitter.com/twitter/status/1732457928496496896</td>
<td headers="createdAt_datetime" class="gt_row gt_right">2023-12-06 17:15:05</td></tr>
    <tr><td headers="noteId" class="gt_row gt_right">1732572426863628544</td>
<td headers="tweetId" class="gt_row gt_right">1732549608230863104</td>
<td headers="createdAtMillis" class="gt_row gt_right">1.701912e+12</td>
<td headers="summary" class="gt_row gt_left">While under oath in congress Liz Magill answered differently by avoiding a direct answer.      Which can be seen here: https://x.com/greenblattjd/status/1732203623994573059?s=46&amp;amp;t=VyhpwyWSIsrJxaJfbSDdeA    &amp;amp; here: https://m.youtube.com/watch?v=oklC-xpSOWc</td>
<td headers="ratings" class="gt_row gt_center">1018</td>
<td headers="tweet_create_datetime" class="gt_row gt_right">2023-12-06 15:56:30</td>
<td headers="tweet_url" class="gt_row gt_left">https://twitter.com/twitter/status/1732549608230863104</td>
<td headers="createdAt_datetime" class="gt_row gt_right">2023-12-06 17:27:10</td></tr>
    <tr><td headers="noteId" class="gt_row gt_right">1732570847267725824</td>
<td headers="tweetId" class="gt_row gt_right">1732549608230863104</td>
<td headers="createdAtMillis" class="gt_row gt_right">1.701912e+12</td>
<td headers="summary" class="gt_row gt_left">At a Congressional hearing yesterday, Liz Magill refused to say if calling for Jewish genocide is against the university code of conduct.  https://www.nytimes.com/2023/12/06/us/donors-and-alumni-demand-that-penns-president-resign-over-remarks-at-hearing.html</td>
<td headers="ratings" class="gt_row gt_center">882</td>
<td headers="tweet_create_datetime" class="gt_row gt_right">2023-12-06 15:56:30</td>
<td headers="tweet_url" class="gt_row gt_left">https://twitter.com/twitter/status/1732549608230863104</td>
<td headers="createdAt_datetime" class="gt_row gt_right">2023-12-06 17:20:54</td></tr>
    <tr><td headers="noteId" class="gt_row gt_right">1732782810916930048</td>
<td headers="tweetId" class="gt_row gt_right">1732775764980797952</td>
<td headers="createdAtMillis" class="gt_row gt_right">1.701963e+12</td>
<td headers="summary" class="gt_row gt_left">Correct name of Disney CEO is Bob Iger    Source: https://en.m.wikipedia.org/wiki/Bob_Iger</td>
<td headers="ratings" class="gt_row gt_center">844</td>
<td headers="tweet_create_datetime" class="gt_row gt_right">2023-12-07 06:55:10</td>
<td headers="tweet_url" class="gt_row gt_left">https://twitter.com/twitter/status/1732775764980797952</td>
<td headers="createdAt_datetime" class="gt_row gt_right">2023-12-07 07:23:10</td></tr>
    <tr><td headers="noteId" class="gt_row gt_right">1732793712911298816</td>
<td headers="tweetId" class="gt_row gt_right">1732758781769941248</td>
<td headers="createdAtMillis" class="gt_row gt_right">1.701965e+12</td>
<td headers="summary" class="gt_row gt_left">This picture is from Beit Lahia Northern Gaza, not Khan Yunis. These mens are civilians who were kidnapped from UNRWA shelter. There is no evidence that these mens were terrorists. Also there is Gazan Journalist, Diaa Al-Kahlot was detained in the scene.     https://twitter.com/OnlinePalEng/status/1732784462356787567?t=l9X_TL7U9MIsHFlGZ1NbkQ&amp;amp;s=19    https://twitter.com/RamAbdu/status/1732757512355455438?t=7jXZzm3mpVkitCYAySXBkw&amp;amp;s=19    https://twitter.com/NaksBilal/status/1732771098159112246?t=U9fb9bGT9mOuAOap96svbw&amp;amp;s=19    https://twitter.com/MuathHamed/status/1732773171420426523?t=ZY7ucSlFOdGW1yk8VzGwCQ&amp;amp;s=19</td>
<td headers="ratings" class="gt_row gt_center">787</td>
<td headers="tweet_create_datetime" class="gt_row gt_right">2023-12-07 05:47:41</td>
<td headers="tweet_url" class="gt_row gt_left">https://twitter.com/twitter/status/1732758781769941248</td>
<td headers="createdAt_datetime" class="gt_row gt_right">2023-12-07 08:06:29</td></tr>
    <tr><td headers="noteId" class="gt_row gt_right">1732570038622736896</td>
<td headers="tweetId" class="gt_row gt_right">1597273816929296384</td>
<td headers="createdAtMillis" class="gt_row gt_right">1.701912e+12</td>
<td headers="summary" class="gt_row gt_left">This image uses forced perspective to misrepresent the size of the centipede. The centipede was held on a piece of string in front of the camera to mimic the solider holding it.    The species, Scolopendra subspinipes, can grow to about 8 inches in length.    https://www.snopes.com/fact-check/giant-jungle-centipede-real/</td>
<td headers="ratings" class="gt_row gt_center">760</td>
<td headers="tweet_create_datetime" class="gt_row gt_right">2022-11-28 08:58:48</td>
<td headers="tweet_url" class="gt_row gt_left">https://twitter.com/twitter/status/1597273816929296384</td>
<td headers="createdAt_datetime" class="gt_row gt_right">2023-12-06 17:17:41</td></tr>
    <tr><td headers="noteId" class="gt_row gt_right">1732810823653834752</td>
<td headers="tweetId" class="gt_row gt_right">1732766981164585472</td>
<td headers="createdAtMillis" class="gt_row gt_right">1.701969e+12</td>
<td headers="summary" class="gt_row gt_left">Those are not civilians but Hamas fighters who surrendered to the IDF.    https://nypost.com/2023/12/07/news/dozens-of-hamas-terrorists-surrender-to-israeli-soldiers/  https://bnn.network/breaking-news/war/unprecedented-surrender-hamas-militants-capitulate-to-idf-amidst-intensified-conflict/  https://www.haaretz.com/israel-news/2023-12-07/ty-article-live/under-u-s-pressure-israeli-cabinet-approves-more-fuel-for-gaza/0000018c-4281-db23-ad9f-6ad9e0600000</td>
<td headers="ratings" class="gt_row gt_center">757</td>
<td headers="tweet_create_datetime" class="gt_row gt_right">2023-12-07 06:20:16</td>
<td headers="tweet_url" class="gt_row gt_left">https://twitter.com/twitter/status/1732766981164585472</td>
<td headers="createdAt_datetime" class="gt_row gt_right">2023-12-07 09:14:29</td></tr>
    <tr><td headers="noteId" class="gt_row gt_right">1732787763764658688</td>
<td headers="tweetId" class="gt_row gt_right">1732770845997650432</td>
<td headers="createdAtMillis" class="gt_row gt_right">1.701964e+12</td>
<td headers="summary" class="gt_row gt_left">The photo shows Hamas fighters that surrendered to IDF.  https://www.haaretz.com/israel-news/2023-12-07/ty-article-live/under-u-s-pressure-israeli-cabinet-approves-more-fuel-for-gaza/0000018c-4281-db23-ad9f-6ad9e0600000</td>
<td headers="ratings" class="gt_row gt_center">756</td>
<td headers="tweet_create_datetime" class="gt_row gt_right">2023-12-07 06:35:37</td>
<td headers="tweet_url" class="gt_row gt_left">https://twitter.com/twitter/status/1732770845997650432</td>
<td headers="createdAt_datetime" class="gt_row gt_right">2023-12-07 07:42:51</td></tr>
    <tr><td headers="noteId" class="gt_row gt_right">1732744960170938624</td>
<td headers="tweetId" class="gt_row gt_right">1732718945063280896</td>
<td headers="createdAtMillis" class="gt_row gt_right">1.701954e+12</td>
<td headers="summary" class="gt_row gt_left">According to the Supreme Court, &amp;quot;Courts are the final arbiter between the citizen and the state, and are therefore a fundamental pillar of the constitution&amp;quot;, thus to enact a law that cannot be challenged by a court would be unconstitutional.    https://www.supremecourt.uk/about/significance-to-the-uk.html</td>
<td headers="ratings" class="gt_row gt_center">734</td>
<td headers="tweet_create_datetime" class="gt_row gt_right">2023-12-07 03:09:23</td>
<td headers="tweet_url" class="gt_row gt_left">https://twitter.com/twitter/status/1732718945063280896</td>
<td headers="createdAt_datetime" class="gt_row gt_right">2023-12-07 04:52:46</td></tr>
    <tr><td headers="noteId" class="gt_row gt_right">1732792578733416704</td>
<td headers="tweetId" class="gt_row gt_right">1732784355368444160</td>
<td headers="createdAtMillis" class="gt_row gt_right">1.701965e+12</td>
<td headers="summary" class="gt_row gt_left">The photo doesn’t prove that those are from Hamas members no official details and information was given to this claim   Those are gazans civilians in the north of Gaza that what other pages tell .   https://www.instagram.com/reel/C0jiiQJNSjc/?igshid=MzRlODBiNWFlZA==  https://www.instagram.com/reel/C0jgh2lO7Bc/?igshid=MzRlODBiNWFlZA==</td>
<td headers="ratings" class="gt_row gt_center">718</td>
<td headers="tweet_create_datetime" class="gt_row gt_right">2023-12-07 07:29:18</td>
<td headers="tweet_url" class="gt_row gt_left">https://twitter.com/twitter/status/1732784355368444160</td>
<td headers="createdAt_datetime" class="gt_row gt_right">2023-12-07 08:01:59</td></tr>
    <tr><td headers="noteId" class="gt_row gt_right">1732806539738816768</td>
<td headers="tweetId" class="gt_row gt_right">1732766194136977664</td>
<td headers="createdAtMillis" class="gt_row gt_right">1.701968e+12</td>
<td headers="summary" class="gt_row gt_left">This picture is from Beit Lahia Northern Gaza, not Khan Yunis. These mens are civilians who were kidnapped from UNRWA shelter. There is no evidence that these mens were terrorists. Also there is Gazan Journalist, Diaa Al-Kahlot was detained in the scene.     https://twitter.com/OnlinePalEng/status/1732784462356787567?t=l9X_TL7U9MIsHFlGZ1NbkQ&amp;amp;s=19    https://twitter.com/RamAbdu/status/1732757512355455438?t=7jXZzm3mpVkitCYAySXBkw&amp;amp;s=19    https://twitter.com/NaksBilal/status/1732771098159112246?t=U9fb9bGT9mOuAOap96svbw&amp;amp;s=19    https://twitter.com/MuathHamed/status/1732773171420426523?t=ZY7ucSlFOdGW1yk8VzGwCQ&amp;amp;s=19</td>
<td headers="ratings" class="gt_row gt_center">686</td>
<td headers="tweet_create_datetime" class="gt_row gt_right">2023-12-07 06:17:08</td>
<td headers="tweet_url" class="gt_row gt_left">https://twitter.com/twitter/status/1732766194136977664</td>
<td headers="createdAt_datetime" class="gt_row gt_right">2023-12-07 08:57:27</td></tr>
    <tr><td headers="noteId" class="gt_row gt_right">1732697404871148032</td>
<td headers="tweetId" class="gt_row gt_right">1732457928496496896</td>
<td headers="createdAtMillis" class="gt_row gt_right">1.701942e+12</td>
<td headers="summary" class="gt_row gt_left">This Secretary General didn’t invoke article 99 for Yemen, Syria, Ukraine, Afghanistan, Sudan, Mali, Ethiopia, Venezuela etc.    https://www.cambridge.org/core/books/abs/justice-in-international-law/origins-and-development-of-article-99-of-the-charter/362898EEAAD51D5AACED0AF23A04790B#:~:text=Article%2099%20of%20the%20Charter%20of%20the%20United%20Nations%2C%20which,the%20United%20Nations%20as%20endowing</td>
<td headers="ratings" class="gt_row gt_center">660</td>
<td headers="tweet_create_datetime" class="gt_row gt_right">2023-12-06 09:52:12</td>
<td headers="tweet_url" class="gt_row gt_left">https://twitter.com/twitter/status/1732457928496496896</td>
<td headers="createdAt_datetime" class="gt_row gt_right">2023-12-07 01:43:47</td></tr>
    <tr><td headers="noteId" class="gt_row gt_right">1732801275450855680</td>
<td headers="tweetId" class="gt_row gt_right">1732754037949264128</td>
<td headers="createdAtMillis" class="gt_row gt_right">1.701967e+12</td>
<td headers="summary" class="gt_row gt_left">This was filmed in Beit Lahia: https://twitter.com/NaksBilal/status/1732771098159112246?t=-FMXmakWQPdq5Mi_lzVrww&amp;amp;s=19    Additionally, the claim that these men are members of Hamas has not been verified at the time of this post. The Times of Israel describes these men as &amp;quot;Gaza men&amp;quot;, &amp;quot;may be Hamas suspects&amp;quot;.    https://www.timesofisrael.com/liveblog_entry/footage-purports-to-show-dozens-of-gazans-after-they-surrendered-to-idf/  </td>
<td headers="ratings" class="gt_row gt_center">660</td>
<td headers="tweet_create_datetime" class="gt_row gt_right">2023-12-07 05:28:50</td>
<td headers="tweet_url" class="gt_row gt_left">https://twitter.com/twitter/status/1732754037949264128</td>
<td headers="createdAt_datetime" class="gt_row gt_right">2023-12-07 08:36:32</td></tr>
    <tr><td headers="noteId" class="gt_row gt_right">1732777047095718400</td>
<td headers="tweetId" class="gt_row gt_right">1732754037949264128</td>
<td headers="createdAtMillis" class="gt_row gt_right">1.701961e+12</td>
<td headers="summary" class="gt_row gt_left">It's a picture of unknown people, and there is no evidence that they are from Hamas or that they were captured in combat conditions. The operation is just psychological warfare and nothing more, with the aim of showing that Hamas has lost control.    https://twitter.com/NaksBilal/status/1732771098159112246?t=rKpG5nwosOOqzvAk5tbkGQ&amp;amp;s=19</td>
<td headers="ratings" class="gt_row gt_center">658</td>
<td headers="tweet_create_datetime" class="gt_row gt_right">2023-12-07 05:28:50</td>
<td headers="tweet_url" class="gt_row gt_left">https://twitter.com/twitter/status/1732754037949264128</td>
<td headers="createdAt_datetime" class="gt_row gt_right">2023-12-07 07:00:16</td></tr>
    <tr><td headers="noteId" class="gt_row gt_right">1732790076218765824</td>
<td headers="tweetId" class="gt_row gt_right">1732766194136977664</td>
<td headers="createdAtMillis" class="gt_row gt_right">1.701964e+12</td>
<td headers="summary" class="gt_row gt_left">This was filmed in Beit Lahia, not Khan Younis: https://twitter.com/NaksBilal/status/1732771098159112246?t=-FMXmakWQPdq5Mi_lzVrww&amp;amp;s=19    Additionally, the claim that these men are members of Hamas has not been verified at the time of this post. The Times of Israel describes these men as &amp;quot;Gaza men&amp;quot;, &amp;quot;may be Hamas suspects&amp;quot;.    https://www.timesofisrael.com/liveblog_entry/footage-purports-to-show-dozens-of-gazans-after-they-surrendered-to-idf/</td>
<td headers="ratings" class="gt_row gt_center">656</td>
<td headers="tweet_create_datetime" class="gt_row gt_right">2023-12-07 06:17:08</td>
<td headers="tweet_url" class="gt_row gt_left">https://twitter.com/twitter/status/1732766194136977664</td>
<td headers="createdAt_datetime" class="gt_row gt_right">2023-12-07 07:52:02</td></tr>
    <tr><td headers="noteId" class="gt_row gt_right">1732573827018748160</td>
<td headers="tweetId" class="gt_row gt_right">1732549608230863104</td>
<td headers="createdAtMillis" class="gt_row gt_right">1.701913e+12</td>
<td headers="summary" class="gt_row gt_left">NNN    The individual in the video is clearly mentioning “I should have focused” to note their speech should have focused on the genocide, and subsequently would have different answer. </td>
<td headers="ratings" class="gt_row gt_center">652</td>
<td headers="tweet_create_datetime" class="gt_row gt_right">2023-12-06 15:56:30</td>
<td headers="tweet_url" class="gt_row gt_left">https://twitter.com/twitter/status/1732549608230863104</td>
<td headers="createdAt_datetime" class="gt_row gt_right">2023-12-06 17:32:44</td></tr>
    <tr><td headers="noteId" class="gt_row gt_right">1732822354764410880</td>
<td headers="tweetId" class="gt_row gt_right">1732781753448727040</td>
<td headers="createdAtMillis" class="gt_row gt_right">1.701972e+12</td>
<td headers="summary" class="gt_row gt_left">This is in fact the attitude of Conservatives towards everyone else.    http://www.conservatives.com/</td>
<td headers="ratings" class="gt_row gt_center">614</td>
<td headers="tweet_create_datetime" class="gt_row gt_right">2023-12-07 07:18:58</td>
<td headers="tweet_url" class="gt_row gt_left">https://twitter.com/twitter/status/1732781753448727040</td>
<td headers="createdAt_datetime" class="gt_row gt_right">2023-12-07 10:00:18</td></tr>
    <tr><td headers="noteId" class="gt_row gt_right">1732814266116247552</td>
<td headers="tweetId" class="gt_row gt_right">1732781753448727040</td>
<td headers="createdAtMillis" class="gt_row gt_right">1.701970e+12</td>
<td headers="summary" class="gt_row gt_left">This post isn't satire, it is from a political party, as such it should aim to be factually accurate. This post is not accurate.  Labour have already set out a plan for the boat crossings, including the establishment of a new police force just to give an example.  https://www.reuters.com/world/uk/no-more-gimmicks-uk-labours-starmer-sets-out-plans-illegal-migration-2023-09-14/</td>
<td headers="ratings" class="gt_row gt_center">603</td>
<td headers="tweet_create_datetime" class="gt_row gt_right">2023-12-07 07:18:58</td>
<td headers="tweet_url" class="gt_row gt_left">https://twitter.com/twitter/status/1732781753448727040</td>
<td headers="createdAt_datetime" class="gt_row gt_right">2023-12-07 09:28:09</td></tr>
    <tr><td headers="noteId" class="gt_row gt_right">1732799285266198528</td>
<td headers="tweetId" class="gt_row gt_right">1732781753448727040</td>
<td headers="createdAtMillis" class="gt_row gt_right">1.701967e+12</td>
<td headers="summary" class="gt_row gt_left">Maryam Moshiri is not a Labour politician, she is a BBC reporter who was interacting with studio staff and was unaware this was being broadcast. It has no political meaning whatsoever.    https://www.standard.co.uk/news/london/bbc-news-anchor-maryam-moshiri-gives-finger-live-on-air-b1125355.html</td>
<td headers="ratings" class="gt_row gt_center">592</td>
<td headers="tweet_create_datetime" class="gt_row gt_right">2023-12-07 07:18:58</td>
<td headers="tweet_url" class="gt_row gt_left">https://twitter.com/twitter/status/1732781753448727040</td>
<td headers="createdAt_datetime" class="gt_row gt_right">2023-12-07 08:28:38</td></tr>
  </tbody>
  &#10;  
</table>
</div>
