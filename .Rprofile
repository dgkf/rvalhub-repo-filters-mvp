options(
  repos = c("Local Repo" = "file:."),

  # see `?available.packages` for how this is used
  available_packages_filters = list(

    # Filter for only "low risk" packages using custom filters
    "Low-Risk Packages" = function(packages) {
      is_low_risk <- with(as.data.frame(packages), {
        Priority %in% c("base", "recommended") | 
        (
          as.numeric(MetricCoverage) > 0.8 & 
          as.numeric(MetricHasSourceControl) == 1 & 
          as.numeric(MetricHasBugReportsURL) == 1  &
          (
            as.numeric(MetricHasNews) == 1 | 
            as.numeric(MetricHasVignettes) >= 1
          )
        )
      })

      packages[is_low_risk,]
    },

    # add filter to defaults (ie, latest compatible available)
    add = TRUE
  )
)

# mask utils available.packages to include other fields by default
available.packages <- function(...) {
  additional_fields <- c(
    "MetricCoverage",
    "MetricHasBugReportsURL",
    "MetricHasNews",
    "MetricHasSourceControl",
    "MetricHasVignettes"
  )

  args <- list(...)
  args$fields <- c(args$fields, additional_fields)

  do.call(utils::available.packages, args)
}

# mock install.packages for demonstration of security checking at install time 
install.packages <- function(pkgs, ..., accept_vulnerabilities = FALSE) {
  ap <- available.packages()
  pkg_versions <- ap[match(pkgs, ap[, "Package"]), "Version"]

  # for the sake of example, just load an existing mocked audit result
  # audit <- oysteR::audit(pkgs, pkg_versions, type = "cran")
  audit <- readRDS("fixtures/audit.Rds")

  if ((n <- sum(audit$no_of_vulnerabilities)) > 0 && !accept_vulnerabilities) {
    message(
      "Security vulnerabilities found in packages to be installed. \n",
      "To proceed with installation, re-run with ",
      "`accept_vulnerabilities = TRUE`"
    )

    if (requireNamespace("oyster", quietly = TRUE)) {
      oysteR:::audit_verbose(audit)

    # provide a fallback for demoing when oysteR isn't available
    } else {
      cat(sprintf(
        paste(sep = "\n", 
          "",
          "%d package had known vulnerability",
          "A total of %d known vulnerability was identified",
          ""
        ),
        nrow(audit[audit$no_of_vulnerabilities > 0,]),
        sum(audit$no_of_vulnerabilities)
      ))      
    }

    return(invisible(audit))
  }

  utils::install.packages(pkgs, ...)
}
