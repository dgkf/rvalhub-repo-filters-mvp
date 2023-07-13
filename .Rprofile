options(
	available_packages_filters = list(
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