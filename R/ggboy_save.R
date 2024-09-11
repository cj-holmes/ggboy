#' Save a ggboy image with the correct dimensions
#'
#' ggboy_save() is a convenient function for saving a ggboy image at the correct aspect ratio.
#' By default it saves images at 160 px (wide) x 144 px (high)
#'
#' @param filename file name to create on disk
#' @param scale multiplicative scaling factor
#'
#' @export
ggboy_save <- function(filename, scale = 1){

  ggplot2::ggsave(
    filename = filename,
    width = 160 * scale,
    height = 144 * scale,
    units = "px")
  }
