#' Installation and Loading of Required Libraries
#'
#' Based on a plain-text file, this function installs and loads
#' all libraries and packages.
#'
#' @param req_file Path to file with list of libraries. Plain-text, one
#'library per line.
#' @param loc_lib (Optional) Determine the folder, where the local library
#' should be installed. Defaults to the first element of .libPaths().
#' @keywords libraries, init
#' @export
#' @examples
#'req_file <- "requirements.txt"
#'writeLines("dplyr", req_file)
#'
#'lib_master(req_file)
#' @author Sebastian Schweer

lib_master <- function(req_file,
                       loc_lib = NULL){
  list.of.packages <- readLines(con = req_file, warn = FALSE)

  # Check for missing packages
  new.packages <-
    list.of.packages[!(list.of.packages %in% utils::installed.packages()[,"Package"])]

  # Install if necessary
  if(length(new.packages)){
   if(is.null(loc_lib)){
     utils::install.packages(new.packages,
                     repos="http://cran.uni-muenster.de/",
                     dependencies = c("Depends", "Imports"))
   } else {
     utils::install.packages(new.packages,
                      repos="http://cran.uni-muenster.de/",
                      dependencies = c("Depends", "Imports"),
                      lib = loc_lib)
   }
  }

  lapply(list.of.packages, require, character.only = TRUE)
}
