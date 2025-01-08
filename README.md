# Smart Narrative for Correlation Analysis in Power BI

This R script enables the creation of a smart narrative for Power BI, providing insights into the correlation and R² values between two indicators. Designed for public health data (e.g., obesity indicators), it uses datasets formatted to the LGInform data standard to generate descriptive and visual analyses directly in Power BI.

## Features

- **Dynamic Correlation Analysis**: Computes the Pearson correlation coefficient (`correlation`) between two indicators, showing the strength and direction of their relationship.
- **R² Calculation**: Determines the coefficient of determination (`R²`), explaining the proportion of variance shared between the indicators.
- **Plain-English Narrative**: Produces a natural-language narrative summarising the statistical findings, making the analysis accessible to non-technical stakeholders.
- **Power BI Integration**: Customised for Power BI R visuals, providing automated outputs in real-time.
- **LGInform Compatibility**: Works seamlessly with data adhering to the LGInform data standard.

## Requirements

### Data Requirements

Two datasets (`correlationDataX` and `correlationDataY`) are required as inputs. Both datasets should include:

1. **`areaLabel`**: The area or geographic identifier.
2. **`metricTypeLabel`**: The name of the indicator (e.g., "% Obese in Year 6").
3. **`valueX` or `valueY`**: Numerical values for the respective indicators.

These datasets must have matching `areaLabel` values to allow for merging and comparison.

### R Libraries

The script requires the following R packages:
- [`dplyr`](https://dplyr.tidyverse.org/): For data manipulation.
- [`grid`](https://stat.ethz.ch/R-manual/R-devel/library/grid/html/grid-package.html): For custom text visuals in Power BI.

Ensure these packages are installed in your R environment before running the script.

### Power BI Integration

The script is designed to work as an R visual in Power BI. Ensure that R is installed and configured in your Power BI environment.

## Setup and Usage

1. **Prepare the Datasets**: Ensure that your datasets (`correlationDataX` and `correlationDataY`) include the required columns and are formatted according to the LGInform data standard.

2. **Load the Script**:
   - Copy the script into the R script editor of a Power BI R visual.
   - Specify the input datasets (`correlationDataX` and `correlationDataY`) in the Power BI Fields pane.

3. **Execute the Script**:
   - Power BI will execute the R script to calculate the correlation and R² values.
   - The visual will display the narrative and metrics table as outputs.

4. **Interpret Results**:
   - **Narrative**: A textual description of the correlation and R² values.
   - **Table Output**: A summary table showing `Correlation` and `R2_Value`.

## Outputs

### Narrative

A plain-English description summarising the statistical relationship between the two indicators. For example:

*"The R² value is 0.45, which indicates a moderate relationship between the two indicators. The correlation coefficient is 0.67, suggesting a moderate positive correlation between the variables."*

### Metrics Table

A simple table summarising the key metrics:

| Correlation | R2_Value |
|-------------|----------|
| 0.67        | 0.45     |

### Visual Design

The narrative is displayed in a styled text box using the `grid` package:
- **Background Colour**: Dark blue (`#0E1A77`).
- **Font**: Arial, white text, size 18.
- **Line Wrapping**: Automatically wraps text for readability.

## Example

### Input Datasets

#### correlationDataX
| areaLabel    | metricTypeLabel          | valueX |
|--------------|--------------------------|--------|
| Hartlepool   | % Obese in Year 6        | 23.1   |
| Middlesbrough   | % Obese in Year 6        | 21.5   |
| Redcard & Cleveland      | % Obese in Year 6        | 20.0   |

#### correlationDataY
| areaLabel    | metricTypeLabel          | valueY |
|--------------|--------------------------|--------|
| Hartlepool   | % of Adults Who Are Active | 55.0   |
| Middlesbrough   | % of Adults Who Are Active | 58.2   |
| Redcard & Cleveland      | % of Adults Who Are Active | 60.1   |

### Output
#### Narrative
*"The R² value is 0.45, which indicates a moderate relationship between the two indicators. The correlation coefficient is 0.67, suggesting a moderate positive correlation between the variables."*

#### Metrics Table
| Correlation | R2_Value |
|-------------|----------|
| 0.67        | 0.45     |

## Customisation

- **Thresholds**: Adjust the thresholds for interpreting `correlation` and `R²` values directly in the script.
- **Visual Style**: Modify font size, colour, and background by changing parameters in the `grid.text` and `grid.rect` sections.
- **Data Sources**: Replace LGInform datasets with other sources by adapting the data preprocessing steps.

## Troubleshooting

- **Blank Narrative or Table**: Ensure both datasets have valid numerical values in `valueX` and `valueY`. Missing or non-numeric data may result in incomplete outputs.
- **R Visual Errors in Power BI**: Confirm that your R environment is correctly configured and all required packages are installed.

