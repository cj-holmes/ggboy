#' Bayer Matrix
#'
#' Returns a Bayer matrix of side length 2^n. Not exported, not intended for use by the user.
#' @param n matrix size (square matrix of side length 2^n)
#' @details My code related to ordered dithering is based on my own web research, using mainly these two articles
#'   \itemize{
#'     \item https://gist.github.com/MehdiNS/bd41bbc6db780c9409157d35d331ac80
#'     \item http://www.sumsar.net/blog/2019/01/image-dithering-in-r/
#'     }
#'   It might not be exactly right from a 'purist' point of view - but it seems to give the effect I am looking
#'   for in this application - based purely on visual aesthetics
#' @return A matrix
bayer <- function(n){

  if(n <= 0) return(matrix(0))

  m <- bayer(n-1)

  rbind(
    cbind(4 * m + 0, 4 * m + 2),
    cbind(4 * m + 3, 4 * m + 1))
}


#' Normalize a bayer matrix
#'
#' Not exported. Not intended for use by the user.
#'
#' @param m A matrix returned from \code{bayer()}
#' @details My code related to ordered dithering is based on my own web research, using mainly these two articles
#'   \itemize{
#'     \item https://gist.github.com/MehdiNS/bd41bbc6db780c9409157d35d331ac80
#'     \item http://www.sumsar.net/blog/2019/01/image-dithering-in-r/
#'     }
#'   It might not be exactly right from a 'purist' point of view - but it seems to give the effect I am looking
#'   for in this application - based purely on visual aesthetics
#'
#' @return A normalised Bayer matrix
norm_bayer <- function(m) (m/length(m))-0.5


#' Repeat a Bayer matrix to fill rows and columns
#'
#' Not exported. Not intended for use by the user.
#'
#' @param mat Bayer matrix
#' @param nrow_out Number of rows
#' @param ncol_out NUmber of columns
#' @details My code related to ordered dithering is based on my own web research, using mainly these two articles
#'   \itemize{
#'     \item https://gist.github.com/MehdiNS/bd41bbc6db780c9409157d35d331ac80
#'     \item http://www.sumsar.net/blog/2019/01/image-dithering-in-r/
#'     }
#'   It might not be exactly right from a 'purist' point of view - but it seems to give the effect I am looking
#'   for in this application - based purely on visual aesthetics
rep_mat <- function(mat, nrow_out, ncol_out) {
  mat[
    rep(seq_len(nrow(mat)), length.out = nrow_out),
    rep(seq_len(ncol(mat)), length.out = ncol_out)
  ]
}

b_filter <-
  bayer(2) |>
  norm_bayer() |>
  rep_mat(nrow_out = 112,
          ncol_out = 128) |>
  t() |>
  as.vector()

# Create R data object
usethis::use_data(b_filter, overwrite = TRUE)
