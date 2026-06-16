-- ============================================================

--  ██████╗  █████╗ ███╗   ██╗██╗  ██╗██╗ ██████╗
--  ██╔══██╗██╔══██╗████╗  ██║██║ ██╔╝██║██╔═══██╗
--  ██████╔╝███████║██╔██╗ ██║█████╔╝ ██║██║   ██║
--  ██╔══██╗██╔══██║██║╚██╗██║██╔═██╗ ██║██║▄▄ ██║
--  ██████╔╝██║  ██║██║ ╚████║██║  ██╗██║╚██████╔╝
--  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝╚═╝ ╚══▀▀═╝
-- ============================================================
--  Project      : BankIQ — Banking Analytics SQL Project
--  Author       : [Your Name]
--  Database     : MySQL 8+
--  Description  : 40 progressive SQL queries covering schema
--                 design, joins, aggregations, subqueries,
--                 CTEs, window functions, and fraud detection
--                 built on a 12-table retail banking system.
--  GitHub       : [Your GitHub Link]
-- ============================================================
CREATE DATABASE IF NOT EXISTS bank_system;
USE bank_system;


-- ============================================================
--  PHASE 1 — SCHEMA & WARM-UP  (Tasks 1–8)
--  Skills: DDL, basic SELECT, WHERE, ORDER BY, JOIN
-- ============================================================


-- ------------------------------------------------------------
-- TASK 1 — Add Foreign Key: Branch Manager → Employee
-- After inserting employees, link each branch to its manager.
-- This is done after both tables are populated to avoid
-- circular FK dependency during initial table creation.
-- ------------------------------------------------------------

-- ALTER TABLE branches
--     ADD CONSTRAINT fk_manager_id
--     FOREIGN KEY (manager_emp_id)
--     REFERENCES employees (emp_id);

-- ------------------------------------------------------------
-- TASK 2 — Customer Directory with Branch Details
-- List every customer with their assigned branch name and city.
-- ------------------------------------------------------------

SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    c.email,
    c.city,
    b.branch_name
FROM customers AS c
JOIN branches AS b
    ON b.branch_id = c.branch_id;


-- ------------------------------------------------------------
-- TASK 3 — High-Value Active Savings Accounts
-- Find all active accounts with a balance above ₹1,00,000.
-- ------------------------------------------------------------

SELECT
    *
FROM accounts
WHERE balance > 100000
    AND status = 'Active';


-- ------------------------------------------------------------
-- TASK 4 — Recently Joined Customers (2022 onwards)
-- List all customers who joined in 2022 or later,
-- sorted by most recent join date first.
-- ------------------------------------------------------------

SELECT *
FROM customers
WHERE YEAR(joined_on) >= 2022
ORDER BY joined_on DESC;


-- ------------------------------------------------------------
-- TASK 5 — Large Transactions in January 2024
-- Find all transactions above ₹50,000 made in January 2024.
-- ------------------------------------------------------------

SELECT *
FROM transactions
WHERE txn_date BETWEEN '2024-01-01' AND '2024-01-31'
  AND amount > 50000
ORDER BY txn_date ASC;


-- ------------------------------------------------------------
-- TASK 6 — Account Count per Customer
-- Show how many accounts each customer holds.
-- Includes customers with zero accounts via LEFT JOIN.
-- ------------------------------------------------------------

SELECT
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    c.customer_type,
    COUNT(a.account_id)                     AS account_count
FROM customers c
LEFT JOIN accounts a ON a.customer_id = c.customer_id
GROUP BY c.customer_id, customer_name, c.customer_type;


-- ------------------------------------------------------------
-- TASK 7 — Loans with High Outstanding Balance
-- Find loans where more than 80% of the principal
-- is still outstanding — high-risk borrowers.
-- ------------------------------------------------------------

SELECT *
FROM loans
WHERE outstanding > (0.80 * principal);


-- ------------------------------------------------------------
-- TASK 8 — Loan Officers and Their Branch Locations
-- List all employees in the Loan Officer role
-- along with the city they operate from.
-- ------------------------------------------------------------

SELECT
    e.*,
    b.city
FROM employees e
JOIN branches b ON b.branch_id = e.branch_id
WHERE e.role = 'Loan Officer';


-- ============================================================
--  PHASE 2 — MULTI-TABLE JOINS  (Tasks 9–16)
--  Skills: Multi-table JOIN, anti-join, LEFT JOIN + IS NULL
-- ============================================================


-- ------------------------------------------------------------
-- TASK 9 — Full Customer–Account–Branch Report
-- Three-table join showing customer, account, and
-- branch details in a single consolidated report.
-- ------------------------------------------------------------

SELECT
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    a.account_number,
    a.account_type,
    a.status,
    a.balance,
    b.branch_name,
    b.city
FROM customers c
JOIN accounts a  ON a.customer_id = c.customer_id
JOIN branches b  ON b.branch_id   = c.branch_id;


-- ------------------------------------------------------------
-- TASK 10 — Customers with Accounts but Zero Transactions
-- Anti-join pattern: LEFT JOIN on transactions + IS NULL
-- finds accounts that have never had any activity.
-- ------------------------------------------------------------

SELECT
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    c.customer_id,
    a.account_id,
    a.account_number
FROM customers c
JOIN accounts a      ON a.customer_id = c.customer_id
LEFT JOIN transactions t ON t.account_id = a.account_id
WHERE t.txn_id IS NULL;


-- ------------------------------------------------------------
-- TASK 11 — Branch-Level Summary Report
-- For each branch: total unique customers, total accounts,
-- and combined capital (sum of all account balances).
-- ------------------------------------------------------------

SELECT
    c.branch_id,
    COUNT(DISTINCT c.customer_id) AS total_customers,
    COUNT(a.account_id)           AS total_accounts,
    SUM(a.balance)                AS total_capital_in_bank
FROM customers c
JOIN accounts a ON a.customer_id = c.customer_id
GROUP BY c.branch_id;


-- ------------------------------------------------------------
-- TASK 12 — Loan Portfolio with Officer and Branch Details
-- Four-table join. LEFT JOIN on employees handles cases
-- where a loan officer has not been assigned (NULL).
-- ------------------------------------------------------------

SELECT
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    l.loan_type,
    l.principal,
    l.outstanding,
    l.status                                AS loan_status,
    b.branch_name,
    CONCAT(e.first_name, ' ', e.last_name)  AS loan_officer_name
FROM customers c
JOIN loans l         ON l.customer_id     = c.customer_id
LEFT JOIN employees e ON e.emp_id         = l.loan_officer_id
JOIN branches b      ON b.branch_id       = l.branch_id;


-- ------------------------------------------------------------
-- TASK 13 — Customers with Both a Savings Account and Active Loan
-- Uses DISTINCT to avoid duplicates when a customer
-- holds multiple savings accounts or loans.
-- ------------------------------------------------------------

SELECT DISTINCT
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    a.account_number,
    a.account_type,
    l.loan_type,
    l.status                                AS loan_status
FROM customers c
JOIN accounts a ON a.customer_id = c.customer_id
JOIN loans l    ON l.customer_id = c.customer_id
WHERE a.account_type = 'Savings'
  AND l.status       = 'Active';


-- ------------------------------------------------------------
-- TASK 14 — Credit Card Utilisation Report
-- Shows outstanding balance vs credit limit for each
-- credit card holder. Debit cards excluded (no credit limit).
-- Utilisation % = (outstanding / limit) × 100
-- ------------------------------------------------------------

SELECT
    CONCAT(c.first_name, ' ', c.last_name)          AS customer_name,
    ca.card_type,
    ca.card_network,
    ca.card_number_last4,
    ca.issued_on,
    ca.expiry_date,
    ca.credit_limit,
    ca.outstanding_due,
    ROUND(ca.outstanding_due / ca.credit_limit * 100, 2) AS utilisation_pct
FROM cards ca
JOIN accounts a  ON a.account_id   = ca.account_id
JOIN customers c ON c.customer_id  = ca.customer_id
WHERE ca.card_type = 'Credit';


-- ------------------------------------------------------------
-- TASK 15 — Pending and Expired KYC Documents
-- Compliance report flagging customers whose KYC
-- is either awaiting review or has lapsed.
-- ------------------------------------------------------------

SELECT
    b.branch_id,
    b.branch_name,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    kyc.*
FROM kyc_documents kyc
JOIN customers c ON kyc.customer_id = c.customer_id
JOIN branches b  ON c.branch_id     = b.branch_id
WHERE kyc.status IN ('Pending', 'Expired');


-- ------------------------------------------------------------
-- TASK 16 — Monthly EMI Collection Report (2024)
-- Total EMI amount collected per month across all loans.
-- Useful for cash flow and collections team reporting.
-- ------------------------------------------------------------

SELECT
    EXTRACT(MONTH FROM payment_date) AS month_number,
    SUM(amount_paid)                 AS total_emi_collected
FROM loan_repayments
WHERE EXTRACT(YEAR FROM payment_date) = 2024
GROUP BY EXTRACT(MONTH FROM payment_date)
ORDER BY month_number ASC;


-- ============================================================
--  PHASE 3 — AGGREGATION & SUBQUERIES  (Tasks 17–26)
--  Skills: Scalar subquery, correlated subquery,
--          CASE WHEN aggregation, HAVING, date arithmetic
-- ============================================================


-- ------------------------------------------------------------
-- TASK 17 — Accounts Above Bank-Wide Average Savings Balance
-- Scalar subquery computes the average once; outer query
-- filters accounts that exceed it.
-- ------------------------------------------------------------

SELECT *
FROM accounts a
WHERE a.balance > (
    SELECT AVG(balance)
    FROM accounts
    WHERE account_type = 'Savings'
);


-- ------------------------------------------------------------
-- TASK 18 — Top Balance Customer per City
-- Correlated subquery finds the maximum balance in each
-- city and returns the customer who holds it.
-- Covers Savings and Current accounts only.
-- ------------------------------------------------------------

SELECT
    c.city,
    b.branch_name,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    a.balance
FROM customers c
JOIN accounts a  ON a.customer_id = c.customer_id
JOIN branches b  ON b.branch_id   = c.branch_id
WHERE a.account_type IN ('Savings', 'Current')
  AND a.balance = (
      SELECT MAX(a2.balance)
      FROM customers c2
      JOIN accounts a2 ON a2.customer_id = c2.customer_id
      WHERE c2.city          = c.city
        AND a2.account_type IN ('Savings', 'Current')
  );


-- ------------------------------------------------------------
-- TASK 19 — High-Risk Branches by Average Loan Outstanding
-- Identifies branches where the average outstanding
-- loan balance exceeds ₹20,00,000.
-- ------------------------------------------------------------

SELECT
    b.branch_id,
    b.branch_name,
    b.city,
    b.state,
    ROUND(AVG(l.outstanding), 2) AS avg_loan_outstanding
FROM branches b
JOIN loans l ON l.branch_id = b.branch_id
GROUP BY b.branch_id, b.branch_name, b.city, b.state
HAVING AVG(l.outstanding) > 2000000;


-- ------------------------------------------------------------
-- TASK 20 — Accounts Spending More Than They Receive (2024)
-- Conditional aggregation with CASE WHEN inside SUM.
-- HAVING filters only accounts where debits exceed credits.
-- ------------------------------------------------------------

SELECT
    t.account_id,
    CONCAT(c.first_name, ' ', c.last_name)                         AS customer_name,
    c.city,
    SUM(CASE WHEN t.txn_type = 'Debit'  THEN t.amount ELSE 0 END)  AS total_debit,
    SUM(CASE WHEN t.txn_type = 'Credit' THEN t.amount ELSE 0 END)  AS total_credit
FROM transactions t
JOIN accounts a  ON a.account_id  = t.account_id
JOIN customers c ON c.customer_id = a.customer_id
WHERE EXTRACT(YEAR FROM t.txn_date) = 2024
GROUP BY t.account_id, c.customer_id, customer_name, c.city
HAVING SUM(CASE WHEN t.txn_type = 'Debit'  THEN t.amount ELSE 0 END) >
       SUM(CASE WHEN t.txn_type = 'Credit' THEN t.amount ELSE 0 END);


-- ------------------------------------------------------------
-- TASK 21 — Monthly Transaction Volume Trend (2024)
-- Breakdown of total transactions, credits, and debits
-- per month for the full year 2024.
-- ------------------------------------------------------------

SELECT
    EXTRACT(MONTH FROM txn_date)                                    AS month_number,
    COUNT(*)                                                        AS total_transactions,
    SUM(CASE WHEN txn_type = 'Credit' THEN amount ELSE 0 END)      AS total_credited,
    SUM(CASE WHEN txn_type = 'Debit'  THEN amount ELSE 0 END)      AS total_debited
FROM transactions
WHERE EXTRACT(YEAR FROM txn_date) = 2024
GROUP BY EXTRACT(MONTH FROM txn_date)
ORDER BY month_number ASC;


-- ------------------------------------------------------------
-- TASK 22 — Dormant Accounts (No Activity for 180+ Days)
-- Uses DATEDIFF against last_txn_date from accounts table.
-- Note: The status column is intentionally not used here as
-- the status flag in the data may not always be up to date.
-- Using date arithmetic gives a more reliable result.
-- ------------------------------------------------------------

SELECT *,
    DATEDIFF(CURRENT_DATE, last_txn_date) AS days_since_last_txn
FROM accounts
WHERE DATEDIFF(CURRENT_DATE, last_txn_date) > 180;


-- ------------------------------------------------------------
-- TASK 23 — Top 3 Spending Categories (2024)
-- Ranks debit transaction categories by total amount spent.
-- Useful for customer behaviour and product analysis.
-- ------------------------------------------------------------

SELECT
    category,
    SUM(amount) AS total_amount_spent
FROM transactions
WHERE EXTRACT(YEAR FROM txn_date) = 2024
  AND txn_type = 'Debit'
GROUP BY category
ORDER BY total_amount_spent DESC
LIMIT 3;


-- ------------------------------------------------------------
-- TASK 24 — Customers with at Least One Missed EMI
-- EXISTS subquery efficiently checks loan_repayments
-- without pulling unnecessary rows into the outer query.
-- ------------------------------------------------------------

SELECT c.*
FROM customers c
WHERE EXISTS (
    SELECT 1
    FROM loans l
    JOIN loan_repayments lr ON lr.loan_id = l.loan_id
    WHERE l.customer_id = c.customer_id
      AND lr.status     = 'Missed'
);


-- ------------------------------------------------------------
-- TASK 25 — Loan Portfolio Summary by Loan Type
-- Multi-metric aggregation per loan type:
-- count, total principal, total outstanding, avg interest rate.
-- Active filter inside CASE WHEN to isolate live loans.
-- ------------------------------------------------------------

SELECT
    l.loan_type,
    COUNT(*)                                                                AS total_loans,
    SUM(CASE WHEN l.status = 'Active' THEN l.principal    ELSE 0 END)      AS total_principal,
    SUM(CASE WHEN l.status = 'Active' THEN l.outstanding  ELSE 0 END)      AS total_outstanding,
    ROUND(AVG(CASE WHEN l.status = 'Active' THEN l.interest_rate END), 2)  AS avg_interest_rate
FROM loans l
GROUP BY l.loan_type;


-- ------------------------------------------------------------
-- TASK 26 — Accounts Below Minimum Balance
-- Flags accounts that have fallen below their required
-- minimum balance and calculates the exact shortfall.
-- ------------------------------------------------------------

SELECT *,
    (min_balance - balance) AS shortfall_amount
FROM accounts
WHERE balance < min_balance;


-- ============================================================
--  PHASE 4 — COMMON TABLE EXPRESSIONS  (Tasks 27–31)
--  Skills: WITH clause, chained CTEs, window functions in CTEs
-- ============================================================


-- ------------------------------------------------------------
-- TASK 27 — Customer Health Score
-- CTE computes per-customer: total balance, loan count,
-- missed EMI count, and KYC status.
-- Final SELECT assigns a health grade A / B / C.
--   Grade A: Verified KYC, zero missed EMIs, balance > ₹1L
--   Grade B: Verified KYC, at most 1 missed EMI
--   Grade C: Everything else (unverified, high risk)
-- ------------------------------------------------------------

WITH customer_metrics AS (
    SELECT
        c.customer_id,
        CONCAT(c.first_name, ' ', c.last_name)  AS customer_name,
        c.kyc_status,
        SUM(a.balance)                           AS total_balance,
        COUNT(DISTINCT l.loan_id)                AS total_loans,
        COUNT(CASE WHEN lr.status = 'Missed' THEN 1 END) AS missed_emi
    FROM customers c
    LEFT JOIN accounts a         ON a.customer_id = c.customer_id
    LEFT JOIN loans l            ON l.customer_id = c.customer_id
    LEFT JOIN loan_repayments lr ON lr.loan_id    = l.loan_id
    GROUP BY c.customer_id, customer_name, c.kyc_status
)
SELECT *,
    CASE
        WHEN kyc_status = 'Verified' AND missed_emi = 0 AND total_balance > 100000 THEN 'A'
        WHEN kyc_status = 'Verified' AND missed_emi <= 1                           THEN 'B'
        ELSE                                                                            'C'
    END AS health_score
FROM customer_metrics
ORDER BY health_score, total_balance DESC;


-- ------------------------------------------------------------
-- TASK 28 — Branch Performance Report (Chained CTEs)
-- Three separate CTEs each compute one dimension:
--   1. branch_deposits  — total 2024 credit inflow
--   2. branch_loans     — total outstanding loan value
--   3. branch_employees — headcount per branch
-- Final SELECT joins all three with branch master data.
-- ------------------------------------------------------------

WITH branch_deposits AS (
    SELECT
        a.branch_id,
        SUM(t.amount) AS total_deposits
    FROM transactions t
    JOIN accounts a ON a.account_id = t.account_id
    WHERE t.txn_type = 'Credit'
      AND EXTRACT(YEAR FROM t.txn_date) = 2024
    GROUP BY a.branch_id
),
branch_loans AS (
    SELECT
        branch_id,
        SUM(outstanding) AS total_outstanding
    FROM loans
    GROUP BY branch_id
),
branch_employees AS (
    SELECT
        branch_id,
        COUNT(emp_id) AS total_employees
    FROM employees
    GROUP BY branch_id
)
SELECT
    b.branch_id,
    b.branch_name,
    b.city,
    bd.total_deposits,
    bl.total_outstanding,
    be.total_employees
FROM branches b
JOIN branch_deposits  bd ON bd.branch_id = b.branch_id
JOIN branch_loans     bl ON bl.branch_id = b.branch_id
JOIN branch_employees be ON be.branch_id = b.branch_id
ORDER BY b.branch_id;


-- ------------------------------------------------------------
-- TASK 29 — Top Customer per Branch by Transaction Volume
-- CTE computes total transaction count and amount per customer
-- per branch. RANK() window function picks the #1 customer
-- in each branch by total transaction amount.
-- ------------------------------------------------------------

WITH customer_txn_volume AS (
    SELECT
        a.branch_id,
        c.customer_id,
        CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
        COUNT(DISTINCT t.txn_id)               AS transaction_count,
        SUM(t.amount)                          AS total_txn_amount
    FROM customers c
    JOIN accounts a     ON a.customer_id = c.customer_id
    JOIN transactions t ON t.account_id  = a.account_id
    GROUP BY a.branch_id, c.customer_id, customer_name
),
ranked AS (
    SELECT *,
        RANK() OVER (
            PARTITION BY branch_id
            ORDER BY total_txn_amount DESC
        ) AS rank_in_branch
    FROM customer_txn_volume
)
SELECT *
FROM ranked
WHERE rank_in_branch = 1
ORDER BY branch_id;


-- ------------------------------------------------------------
-- TASK 30 — Loans Closing in the Next 90 Days
-- Flags loans approaching their end date.
-- EXISTS subquery checks if any EMI was ever missed,
-- producing an 'At Risk' or 'Clean' flag per loan.
-- ------------------------------------------------------------

SELECT
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    l.loan_type,
    l.principal,
    l.outstanding,
    l.emi_amount,
    l.end_date,
    b.branch_name,
    CASE
        WHEN EXISTS (
            SELECT 1
            FROM loan_repayments r
            WHERE r.loan_id = l.loan_id
              AND r.status  = 'Missed'
        ) THEN 'At Risk'
        ELSE 'Clean'
    END AS repayment_flag
FROM loans l
JOIN customers c ON c.customer_id = l.customer_id
JOIN branches b  ON b.branch_id   = l.branch_id
WHERE l.end_date BETWEEN CURRENT_DATE
                     AND DATE_ADD(CURRENT_DATE, INTERVAL 90 DAY)
ORDER BY l.end_date ASC;


-- ------------------------------------------------------------
-- TASK 31 — Highest and Lowest Paid Employee per Branch
-- Window functions MAX() and MIN() OVER PARTITION BY branch
-- compute salary extremes without a GROUP BY collapse.
-- Outer WHERE filters to only show those two employees,
-- and salary_gap shows the pay spread within each branch.
-- ------------------------------------------------------------

WITH branch_salary AS (
    SELECT
        e.branch_id,
        CONCAT(e.first_name, ' ', e.last_name)          AS employee_name,
        e.role,
        e.salary,
        MAX(e.salary) OVER (PARTITION BY e.branch_id)   AS max_salary,
        MIN(e.salary) OVER (PARTITION BY e.branch_id)   AS min_salary
    FROM employees e
)
SELECT
    b.branch_id,
    b.branch_name,
    bs.employee_name,
    bs.role,
    bs.salary,
    bs.max_salary,
    bs.min_salary,
    bs.max_salary - bs.min_salary AS salary_gap
FROM branch_salary bs
JOIN branches b ON b.branch_id = bs.branch_id
WHERE bs.salary = bs.max_salary
   OR bs.salary = bs.min_salary
ORDER BY b.branch_name, bs.salary DESC;


-- ============================================================
--  PHASE 5 — WINDOW FUNCTIONS  (Tasks 32–38)
--  Skills: RANK, DENSE_RANK, PERCENT_RANK, LAG,
--          FIRST_VALUE, LAST_VALUE, running totals,
--          rolling averages, frame clauses
-- ============================================================


-- ------------------------------------------------------------
-- TASK 32 — Rank Customers by Balance Within Each City
-- RANK() restarts numbering per city via PARTITION BY.
-- Ties receive the same rank; next rank skips a number.
-- ------------------------------------------------------------

SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name)                      AS customer_name,
    c.city,
    a.account_type,
    a.balance,
    RANK() OVER (
        PARTITION BY c.city
        ORDER BY a.balance DESC
    )                                                            AS balance_rank_in_city
FROM customers c
JOIN accounts a ON a.customer_id = c.customer_id
ORDER BY c.city, balance_rank_in_city;


-- ------------------------------------------------------------
-- TASK 33 — Balance Change Between Consecutive Transactions
-- LAG() retrieves the previous transaction's balance_after
-- within the same account, ordered by date.
-- The difference shows exactly how each transaction
-- moved the account balance.
-- NULL appears on each account's very first transaction
-- (no previous row to compare against).
-- ------------------------------------------------------------

SELECT
    t.account_id,
    t.txn_id,
    t.txn_date,
    t.txn_type,
    t.amount,
    t.balance_after,
    LAG(t.balance_after) OVER (
        PARTITION BY t.account_id
        ORDER BY t.txn_date
    )                                                            AS previous_balance,
    t.balance_after - LAG(t.balance_after) OVER (
        PARTITION BY t.account_id
        ORDER BY t.txn_date
    )                                                            AS balance_change
FROM transactions t
JOIN accounts a ON a.account_id = t.account_id
ORDER BY t.account_id, t.txn_date;


-- ------------------------------------------------------------
-- TASK 34 — Running Total of Transactions per Account
-- SUM() with ROWS UNBOUNDED PRECEDING accumulates the
-- total amount transacted from the first row up to
-- the current row, partitioned per account.
-- ------------------------------------------------------------

SELECT
    t.account_id,
    t.txn_id,
    t.txn_date,
    t.txn_type,
    t.amount,
    SUM(t.amount) OVER (
        PARTITION BY t.account_id
        ORDER BY t.txn_date
        ROWS UNBOUNDED PRECEDING
    )                                                            AS running_total
FROM transactions t
ORDER BY t.account_id, t.txn_date;


-- ------------------------------------------------------------
-- TASK 35 — 3-Month Rolling Average Transaction Volume per Branch
-- CTE first aggregates transaction count by branch and month.
-- Window function then applies a 3-row rolling average
-- (current month + 2 preceding months) per branch.
-- ------------------------------------------------------------

WITH monthly_volume AS (
    SELECT
        a.branch_id,
        YEAR(t.txn_date)  AS txn_year,
        MONTH(t.txn_date) AS txn_month,
        COUNT(*)          AS transaction_volume
    FROM transactions t
    JOIN accounts a ON a.account_id = t.account_id
    GROUP BY a.branch_id, YEAR(t.txn_date), MONTH(t.txn_date)
)
SELECT
    branch_id,
    txn_year,
    txn_month,
    transaction_volume,
    ROUND(AVG(transaction_volume) OVER (
        PARTITION BY branch_id
        ORDER BY txn_year, txn_month
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ), 2)                                                        AS rolling_3month_avg
FROM monthly_volume
ORDER BY branch_id, txn_year, txn_month;


-- ------------------------------------------------------------
-- TASK 36 — Flag First and Last Transaction per Account
-- Two ROW_NUMBER() calls: one ascending (first),
-- one descending (last) per account.
-- CASE WHEN handles the edge case where an account
-- has only one transaction (opening = most recent).
-- This is the cleaner alternate approach using dual
-- ROW_NUMBER instead of FIRST_VALUE / LAST_VALUE.
-- ------------------------------------------------------------

WITH txn_ranked AS (
    SELECT *,
        ROW_NUMBER() OVER (
            PARTITION BY account_id
            ORDER BY txn_date ASC
        ) AS rn_first,
        ROW_NUMBER() OVER (
            PARTITION BY account_id
            ORDER BY txn_date DESC
        ) AS rn_last
    FROM transactions
)
SELECT
    txn_id,
    account_id,
    txn_date,
    txn_type,
    txn_mode,
    amount,
    CASE
        WHEN rn_first = 1 AND rn_last = 1 THEN 'Opening & Most Recent Transaction'
        WHEN rn_first = 1                  THEN 'Opening Transaction'
        WHEN rn_last  = 1                  THEN 'Most Recent Transaction'
    END AS transaction_flag
FROM txn_ranked
WHERE rn_first = 1 OR rn_last = 1
ORDER BY account_id, txn_date;


-- ------------------------------------------------------------
-- TASK 37 — Employee Salary Ranking Within Branch
-- DENSE_RANK() assigns consecutive ranks with no gaps on ties.
-- PERCENT_RANK() shows relative position as a 0–1 percentile.
-- Both window functions partition by branch so rankings
-- reset independently for each branch.
-- ------------------------------------------------------------

SELECT
    e.branch_id,
    CONCAT(e.first_name, ' ', e.last_name)                      AS employee_name,
    e.role,
    e.salary,
    DENSE_RANK() OVER (
        PARTITION BY e.branch_id
        ORDER BY e.salary DESC
    )                                                            AS salary_rank,
    ROUND(PERCENT_RANK() OVER (
        PARTITION BY e.branch_id
        ORDER BY e.salary DESC
    ) * 100, 2)                                                  AS salary_percentile
FROM employees e
ORDER BY e.branch_id, salary_rank;


-- ------------------------------------------------------------
-- TASK 38 — Accounts Where Spending Jumped 50%+ vs Prior Month
-- CTE 1 computes monthly total spend per account.
-- CTE 2 uses LAG() to pull the previous month's spend.
-- Outer query filters where current spend > 1.5× previous.
-- NULLIF protects against divide-by-zero on first months.
-- ------------------------------------------------------------

WITH monthly_expenditure AS (
    SELECT
        account_id,
        YEAR(txn_date)  AS yr,
        MONTH(txn_date) AS mn,
        SUM(amount)     AS monthly_spend
    FROM transactions
    WHERE txn_type = 'Debit'
    GROUP BY account_id, YEAR(txn_date), MONTH(txn_date)
),
with_prev AS (
    SELECT *,
        LAG(monthly_spend) OVER (
            PARTITION BY account_id
            ORDER BY yr, mn
        ) AS prev_month_spend
    FROM monthly_expenditure
)
SELECT
    account_id,
    yr,
    mn,
    monthly_spend,
    prev_month_spend,
    ROUND(monthly_spend / NULLIF(prev_month_spend, 0), 2) AS spend_ratio
FROM with_prev
WHERE monthly_spend > 1.5 * prev_month_spend
ORDER BY spend_ratio DESC;


-- ============================================================
--  PHASE 6 — FRAUD DETECTION ENGINE  (Task 39)
--  Skills: Self-join, time-window analysis, UNION ALL,
--          MOD, EXTRACT(HOUR), conditional aggregation
-- ============================================================


-- ------------------------------------------------------------
-- TASK 39 — Multi-Rule Fraud Detection Query
-- Flags transactions matching any of 4 fraud patterns:
--
--   RULE 1: More than 3 debits from the same account
--           within any rolling 60-minute window
--           (self-join on account + time range)
--
--   RULE 2: Transaction amount exceeds 3× the account's
--           own all-time average debit amount
--           (window AVG compared per row)
--
--   RULE 3: Any transaction occurring between
--           midnight and 04:59 AM
--
--   RULE 4: Round-number transaction above ₹50,000
--           (amount divisible by 10,000)
--
-- All four result sets are combined with UNION ALL so a
-- single transaction can appear multiple times if it
-- triggers more than one rule simultaneously.
-- ------------------------------------------------------------

WITH base_txns AS (
    SELECT
        txn_id,
        account_id,
        txn_date,
        amount,
        txn_type
    FROM transactions
),

-- RULE 1: Rapid debit burst — more than 3 debits in 60 minutes
debit_spikes AS (
    SELECT
        t1.account_id,
        t1.txn_id,
        t1.txn_date,
        t1.amount
    FROM base_txns t1
    JOIN base_txns t2
        ON  t1.account_id = t2.account_id
        AND t2.txn_type   = 'Debit'
        AND t2.txn_date BETWEEN DATE_SUB(t1.txn_date, INTERVAL 60 MINUTE)
                            AND t1.txn_date
    WHERE t1.txn_type = 'Debit'
    GROUP BY t1.account_id, t1.txn_id, t1.txn_date, t1.amount
    HAVING COUNT(*) > 3
),

-- RULE 2: Amount exceeds 3x account's own average debit
avg_per_account AS (
    SELECT
        account_id,
        AVG(amount) AS avg_debit_amount
    FROM base_txns
    WHERE txn_type = 'Debit'
    GROUP BY account_id
),
high_deviation AS (
    SELECT
        b.account_id,
        b.txn_id,
        b.txn_date,
        b.amount
    FROM base_txns b
    JOIN avg_per_account a ON a.account_id = b.account_id
    WHERE b.txn_type = 'Debit'
      AND b.amount   > 3 * a.avg_debit_amount
),

-- RULE 3: Off-hours transaction (midnight to 04:59 AM)
off_hours AS (
    SELECT
        account_id,
        txn_id,
        txn_date,
        amount
    FROM base_txns
    WHERE EXTRACT(HOUR FROM txn_date) < 5
),

-- RULE 4: Suspiciously round high-value amount
round_high AS (
    SELECT
        account_id,
        txn_id,
        txn_date,
        amount
    FROM base_txns
    WHERE amount > 50000
      AND MOD(amount, 10000) = 0
)

SELECT account_id, txn_id, txn_date, amount, 'rapid_debit_burst_60min'    AS flag_reason FROM debit_spikes
UNION ALL
SELECT account_id, txn_id, txn_date, amount, 'amount_exceeds_3x_avg'      AS flag_reason FROM high_deviation
UNION ALL
SELECT account_id, txn_id, txn_date, amount, 'off_hours_transaction'       AS flag_reason FROM off_hours
UNION ALL
SELECT account_id, txn_id, txn_date, amount, 'round_number_high_value'     AS flag_reason FROM round_high
ORDER BY account_id, txn_date;


-- ============================================================
--  PHASE 7 — CAPSTONE VIEW  (Task 40)
--  Skills: CREATE VIEW, chained CTEs, multi-source JOIN,
--          DATE_FORMAT for year-month grouping
-- ============================================================


-- ------------------------------------------------------------
-- TASK 40 — Executive Branch Dashboard View
-- A single VIEW that consolidates branch performance
-- across four dimensions:
--
--   monthly_txn      — credit/debit inflow per month
--   branch_loans     — loan portfolio size and bad loan count
--   branch_customers — customer count and average credit score
--
-- Query it with:
--   SELECT * FROM v_branch_executive_dashboard
--   WHERE txn_month = '2024-01'
--   ORDER BY total_credits DESC;
-- ------------------------------------------------------------

CREATE VIEW v_branch_executive_dashboard AS
WITH monthly_txn AS (
    SELECT
        a.branch_id,
        DATE_FORMAT(t.txn_date, '%Y-%m')                                    AS txn_month,
        SUM(CASE WHEN t.txn_type = 'Credit' THEN t.amount ELSE 0 END)      AS total_credits,
        SUM(CASE WHEN t.txn_type = 'Debit'  THEN t.amount ELSE 0 END)      AS total_debits,
        COUNT(*)                                                             AS txn_count
    FROM transactions t
    JOIN accounts a ON a.account_id = t.account_id
    GROUP BY a.branch_id, DATE_FORMAT(t.txn_date, '%Y-%m')
),
branch_loans AS (
    SELECT
        branch_id,
        COUNT(*)                                                             AS total_loans,
        SUM(outstanding)                                                     AS total_outstanding,
        SUM(CASE WHEN status IN ('Defaulted', 'NPA') THEN 1 ELSE 0 END)    AS bad_loans
    FROM loans
    GROUP BY branch_id
),
branch_customers AS (
    SELECT
        branch_id,
        COUNT(*)            AS total_customers,
        AVG(credit_score)   AS avg_credit_score
    FROM customers
    GROUP BY branch_id
)
SELECT
    b.branch_id,
    b.branch_name,
    b.city,
    CONCAT(e.first_name, ' ', e.last_name)  AS manager_name,
    bc.total_customers,
    ROUND(bc.avg_credit_score, 0)            AS avg_credit_score,
    bl.total_loans,
    bl.total_outstanding,
    bl.bad_loans,
    mt.txn_month,
    mt.total_credits,
    mt.total_debits,
    mt.txn_count
FROM branches b
JOIN employees e        ON e.emp_id    = b.manager_emp_id
JOIN branch_loans bl    ON bl.branch_id = b.branch_id
JOIN branch_customers bc ON bc.branch_id = b.branch_id
JOIN monthly_txn mt     ON mt.branch_id = b.branch_id;


-- ============================================================
--  END OF PROJECT
--  40 queries | 12 tables | 7 phases
--  MySQL 8+ compatible
-- ============================================================