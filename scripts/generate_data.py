"""
seed.py — Bank System Database Seeder (MySQL)
===============================================
Generates realistic, India-specific fake data for all 12 tables.
Respects foreign key order, wraps everything in a transaction,
and logs progress at every step.

Usage:
    python seed.py                          # default volumes
    python seed.py --branches 5 --customers 200
    python seed.py --reset                  # clears all tables first

Requirements:
    pip install faker mysql-connector-python python-dotenv

.env file (create in same folder as seed.py):
    DB_HOST=localhost
    DB_PORT=3306
    DB_NAME=bank_system
    DB_USER=root
    DB_PASSWORD=yourpassword
"""

import os
import sys
import random
import string
import logging
import argparse
from datetime import date, timedelta, datetime

import mysql.connector
from faker import Faker
from dotenv import load_dotenv

# ──────────────────────────────────────────────
# CONFIGURATION
# ──────────────────────────────────────────────

load_dotenv()

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s  %(levelname)-8s  %(message)s",
    datefmt="%H:%M:%S",
)
log = logging.getLogger("seeder")

fake = Faker("en_IN")   # Indian locale
Faker.seed(42)
random.seed(42)

# ──────────────────────────────────────────────
# HELPERS
# ──────────────────────────────────────────────

def rand_date(start: date, end: date) -> date:
    delta = (end - start).days
    return start + timedelta(days=random.randint(0, delta))

def rand_phone() -> str:
    return str(random.randint(6, 9)) + "".join(
        str(random.randint(0, 9)) for _ in range(9)
    )

def rand_pan() -> str:
    letters = string.ascii_uppercase
    return (
        "".join(random.choices(letters, k=5))
        + "".join(random.choices(string.digits, k=4))
        + random.choice(letters)
    )

def rand_account_number() -> str:
    return "".join(str(random.randint(0, 9)) for _ in range(16))

def rand_reference_no() -> str:
    chars = string.ascii_uppercase + string.digits
    return "TXN" + "".join(random.choices(chars, k=16))

def rand_ifsc_prefix() -> str:
    bank_codes = ["HDFC", "ICIC", "SBIN", "AXIS", "KOTK", "PUNB", "CNRB", "IDFB"]
    return random.choice(bank_codes) + str(random.randint(1000, 9999))

def emi_calc(principal: float, annual_rate: float, months: int) -> float:
    r = annual_rate / (12 * 100)
    if r == 0:
        return round(principal / months, 2)
    emi = principal * r * (1 + r) ** months / ((1 + r) ** months - 1)
    return round(emi, 2)

def get_connection():
    return mysql.connector.connect(
        host=os.getenv("DB_HOST", "localhost"),
        port=int(os.getenv("DB_PORT", 3306)),
        database=os.getenv("DB_NAME", "bank_system"),
        user=os.getenv("DB_USER", "root"),
        password=os.getenv("DB_PASSWORD", ""),
    )

def bulk_insert(cur, table: str, columns: list, rows: list) -> list:
    """Insert many rows and return all auto-generated IDs."""
    if not rows:
        return []
    placeholders = ", ".join(["%s"] * len(columns))
    col_str      = ", ".join(columns)
    sql          = f"INSERT INTO {table} ({col_str}) VALUES ({placeholders})"
    cur.executemany(sql, rows)
    # MySQL executemany: lastrowid is the FIRST inserted id of the batch
    first_id = cur.lastrowid
    return list(range(first_id, first_id + len(rows)))


# ──────────────────────────────────────────────
# SEEDER FUNCTIONS  (FK order: top → bottom)
# ──────────────────────────────────────────────

def seed_branches(cur, n: int) -> list:
    log.info(f"Seeding {n} branches ...")
    indian_states = [
        "Maharashtra", "Gujarat", "Karnataka", "Tamil Nadu", "Delhi",
        "Rajasthan", "West Bengal", "Uttar Pradesh", "Telangana", "Kerala",
    ]
    cities_by_state = {
        "Maharashtra":   ["Mumbai", "Pune", "Nagpur"],
        "Gujarat":       ["Ahmedabad", "Surat", "Vadodara", "Rajkot"],
        "Karnataka":     ["Bengaluru", "Mysuru", "Hubli"],
        "Tamil Nadu":    ["Chennai", "Coimbatore", "Madurai"],
        "Delhi":         ["New Delhi", "Dwarka", "Rohini"],
        "Rajasthan":     ["Jaipur", "Jodhpur", "Udaipur"],
        "West Bengal":   ["Kolkata", "Howrah", "Durgapur"],
        "Uttar Pradesh": ["Lucknow", "Kanpur", "Agra"],
        "Telangana":     ["Hyderabad", "Warangal", "Karimnagar"],
        "Kerala":        ["Kochi", "Thiruvananthapuram", "Kozhikode"],
    }
    used_ifsc = set()
    rows = []
    for _ in range(n):
        state = random.choice(indian_states)
        city  = random.choice(cities_by_state[state])
        ifsc  = rand_ifsc_prefix()
        while ifsc in used_ifsc:
            ifsc = rand_ifsc_prefix()
        used_ifsc.add(ifsc)
        rows.append((
            (fake.company() + " Branch")[:100],
            city, state,
            fake.postcode()[:6].ljust(6, "0"),
            None,
            rand_date(date(2000, 1, 1), date(2020, 12, 31)),
            True,
            ifsc,
        ))
    ids = bulk_insert(cur, "branches",
        ["branch_name","city","state","pincode","manager_emp_id",
         "established_on","is_active","ifsc_prefix"], rows)
    log.info(f"  + {len(ids)} branches inserted")
    return ids


def seed_employees(cur, branch_ids: list, n: int) -> list:
    log.info(f"Seeding {n} employees ...")
    roles = ["Manager","Senior Analyst","Analyst","Teller","Loan Officer","Compliance Officer"]
    salary_map = {
        "Manager":              (120000, 200000),
        "Senior Analyst":       (80000,  130000),
        "Analyst":              (50000,   80000),
        "Teller":               (30000,   50000),
        "Loan Officer":         (60000,  100000),
        "Compliance Officer":   (70000,  110000),
    }
    used_emails = set()
    rows = []
    for _ in range(n):
        role  = random.choice(roles)
        email = fake.email()
        while email in used_emails:
            email = fake.email()
        used_emails.add(email)
        lo, hi = salary_map[role]
        rows.append((
            random.choice(branch_ids),
            fake.first_name()[:50], fake.last_name()[:50],
            role, email, rand_phone(),
            rand_date(date(2010, 1, 1), date(2024, 6, 30)),
            round(random.uniform(lo, hi), 2),
            True,
        ))
    ids = bulk_insert(cur, "employees",
        ["branch_id","first_name","last_name","role","email",
         "phone","hire_date","salary","is_active"], rows)

    # Assign one manager per branch
    cur.execute("SELECT emp_id, branch_id FROM employees WHERE role = 'Manager'")
    for emp_id, branch_id in cur.fetchall():
        cur.execute(
            "UPDATE branches SET manager_emp_id = %s WHERE branch_id = %s",
            (emp_id, branch_id)
        )
    log.info(f"  + {len(ids)} employees inserted; managers assigned")
    return ids


def seed_customers(cur, branch_ids: list, n: int) -> list:
    log.info(f"Seeding {n} customers ...")
    used_emails = set()
    used_pans   = set()
    rows = []
    for _ in range(n):
        email = fake.email()
        while email in used_emails:
            email = fake.email()
        used_emails.add(email)

        pan = rand_pan()
        while pan in used_pans:
            pan = rand_pan()
        used_pans.add(pan)

        rows.append((
            random.choice(branch_ids),
            fake.first_name()[:50], fake.last_name()[:50],
            rand_date(date(1960, 1, 1), date(2000, 12, 31)),
            random.choice(["M","F","O"]),
            email, rand_phone(),
            fake.street_address()[:150],
            fake.city()[:50],
            fake.postcode()[:6].ljust(6, "0"),
            pan,
            str(random.randint(1000, 9999)),
            random.choice(["Individual","Business"]),
            random.choices(["Pending","Verified","Rejected"], weights=[15,75,10])[0],
            random.randint(300, 900),
            rand_date(date(2015, 1, 1), date(2024, 6, 30)),
            True,
        ))
    ids = bulk_insert(cur, "customers",
        ["branch_id","first_name","last_name","date_of_birth","gender",
         "email","phone","address_line1","city","pincode",
         "pan_number","aadhar_last4","customer_type","kyc_status",
         "credit_score","joined_on","is_active"], rows)
    log.info(f"  + {len(ids)} customers inserted")
    return ids


def seed_accounts(cur, customer_ids: list, branch_ids: list) -> list:
    log.info("Seeding accounts (1-2 per customer) ...")
    acc_types   = ["Savings","Current","Fixed Deposit","Recurring Deposit","Salary"]
    acc_weights = [50, 20, 15, 10, 5]
    used_acc_nos = set()
    rows = []
    mapping = []   # (customer_id, branch_id, balance, opened_on) per row

    for cust_id in customer_ids:
        for _ in range(random.randint(1, 2)):
            acc_no = rand_account_number()
            while acc_no in used_acc_nos:
                acc_no = rand_account_number()
            used_acc_nos.add(acc_no)
            branch_id = random.choice(branch_ids)
            balance   = round(random.uniform(1000, 500000), 2)
            opened_on = rand_date(date(2015, 1, 1), date(2024, 1, 1))
            status    = random.choices(
                ["Active","Dormant","Closed","Frozen"], weights=[80,10,7,3]
            )[0]
            rows.append((
                cust_id, branch_id, acc_no,
                random.choices(acc_types, weights=acc_weights)[0],
                "INR", balance, 1000.00,
                round(random.uniform(2.5, 7.5), 2),
                opened_on, None, status, opened_on,
            ))
            mapping.append((cust_id, branch_id, balance, opened_on))

    ids = bulk_insert(cur, "accounts",
        ["customer_id","branch_id","account_number","account_type",
         "currency","balance","min_balance","interest_rate",
         "opened_on","closed_on","status","last_txn_date"], rows)

    accounts = [
        {"account_id": aid, "customer_id": m[0], "branch_id": m[1],
         "balance": m[2], "opened_on": m[3]}
        for aid, m in zip(ids, mapping)
    ]
    log.info(f"  + {len(accounts)} accounts inserted")
    return accounts


def seed_transactions(cur, accounts: list, txns_per_account: int) -> list:
    log.info(f"Seeding ~{txns_per_account} transactions per account ...")
    modes      = ["UPI","NEFT","RTGS","IMPS","ATM","Cash","Cheque","Auto-debit","Internal Transfer"]
    categories = ["Salary","EMI","Utilities","Shopping","Food & Dining",
                  "Travel","Healthcare","Investment","Transfer","ATM Withdrawal","Other"]
    channels   = ["Online","Branch","ATM","Mobile App"]
    merchants  = ["Amazon","Flipkart","Swiggy","Zomato","Ola","Uber",
                  "BigBasket","Reliance Fresh","HDFC Bank","SBI","Paytm"]
    used_refs  = set()
    rows = []

    for acc in accounts:
        balance  = float(acc["balance"])
        txn_date = acc["opened_on"]
        for _ in range(random.randint(txns_per_account - 2, txns_per_account + 5)):
            txn_date = txn_date + timedelta(days=random.randint(0, 7))
            if txn_date > date.today():
                break
            txn_type = random.choices(["Credit","Debit"], weights=[40,60])[0]
            amount   = round(random.uniform(100, 50000), 2)
            if txn_type == "Debit" and balance < amount:
                txn_type = "Credit"
            balance  = round(balance + amount if txn_type == "Credit" else balance - amount, 2)
            balance  = max(balance, 0)
            ref = rand_reference_no()
            while ref in used_refs:
                ref = rand_reference_no()
            used_refs.add(ref)
            txn_dt = datetime.combine(txn_date, datetime.min.time()) \
                     + timedelta(hours=random.randint(0,23), minutes=random.randint(0,59))
            rows.append((
                acc["account_id"], txn_dt,
                txn_type, random.choice(modes),
                amount, balance,
                fake.sentence(nb_words=6)[:200],
                ref,
                random.choice(merchants) if random.random() > 0.4 else None,
                random.choice(categories),
                random.choice(channels),
            ))

    ids = bulk_insert(cur, "transactions",
        ["account_id","txn_date","txn_type","txn_mode",
         "amount","balance_after","description","reference_no",
         "merchant_name","category","channel"], rows)
    log.info(f"  + {len(ids)} transactions inserted")
    return ids


def seed_loans(cur, accounts: list, emp_ids: list) -> list:
    log.info("Seeding loans (for ~40% of accounts) ...")
    loan_types = ["Home Loan","Car Loan","Personal Loan",
                  "Business Loan","Education Loan","Gold Loan"]
    principal_range = {
        "Home Loan":      (1000000, 10000000),
        "Car Loan":       (300000,   2000000),
        "Personal Loan":  (50000,     500000),
        "Business Loan":  (500000,   5000000),
        "Education Loan": (200000,   2000000),
        "Gold Loan":      (50000,     500000),
    }
    collateral_map = {
        "Home Loan":      "Residential Property",
        "Car Loan":       "Vehicle RC Book",
        "Gold Loan":      "Gold Jewellery",
        "Business Loan":  "Business Assets",
        "Personal Loan":  None,
        "Education Loan": None,
    }
    cur.execute("SELECT emp_id FROM employees WHERE role = 'Loan Officer'")
    loan_officers = [r[0] for r in cur.fetchall()] or emp_ids

    rows = []
    mapping = []
    for acc in random.sample(accounts, k=int(len(accounts) * 0.4)):
        loan_type  = random.choice(loan_types)
        lo, hi     = principal_range[loan_type]
        principal  = round(random.uniform(lo, hi), 2)
        rate       = round(random.uniform(7.0, 18.0), 2)
        tenure     = random.choice([12,24,36,60,84,120,180,240])
        emi        = emi_calc(principal, rate, tenure)
        disbursed  = rand_date(date(2018, 1, 1), date(2023, 12, 31))
        first_emi  = disbursed + timedelta(days=30)
        end_date   = disbursed + timedelta(days=tenure * 30)
        outstanding = round(principal * random.uniform(0.1, 0.95), 2)
        rows.append((
            acc["customer_id"], acc["branch_id"], acc["account_id"],
            loan_type, principal, rate, tenure, emi,
            disbursed, first_emi, end_date, outstanding,
            random.choices(
                ["Active","Closed","Defaulted","NPA","Restructured"],
                weights=[60,25,7,5,3]
            )[0],
            random.choice(loan_officers),
            collateral_map[loan_type],
        ))
        mapping.append({"emi_amount": emi, "disbursed_on": disbursed, "tenure_months": tenure})

    ids = bulk_insert(cur, "loans",
        ["customer_id","branch_id","account_id","loan_type",
         "principal","interest_rate","tenure_months","emi_amount",
         "disbursed_on","first_emi_date","end_date","outstanding",
         "status","loan_officer_id","collateral"], rows)

    loans = [{"loan_id": lid, **m} for lid, m in zip(ids, mapping)]
    log.info(f"  + {len(loans)} loans inserted")
    return loans


def seed_loan_repayments(cur, loans: list):
    log.info("Seeding loan repayments ...")
    rows = []
    for loan in loans:
        num_paid = random.randint(1, min(loan["tenure_months"], 24))
        pay_date = loan["disbursed_on"] + timedelta(days=30)
        emi      = float(loan["emi_amount"])
        for _ in range(num_paid):
            interest  = round(emi * random.uniform(0.2, 0.45), 2)
            principal = round(emi - interest, 2)
            penalty   = round(random.uniform(0, 500), 2) if random.random() < 0.05 else 0.0
            rows.append((
                loan["loan_id"], pay_date,
                round(emi + penalty, 2),
                principal, interest, penalty,
                random.choice(["Auto-debit","Online","Branch","Cheque"]),
                random.choices(
                    ["Paid","Missed","Partial","Bounced"], weights=[85,7,5,3]
                )[0],
            ))
            pay_date += timedelta(days=30)
    bulk_insert(cur, "loan_repayments",
        ["loan_id","payment_date","amount_paid","principal_paid",
         "interest_paid","penalty","payment_mode","status"], rows)
    log.info(f"  + {len(rows)} loan repayments inserted")


def seed_cards(cur, accounts: list):
    log.info("Seeding cards ...")
    networks = ["Visa","Mastercard","RuPay"]
    rows = []
    for acc in accounts:
        if random.random() < 0.75:
            issued    = rand_date(date(2018, 1, 1), date(2023, 12, 31))
            expiry    = issued.replace(year=issued.year + 5)
            card_type = random.choices(["Debit","Credit"], weights=[65,35])[0]
            rows.append((
                acc["account_id"], acc["customer_id"],
                card_type, random.choice(networks),
                str(random.randint(1000, 9999)),
                issued, expiry,
                round(random.uniform(10000, 500000), 2) if card_type == "Credit" else None,
                round(random.uniform(0, 50000), 2)      if card_type == "Credit" else 0.00,
                random.choices(
                    ["Active","Blocked","Expired","Hotlisted"], weights=[80,10,7,3]
                )[0],
                True,
            ))
    bulk_insert(cur, "cards",
        ["account_id","customer_id","card_type","card_network",
         "card_number_last4","issued_on","expiry_date",
         "credit_limit","outstanding_due","status","is_contactless"], rows)
    log.info(f"  + {len(rows)} cards inserted")


def seed_fixed_deposits(cur, accounts: list):
    log.info("Seeding fixed deposits ...")
    rows = []
    for acc in accounts:
        if random.random() < 0.3:
            principal  = round(random.uniform(10000, 2000000), 2)
            rate       = round(random.uniform(5.0, 8.5), 2)
            tenure     = random.choice([6, 12, 24, 36, 60])
            start      = rand_date(date(2018, 1, 1), date(2023, 1, 1))
            maturity   = start + timedelta(days=tenure * 30)
            mat_amount = round(principal * (1 + rate / 100 * tenure / 12), 2)
            rows.append((
                acc["account_id"], acc["customer_id"],
                principal, rate, tenure, maturity, mat_amount,
                random.choice(["Monthly","Quarterly","On Maturity"]),
                random.choices(
                    ["Active","Matured","Broken","Renewed"], weights=[55,30,10,5]
                )[0],
                random.random() < 0.3,
            ))
    bulk_insert(cur, "fixed_deposits",
        ["account_id","customer_id","principal","interest_rate",
         "tenure_months","maturity_date","maturity_amount",
         "payout_type","status","auto_renew"], rows)
    log.info(f"  + {len(rows)} fixed deposits inserted")


def seed_kyc_documents(cur, customer_ids: list, emp_ids: list):
    log.info("Seeding KYC documents ...")
    doc_types = ["PAN Card","Aadhaar","Passport","Voter ID",
                 "Driving License","Utility Bill","Bank Statement"]
    rows = []
    for cust_id in customer_ids:
        for doc_type in random.sample(doc_types, k=random.randint(1, 3)):
            submitted = rand_date(date(2015, 1, 1), date(2024, 1, 1))
            verified  = submitted + timedelta(days=random.randint(1, 30))
            status    = random.choices(
                ["Pending","Verified","Rejected","Expired"], weights=[10,75,10,5]
            )[0]
            rows.append((
                cust_id, doc_type,
                fake.bothify(text="??######??")[:30],
                submitted,
                verified if status == "Verified" else None,
                random.choice(emp_ids) if status == "Verified" else None,
                verified + timedelta(days=365 * random.randint(1, 10)) if status != "Rejected" else None,
                status,
            ))
    bulk_insert(cur, "kyc_documents",
        ["customer_id","doc_type","doc_number","submitted_on",
         "verified_on","verified_by","expiry_date","status"], rows)
    log.info(f"  + {len(rows)} KYC documents inserted")


def seed_fraud_alerts(cur, accounts: list, txn_ids: list, emp_ids: list):
    log.info("Seeding fraud alerts ...")
    alert_types = ["Unusual Hour","Rapid Succession","Round Amount","Geo Anomaly",
                   "Excessive Withdrawal","Dormant Activity","Large Single Txn"]
    rows = []
    for acc in random.sample(accounts, k=max(1, int(len(accounts) * 0.1))):
        rows.append((
            acc["account_id"],
            random.choice(txn_ids) if txn_ids else None,
            random.choice(alert_types),
            random.choices(["Low","Medium","High","Critical"], weights=[40,30,20,10])[0],
            datetime.now() - timedelta(days=random.randint(0, 180)),
            random.choice(emp_ids),
            random.choices(
                ["Open","False Positive","Confirmed Fraud","Under Review"], weights=[30,40,15,15]
            )[0],
            fake.sentence(nb_words=12),
        ))
    bulk_insert(cur, "fraud_alerts",
        ["account_id","txn_id","alert_type","severity",
         "flagged_on","reviewed_by","resolution","notes"], rows)
    log.info(f"  + {len(rows)} fraud alerts inserted")


def seed_interest_postings(cur, accounts: list):
    log.info("Seeding interest postings ...")
    rows = []
    for acc in random.sample(accounts, k=int(len(accounts) * 0.6)):
        for quarter in range(random.randint(1, 8)):
            period_start = date(2022, 1, 1) + timedelta(days=quarter * 90)
            period_end   = period_start + timedelta(days=89)
            rate         = round(random.uniform(3.0, 7.5), 2)
            principal    = round(random.uniform(5000, 500000), 2)
            interest     = round(principal * rate / 100 * 90 / 365, 2)
            tds          = round(interest * 0.1, 2) if interest > 5000 else 0.0
            rows.append((
                acc["account_id"], period_end,
                period_start, period_end,
                principal, rate, interest, tds,
                round(interest - tds, 2),
            ))
    bulk_insert(cur, "interest_postings",
        ["account_id","posting_date","period_start","period_end",
         "principal_used","rate_applied","interest_amount",
         "tds_deducted","net_posted"], rows)
    log.info(f"  + {len(rows)} interest postings inserted")


# ──────────────────────────────────────────────
# RESET
# ──────────────────────────────────────────────

def reset_tables(cur):
    log.warning("Resetting all tables ...")
    cur.execute("SET FOREIGN_KEY_CHECKS = 0")
    tables = [
        "interest_postings","fraud_alerts","kyc_documents",
        "fixed_deposits","cards","loan_repayments","loans",
        "transactions","accounts","customers","employees","branches",
    ]
    for t in tables:
        cur.execute(f"TRUNCATE TABLE {t}")
    cur.execute("SET FOREIGN_KEY_CHECKS = 1")
    log.warning("  + All tables cleared")


# ──────────────────────────────────────────────
# MAIN
# ──────────────────────────────────────────────

def parse_args():
    parser = argparse.ArgumentParser(description="Bank System DB Seeder (MySQL)")
    parser.add_argument("--branches",  type=int, default=10,  help="Number of branches")
    parser.add_argument("--employees", type=int, default=60,  help="Number of employees")
    parser.add_argument("--customers", type=int, default=200, help="Number of customers")
    parser.add_argument("--txns",      type=int, default=20,  help="Avg transactions per account")
    parser.add_argument("--reset",     action="store_true",   help="Truncate all tables before seeding")
    return parser.parse_args()


def main():
    args = parse_args()
    log.info("=" * 55)
    log.info("  Bank System Seeder (MySQL) - Starting")
    log.info(f"  branches={args.branches}  employees={args.employees}")
    log.info(f"  customers={args.customers}  txns/account~{args.txns}")
    log.info("=" * 55)

    start_time = datetime.now()
    conn = None
    try:
        conn = get_connection()
        conn.autocommit = False
        cur  = conn.cursor()
        log.info("Connected to MySQL database")

        if args.reset:
            reset_tables(cur)

        branch_ids   = seed_branches(cur, args.branches)
        emp_ids      = seed_employees(cur, branch_ids, args.employees)
        customer_ids = seed_customers(cur, branch_ids, args.customers)
        accounts     = seed_accounts(cur, customer_ids, branch_ids)
        txn_ids      = seed_transactions(cur, accounts, args.txns)
        loans        = seed_loans(cur, accounts, emp_ids)
        seed_loan_repayments(cur, loans)
        seed_cards(cur, accounts)
        seed_fixed_deposits(cur, accounts)
        seed_kyc_documents(cur, customer_ids, emp_ids)
        seed_fraud_alerts(cur, accounts, txn_ids, emp_ids)
        seed_interest_postings(cur, accounts)

        conn.commit()
        elapsed = round((datetime.now() - start_time).total_seconds(), 2)
        log.info("=" * 55)
        log.info(f"  Seeding complete in {elapsed}s")
        log.info("=" * 55)

    except Exception as e:
        if conn:
            conn.rollback()
        log.error(f"Seeding FAILED - rolled back. Error: {e}")
        raise
    finally:
        if conn and conn.is_connected():
            cur.close()
            conn.close()


if __name__ == "__main__":
    main()
