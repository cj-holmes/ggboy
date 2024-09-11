#' Create a frame for ggboy images from another image
#'
#' Images will be scaled and cropped to 160 px (wide) x 144 px (high) (if not already these dimensions)
#' Then converted to greyscale with the outer 16 pixels border selected
#'
#' @param img path to image to use for frame
#' @param resize_filter resize filter to be used \code{magick::filter_types} (default = 'Mitchell')
#' @param gravity position of crop window relative to image (default = "center"). A string value from \code{magick::gravity_types()}. Values such as \code{"south"}, \code{"west"}, \code{"northeast"}
#' @export
image_to_frame <- function(img, resize_filter = "Mitchell", gravity = "center"){

  if(inherits(img, "magick-image")){raw<-img} else {raw<-magick::image_read(img)}
  raw_info <- magick::image_info(raw)

  if(!(raw_info$width == 160 & raw_info$height == 144)){
    i <-
      raw |>
      magick::image_resize(geometry = "160x144^", filter = resize_filter) |>
      magick::image_crop(geometry = "160x144", gravity = gravity)
  } else {
    i <- raw
  }

  i |>
    magick::image_convert(type = "grayscale") |>
    magick::image_raster() |>
    dplyr::filter(!(x >= 17 & x <= 144 & y >= 17 & y <= 128)) |>
    dplyr::transmute(
      x,
      y,
      z = cut(t(col2rgb(col))[,1], breaks = 4, labels = FALSE))
}
