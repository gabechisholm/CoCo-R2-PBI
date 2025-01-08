library(dplyr)
library(grid)

# Select and rename columns
dataX <- dataset %>%
  select(Area = areaLabel, IndicatorX = metricTypeLabel, ValueX = valueX)

dataY <- dataset %>%
  select(Area = areaLabel, IndicatorY = metricTypeLabel, ValueY = valueY)

# Merge the two datasets based on the "Area" column
merged_data <- merge(dataX, dataY, by = "Area")

# Filter out rows with NA or blank values in ValueX or ValueY
filtered_data <- merged_data %>%
  filter(!is.na(ValueX) & !is.na(ValueY))

# Initialize variables for narrative
correlation <- NA
r_squared <- NA
correlation_type <- "no"
r2_interpretation <- "no"

# Check if there is sufficient data for calculation
if (nrow(filtered_data) > 1) {
  # Calculate the correlation coefficient
  correlation <- cor(filtered_data$ValueX, filtered_data$ValueY, use = "complete.obs")
  r_squared <- correlation^2  # Coefficient of determination
  
  # Determine the type of correlation
  correlation_type <- ifelse(correlation >= 0.8, "a strong positive",
                             ifelse(correlation >= 0.5, "a moderate positive",
                                    ifelse(correlation > 0, "a weak positive",
                                           ifelse(correlation <= -0.8, "a strong negative",
                                                  ifelse(correlation <= -0.5, "a moderate negative",
                                                         ifelse(correlation < 0, "a weak negative", "no"))))))
  
  # Interpret the R² value
  r2_interpretation <- ifelse(r_squared >= 0.8, "strong",
                              ifelse(r_squared >= 0.5, "moderate",
                                     ifelse(r_squared >= 0.3, "weak",
                                            ifelse(r_squared > 0, "very weak", "no"))))
}

# Create the narrative
narrative <- paste0(
  "The R² value is ", ifelse(is.na(r_squared), "N/A", sprintf("%.2f", r_squared)),
  ", which indicates a ", r2_interpretation, " relationship between the two indicators. ",
  "The correlation coefficient is ", ifelse(is.na(correlation), "N/A", sprintf("%.2f", correlation)),
  ", suggesting ", correlation_type, " correlation between the variables."
)

wrapped_text <- strwrap(narrative, width = 85)  # Adjust the width

grid.newpage()
grid.rect(gp = gpar(fill = "#0E1A77", col = NA))
for (i in seq_along(wrapped_text)) {
  grid.text(
    wrapped_text[i], 
    x = 0.5, 
    y = 0.88 - (i - 1) * 0.35,  # Adjust line spacing
    just = "center", 
    gp = gpar(
      fontsize = 18,         # Font size
      col = "white",         # Font colour
      fontface = "plain",     # Font style
      fontfamily = "Arial"   # Font family
    )
  )
}

# Return values to Power BI
output <- data.frame(
  Correlation = ifelse(is.na(correlation), "N/A", round(correlation, 3)),
  R2_Value = ifelse(is.na(r_squared), "N/A", round(r_squared, 3))
)
output