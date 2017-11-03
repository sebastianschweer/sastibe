#' Initialization of the Logger for Scripts
#'
#' This function initialzies the logging of the current script in a text
#' file. The head of the logfile contains essential information on the
#' build of the system, the R version, and the versions of the attached
#' packages.
#'
#' @param code_dir Directory in which the script is located. Defaults to "."
#' @param log_path Path of the logfile to be created. Defaults to "logfile.txt"
#' within the working directory.
#' @param logger Name of the logger handler to be initialized, defaults to "main".
#' @param script_name (Optional) Name of the Script or project at the head of
#' the log.
#' @keywords logging
#' @export
#' @examples
#' script_init()
#' logging::loginfo("This is not in logfile.txt, wrong logger")
#' logging::loginfo("This appears in logfile.txt", logger = 'main')
#' @author Sebastian Schweer
#' @import logging


script_init <- function(code_dir = ".",
                        log_path = "logfile.txt",
                        logger = "main",
                        script_name = NULL){
  logReset()
  basicConfig(level = 'FINEST')
  addHandler(writeToFile, file = log_path, level = 'DEBUG', logger = logger)
  removeHandler('basic.stdout')

  loginfo(paste0('Script <<', script_name, '>> was launched.'), logger = logger)
  loginfo('Working Directory: %s', code_dir, logger = logger)
  loginfo('R Version: %s', utils::sessionInfo()[['R.version']]$version.string, logger = logger)
  loginfo('Platform: %s', utils::sessionInfo()[['platform']], logger = logger)
  loginfo('Loaded basePkgs: %s',
                   paste(utils::sessionInfo()[['basePkgs']], collapse = ", "),
                   logger = logger)
  loginfo('Loaded otherPkgs: %s',
                   paste(lapply(utils::sessionInfo()[['otherPkgs']],
                                function(x){return(paste(x$Package, x$Version))}),
                         collapse = ", "),
                   logger = logger)
}
