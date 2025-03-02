# 🌍 Global Merchandise Trade (1947-2023) Analysis using ChatGPT AI, Google BigQuery & Python

## 📌 Project Overview
This project analyzes **global merchandise trade trends from 1947 to 2023**, with a primary focus on **India's trade performance**. The dataset is sourced from **Google BigQuery** and consists of key indicators such as **exports, imports, total trade, and trade deficit** for different countries. The analysis leverages:

✅ **Google BigQuery** for data extraction 📊  
✅ **Python** for data processing & visualization 🐍  
✅ **ChatGPT AI** for insights generation 🤖  
✅ **Automated PDF Report** for structured storytelling 📄

---

## 📊 Key Objectives
🔹 Analyze **India's exports, imports, total trade, and trade deficit** over time.  
🔹 Compare **India's trade performance** against **global leaders**.  
🔹 Identify **key trade trends, challenges, and opportunities** for improvement.  

---

## 📊 Key Questions Analyzed
1️⃣ **How has global trade evolved from 1947 to 2023?**  
2️⃣ **What is India’s trade performance in exports, imports, and total trade?**  
3️⃣ **How has India’s trade deficit changed over time?**  
4️⃣ **How does India compare with top exporting and importing nations?**  
5️⃣ **What are the key challenges in India’s trade landscape?**  
6️⃣ **What strategies can improve India’s trade competitiveness?**  

---

## 📊 Dataset Overview
### 📂 Dataset Structure
| Column Name        | Description                            |
|--------------------|------------------------------------|
| **IndicatorCode**   | Unique code for trade indicators   |
| **Indicator**       | Type of trade (Exports/Imports)   |
| **ReporterCountry** | Country reporting the trade       |
| **Partner**        | Trade partner country             |
| **ProductCode**    | Unique product identifier         |
| **Product**        | Name of traded product           |
| **Year**           | Trade year                         |
| **Value_MillionUSD** | Trade value in million USD        |

---

## 📥 Installation
### 🚀 Clone the Repository
```bash
git clone https://github.com/yourusername/Global-Trade-Analysis.git
cd Global-Trade-Analysis
```
### 📦 Install Dependencies
```bash
pip install pandas matplotlib seaborn fpdf google-cloud-bigquery
```
### 🔑 Set Up Google BigQuery Credentials
1️⃣ Create a **Google Cloud Project**.  
2️⃣ Enable **BigQuery API**.  
3️⃣ Download your **service account JSON key** and set it as an environment variable:  
```bash
export GOOGLE_APPLICATION_CREDENTIALS="path/to/your-key.json"
```

---

## 📜 Analysis & Code Overview 

## 📌 Section A: Some BigQuery Code & Console Screenshots

### 1️⃣ Yearly Growth of Trade Value (1948-2023)
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

### 2️⃣ India's Total Trade Value (Exports + Imports) (1948-2023)
```sql
SELECT 
    Year, 
    SUM(Value_MillionUSD) AS Total_Trade_Value
FROM `my-project-1711648161671.World_Trade.Countries_Merchandise_Trade`
WHERE ReporterCountry = 'India' AND Product ="Total merchandise"
GROUP BY Year
ORDER BY Year;
```

### 3️⃣ India's Trade Deficit (1948-2023)
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
📸 **BigQuery Execution Screenshots:**

*https://github.com/pradip-data/World-Merchandise-Trade/blob/866246cb9e2593a5b7c0960b7441ef9257ffa98e/Bigquery%20Google%20Cloud%20Console%20project%20images/BigQuery-Google%20Cloud%20Console%201.png*

*https://github.com/pradip-data/World-Merchandise-Trade/blob/3223d8a7157473066f1796867760e0286724330e/Bigquery%20Google%20Cloud%20Console%20project%20images/BigQuery-Google%20Cloud%20Console%202.png*

---

## 📌 Section B: Python Code & Visualizations
### 📊 Python Code for Data Visualization
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
📸 **Generated Visualizations:** 

*1.*

---

## 📌 Section C: ChatGPT AI Report Generation
🔍 *(Screenshots and code snippets will be placed here)*

---


# 🌍 India's Trade Performance Analysis (2023) 🚀

## 📊 Insights: India's Trade Performance in 2023

- **Exports:** 💰 $431,574 Million USD
- **India's Export Percentage:** 🌎 1.81%
- **Export Rank:** 📈 17
- **Imports:** 💰 $672,231 Million USD
- **India's Import Percentage:** 🌍 2.77%
- **Import Rank:** 📉 8
- **Total Trade:** 💰 $1,103,805 Million USD
- **India's Total Trade Percentage:** 🌏 2.3%
- **Trade Rank:** 📊 14
- **Trade Deficit:** ❌ $240,657 Million USD

India remains one of the largest players in global trade. In 2023, India's exports crossed **$431,574 million**, placing it among the **top exporters** worldwide. However, its **imports outpaced exports**, leading to a **significant trade deficit**. India continues to be a major importer of **crude oil, gold, and electronic components**, while its key export sectors include **pharmaceuticals, IT services, and textiles**. The trade balance has been influenced by **global economic conditions, currency fluctuations, and demand shifts** in international markets.

---

## 🌎 Top Exporting Countries & Rankings (2023)

- 1️⃣ **China** - $3,379,255M
- 2️⃣ **United States** - $2,020,606M
- 3️⃣ **Germany** - $1,718,251M
- 4️⃣ **Netherlands** - $936,392M
- 5️⃣ **Japan** - $717,261M
- 6️⃣ **Italy** - $676,993M
- 7️⃣ **France** - $648,569M
- 8️⃣ **South Korea** - $632,226M
- 9️⃣ **Mexico** - $593,005M
- 🔟 **Hong Kong** - $573,871M

---

## 🌍 Top Importing Countries & Rankings (2023)

- 1️⃣ **United States** - $3,172,476M
- 2️⃣ **China** - $2,556,565M
- 3️⃣ **Germany** - $1,476,656M
- 4️⃣ **Netherlands** - $842,331M
- 5️⃣ **United Kingdom** - $791,523M
- 6️⃣ **France** - $786,158M
- 7️⃣ **Japan** - $785,796M
- 8️⃣ **India** - $672,231M
- 9️⃣ **Hong Kong** - $653,696M
- 🔟 **South Korea** - $642,572M

---

## 💰 Countries with the Highest Trade Surpluses (2023)

🔹 **China** - $822,690M
🔹 **Germany** - $241,595M
🔹 **Russia** - $120,925M
🔹 **Saudi Arabia** - $113,078M
🔹 **Netherlands** - $94,061M

---

## 🔴 Countries with the Highest Trade Deficits (2023)

❌ **United States** - $1,151,870M
❌ **United Kingdom** - $270,483M
❌ **India** - $240,657M
❌ **France** - $137,589M
❌ **Türkiye** - $106,327M

---

## ⚠️ Key Challenges Identified

- 1️⃣ **High Import Dependency** 🏭: India imports more than it exports in key categories like **fuels, machinery, and pharmaceuticals**, leading to a trade imbalance.
- 2️⃣ **Weak Export Competitiveness** 📉: India's **export share (1.81%)** is much lower than its economic size, indicating **low global competitiveness**.
- 3️⃣ **Sector-Specific Deficits** 🏥: Deficits in **pharmaceuticals and food sectors** suggest a **need for domestic production growth and export incentives**.
- 4️⃣ **Limited Market Penetration** 🌎: India relies **heavily on traditional export markets**, limiting its trade reach.

---

## 🎯 Strategic Recommendations & Policy Suggestions

### A. 🚀 Boosting Exports
✅ **Expand High-Value Manufacturing** 🔧
   - Encourage **semiconductor, AI, and high-tech industries**
   - Invest in **automobile and electronics manufacturing**
✅ **Strengthen Trade Agreements** 🤝
   - Negotiate **preferential trade deals** with **Africa, Latin America, and Southeast Asia**
✅ **Enhance Export Incentives** 📈
   - Introduce **tax benefits for export-driven industries**

### B. 📉 Reducing Import Dependence
✅ **Increase Domestic Production in Deficit Sectors** 🏭
   - Expand **pharmaceutical manufacturing** to reduce **$17.9B deficit**
   - Boost **agriculture and textile production** to cut food & clothing imports
✅ **Invest in Renewable Energy** ☀️
   - Reduce **oil import dependency ($220.6B)** by investing in **solar, wind, and green hydrogen**

### C. 🚢 Strengthening Trade Infrastructure
✅ **Improve Logistics & Ports** ⚓
   - Reduce **trade costs and shipment delays** to make exports more competitive
✅ **Ease Business Regulations** 📜
   - Simplify **tax laws and streamline customs processes** for exporters

### D. 🌏 Diversifying Export Markets
✅ **Expand Beyond Traditional Markets** 🌍
   - Strengthen trade with **Africa, Middle East, and Latin America**
   - Reduce **over-reliance on US and European markets**

---

## 🔮 Final Outlook

India has the **potential to become a major global trade powerhouse** but must address **its trade deficit, boost exports, and reduce import dependence**. By implementing **strategic manufacturing policies, improving infrastructure, and diversifying export markets**, India can move **up in global trade rankings** and achieve a **more balanced trade profile** in the coming years.

### 🎯 Key Focus Areas for 2024 & Beyond
- ✅ Strengthen **high-value manufacturing exports**
- ✅ Reduce **fuel & machinery import dependency**
- ✅ Improve **trade policies and agreements**
- ✅ Expand **global market reach beyond traditional partners**
- ✅ Invest in **logistics and supply chain efficiency** 🚢

---

### 📊 BigQuery Analysis & Python Visualizations

📌 **BigQuery SQL Code & Execution Screenshots**
📌 **Python Code for Trade Analysis & Data Visualization**
📌 **ChatGPT AI Report Generation & Insights**


## 🏆 Final Thoughts
India has the potential to become a **major global trade powerhouse** but must address:

📉 **Trade Deficit Challenges** – Reduce reliance on imports.  
🚀 **Boost Export Competitiveness** – Focus on high-value industries.  
🌎 **Expand Market Reach** – Diversify beyond traditional partners.  

By implementing **strategic policies**, **investing in infrastructure**, and **expanding global trade agreements**, India can significantly improve its trade rankings and achieve a **balanced trade profile** in the coming years.  

---

🔗 **Author & Contributions**  
👤 Your Name - [GitHub](https://github.com/yourusername)  
📩 For inquiries, reach out at: **your.email@example.com**  
---





























