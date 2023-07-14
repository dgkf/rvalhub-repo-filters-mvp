# Filtering Available Packages Demo

This repo is a proof-of-concept to demonstrate how package quality measures
can be more systematically embedded in analytic workflows. 

## Running the Demo

> The full demo code is available in `workflow.R`

Kick off a new R session (in the project root as the working directory to pick
up the .Rprofile settings). 

We can take a look at the available packages, which will automatically apply a
filter for "low risk" packages as specified in `.Rprofile`.

```r
packages <- available.packages()
nrow(packages)
#> 5 "low risk" packages
```

Attempting to install a package with a vulnerability will abort the installation
and warn of the vulnerability. Installing packages with known vulnerabilities
must be opted into.

```r
# installing a package with known vulnerabilities will abort installation
install.packages("options")
#> Security vulnerabilities found in packages to be installed.
#> To proceed with installation, re-run with `accept_vulnerabilities = TRUE`
#> 
#> ── Vulnerability overview ──
#> 
#> ℹ 1 package was scanned
#> ℹ 1 package was found in the Sonatype database
#> ℹ 1 package had known vulnerability
#> ℹ A total of 1 known vulnerability was identified
#> ℹ See https://github.com/sonatype-nexus-community/oysteR/ for details.
```

We can also turn off the "low risk" package filter by disabling non-default
filters just to show that the package database is being appropriately subset by
our metric heuristics. Now we can see that we have access to 17 packages,
whereas we only had access to 5 "low risk" packages.

```r
options(available_packages_filters = NULL)

packages <- available.packages()
nrow(packages)  
#> 17 available packages
```

> **Note:**  
> My `options` package has no known vulnerabilities! This is just a demo :)

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

1. `fixtures/audit.Rds`
   A fixed output of `oysteR::audit()` so that the demo is reproducible. I
   provided a vulnerability for one of my own packages because vulnerable
   packages might be fixed in the future.

## Further Work

* The risk criteria used here is relatively simple. A production-grade solution
  might include many other measures of risk, and might consider dependency
  relationships between packages to impose constraints on dependencies as well 
  as individual packages.
* There are no actual packages hosted here, just the minimum index file needed
  for `available.packages()` to work. A solution would require hosting of the
  package `.tar.gz` source or binaries.