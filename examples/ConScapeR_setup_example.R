library(ConScapeR)

# If the ConScape library is not installed in Julia, run:
ConScapeR_setup(Sys.getenv("JULIA_PATH"), install_libraries=TRUE)

# If this function has ran successfully before, or the ConScape library has been installed previously in Julia:
ConScapeR_setup(Sys.getenv("JULIA_PATH"))