# How images/cover.png was made (2026-11-15): from the earlier cover, images/cover.png at commit 5dd2e65 (git show
# 5dd2e65:images/cover.png > cover_original.png), with
#   Rscript tools/make_cover.R cover_original.png images/cover.png
# Coral Book's cover: the old cover's background with its title erased, and the new title (金融工学の応用基礎).
# Neutral: the picture in pale grey, the text in charcoal, and a single spot of coral (the dot on the upper rule).
#   Rscript cover.R <input png> <output png>
# The old title is erased, not veiled: inside its area a smooth background (a quadratic surface fitted to the
# light pixels) is estimated, and the pixels darker than it (the old letters and rules) take its colour.
library(grid)

args <- commandArgs(trailingOnly = TRUE)
input <- args[1]; output <- args[2]
bg <- png::readPNG(input)
h <- dim(bg)[1]; w <- dim(bg)[2]

# the old title, rules, subtitle and author: x 140..790, y 290..715 (pixels from the top)
rows <- 290:715; cols <- 140:790
lum <- function(a) 0.299 * a[, , 1] + 0.587 * a[, , 2] + 0.114 * a[, , 3]
region <- bg[rows, cols, , drop = FALSE]
L <- lum(region)
grid_xy <- expand.grid(r = seq_along(rows), c = seq_along(cols))
light <- as.vector(L) > quantile(L, 0.6)
fit_channel <- function(k) {
  v <- as.vector(region[, , k])
  d <- data.frame(v = v, r = grid_xy$r / 100, c = grid_xy$c / 100)
  m <- lm(v ~ r + c + I(r^2) + I(c^2) + I(r * c), data = d[light, ])
  matrix(predict(m, newdata = d), length(rows), length(cols))
}
surface <- array(c(fit_channel(1), fit_channel(2), fit_channel(3)), dim = dim(region))
dark <- L < lum(surface) - 0.08  # the letters (navy) and the rules (gold), not the faint texture
# also take the anti-aliased rims of the letters: grow the dark mask by two pixels
grow <- function(m) {
  out <- m
  for (dr in -2:2) for (dc in -2:2) {
    shifted <- matrix(FALSE, nrow(m), ncol(m))
    rs <- max(1, 1 + dr):min(nrow(m), nrow(m) + dr); cs <- max(1, 1 + dc):min(ncol(m), ncol(m) + dc)
    shifted[rs, cs] <- m[rs - dr, cs - dc]
    out <- out | shifted
  }
  out
}
mask <- grow(dark)

for (k in 1:3) {
  ch <- region[, , k]; ch[mask] <- surface[, , k][mask]; region[, , k] <- ch
}
bg[rows, cols, ] <- region

# pale grey duotone: the picture's lightness, from a soft grey (dark) to an almost white (light)
duo_dark <- c(0xb4, 0xb4, 0xb6) / 255
duo_light <- c(0xfb, 0xfb, 0xfb) / 255
t <- lum(bg)^0.8
for (k in 1:3) bg[, , k] <- duo_dark[k] + (duo_light[k] - duo_dark[k]) * t

systemfonts::register_font("CoverMincho", plain = "C:/Windows/Fonts/yumin.ttf", bold = "C:/Windows/Fonts/yumindb.ttf")
navy <- "#2b2b2e"   # charcoal for the title and the text
coral <- "#e0583c"   # the one spot of colour
grey <- "#8c8c90"    # the label and the rules
mid <- 462  # the old title's centre line
px <- function(x) unit(x, "native")
yy <- function(y_top) unit(h - y_top, "native")

ragg::agg_png(output, width = w, height = h, units = "px", res = 72, background = "white")
pushViewport(viewport(xscale = c(0, w), yscale = c(0, h)))
grid.raster(bg, width = unit(1, "npc"), height = unit(1, "npc"), interpolate = FALSE)
rule <- function(y, half, dot = grey, r = 4.5) {
  grid.lines(px(c(mid - half, mid - 14)), yy(c(y, y)), gp = gpar(col = grey, lwd = 1.3))
  grid.lines(px(c(mid + 14, mid + half)), yy(c(y, y)), gp = gpar(col = grey, lwd = 1.3))
  grid.circle(px(mid), yy(y), r = unit(r, "native"), gp = gpar(fill = dot, col = NA))
}
grid.text("C O R A L   B O O K", px(mid), yy(345), gp = gpar(fontfamily = "Georgia", fontsize = 26, col = grey))
grid.text("金融工学の応用基礎", px(mid), yy(438), gp = gpar(fontfamily = "CoverMincho", fontface = "bold", fontsize = 70, col = navy))
rule(527, 300, dot = coral, r = 7)
grid.text("Rによる金融データ分析・数理モデル・並列計算", px(mid), yy(582), gp = gpar(fontfamily = "CoverMincho", fontsize = 26, col = navy))
rule(638, 185)
grid.text("Eiichi Horigome", px(mid), yy(690), gp = gpar(fontfamily = "Georgia", fontsize = 26, col = navy))
popViewport()
invisible(dev.off())
cat("cover:", output, w, "x", h, "erased pixels", sum(mask), "\n")
