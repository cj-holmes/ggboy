#' Create a ggboy animated gif
#'
#' @param gif File path or URL of GIF
#' @param width output width (default 160 * scale)
#' @param height output height (default 144 * scale)
#' @param scale multiplicative scaling factor for width and height (default = 1)
#' @param fps frames per second. Ignored if delay is not NULL
#' @param delay delay after each frame, in 1/100 seconds. Must be length 1, or number of frames. If specified, then fps is ignored.
#' @param frame_data a dataframe of x, y and z values as returned by \code{image_to_frame()} (default = NULL)
#' @param first_n only use frames \code{1:first_n} of the gif. Useful for testing settings on a smaller subset of the gif
#' @param ... named arguments passed on to \code{ggboy()}
#'
#' @export
ggboy_gif <- 
  function(
    gif,
    width = 160,
    height = 144,
    scale = 1,
    fps = 5,
    delay = NULL,
    frame_data = NULL,
    first_n = NULL,
    ...){

  x <- magick::image_read(gif)

  if(!is.null(first_n)) x <- x[1:first_n]

  # Process GIF -------------------------------------------------------------
  message(paste0("Processing GIF (", length(x), " frames)"))
  l <- list()
  for (i in seq_along(x)) l[[i]] <- magick::image_flatten(x[1:i])

  # Run ggboy ---------------------------------------------------------------
  message("Running ggboy on all GIF frames")
  fig <- magick::image_graph(width = width * scale, height = height * scale)

  purrr::map(
    .x = as.list(magick::image_join(l)),
    .f = function(x) print(ggboy(x, frame_data = frame_data, ...)),
    .progress = TRUE)

  dev.off()

  # Animate GIF -------------------------------------------------------------
  message("Animating GIF")
  magick::image_animate(fig, fps = fps, delay = delay)
}
