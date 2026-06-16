<div align="center">

# 🏦 BankIQ — Banking Analytics SQL Project

**A production-grade SQL portfolio project built on a 12-table retail banking database**

`MySQL 8.0+` &nbsp;|&nbsp; `Python 3.10+` &nbsp;|&nbsp; `Pandas` &nbsp;|&nbsp; `Matplotlib` &nbsp;|&nbsp; `Seaborn` &nbsp;|&nbsp; `Status: Complete ✅`

</div>

---

## 📌 Project Overview

BankIQ simulates the internal analytics database of a mid-sized retail bank operating
across **134 cities in India**. Built entirely from scratch — schema design, realistic
data generation, and 40 progressive SQL queries that mirror what real bank analysts,
compliance teams, and fraud teams actually write.

| Metric | Value |
|---|---|
| Total Customers | 150–500 (Faker generated) |
| Total Transactions | 6,169 |
| Total Volume Processed | ₹16.82 Crore |
| Cities Covered | 134 |
| Active Loans | 85 |
| Bad Loan Rate | 14.2% |
| Average Transaction Value | ₹27,269 |

---

## 🗂️ Repository Structure

```
BankIQ/
│
├── README.md                  ← You are here
├── FINDINGS.md                ← Analyst findings report with real insights
├── 01_schema.sql              ← CREATE TABLE for all 12 tables with constraints
├── 02_seed_data.sql           ← Original seed data (30 customers, 60 transactions)
├── 03_queries.sql             ← 40 SQL tasks across 7 progressive phases
├── 04_analysis.ipynb          ← EDA notebook with 6 analytical charts
└── scripts/
    └── generate_data.py       ← Faker script — generates realistic banking data
```

---

## 🗃️ Database Design — 12 Tables

| Table | Description |
|---|---|
| `branches` | 6 physical branches across Mumbai, Delhi, Bangalore, Chennai, Kolkata |
| `employees` | Staff — managers, analysts, loan officers, tellers, compliance officers |
| `customers` | Individual and business customers with KYC status and CIBIL credit scores |
| `accounts` | Savings, Current, Salary, Fixed Deposit, Recurring Deposit accounts |
| `transactions` | UPI, NEFT, RTGS, IMPS, ATM, Auto-debit transactions across 2024 |
| `loans` | Home, Car, Personal, Business, Education, Gold loan products |
| `loan_repayments` | EMI payment records including missed, bounced, and partial payments |
| `cards` | Debit and credit cards across Visa, Mastercard, and RuPay networks |
| `fixed_deposits` | FD detail records with maturity dates and payout configurations |
| `kyc_documents` | PAN, Aadhaar, Passport, Voter ID documents per customer |
| `fraud_alerts` | Flags raised by the multi-rule fraud detection engine |
| `interest_postings` | Quarterly interest credited to savings and deposit accounts |

---

## 🔗 Entity Relationship Overview

```
branches ──< employees
         ──< customers ──< accounts ──< transactions
                       ──< loans    ──< loan_repayments
                       ──< cards
                       ──< kyc_documents
                       accounts ──< fixed_deposits
                       accounts ──< interest_postings
                       loans    ──< fraud_alerts
```

---

## 📋 Query Coverage — 40 Tasks Across 7 Phases

| Phase | Tasks | Skills Covered |
|---|---|---|
| Phase 1 — Schema & Warm-up | 1–8 | DDL, ALTER TABLE, basic SELECT, WHERE, ORDER BY, simple JOINs |
| Phase 2 — Multi-table JOINs | 9–16 | INNER JOIN, LEFT JOIN, anti-join pattern, 4-table JOIN |
| Phase 3 — Aggregation & Subqueries | 17–26 | Scalar subquery, correlated subquery, CASE WHEN, HAVING, date arithmetic |
| Phase 4 — CTEs | 27–31 | WITH clause, chained CTEs, customer health scoring, salary gap analysis |
| Phase 5 — Window Functions | 32–38 | RANK, DENSE_RANK, PERCENT_RANK, LAG, running totals, rolling averages |
| Phase 6 — Fraud Detection | 39 | Self-join time windows, UNION ALL, MOD, EXTRACT, multi-rule engine |
| Phase 7 — Capstone View | 40 | CREATE VIEW backed by 3 chained CTEs, executive dashboard |

---

## ⭐ Project Highlights

### 🔍 Customer Health Scoring (Task 27)
CTE-based scoring system that grades every customer **A / B / C** based on KYC
verification status, missed EMI count, and total account balance — the same logic
used in real bank CRM systems for campaign targeting and risk segmentation.

### 🚨 Multi-Rule Fraud Detection Engine (Task 39)
Flags transactions matching any of 4 independent fraud patterns simultaneously:
- Rapid debit bursts — more than 3 debits within a 60-minute window (self-join)
- Amount anomaly — transaction exceeds 3× the account's own average debit
- Off-hours activity — any transaction between midnight and 04:59 AM
- Round-number high-value — amounts divisible by ₹10,000 above ₹50,000

Built with CTEs and `UNION ALL` so a single transaction can trigger multiple flags.

### 📊 Executive Branch Dashboard View (Task 40)
A single `CREATE VIEW` backed by 3 chained CTEs consolidating monthly transaction
inflow, loan portfolio size, bad loan count, customer headcount, and average credit
score per branch — all queryable with a single `SELECT` statement.

### 📈 Exploratory Data Analysis (04_analysis.ipynb)
Six analytical charts built with Matplotlib and Seaborn on real Faker-generated data:
- Monthly transaction volume trend (2024)
- Branch performance comparison by total deposits
- Customer credit score distribution with CIBIL band overlays
- Loan default rate by city
- Top 5 spending categories by debit amount
- Account type distribution by count and balance held

---

## 📊 Key Findings

> Full analysis available in [`FINDINGS.md`](./FINDINGS.md)

- **14.2% bad loan rate** (19 out of 134 loans are Defaulted or NPA) — significantly above the 3–5% industry benchmark
- **Tier-2 cities outperform metros on credit scores** — Tadepalligudem (885), Kumbakonam (872) vs Mumbai (770), Delhi (777)
- **58% of cities have only 1 customer** — geographic concentration risk is high with Mumbai carrying disproportionate weight
- **Average transaction value of ₹27,269** suggests BankIQ is being used as a secondary bank by many customers — transaction frequency per customer is a key growth lever

---

## ⚙️ Setup Instructions

**Requirements:** MySQL 8.0+ · Python 3.10+ · pip

**Step 1 — Create the database**
```sql
CREATE DATABASE bank_system;
USE bank_system;
```

**Step 2 — Create all 12 tables**
```bash
mysql -u root -p bank_system < 01_schema.sql
```

**Step 3 — Insert seed data**
```bash
mysql -u root -p bank_system < 02_seed_data.sql
```

**Step 4 — Generate realistic data volume (optional but recommended)**
```bash
pip install faker mysql-connector-python
python scripts/generate_data.py
```

**Step 5 — Run all 40 queries**
```bash
mysql -u root -p bank_system < 03_queries.sql
```

**Step 6 — Run the EDA notebook**
```bash
pip install pandas sqlalchemy pymysql matplotlib seaborn jupyter
jupyter notebook 04_analysis.ipynb
```

---

## 🛠️ Skills Demonstrated

- Relational schema design with primary keys, foreign keys, and CHECK constraints
- Handling circular foreign key dependencies between `branches` and `employees`
- Multi-table JOINs across up to 4 tables in a single query
- Anti-join pattern using `LEFT JOIN + IS NULL`
- Scalar and correlated subqueries
- Conditional aggregation with `CASE WHEN` inside `SUM` and `COUNT`
- Common Table Expressions — simple, chained, and multi-level
- Window functions — `RANK`, `DENSE_RANK`, `PERCENT_RANK`, `LAG`, `FIRST_VALUE`
- Running totals with `ROWS UNBOUNDED PRECEDING`
- Rolling averages with `ROWS BETWEEN` frame clauses
- Time-based self-join for sliding window fraud detection
- `CREATE VIEW` for reusable reporting layers
- Python + SQLAlchemy database connectivity
- Exploratory data analysis with Pandas, Matplotlib, and Seaborn
- Realistic data generation with the Faker library

---

## 📝 Resume Summary

> *Designed and built a 12-table retail banking analytics database in MySQL from scratch,
> modelling customers, accounts, transactions, loans, KYC compliance, and fraud alerts
> across 134 Indian cities with 6,169 transactions totalling ₹16.82 Crore. Wrote 40
> progressively complex SQL queries covering multi-table JOINs, correlated subqueries,
> window functions (LAG, RANK, running totals, rolling averages), chained CTEs, and a
> multi-rule fraud detection engine using self-join time windows and UNION ALL. Delivered
> a parameterised executive dashboard VIEW backed by 3 chained CTEs and a 6-chart EDA
> notebook in Python identifying a 14.2% bad loan rate and counter-intuitive credit score
> patterns across Tier-2 Indian cities.*

---

## 👤 Author

**Tatva V. Khara**  
Vapi, Gujarat, India  
 kharatatva60@gmail.com

---

<div align="center">

*MySQL 8.0+ &nbsp;|&nbsp; Python 3.10+ &nbsp;|&nbsp; Domain: Retail Banking &nbsp;|&nbsp; Type: Portfolio Project*

⭐ If you found this project useful, consider giving it a star

</div>
