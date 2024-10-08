% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ggboy.R
\name{ggboy}
\alias{ggboy}
\title{Retro ordered dithering camera simulator}
\usage{
ggboy(
  img,
  palette = c("#2e463d", "#385d49", "#577b46", "#7e8416"),
  frame_colour = 1,
  frame_data = NULL,
  resize_filter = "Mitchell",
  gravity = "center",
  dither_spread = 0.25,
  y_expansion = 0,
  x_expansion = 0,
  return_data = FALSE
)
}
\arguments{
\item{img}{Path (or URL) to image file or object of class magick-image}

\item{palette}{a character vector of 4 colours (default = c("#2e463d", "#385d49", "#577b46", "#7e8416"))}

\item{frame_colour}{the index of the palette colour for the default blank frame. Only used if \code{frame_data = NULL} (default = 1)}

\item{frame_data}{a dataframe of x, y and z values as returned by \code{image_to_frame()} (default = NULL)}

\item{resize_filter}{resize filter to be used \code{magick::filter_types} (default = 'Mitchell')}

\item{gravity}{position of crop window relative to image (default = "center"). A string value from \code{magick::gravity_types()}. Values such as \code{"south"}, \code{"west"}, \code{"northeast"}}

\item{dither_spread}{how much should the dithering 'spread'. Set to 0 for no dithering. (default = 0.25)}

\item{y_expansion}{additive expansion to the image height (default = 0)}

\item{x_expansion}{additive expansion to the image width (default = 0)}

\item{return_data}{return the data for the image (no frame) rather than the plot

\code{ggboy} is meant to be a bit of fun. It performs a janky attempt at ordered dithering that is qualified only by what looks good to my eye. It is for artistic use only.}
}
\value{
A ggplot2 object
}
\description{
\code{ggboy} simulates the retro aesthetic of low resolution ordered image dithering cameras
\itemize{
\item Images are cropped (centrally by default) to have pixel dimensions of width = 128 and height = 112
\item A 16 pixel border is also applied to all sides, meaning the final output image will have width = 160 and height = 144
\item Final images consist of only 4 colours
\item \code{ggboy} is meant to be a bit of fun. It makes an attempt at image dithering which may offend some experts/purists. This project is not an exact technical replication of anything - it's just what looks good to my eye.}
}
