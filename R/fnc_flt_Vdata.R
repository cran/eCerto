#' @title flt_Vdata.
#' @description \code{flt_Vdata} will filter a V data table for specific analytes and levels.
#' @param x The imported V data.
#' @param a Analyte name(s).
#' @param l Level name(s). Will be used to determine the maximum range of levels.
#' @param rng Logical. Shall the filter be extended to cover the full range specified in parameter l?
#' @return A object 'res' from an RData file.
#' @examples
#' inp <- system.file(package = "eCerto", "extdata", "eCerto_Testdata_VModule.xlsx")
#' tab <- eCerto:::read_Vdata(file = inp)
#' eCerto:::flt_Vdata(x = tab, l = c("2","4"), a = c("PFOA", "PFBA"))
#' eCerto:::flt_Vdata(x = tab, l = c(2,5), a = "PFBA", rng = FALSE)
#' @keywords internal
#' @noRd
flt_Vdata <- function(x = NULL, l = NULL, a = NULL, rng = TRUE) {
  e_msg("Filtering V data table.")
  if (!is.null(l)) {
    if (rng) {
      l_rng <- range(which(levels(x[,"Level"]) %in% l))
      l_rng <- seq(min(l_rng), max(l_rng))
    } else {
      l_rng <- which(levels(x[,"Level"]) %in% l)
    }
    x <- x[x[,"Level"] %in% levels(x[,"Level"])[l_rng],]
  }
  if (!is.null(a)) {
    x <- x[as.character(x[,"Analyte"]) %in% a,]
  }
  return(x)
}