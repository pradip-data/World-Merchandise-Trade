

# 🌍Global Merchandise Trade (1947-2023) Analysis using ChatGPT AI, Google BigQuery & Python

## 📌 Project Overview
This project analyzes global merchandise trade trends from 1947 to 2023, with a primary focus on India's trade performance. The dataset is sourced from Google BigQuery and consists of indicators such as exports, imports, total trade, and trade deficit for different countries. The analysis leverages Google BigQuery for data extraction, Python for visualization, and ChatGPT AI for insights generation.**.


## 📊 Key Objectives

- Analyze India's **exports, imports, total trade, and trade deficit** over time.
- Compare India's trade performance against global leaders.
- Identify key trade trends, challenges, and opportunities for improvement.
- 
## 📊 Key Questions Analyzed

1.How has global trade evolved from 1947 to 2023?
2.What is India’s trade performance in exports, imports, and total trade?
3.How has India’s trade deficit changed over time?
4.How does India compare with top exporting and importing nations?
5.What are the key challenges in India’s trade landscape?
6.What strategies can improve India’s trade competitiveness?

## 📊 Key Features
✅ **BigQuery for Data Extraction** – Query and fetch trade data from Google BigQuery.
✅ **ChatGPT AI for Insight Generation** – Enhance analysis with AI-powered insights.
✅ **Python for Data Processing & Visualization** – Generate interactive charts.
✅ **Automated PDF Report** – Structured insights with data-driven storytelling.

---
##  Data Overview
### Dataset Structure
The dataset consists of the following key columns:

| Column Name         | Description |
|--------------------|-------------|
| **IndicatorCode**  | Unique code for trade indicators |
| **Indicator**      | Type of trade (Exports/Imports) |
| **ReporterCountry** | Country reporting the trade |
| **Partner**        | Trade partner country |
| **ProductCode**    | Unique product identifier |
| **Product**        | Name of traded product |
| **Year**           | Trade year |
| **Value_MillionUSD** | Trade value in million USD |

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


## Analysis Sections

### 📌 Section A: BigQuery Code & Console Screenshots

#### 1️⃣ Yearly Growth of Trade Value (1948-2023)
```sql
WITH YearlyTrade AS (
    SELECT 
        Year, 
        SUM(Value_MillionUSD) AS Trade_Value
    FROM `my-project-1711648161671.World_Trade.Countries_Merchandise_Trade`
    WHERE Product="Total merchandise"
    GROUP BY Year
)
SELECT 
    Year, 
    Trade_Value, 
    LAG(Trade_Value) OVER (ORDER BY Year) AS Prev_Year_Trade_Value,
    ROUND(((Trade_Value - LAG(Trade_Value) OVER (ORDER BY Year)) / LAG(Trade_Value) OVER (ORDER BY Year)) * 100, 2) AS Growth_Percentage
FROM YearlyTrade
ORDER BY Year;
```

#### 2️⃣ India's Total Trade Value (Exports + Imports) (1948-2023)
```sql
SELECT 
    Year, 
    SUM(Value_MillionUSD) AS Total_Trade_Value
FROM `my-project-1711648161671.World_Trade.Countries_Merchandise_Trade`
WHERE ReporterCountry = 'India' AND Product ="Total merchandise"
GROUP BY Year
ORDER BY Year;
```

#### 3️⃣ India's Trade Deficit (1948-2023)
```sql
WITH IndiaTrade AS (
    SELECT 
        Year,
        SUM(CASE WHEN Indicator = 'exports' THEN Value_MillionUSD ELSE 0 END) AS India_Exports,
        SUM(CASE WHEN Indicator = 'imports' THEN Value_MillionUSD ELSE 0 END) AS India_Imports
    FROM `my-project-1711648161671.World_Trade.Countries_Merchandise_Trade`
    WHERE ReporterCountry = 'India' AND Product ="Total merchandise"
    GROUP BY Year
)
SELECT 
    Year,
    India_Exports,
    India_Imports,
    (India_Imports - India_Exports) AS Trade_Deficit,
    CASE 
        WHEN (India_Imports - India_Exports) > 0 THEN 'Trade Deficit'
        ELSE 'Trade Surplus'
    END AS Trade_Status
FROM IndiaTrade
ORDER BY Year;
```

📸 **BigQuery Execution Screenshots:** *(Add screenshots here)*

---

### 📌 Section B: Python Code & Visualizations

#### 📊 Python Code for Data Visualization
```python
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

data = pd.read_csv("path/to/dataset.csv")

plt.figure(figsize=(12,6))
sns.lineplot(data=data, x='Year', y='Value_MillionUSD', hue='Indicator')
plt.title("India's Export & Import Trends (1948-2023)")
plt.xlabel("Year")
plt.ylabel("Trade Value (Million USD)")
plt.legend(title="Trade Type")
plt.show()
```

📸 **Generated Visualizations:** *(Add Python-generated charts here)*

---

### 📌 Section C: ChatGPT AI Report Generation


#### **Insights from the Data**
**India's Trade Performance in 2023:**
- **Exports:** $431,574M (1.81% of global exports, Rank: 17)
- **Imports:** $672,231M (2.77% of global imports, Rank: 8)
- **Total Trade:** $1,103,805M (2.3% of global trade, Rank: 14)
- **Trade Deficit:** $240,657M

**Key Observations:**
- India's **export ranking remains low** despite its economic size.
- Major **import categories** include crude oil, gold, and electronic components.
- **IT services, textiles, and pharmaceuticals** are leading export industries.
- Currency fluctuations and global demand shifts impact India's trade balance.

#### **Conclusion & Challenges**
✅ **Key Challenges Identified:**
1. **High Import Dependency** → India heavily relies on imports for fuels & electronics.
2. **Weak Export Competitiveness** → Export share (1.81%) is lower than India's GDP contribution.
3. **Sector-Specific Deficits** → Pharmaceuticals & food sector trade gaps exist.
4. **Limited Market Penetration** → Exports mostly depend on traditional markets.

#### **Strategic Recommendations & Policy Suggestions**
### 🔹 Boosting Exports
- Expand high-value manufacturing: **AI, semiconductors, electronics**
- Strengthen **trade agreements** with Africa, Latin America, Southeast Asia
- Introduce **tax benefits** for export-driven industries

### 🔹 Reducing Import Dependence
- Increase domestic **pharmaceutical & agriculture production**
- Invest in **renewable energy** to cut oil imports

### 🔹 Strengthening Trade Infrastructure
- **Improve logistics & ports** to cut export costs
- **Ease business regulations** for exporters

📸 **ChatGPT-Generated Reports:** *(Add screenshots here)*

---

##  Final Outlook 🚀
India has the potential to **improve its global trade ranking** by:
- Strengthening **high-value manufacturing exports**
- Reducing **fuel & machinery import dependency**
- Expanding global trade agreements
- Improving **logistics and supply chain efficiency**

By implementing **strategic trade policies**, India can achieve a **more balanced trade profile** in the coming years.

---
## 🔗 References
- **Google BigQuery** Documentation
- **World Bank Trade Data**


---
## 📌 Author
🔹 **GitHub:** [Your GitHub Profile](https://github.com/your-profile)
🔹 **LinkedIn:** [Your LinkedIn](https://linkedin.com/in/your-profile)














