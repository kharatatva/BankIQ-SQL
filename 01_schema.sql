CREATE DATABASE bank_system;
USE bank_system;
 CREATE TABLE branches(
     branch_id INT AUTO_INCREMENT PRIMARY KEY,
     branch_name VARCHAR(100) NOT NULL,
     city VARCHAR(50) NOT NULL,
     state VARCHAR(50) NOT NULL,
     pincode CHAR(6) NOT NULL,
     manager_emp_id INT,
     established_on DATE NOT NULL,
     is_active BOOLEAN DEFAULT TRUE,
     ifsc_prefix CHAR(8) NOT NULL UNIQUE
 );
 CREATE TABLE employees (
    emp_id          SERIAL PRIMARY KEY,
    branch_id       INT          NOT NULL REFERENCES branches(branch_id),
    first_name      VARCHAR(50)  NOT NULL,
    last_name       VARCHAR(50)  NOT NULL,
    role            VARCHAR(30)  NOT NULL CHECK (role IN ('Manager','Senior Analyst','Analyst','Teller','Loan Officer','Compliance Officer')),
    email           VARCHAR(100) NOT NULL UNIQUE,
    phone           CHAR(10)     NOT NULL,
    hire_date       DATE         NOT NULL,
    salary          NUMERIC(10,2) NOT NULL,
    is_active       BOOLEAN      DEFAULT TRUE
);
CREATE TABLE customers (
    customer_id     SERIAL PRIMARY KEY,
    branch_id       INT          NOT NULL REFERENCES branches(branch_id),
    first_name      VARCHAR(50)  NOT NULL,
    last_name       VARCHAR(50)  NOT NULL,
    date_of_birth   DATE         NOT NULL,
    gender          CHAR(1)      CHECK (gender IN ('M','F','O')),
    email           VARCHAR(100) UNIQUE,
    phone           CHAR(10)     NOT NULL,
    address_line1   VARCHAR(150) NOT NULL,
    city            VARCHAR(50)  NOT NULL,
    pincode         CHAR(6)      NOT NULL,
    pan_number      CHAR(10)     UNIQUE,
    aadhar_last4    CHAR(4),
    customer_type   VARCHAR(20)  DEFAULT 'Individual' CHECK (customer_type IN ('Individual','Business')),
    kyc_status      VARCHAR(20)  DEFAULT 'Pending' CHECK (kyc_status IN ('Pending','Verified','Rejected')),
    credit_score    SMALLINT     CHECK (credit_score BETWEEN 300 AND 900),
    joined_on       DATE         NOT NULL,
    is_active       BOOLEAN      DEFAULT TRUE
);
CREATE TABLE accounts (
    account_id      SERIAL PRIMARY KEY,
    customer_id     INT          NOT NULL REFERENCES customers(customer_id),
    branch_id       INT          NOT NULL REFERENCES branches(branch_id),
    account_number  VARCHAR(16)  NOT NULL UNIQUE,
    account_type    VARCHAR(20)  NOT NULL CHECK (account_type IN ('Savings','Current','Fixed Deposit','Recurring Deposit','Salary')),
    currency        CHAR(3)      DEFAULT 'INR',
    balance         NUMERIC(14,2) NOT NULL DEFAULT 0.00,
    min_balance     NUMERIC(10,2) DEFAULT 1000.00,
    interest_rate   NUMERIC(5,2) DEFAULT 3.50,
    opened_on       DATE         NOT NULL,
    closed_on       DATE,
    status          VARCHAR(20)  DEFAULT 'Active' CHECK (status IN ('Active','Dormant','Closed','Frozen')),
    last_txn_date   DATE
);
CREATE TABLE transactions (
    txn_id          SERIAL PRIMARY KEY,
    account_id      INT          NOT NULL REFERENCES accounts(account_id),
    txn_date        TIMESTAMP    NOT NULL DEFAULT NOW(),
    txn_type        VARCHAR(20)  NOT NULL CHECK (txn_type IN ('Credit','Debit')),
    txn_mode        VARCHAR(20)  NOT NULL CHECK (txn_mode IN ('UPI','NEFT','RTGS','IMPS','ATM','Cash','Cheque','Auto-debit','Internal Transfer')),
    amount          NUMERIC(12,2) NOT NULL CHECK (amount > 0),
    balance_after   NUMERIC(14,2) NOT NULL,
    description     VARCHAR(200),
    reference_no    VARCHAR(30)  UNIQUE,
    merchant_name   VARCHAR(100),
    category        VARCHAR(30)  CHECK (category IN ('Salary','EMI','Utilities','Shopping','Food & Dining','Travel','Healthcare','Investment','Transfer','ATM Withdrawal','Other')),
    channel         VARCHAR(20)  DEFAULT 'Online' CHECK (channel IN ('Online','Branch','ATM','Mobile App'))
);
CREATE TABLE loans (
    loan_id         SERIAL PRIMARY KEY,
    customer_id     INT          NOT NULL REFERENCES customers(customer_id),
    branch_id       INT          NOT NULL REFERENCES branches(branch_id),
    account_id      INT          REFERENCES accounts(account_id),   -- linked debit account for EMI
    loan_type       VARCHAR(30)  NOT NULL CHECK (loan_type IN ('Home Loan','Car Loan','Personal Loan','Business Loan','Education Loan','Gold Loan')),
    principal       NUMERIC(14,2) NOT NULL,
    interest_rate   NUMERIC(5,2) NOT NULL,
    tenure_months   SMALLINT     NOT NULL,
    emi_amount      NUMERIC(10,2) NOT NULL,
    disbursed_on    DATE         NOT NULL,
    first_emi_date  DATE         NOT NULL,
    end_date        DATE         NOT NULL,
    outstanding     NUMERIC(14,2) NOT NULL,
    status          VARCHAR(20)  DEFAULT 'Active' CHECK (status IN ('Active','Closed','Defaulted','NPA','Restructured')),
    loan_officer_id INT          REFERENCES employees(emp_id),
    collateral      VARCHAR(100)
);
CREATE TABLE loan_repayments (
    repayment_id    SERIAL PRIMARY KEY,
    loan_id         INT          NOT NULL REFERENCES loans(loan_id),
    payment_date    DATE         NOT NULL,
    amount_paid     NUMERIC(10,2) NOT NULL,
    principal_paid  NUMERIC(10,2) NOT NULL,
    interest_paid   NUMERIC(10,2) NOT NULL,
    penalty         NUMERIC(8,2)  DEFAULT 0.00,
    payment_mode    VARCHAR(20)   CHECK (payment_mode IN ('Auto-debit','Online','Branch','Cheque')),
    status          VARCHAR(20)   DEFAULT 'Paid' CHECK (status IN ('Paid','Missed','Partial','Bounced'))
);
CREATE TABLE cards (
    card_id         SERIAL PRIMARY KEY,
    account_id      INT          NOT NULL REFERENCES accounts(account_id),
    customer_id     INT          NOT NULL REFERENCES customers(customer_id),
    card_type       VARCHAR(20)  NOT NULL CHECK (card_type IN ('Debit','Credit')),
    card_network    VARCHAR(20)  NOT NULL CHECK (card_network IN ('Visa','Mastercard','RuPay')),
    card_number_last4 CHAR(4)    NOT NULL,
    issued_on       DATE         NOT NULL,
    expiry_date     DATE         NOT NULL,
    credit_limit    NUMERIC(10,2),
    outstanding_due NUMERIC(10,2) DEFAULT 0.00,
    status          VARCHAR(20)  DEFAULT 'Active' CHECK (status IN ('Active','Blocked','Expired','Hotlisted')),
    is_contactless  BOOLEAN      DEFAULT TRUE
);
CREATE TABLE fixed_deposits (
    fd_id           SERIAL PRIMARY KEY,
    account_id      INT          NOT NULL REFERENCES accounts(account_id),
    customer_id     INT          NOT NULL REFERENCES customers(customer_id),
    principal       NUMERIC(12,2) NOT NULL,
    interest_rate   NUMERIC(5,2) NOT NULL,
    tenure_months   SMALLINT     NOT NULL,
    maturity_date   DATE         NOT NULL,
    maturity_amount NUMERIC(14,2) NOT NULL,
    payout_type     VARCHAR(20)  DEFAULT 'On Maturity' CHECK (payout_type IN ('Monthly','Quarterly','On Maturity')),
    status          VARCHAR(20)  DEFAULT 'Active' CHECK (status IN ('Active','Matured','Broken','Renewed')),
    auto_renew      BOOLEAN      DEFAULT FALSE
);
CREATE TABLE kyc_documents (
    doc_id          SERIAL PRIMARY KEY,
    customer_id     INT          NOT NULL REFERENCES customers(customer_id),
    doc_type        VARCHAR(30)  NOT NULL CHECK (doc_type IN ('PAN Card','Aadhaar','Passport','Voter ID','Driving License','Utility Bill','Bank Statement')),
    doc_number      VARCHAR(30),
    submitted_on    DATE         NOT NULL,
    verified_on     DATE,
    verified_by     INT          REFERENCES employees(emp_id),
    expiry_date     DATE,
    status          VARCHAR(20)  DEFAULT 'Pending' CHECK (status IN ('Pending','Verified','Rejected','Expired'))
);
CREATE TABLE fraud_alerts (
    alert_id        SERIAL PRIMARY KEY,
    account_id      INT          NOT NULL REFERENCES accounts(account_id),
    txn_id          INT          REFERENCES transactions(txn_id),
    alert_type      VARCHAR(50)  NOT NULL CHECK (alert_type IN ('Unusual Hour','Rapid Succession','Round Amount','Geo Anomaly','Excessive Withdrawal','Dormant Activity','Large Single Txn')),
    severity        VARCHAR(10)  NOT NULL CHECK (severity IN ('Low','Medium','High','Critical')),
    flagged_on      TIMESTAMP    NOT NULL DEFAULT NOW(),
    reviewed_by     INT          REFERENCES employees(emp_id),
    resolution      VARCHAR(20)  DEFAULT 'Open' CHECK (resolution IN ('Open','False Positive','Confirmed Fraud','Under Review')),
    notes           TEXT
);
CREATE TABLE interest_postings (
    posting_id      SERIAL PRIMARY KEY,
    account_id      INT          NOT NULL REFERENCES accounts(account_id),
    posting_date    DATE         NOT NULL,
    period_start    DATE         NOT NULL,
    period_end      DATE         NOT NULL,
    principal_used  NUMERIC(14,2) NOT NULL,
    rate_applied    NUMERIC(5,2) NOT NULL,
    interest_amount NUMERIC(10,2) NOT NULL,
    tds_deducted    NUMERIC(8,2)  DEFAULT 0.00,
    net_posted      NUMERIC(10,2) NOT NULL
);

