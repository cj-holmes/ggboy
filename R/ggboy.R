#' Retro ordered dithering camera simulator
#'
#' @description
#' \code{ggboy} simulates the retro aesthetic of low resolution ordered image dithering cameras
#' \itemize{
#'   \item Images are cropped (centrally by default) to have pixel dimensions of width = 128 and height = 112
#'   \item A 16 pixel border is also applied to all sides, meaning the final output image will have width = 160 and height = 144
#'   \item Final images consist of only 4 colours
#'   \item \code{ggboy} is meant to be a bit of fun. It makes an attempt at image dithering which may offend some experts/purists. This project is not an exact technical replication of anything - it's just what looks good to my eye.}
#' @param img Path (or URL) to image file or object of class magick-image
#' @param palette a character vector of 4 colours (default = c("#2e463d", "#385d49", "#577b46", "#7e8416"))
#' @param frame_colour the index of the palette colour for the default blank frame. Only used if \code{frame_data = NULL} (default = 1)
#' @param frame_data a dataframe of x, y and z values as returned by \code{image_to_frame()} (default = NULL)
#' @param gravity position of crop window relative to image (default = "center"). A string value from \code{magick::gravity_types()}. Values such as \code{"south"}, \code{"west"}, \code{"northeast"}
#' @param resize_filter resize filter to be used \code{magick::filter_types} (default = 'Mitchell')
#' @param dither_spread how much should the dithering 'spread'. Set to 0 for no dithering. (default = 0.25)
#' @param y_expansion additive expansion to the image height (default = 0)
#' @param x_expansion additive expansion to the image width (default = 0)
#' @param return_data return the data for the image (no frame) rather than the plot
#'
#' \code{ggboy} is meant to be a bit of fun. It performs a janky attempt at ordered dithering that is qualified only by what looks good to my eye. It is for artistic use only.
#'
#' @return A ggplot2 object
#' @export
ggboy <-
  function(
    img,
    palette = c("#2e463d", "#385d49", "#577b46", "#7e8416"),
    frame_colour = 1,
    frame_data = NULL,
    resize_filter = "Mitchell",
    gravity = "center",
    dither_spread = 0.25,
    y_expansion = 0,
    x_expansion = 0,
    return_data = FALSE){

    # Read image or accept as is if its magick
    if(inherits(img, "magick-image")){i<-img} else {i<-magick::image_read(img)}

    # Check palette has exactly 4 unique colours
    stopifnot(
      "palette must have 4 colours" = {length(palette) == 4},
      "palette must have 4 unique colours" = {length(unique(palette)) == 4}
    )

    # If no frame data and frame intensity is not 1-4, stop
    if(is.null(frame_data) && !(frame_colour %in% 1:4)){
      stop("If frame_data is not supplied, the value of frame_colour must be 1, 2, 3 or 4", call. = FALSE)
    }

    # Tests on frame data if its supplied else create a single colour frame dataframe
    if(!is.null(frame_data)){
      stopifnot(
        "frame_data must be a data frame" = {any(class(frame_data) %in% "data.frame")},
        "frame_data must contain columns x, y and z" = {all(c("x", "y", "z") %in% colnames(frame_data))},
        "frame_data columns x, y and z must all be numeric" = {all(sapply(frame_data |> dplyr::select(x, y, z), is.numeric))},
        "The range of the frame_data x values must be 1 to 160" = {all(range(frame_data$x, na.rm = TRUE) == c(1, 160))},
        "The range of the frame_data y values must be 1 to 144" = {all(range(frame_data$y, na.rm = TRUE) == c(1, 144))},
        "The z colour column must contain a maximum of 4 distinct values" = {dplyr::n_distinct(frame_data$z) <= 4})
    } else {
      frame_data <- frame_df |> dplyr::mutate(z = frame_colour)
    }

    p <-
      i |>
      magick::image_resize(filter = resize_filter, geometry = "128x112^") |>
      magick::image_crop(geometry = "128x112", gravity = gravity) |>
      magick::image_raster() |>
      dplyr::mutate(
        col2rgb(col) |> t() |> dplyr::as_tibble(), # original pixel RGB values
        greyscale = (red + green + blue) / 3,
        greyscale_scaled =  scales::rescale(greyscale, to = c(0,1)),
        dither_mat = b_filter,
        z = cut(greyscale_scaled + (dither_mat*dither_spread), breaks = 4, labels = FALSE)) |>
      dplyr::mutate(x = x + 16, y = y + 16) |>
      dplyr::bind_rows(frame_data)

    if(return_data) return(p)

    # Make plot ---------------------------------------------------------------
    p |>
      ggplot2::ggplot() +
      ggplot2::geom_raster(ggplot2::aes(x, y, fill = z)) +
      ggplot2::scale_fill_gradientn(colours = palette, guide = "none") +
      ggplot2::scale_y_reverse(expand = ggplot2::expansion(mult = 0, add = y_expansion)) +
      ggplot2::scale_x_continuous(expand = ggplot2::expansion(mult = 0, add = x_expansion)) +
      ggplot2::coord_equal() +
      ggplot2::theme_void()

  }
