# use the project directory (./src/contrib) to spoof a remote repository
options(repos = c("Local Example Repo" = "file:."))

# by default, we set a "low risk only" filter (see .Rprofile)
packages <- available.packages()
nrow(packages)  # 5 "low risk" packages

# we can remove the default and permit any package
options(available_packages_filters = NULL)

packages <- available.packages()
nrow(packages)  # 17 available packages


