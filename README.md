# SAP Case Study Visualizations

Business visualizations for SAP case study analysis, created with R and ggplot2.

## Repository Structure

### /scripts
R scripts organized by category:
- portfolio - BCG Matrix analysis
- swot - SWOT analyses for S/4HANA and Qualtrics decisions
- strategy - Strategic architecture and planning visualizations
- analysis - Comprehensive strategic analyses

### /output
Generated PNG visualizations (300 DPI, PowerPoint-optimized), organized by category.

## Content Overview

### Portfolio Analysis
BCG Matrix showing SAP product portfolio positioning.

### SWOT Analyses
Key strategic decisions:
- S/4HANA Migration - Strategically necessary, operationally complex (6/10)
- Qualtrics Acquisition - Strategic failure analysis (2/10)

### Strategy
Strategic architecture and planning:
- Cloud-only strategy pillars
- Three pillars framework

### Analysis
Comprehensive strategic analyses:
- Execution gap analysis (Strategy vs. Reality)
- Porter's Five Forces
- Magic Triangle (Quality-Time-Cost)
- Revenue breakdown (Donut chart)
- Lessons learned

## Technology Stack

- Language: R
- Visualization: ggplot2, ggrepel, dplyr
- Output: PNG (300 DPI, PowerPoint-optimized)
- Style: Minimalist, professional, management-ready

## Usage

Run any script directly in RStudio or via command line:

```bash
Rscript scripts/portfolio/bcg_matrix.R
```

All visualizations are automatically saved to the corresponding /output directory.

## Data Source

Based on SAP Integrated Report 2024 and official financial disclosures.
