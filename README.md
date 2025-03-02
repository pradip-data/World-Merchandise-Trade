# 🌍 Global Trade Analysis using ChatGPT AI, Google BigQuery & Python

## 📌 Project Overview
This project leverages **ChatGPT AI, Google BigQuery, and Python** to analyze and visualize **global trade data**. It extracts insights from a dataset containing trade indicators across multiple countries, products, and years. The results are presented through **Python-based visualizations** and a structured **PDF report**.

## 📊 Key Features
✅ **BigQuery for Data Extraction** – Query and fetch trade data from Google BigQuery.
✅ **ChatGPT AI for Insight Generation** – Enhance analysis with AI-powered insights.
✅ **Python for Data Processing & Visualization** – Generate interactive charts.
✅ **Automated PDF Report** – Structured insights with data-driven storytelling.

---

## 📂 Dataset Description
The dataset contains **global trade data**, including the following columns:

| Column Name         | Description                                   |
|---------------------|----------------------------------------------|
| `IndicatorCode`     | Trade metric identifier                      |
| `Indicator`        | Trade metric name                            |
| `ReporterCountry`  | Country reporting the trade data            |
| `Partner`         | Trading partner country                      |
| `ProductCode`      | Unique code for the product                  |
| `Product`         | Product name                                 |
| `Year`            | Year of the trade transaction                |
| `Value_MillionUSD` | Trade value in million USD                   |

---

## 🚀 Technologies Used
- **Google BigQuery** – For data extraction
- **Python (Pandas, Matplotlib, Seaborn, FPDF)** – Data processing, visualization, and report generation
- **ChatGPT AI** – Insight generation

---

## 📥 Installation
1. **Clone the Repository**
```bash
git clone https://github.com/yourusername/Global-Trade-Analysis.git
cd Global-Trade-Analysis
```

2. **Install Dependencies**
```bash
pip install pandas matplotlib seaborn fpdf google-cloud-bigquery
```

3. **Set Up Google BigQuery Credentials**
- Create a **Google Cloud Project**.
- Enable **BigQuery API**.
- Download your service account JSON key and set it as an environment variable:
```bash
export GOOGLE_APPLICATION_CREDENTIALS="path/to/your-key.json"
```

---

## 📜 Code Overview
### 1️⃣ **Extracting Data from BigQuery**
```python
from google.cloud import bigquery
import pandas as pd

client = bigquery.Client()
query = """
    SELECT IndicatorCode, Indicator, ReporterCountry, Partner, ProductCode, Product, Year, Value_MillionUSD
    FROM `your_project.your_dataset.your_table`
    WHERE Year = 2023
"""
df = client.query(query).to_dataframe()
```
✅ **Fetches trade data for 2023** from BigQuery.
✅ **Stores data in a Pandas DataFrame** for further processing.

### 2️⃣ **Data Visualization in Python**
```python
import matplotlib.pyplot as plt
import seaborn as sns

plt.figure(figsize=(12, 6))
sns.barplot(data=df, x='ReporterCountry', y='Value_MillionUSD', hue='Indicator')
plt.xticks(rotation=45)
plt.title("Global Trade by Country in 2023")
plt.show()
```
✅ **Creates bar charts for trade trends**.
✅ **Uses Seaborn for enhanced visualizations**.

### 3️⃣ **Generating a PDF Report**
```python
from fpdf import FPDF

pdf = FPDF()
pdf.add_page()
pdf.set_font("Arial", size=12)
pdf.cell(200, 10, "Global Trade Analysis Report (2023)", ln=True, align='C')
pdf.output("Trade_Report.pdf")
```
✅ **Automates report generation** with trade insights.
✅ **Creates a structured and professional PDF report**.

---

## 📊 Sample Visualization Output
📈 **Example Chart:**
![Trade Analysis Chart](example_chart.png)

---

## 📢 Future Improvements
- 📌 **Advanced AI Insights** – Leverage ChatGPT for automated trend analysis.
- 📌 **Interactive Dashboards** – Develop Power BI/Tableau dashboards.
- 📌 **Real-time Trade Monitoring** – Implement live BigQuery data streaming.

---

## 🤝 Contributing
🔹 **Fork the repository**
🔹 **Create a new branch** (`feature-branch`)
🔹 **Commit your changes**
🔹 **Push to GitHub and create a Pull Request**

---

## 📜 License
This project is licensed under the **MIT License**.

🔗 **Author:** [Your Name](https://github.com/yourusername)

