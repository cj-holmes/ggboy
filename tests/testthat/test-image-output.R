library(ggboy)

# Test set 1 -------------------------------------------------------------------
test_image <- "https://pbs.twimg.com/profile_images/905186381995147264/7zKAG5sY_400x400.jpg"
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

# Test set 2 -------------------------------------------------------------------
test_image <- "https://pbs.twimg.com/profile_images/905186381995147264/7zKAG5sY_400x400.jpg"
test_output <- ggboy(test_image, frame_data = image_to_frame(test_image))
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



# Test set 3 -------------------------------------------------------------------
test_image <- "https://pbs.twimg.com/profile_images/905186381995147264/7zKAG5sY_400x400.jpg"
test_output <- ggboy(test_image, frame_data = image_to_frame(test_image), palette = viridis::mako(4), dither_spread = 0)
test_output
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


# Test set 4 -------------------------------------------------------------------
test_image <- "https://pbs.twimg.com/profile_images/905186381995147264/7zKAG5sY_400x400.jpg"
test_output <-
  ggboy(
    test_image,
    frame_data = image_to_frame(test_image),
    palette = viridis::turbo(4),
    dither_spread = 1)
test_output
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

# Test set 5 -------------------------------------------------------------------
test_image <- "https://exp.itemku.com/wp-content/uploads/2020/12/gunpei-1.jpg"
test_output <-
  ggboy(
    test_image,
    frame_colour = 3,
    palette = viridis::turbo(4),
    dither_spread = 1)
test_output
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



# Test the data out normalisation ----------------------------------------
test_image <- "https://exp.itemku.com/wp-content/uploads/2020/12/gunpei-1.jpg"
test_output <-
  ggboy(
    test_image,
    frame_colour = 3,
    palette = viridis::turbo(4),
    dither_spread = 1,
    return_data = TRUE)
test_output

# na.rm=TRUE as there is NAs for the xy coords where the frame is
test_that("Normalised greyscale is correct", {
  expect_equal(test_output$greyscale_scaled |> range(na.rm=TRUE), c(0,1))
})
