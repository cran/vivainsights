#' @title
#' Generate a vector of `n` contiguous colours, as a red-yellow-green palette.
#'
#' @description
#' Takes a numeric value `n` and returns a character vector of colour HEX codes
#' corresponding to the heat map palette.
#'
#' @param n the number of colors (>= 1) to be in the palette.
#' @param alpha an alpha-transparency level in the range of 0 to 1
#' (0 means transparent and 1 means opaque)
#' @param rev logical indicating whether the ordering of the colors should be
#'   reversed.
#'
#' @examples
#' barplot(rep(10, 50), col = heat_colours(n = 50), border = NA)
#'
#' barplot(rep(10, 50), col = heat_colours(n = 50, alpha = 0.5, rev = TRUE),
#' border = NA)
#'
#' @family Support
#'
#' @return
#' A character vector containing the HEX codes and the same length as `n` is
#' returned.
#'
#' @export
heat_colours <- function (n, alpha, rev = FALSE) {

  ## Move from red to green
  h <- seq(from = 0, to = 0.3, length.out = n)
  #h <- c(1, pre_h)

  ## Less bright
  s <- rep(0.69, length(h))

  ## Increasingly low value (darker)
  v <- seq(from = 1, to = 0.8, length.out = n)

  cols <- grDevices::hsv(h = h, s = s, v = v, alpha = alpha)

  if(rev){

    rev(cols)

  } else if(rev == FALSE) {

    cols
  }
}

#' @rdname heat_colours
#' @export
heat_colors <- heat_colours

