library(ggboy)

# A single colour image
test_image <- magick::image_read(matrix("black", nrow = 144, ncol = 160))
test_output <- ggboy(test_image)
test_data <- test_output$data
test_build <- test_output |> ggplot2::ggplot_build()


test_that("Image outputs (dimensions and colours) are correct", {
  # test data passed to plot
  expect_equal(test_data$x |> range(), c(1, 160))
  expect_equal(test_data$y |> range(), c(1, 144))
  expect_equal(test_data$z |> unique() |> length(), 4)

  # test data from rebuilt plot
  expect_equal(test_build$data[[1]]$fill |> unique() |> length(), 4)
  expect_equal(test_build$data[[1]]$x |> range(), c(1, 160))
  expect_equal(test_build$data[[1]]$y |> range(), c(-144, -1))

  expect_equal(test_build$data[[1]]$xmin |> range(), c(0.5, 159.5))
  expect_equal(test_build$data[[1]]$ymin |> range(), c(-144.5, -1.5))
  expect_equal(test_build$data[[1]]$xmax |> range(), c(1.5, 160.5))
  expect_equal(test_build$data[[1]]$ymax |> range(), c(-143.5, -0.5))
}
)


# A single colour image
test_image <- magick::image_read(matrix("black", nrow = 144, ncol = 160))
test_output <- ggboy(test_image, dither_spread = 0)
test_data <- test_output$data
test_build <- test_output |> ggplot2::ggplot_build()

# Even though image is black the ouput is scaled and the image is white
# perhaps that behaviour depends on the frame colour?

test_that("With no dither on solid colour image you get 2 colours in output", {
  # test data passed to plot
  expect_equal(test_data$x |> range(), c(1, 160))
  expect_equal(test_data$y |> range(), c(1, 144))
  expect_equal(test_data$z |> unique() |> length(), 2)

  # test data from rebuilt plot
  expect_equal(test_build$data[[1]]$fill |> unique() |> length(), 2)
  expect_equal(test_build$data[[1]]$x |> range(), c(1, 160))
  expect_equal(test_build$data[[1]]$y |> range(), c(-144, -1))

  expect_equal(test_build$data[[1]]$xmin |> range(), c(0.5, 159.5))
  expect_equal(test_build$data[[1]]$ymin |> range(), c(-144.5, -1.5))
  expect_equal(test_build$data[[1]]$xmax |> range(), c(1.5, 160.5))
  expect_equal(test_build$data[[1]]$ymax |> range(), c(-143.5, -0.5))
}
)
