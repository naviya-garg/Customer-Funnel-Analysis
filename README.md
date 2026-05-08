# 📊 Customer Funnel Analysis (SQL + Python)

## 📌 Overview

This project explores how customers move through different stages of a typical e-commerce funnel — from browsing to completing a purchase. The aim is to understand user behavior, identify where drop-offs occur, and measure how long users take to progress between stages.

---

## 🎯 Objectives

* Track customer movement across funnel stages
* Identify key drop-off points in the journey
* Calculate time taken to transition between stages
* Analyze average conversion time
* Compare funnel performance across different cities

---

## 🛠 Tools & Technologies

* **SQL** – for data extraction, transformation, and funnel creation
* **Python (Pandas, Matplotlib, Seaborn, Plotly)** – for analysis and visualization

---

## 📂 Project Structure

```
customer-funnel-analysis/
│
├── data/        → Contains sample dataset (CSV files)
├── sql/         → SQL queries used for analysis
├── python/      → Jupyter Notebook with full analysis & visuals
└── README.md
```

---

## 📊 What This Project Covers

### 1. Funnel Creation

Raw activity data is transformed into a structured funnel for each customer.

### 2. Transition Time Analysis

Calculated the number of days users take to move between stages:

* Browse → Sign Up
* Sign Up → Add to Cart
* Add to Cart → Checkout

### 3. Average Time Calculation

Computed average time taken at each stage to understand overall user behavior.

### 4. Drop-off Analysis

Identified where the highest number of users exit the funnel.

### 5. City-wise Analysis

Compared funnel performance across different cities to uncover patterns.

---

## 📈 Key Insights

* A noticeable drop-off occurs between **Sign Up and Add to Cart**
* Early-stage transitions are relatively faster compared to later stages
* Funnel performance varies across cities, indicating regional behavior differences

---

## 🚀 How to Run the Project

1. Execute SQL queries from the `/sql` folder to prepare the dataset
2. Load the dataset in Python:

   ```python
   pd.read_csv('data/sample_data.csv')
   ```
3. Run the notebook in the `/python` folder
4. Review the visualizations and insights

---

## 📂 Dataset
The `/data` folder contains multiple CSV files representing different tables used in the analysis.

These tables simulate a relational database structure and are used together to perform funnel analysis.

### Tables Included:
- `cust_activity.csv`  
- `cust_bio.csv` 
- `cust_sub.csv` 
- `orders.csv` 
- `subscription`

### Key Fields Used:
- `Cust_ID` – Unique customer identifier  
- `Activity` – Funnel stage (Browse, Sign Up, etc.)  
- `Date` – Activity date  
- `City` – Customer location  

> Note: These datasets are created for demonstration and analysis purposes.

---

## 💡 Business Relevance

This type of analysis helps businesses:

* Improve conversion rates
* Identify bottlenecks in the customer journey
* Make data-driven product and marketing decisions

---

## 🙌 Conclusion

This project demonstrates an end-to-end workflow — from raw data to meaningful insights — using a combination of SQL and Python. It focuses not just on technical implementation, but also on deriving actionable business insights.

---

⭐ If you found this project useful, feel free to explore and share your feedback!
