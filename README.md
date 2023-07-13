# Filtering Available Packages Demo

This repo is a proof-of-concept to demonstrate how package quality measures
can be more systematically embedded in analytic workflows. 

## Running the Demo

1. Launch a new R session with the repository root directory as your working
   directory.
2. Step through the code in `workflow.R`

```r
# use the project directory (./src/contrib) to spoof a remote repository
options(repos = c("Local Example Repo" = "file:."))

# by default, we set a "low risk only" filter (see .Rprofile)
packages <- available.packages()
nrow(packages)
#> 5 "low risk" packages

# we can remove the default and permit any package
options(available_packages_filters = NULL)

packages <- available.packages()
nrow(packages)  
#> 17 available packages
```

## Project Tour

There are a few key components to this process:

1. `PACKAGES`  
   Metrics are included in the `src/contrib/PACKAGES` file, which indexes
   packages available in a repository.

   > **Note:**  
   > This is the same file that `available.packages()` downloads from public
   > repositories. We use a local file for demonstration purposes, but these
   > metrics could be served on a public web server and would function 
   > identically.
   > 
   > The metrics provided here are only for representative purposes.

1. `.Rprofile`  
   Provided these quality scores, a default filter on the `available.packages()`
   can be set. For demonstration purposes, this configuration sits in the 
   project's `.Rprofile`, but such a behavior could be configured by a system 
   administrator.

1. `workflow.R`  
   This simple script showcases how the metrics can be pulled from the local
   repository's index file and used to filter for some pre-specified risk
   criteria.

## Further Work

* The risk criteria used here is relatively simple. A production-grade solution
  might include many other measures of risk, and might consider dependency
  relationships between packages to impose constraints on dependencies as well 
  as individual packages.
* There are no actual packages hosted here, just the minimum index file needed
  for `available.packages()` to work. A solution would require hosting of the
  package `.tar.gz` source or binaries.