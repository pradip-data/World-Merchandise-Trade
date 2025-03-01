# India's Global Trade Analysis (1948-2023)

## Project Overview
This project provides a **comprehensive analysis of India's global trade performance** from **1948 to 2023**, leveraging **Google BigQuery**, **Python for data visualization**, and **ChatGPT AI for insights**. It examines India's **exports, imports, trade balance, and global ranking trends**, offering in-depth visual representations and detailed insights.

## Data Source
The dataset is extracted from **Google BigQuery** and contains trade data for various products and partner countries. It provides insights into India's global trade evolution, helping to understand economic trends and trade policy impacts.

## Technologies Used
- **Google BigQuery**: Extracting and analyzing large-scale trade data
- **Python (Pandas, Matplotlib, Seaborn, Plotly)**: Data processing and visualization
- **ChatGPT AI**: Generating insights and reports
- **Jupyter Notebook**: Interactive data analysis and visualization

## Dataset Details
The dataset contains the following key columns:
| Column Name         | Description                                            |
|---------------------|--------------------------------------------------------|
| IndicatorCode       | Unique trade indicator code                            |
| Indicator          | Description of the trade indicator                     |
| ReporterCountry    | The country reporting trade data (India)               |
| Partner           | Partner country involved in trade                       |
| ProductCode        | Unique product code                                    |
| Product           | Product category                                       |
| Year              | Year of the trade data                                  |
| Value_MillionUSD  | Trade value in million USD                             |

## Analysis Performed
### 1. **Year-wise Trade Performance**
- Trends in **exports, imports, and trade balance** from 1948 to 2023
- **Growth rate analysis** of trade components

### 2. **Global Trade Ranking Analysis**
- India’s **global ranking** in exports and imports over the years
- Comparison with top trading nations

### 3. **Product-wise Trade Trends**
- Key **exported and imported products** over time
- **Growth trends** of high-value commodities

### 4. **Country-wise Trade Patterns**
- India’s **major trading partners** by value
- Trends in **bilateral trade agreements**

### 5. **Trade Deficit Analysis**
- Year-wise **trade surplus/deficit** trends
- Identifying periods of trade imbalance

## Visualizations
The project features interactive and static visualizations using **Matplotlib, Seaborn, and Plotly**, including:
- **Line Charts**: Year-wise trends of exports, imports, and trade deficit
- **Bar Charts**: Top traded products and partner countries
- **Heatmaps**: Trade intensity across different countries
- **Bubble Charts**: Growth rate vs. total trade for key products

## Installation & Usage
### 1. Clone the Repository
```bash
git clone https://github.com/yourusername/India-Trade-Analysis.git
cd India-Trade-Analysis
```
### 2. Install Dependencies
```bash
pip install pandas numpy matplotlib seaborn plotly google-cloud-bigquery
```
### 3. Run the Analysis
```bash
python trade_analysis.py
```

## Insights & Key Findings
- **India's exports and imports have grown exponentially** since 1948.
- **Trade balance fluctuated over decades**, influenced by economic policies.
- **Top trading partners** include the USA, China, and UAE.
- **Petroleum, gems, and machinery dominate India’s trade portfolio**.

## Contributions
Feel free to fork this project, submit pull requests, or report issues. Contributions are welcome to improve data analysis and visualizations.

## License
This project is licensed under the **MIT License**.

## Author
**[Your Name]** - Data Analyst | BigQuery | Python | AI

