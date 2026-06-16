# BankIQ — Analyst Findings Report

**Prepared by:** Tatva V. Khara  
**Database:** BankIQ Retail Banking System  
**Data Coverage:** 134 cities across India | 6,169 transactions | ₹16.82 Cr total volume  
**Analysis Date:** June 2025  

---

## Executive Summary

BankIQ operates as a retail bank serving customers across 134 cities in India, with the highest
customer concentration in Mumbai (11), followed by Delhi, Bangalore, and Chennai (6 each).
The total transaction volume processed stands at ₹16.82 Crore across 6,169 transactions.
The loan portfolio is predominantly healthy — 85 active loans — but carries a notable default
exposure with 14 defaulted loans and 5 classified as NPA, representing a combined bad loan
rate of approximately 14.4% of the total portfolio which warrants immediate attention from
the risk and collections teams.

---

## Key Findings

---

### 1. Geographic Concentration Risk

The customer base spans 134 cities which reflects strong geographic reach, however the
distribution is heavily skewed. Mumbai alone accounts for a disproportionate share of
customers while 78 out of 134 cities (58%) have only a single customer on record.

| City | Customers |
|---|---|
| Mumbai | 11 |
| Delhi | 6 |
| Bangalore | 6 |
| Chennai | 6 |
| Kolkata | 5 |

**Insight:** The bank's revenue and risk are highly concentrated in 5 major metros. A
localised economic disruption in Mumbai would have an outsized impact on the overall
portfolio compared to any other geography. Tier-2 city presence exists but is too thin
to provide meaningful diversification at this stage.

---

### 2. Credit Score Health — A Tale of Two Segments

The average credit score across the customer base varies significantly by city. Smaller
Tier-2 and Tier-3 cities — Tadepalligudem (885), Kumbakonam (872), Chinsurah (868) —
show higher average credit scores than the major metros.

| Segment | Cities | Avg Credit Score |
|---|---|---|
| Top performing (Tier-2/3) | Tadepalligudem, Kumbakonam, Chinsurah | 868–885 |
| Major metros | Mumbai, Delhi, Bangalore | 762–777 |
| Lowest performing | Nangloi Jat, Chapra, Bulandshahr | 304–316 |

**Insight:** Counter-intuitively, the cities with the most customers (metros) do not have
the strongest credit profiles. The bank's highest credit quality customers are concentrated
in Tier-2 cities where the customer base is small. This suggests an opportunity to deepen
penetration in high-credit-score Tier-2 markets rather than further expanding in metros
where credit risk is relatively higher.

---

### 3. Loan Portfolio — Elevated Bad Loan Exposure

The loan book of 134 total loans shows a concerning concentration of stress:

| Loan Status | Count | Share |
|---|---|---|
| Active | 85 | 63.4% |
| Closed | 29 | 21.6% |
| Defaulted | 14 | 10.4% |
| NPA | 5 | 3.7% |
| Restructured | 1 | 0.7% |

**Bad loan rate: 14.2%** (Defaulted + NPA combined = 19 loans out of 134)

**Insight:** A 14.2% bad loan rate is significantly above the industry benchmark of 3–5%
for retail banks. The 14 defaulted loans combined with 5 NPA accounts represent a material
credit risk that requires immediate intervention from the collections and legal teams.
The restructured loan count of 1 suggests the bank has limited experience in loan
restructuring as a recovery tool — this could be explored further as an alternative
to straight defaults.

---

### 4. Transaction Volume Analysis

Total transactions processed: **6,169**  
Total value: **₹16,82,17,824.80 (₹16.82 Crore)**  
Average transaction value: **₹27,269**

**Insight:** With 6,169 transactions across 134 cities, the average transaction frequency
per customer is relatively low — indicating either a young customer base still building
banking habits or a significant portion of customers using BankIQ as a secondary bank
rather than their primary account. Increasing transaction frequency per existing customer
should be a key growth lever alongside new customer acquisition.

---

### 5. Credit Score Distribution Pattern

The distribution of credit scores reveals a bimodal pattern — a cluster of customers in
the 580–670 range (Fair) and another cluster in the 740–850 range (Very Good to Exceptional).
The mean and median scores sit close to each other, suggesting no extreme outliers are
distorting the average.

Cities with average scores below 400 — Nangloi Jat (305), Chapra (304), Bulandshahr (309) —
represent high-risk micro-markets where loan products should be offered conservatively
and with stricter eligibility criteria.

---

## Recommendations

**1. Immediate: Launch targeted collections campaign on 19 bad loans**  
The 14 defaulted and 5 NPA loans should be segmented by outstanding amount, geography,
and collateral status. Loans with collateral should be prioritised for legal recovery
proceedings. Unsecured defaults should be assigned to an external collections agency.
Every quarter of delay increases provisioning requirements and erodes profitability.

**2. Short-term: Deepen presence in high credit score Tier-2 cities**  
Cities like Tadepalligudem, Kumbakonam, Chinsurah, and Navi Mumbai show average credit
scores above 850 but have only 1–2 customers each. These are ideal markets for targeted
personal loan and credit card campaigns where default risk is statistically low and
acquisition cost is lower than in saturated metros.

**3. Medium-term: Increase transaction frequency through digital engagement**  
The low average transactions per customer suggests underutilisation. A UPI cashback
programme, auto-pay setup incentives, and salary account partnerships with local employers
in Tier-2 cities would drive transaction volume without requiring new customer acquisition.

---

## Methodology & Data Notes

This analysis is based on a MySQL relational database containing 12 tables modelling
customers, accounts, transactions, loans, repayments, cards, KYC documents, and fraud
alerts. Customer data was generated using the Python Faker library seeded with realistic
Indian demographic patterns. Transaction data spans calendar year 2024. Credit scores
range from 300 to 900 following the standard CIBIL scoring model used in India.

All monetary values are in Indian Rupees (₹). Lakhs notation (L) is used for figures
above ₹1,00,000. City-level statistics with fewer than 2 customers should be interpreted
with caution due to small sample sizes.

---

*This report was produced as part of the BankIQ SQL Portfolio Project.*  
*For query details refer to `03_queries.sql`. For data generation refer to `scripts/generate_data.py`.*
