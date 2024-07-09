
load_gransasso <- function() {
  data_path <- system.file("data/gransasso.RData", package = "pets")
  if (file.exists(data_path)) {
    load(data_path, envir = .GlobalEnv)
  } else {
    stop("Dataset gransasso not found.")
  }
}
