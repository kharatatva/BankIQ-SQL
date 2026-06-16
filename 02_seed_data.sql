INSERT INTO branches (branch_name, city, state, pincode, established_on, ifsc_prefix) VALUES
('Nariman Point Main',   'Mumbai',    'Maharashtra', '400021', '2005-03-15', 'BKIQ0001'),
('Bandra West',          'Mumbai',    'Maharashtra', '400050', '2009-07-22', 'BKIQ0002'),
('Connaught Place',      'Delhi',     'Delhi',       '110001', '2006-11-10', 'BKIQ0003'),
('Koramangala',          'Bangalore', 'Karnataka',   '560034', '2011-04-05', 'BKIQ0004'),
('Anna Nagar',           'Chennai',   'Tamil Nadu',  '600040', '2013-08-18', 'BKIQ0005'),
('Salt Lake Sector V',   'Kolkata',   'West Bengal', '700091', '2015-01-30', 'BKIQ0006');


INSERT INTO employees (branch_id, first_name, last_name, role, email, phone, hire_date, salary) VALUES
(1, 'Rohan',    'Mehta',    'Manager',            'rohan.mehta@bankiq.in',    '9820011234', '2005-03-15', 95000.00),
(1, 'Priya',    'Sharma',   'Senior Analyst',     'priya.sharma@bankiq.in',   '9820022345', '2010-06-01', 72000.00),
(1, 'Arjun',    'Nair',     'Loan Officer',       'arjun.nair@bankiq.in',     '9820033456', '2015-09-12', 68000.00),
(1, 'Sneha',    'Patil',    'Teller',             'sneha.patil@bankiq.in',    '9820044567', '2018-02-20', 38000.00),
(2, 'Kavita',   'Rao',      'Manager',            'kavita.rao@bankiq.in',     '9821011234', '2009-07-22', 93000.00),
(2, 'Dev',      'Khanna',   'Analyst',            'dev.khanna@bankiq.in',     '9821022345', '2016-04-15', 58000.00),
(2, 'Meera',    'Iyer',     'Compliance Officer', 'meera.iyer@bankiq.in',     '9821033456', '2017-11-08', 65000.00),
(3, 'Vikram',   'Singh',    'Manager',            'vikram.singh@bankiq.in',   '9822011234', '2006-11-10', 96000.00),
(3, 'Aditi',    'Gupta',    'Senior Analyst',     'aditi.gupta@bankiq.in',    '9822022345', '2012-03-25', 74000.00),
(3, 'Rajan',    'Verma',    'Loan Officer',       'rajan.verma@bankiq.in',    '9822033456', '2014-07-14', 67000.00),
(4, 'Ananya',   'Kumar',    'Manager',            'ananya.kumar@bankiq.in',   '9823011234', '2011-04-05', 91000.00),
(4, 'Karthik',  'Reddy',    'Analyst',            'karthik.reddy@bankiq.in',  '9823022345', '2019-01-10', 55000.00),
(4, 'Divya',    'Pillai',   'Teller',             'divya.pillai@bankiq.in',   '9823033456', '2020-06-22', 36000.00),
(5, 'Suresh',   'Babu',     'Manager',            'suresh.babu@bankiq.in',    '9824011234', '2013-08-18', 90000.00),
(5, 'Lakshmi',  'Subramanian','Senior Analyst',   'lakshmi.sub@bankiq.in',    '9824022345', '2015-12-05', 71000.00),
(5, 'Murugan',  'Selvan',   'Loan Officer',       'murugan.selvan@bankiq.in', '9824033456', '2018-09-30', 66000.00),
(5, 'Geetha',   'Venkat',   'Compliance Officer', 'geetha.venkat@bankiq.in',  '9824044567', '2021-03-15', 63000.00),
(6, 'Sourav',   'Das',      'Manager',            'sourav.das@bankiq.in',     '9825011234', '2015-01-30', 89000.00),
(6, 'Rima',     'Chatterjee','Analyst',           'rima.chatterjee@bankiq.in','9825022345', '2019-08-20', 54000.00),
(6, 'Anik',     'Bose',     'Teller',             'anik.bose@bankiq.in',      '9825033456', '2022-01-10', 34000.00);

-- Now link managers back to branches
UPDATE branches SET manager_emp_id = 1  WHERE branch_id = 1;
UPDATE branches SET manager_emp_id = 5  WHERE branch_id = 2;
UPDATE branches SET manager_emp_id = 8  WHERE branch_id = 3;
UPDATE branches SET manager_emp_id = 11 WHERE branch_id = 4;
UPDATE branches SET manager_emp_id = 14 WHERE branch_id = 5;
UPDATE branches SET manager_emp_id = 18 WHERE branch_id = 6;


INSERT INTO customers (branch_id, first_name, last_name, date_of_birth, gender, email, phone, address_line1, city, pincode, pan_number, aadhar_last4, customer_type, kyc_status, credit_score, joined_on) VALUES
(1, 'Aarav',     'Shah',       '1988-05-14', 'M', 'aarav.shah@gmail.com',       '9900001111', '12 Marine Lines',        'Mumbai',    '400002', 'ABCPS1234A', '1234', 'Individual', 'Verified',  780, '2018-03-10'),
(1, 'Diya',      'Mehta',      '1995-11-22', 'F', 'diya.mehta@gmail.com',       '9900002222', '45 Churchgate Apts',     'Mumbai',    '400020', 'BCDQT5678B', '5678', 'Individual', 'Verified',  820, '2019-07-15'),
(1, 'Nikhil',    'Joshi',      '1979-03-08', 'M', 'nikhil.joshi@biz.in',        '9900003333', '88 Nariman Point Tower', 'Mumbai',    '400021', 'CDER U9012C','9012', 'Business',   'Verified',  750, '2017-01-20'),
(1, 'Pooja',     'Desai',      '2000-08-30', 'F', 'pooja.desai@gmail.com',       '9900004444', '7 Malabar Hill',         'Mumbai',    '400006', 'DEFGV3456D', '3456', 'Individual', 'Verified',  690, '2022-05-05'),
(1, 'Sameer',    'Khan',       '1983-12-17', 'M', 'sameer.khan@outlook.com',    '9900005555', '23 Bandra Reclamation',  'Mumbai',    '400050', 'EFGHW7890E', '7890', 'Individual', 'Pending',   720, '2023-01-12'),
(2, 'Rekha',     'Pillai',     '1991-06-25', 'F', 'rekha.pillai@gmail.com',     '9900006666', '3 Linking Road',         'Mumbai',    '400050', 'FGHIX2345F', '2345', 'Individual', 'Verified',  810, '2020-09-08'),
(2, 'Aditya',    'Thakur',     '1986-02-14', 'M', 'aditya.thakur@corp.in',      '9900007777', '67 Hill Road',           'Mumbai',    '400050', 'GHIJY6789G', '6789', 'Business',   'Verified',  760, '2016-11-03'),
(2, 'Nandini',   'Kulkarni',   '1998-09-19', 'F', 'nandini.k@gmail.com',        '9900008888', '14 Pali Hill',           'Mumbai',    '400052', 'HIJKZ0123H', '0123', 'Individual', 'Verified',  735, '2021-04-22'),
(3, 'Rajeev',    'Malhotra',   '1975-04-11', 'M', 'rajeev.m@business.com',      '9900009999', '5 Connaught Circus',     'Delhi',     '110001', 'IJKLA4567I', '4567', 'Business',   'Verified',  855, '2014-06-18'),
(3, 'Sunita',    'Bhatia',     '1990-07-29', 'F', 'sunita.bhatia@gmail.com',    '9900010101', '32 Janpath Colony',      'Delhi',     '110001', 'JKLMB8901J', '8901', 'Individual', 'Verified',  795, '2019-02-14'),
(3, 'Manish',    'Kapoor',     '1982-10-05', 'M', 'manish.kapoor@delhi.in',     '9900011111', '18 Karol Bagh Market',   'Delhi',     '110005', 'KLMNC2345K', '2345', 'Individual', 'Verified',  670, '2020-08-30'),
(3, 'Preethi',   'Aggarwal',   '1997-01-18', 'F', 'preethi.a@gmail.com',        '9900012222', '9 Lajpat Nagar II',      'Delhi',     '110024', 'LMNOD6789L', '6789', 'Individual', 'Pending',   700, '2023-03-07'),
(4, 'Kiran',     'Rao',        '1985-08-22', 'M', 'kiran.rao@startup.io',       '9900013333', '112 Koramangala 5th Blk','Bangalore', '560095', 'MNOPE0123M', '0123', 'Business',   'Verified',  840, '2015-10-11'),
(4, 'Deepa',     'Nair',       '1993-03-15', 'F', 'deepa.nair@gmail.com',       '9900014444', '26 Indiranagar 100ft',   'Bangalore', '560038', 'NOPQF4567N', '4567', 'Individual', 'Verified',  775, '2018-12-25'),
(4, 'Arjun',     'Krishnan',   '1989-11-08', 'M', 'arjun.k@techfirm.in',        '9900015555', '5 HSR Layout Sec 2',     'Bangalore', '560102', 'OPQRG8901O', '8901', 'Individual', 'Verified',  800, '2020-03-14'),
(4, 'Bhavya',    'Shetty',     '2001-05-27', 'F', 'bhavya.shetty@gmail.com',    '9900016666', '33 Whitefield Main Rd',  'Bangalore', '560066', 'PQRSH2345P', '2345', 'Individual', 'Verified',  650, '2022-11-19'),
(5, 'Ramesh',    'Iyer',       '1977-09-14', 'M', 'ramesh.iyer@manufacturing.in','9900017777', '8 Anna Nagar West',      'Chennai',   '600040', 'QRSTI6789Q', '6789', 'Business',   'Verified',  870, '2013-05-22'),
(5, 'Kavitha',   'Sundaram',   '1994-12-03', 'F', 'kavitha.s@gmail.com',         '9900018888', '47 T Nagar North',       'Chennai',   '600017', 'RSTUJ0123R', '0123', 'Individual', 'Verified',  790, '2019-09-16'),
(5, 'Senthil',   'Kumar',      '1987-06-20', 'M', 'senthil.k@chennai.net',       '9900019999', '14 Adyar Bridge Rd',     'Chennai',   '600020', 'STUVK4567S', '4567', 'Individual', 'Verified',  715, '2021-01-30'),
(5, 'Pavithra',  'Rajan',      '1999-04-09', 'F', 'pavithra.r@gmail.com',        '9900020000', '2 Velachery Main Rd',    'Chennai',   '600042', 'TUVWL8901T', '8901', 'Individual', 'Pending',   680, '2023-06-14'),
(6, 'Subhajit',  'Ghosh',      '1980-01-27', 'M', 'subhajit.g@enterprise.com',  '9900021111', '10 Salt Lake AC Block',  'Kolkata',   '700064', 'UVWXM2345U', '2345', 'Business',   'Verified',  835, '2016-04-08'),
(6, 'Anindita',  'Banerjee',   '1992-08-11', 'F', 'anindita.b@gmail.com',        '9900022222', '55 Ballygunge Place',    'Kolkata',   '700019', 'VWXYN6789V', '6789', 'Individual', 'Verified',  785, '2018-07-23'),
(6, 'Debashish', 'Mukherjee',  '1984-03-04', 'M', 'debashish.m@kolkata.in',      '9900023333', '19 Park Street',         'Kolkata',   '700016', 'WXYZO0123W', '0123', 'Individual', 'Verified',  740, '2020-10-05'),
(1, 'Zara',      'Patel',      '2002-07-18', 'F', 'zara.patel@gmail.com',        '9900024444', '6 Pedder Road Apts',     'Mumbai',    '400026', 'XYZAP4567X', '4567', 'Individual', 'Verified',  720, '2023-08-01'),
(2, 'Harsh',     'Vardhan',    '1976-10-31', 'M', 'harsh.v@businessgroup.in',    '9900025555', '88 Worli Sea Face',      'Mumbai',    '400018', 'YZABQ8901Y', '8901', 'Business',   'Verified',  880, '2012-02-14'),
(3, 'Ishita',    'Roy',        '1996-02-22', 'F', 'ishita.roy@gmail.com',        '9900026666', '22 Defence Colony',      'Delhi',     '110024', 'ZABCR2345Z', '2345', 'Individual', 'Verified',  760, '2021-07-11'),
(4, 'Mihir',     'Shah',       '1988-11-15', 'M', 'mihir.shah@consultancy.in',   '9900027777', '7 MG Road Prestige',     'Bangalore', '560001', 'ABCDS6789A', '6789', 'Business',   'Verified',  825, '2017-09-28'),
(5, 'Thenmozhi', 'Selvam',     '1991-05-07', 'F', 'then.selvam@gmail.com',       '9900028888', '31 Mylapore 4th St',     'Chennai',   '600004', 'BCDFT0123B', '0123', 'Individual', 'Verified',  770, '2019-11-19'),
(6, 'Prosenjit', 'Sen',        '1983-09-13', 'M', 'prosenjit.s@business.net',    '9900029999', '14 Dalhousie Square',    'Kolkata',   '700001', 'CDEFU4567C', '4567', 'Business',   'Rejected',  580, '2022-04-03'),
(1, 'Ritu',      'Agarwal',    '1993-12-28', 'F', 'ritu.agarwal@gmail.com',      '9900030000', '39 Juhu Tara Road',      'Mumbai',    '400049', 'DEFGV8901D', '8901', 'Individual', 'Verified',  805, '2020-06-17');


INSERT INTO accounts (customer_id, branch_id, account_number, account_type, balance, min_balance, interest_rate, opened_on, status, last_txn_date) VALUES
(1,  1, '1001000100010001', 'Savings',          245000.00,  1000.00, 3.50, '2018-03-10', 'Active',  '2024-12-28'),
(1,  1, '1001000100010002', 'Fixed Deposit',    500000.00,      0.00, 7.10, '2021-06-15', 'Active',  '2023-06-15'),
(2,  1, '1001000200010001', 'Savings',          182000.50,  1000.00, 3.50, '2019-07-15', 'Active',  '2024-12-30'),
(3,  1, '1001000300010001', 'Current',         1250000.00, 10000.00, 2.00, '2017-01-20', 'Active',  '2024-12-31'),
(4,  1, '1001000400010001', 'Salary',           35800.00,    500.00, 3.50, '2022-05-05', 'Active',  '2024-12-25'),
(5,  1, '1001000500010001', 'Savings',          12000.00,   1000.00, 3.50, '2023-01-12', 'Active',  '2024-11-14'),
(6,  2, '1002000600010001', 'Savings',          320000.00,  1000.00, 3.50, '2020-09-08', 'Active',  '2024-12-29'),
(7,  2, '1002000700010001', 'Current',         2800000.00, 10000.00, 2.00, '2016-11-03', 'Active',  '2024-12-31'),
(8,  2, '1002000800010001', 'Savings',           58000.00,  1000.00, 3.50, '2021-04-22', 'Active',  '2024-12-20'),
(9,  3, '1003000900010001', 'Current',         5500000.00, 10000.00, 2.00, '2014-06-18', 'Active',  '2024-12-31'),
(10, 3, '1003001000010001', 'Savings',          410000.00,  1000.00, 3.50, '2019-02-14', 'Active',  '2024-12-27'),
(10, 3, '1003001000010002', 'Recurring Deposit', 72000.00,     0.00, 6.50, '2022-01-01', 'Active',  '2024-12-01'),
(11, 3, '1003001100010001', 'Savings',           28500.00,  1000.00, 3.50, '2020-08-30', 'Active',  '2024-12-10'),
(12, 3, '1003001200010001', 'Salary',            22400.00,    500.00, 3.50, '2023-03-07', 'Active',  '2024-12-25'),
(13, 4, '1004001300010001', 'Current',         3200000.00, 10000.00, 2.00, '2015-10-11', 'Active',  '2024-12-31'),
(14, 4, '1004001400010001', 'Savings',          175000.00,  1000.00, 3.50, '2018-12-25', 'Active',  '2024-12-28'),
(15, 4, '1004001500010001', 'Savings',          290000.00,  1000.00, 3.50, '2020-03-14', 'Active',  '2024-12-30'),
(16, 4, '1004001600010001', 'Salary',            18600.00,    500.00, 3.50, '2022-11-19', 'Active',  '2024-12-25'),
(17, 5, '1005001700010001', 'Current',         8900000.00, 10000.00, 2.00, '2013-05-22', 'Active',  '2024-12-31'),
(18, 5, '1005001800010001', 'Savings',          225000.00,  1000.00, 3.50, '2019-09-16', 'Active',  '2024-12-26'),
(19, 5, '1005001900010001', 'Savings',           85000.00,  1000.00, 3.50, '2021-01-30', 'Active',  '2024-12-18'),
(20, 5, '1005002000010001', 'Salary',            14200.00,    500.00, 3.50, '2023-06-14', 'Active',  '2024-12-25'),
(21, 6, '1006002100010001', 'Current',         4100000.00, 10000.00, 2.00, '2016-04-08', 'Active',  '2024-12-31'),
(22, 6, '1006002200010001', 'Savings',          380000.00,  1000.00, 3.50, '2018-07-23', 'Active',  '2024-12-29'),
(23, 6, '1006002300010001', 'Savings',          112000.00,  1000.00, 3.50, '2020-10-05', 'Active',  '2024-12-22'),
(24, 1, '1001002400010001', 'Salary',            21300.00,    500.00, 3.50, '2023-08-01', 'Active',  '2024-12-25'),
(25, 2, '1002002500010001', 'Current',         7200000.00, 10000.00, 2.00, '2012-02-14', 'Active',  '2024-12-31'),
(26, 3, '1003002600010001', 'Savings',          145000.00,  1000.00, 3.50, '2021-07-11', 'Active',  '2024-12-23'),
(27, 4, '1004002700010001', 'Current',         2600000.00, 10000.00, 2.00, '2017-09-28', 'Active',  '2024-12-31'),
(28, 5, '1005002800010001', 'Savings',          198000.00,  1000.00, 3.50, '2019-11-19', 'Active',  '2024-12-27'),
(29, 6, '1006002900010001', 'Current',          350000.00, 10000.00, 2.00, '2022-04-03', 'Frozen',  '2024-08-15'),
(30, 1, '1001003000010001', 'Savings',          275000.00,  1000.00, 3.50, '2020-06-17', 'Active',  '2024-12-28'),
(5,  1, '1001000500010002', 'Recurring Deposit', 18000.00,     0.00, 6.50, '2023-06-01', 'Active',  '2024-12-01'),
(8,  2, '1002000800010002', 'Fixed Deposit',    200000.00,      0.00, 7.10, '2023-01-10', 'Active',  '2024-01-10'),
(11, 3, '1003001100010002', 'Fixed Deposit',    100000.00,      0.00, 7.10, '2022-05-15', 'Active',  '2023-05-15'),
(16, 4, '1004001600010002', 'Savings',           32000.00,  1000.00, 3.50, '2023-03-20', 'Active',  '2024-12-15'),
(19, 5, '1005001900010002', 'Recurring Deposit', 24000.00,     0.00, 6.50, '2023-02-01', 'Active',  '2024-12-01'),
(23, 6, '1006002300010002', 'Savings',            4200.00,  1000.00, 3.50, '2021-08-12', 'Dormant', '2023-01-05'),
(26, 3, '1003002600010002', 'Fixed Deposit',    300000.00,      0.00, 7.10, '2022-09-01', 'Active',  '2023-09-01'),
(30, 1, '1001003000010002', 'Current',          620000.00, 10000.00, 2.00, '2021-11-22', 'Active',  '2024-12-30');


INSERT INTO transactions (account_id, txn_date, txn_type, txn_mode, amount, balance_after, description, reference_no, merchant_name, category, channel) VALUES
-- Account 1 (Aarav Shah - Savings)
(1, '2024-01-01 09:00:00', 'Credit', 'NEFT',         85000.00,  245000.00, 'Monthly salary credit',      'REF2401010001', 'Employer HDFC',   'Salary',          'Online'),
(1, '2024-01-05 14:22:00', 'Debit',  'UPI',           3200.00,  241800.00, 'Amazon order payment',       'REF2401050001', 'Amazon India',    'Shopping',        'Mobile App'),
(1, '2024-01-10 11:45:00', 'Debit',  'Auto-debit',   18500.00,  223300.00, 'Home loan EMI',              'REF2401100001', 'SBI Home Loans',  'EMI',             'Online'),
(1, '2024-01-15 08:30:00', 'Debit',  'UPI',           1200.00,  222100.00, 'Electricity bill',           'REF2401150001', 'MSEDCL',          'Utilities',       'Mobile App'),
(1, '2024-02-01 09:00:00', 'Credit', 'NEFT',         85000.00,  307100.00, 'Monthly salary credit',      'REF2402010001', 'Employer HDFC',   'Salary',          'Online'),
(1, '2024-02-14 20:10:00', 'Debit',  'UPI',           6800.00,  300300.00, 'Zomato Valentine dinner',    'REF2402140001', 'Zomato',          'Food & Dining',   'Mobile App'),
(1, '2024-02-10 11:45:00', 'Debit',  'Auto-debit',   18500.00,  281800.00, 'Home loan EMI',              'REF2402100001', 'SBI Home Loans',  'EMI',             'Online'),
(1, '2024-03-01 09:00:00', 'Credit', 'NEFT',         85000.00,  366800.00, 'Monthly salary credit',      'REF2403010001', 'Employer HDFC',   'Salary',          'Online'),
(1, '2024-03-10 11:45:00', 'Debit',  'Auto-debit',   18500.00,  348300.00, 'Home loan EMI',              'REF2403100001', 'SBI Home Loans',  'EMI',             'Online'),
(1, '2024-03-20 16:55:00', 'Debit',  'ATM',          10000.00,  338300.00, 'ATM cash withdrawal',        'REF2403200001', NULL,              'ATM Withdrawal',  'ATM'),
-- Account 3 (Diya Mehta - Savings)
(3, '2024-01-03 10:15:00', 'Credit', 'NEFT',         65000.00,  182000.50, 'Salary Jan',                 'REF2401030001', 'Tech Employer',   'Salary',          'Online'),
(3, '2024-01-12 13:30:00', 'Debit',  'UPI',           4500.00,  177500.50, 'Flipkart purchase',          'REF2401120001', 'Flipkart',        'Shopping',        'Mobile App'),
(3, '2024-01-18 09:00:00', 'Debit',  'Auto-debit',   12000.00,  165500.50, 'Car loan EMI',               'REF2401180001', 'Axis Auto Loans', 'EMI',             'Online'),
(3, '2024-02-03 10:15:00', 'Credit', 'NEFT',         65000.00,  230500.50, 'Salary Feb',                 'REF2402030001', 'Tech Employer',   'Salary',          'Online'),
(3, '2024-02-18 09:00:00', 'Debit',  'Auto-debit',   12000.00,  218500.50, 'Car loan EMI',               'REF2402180001', 'Axis Auto Loans', 'EMI',             'Online'),
(3, '2024-02-22 19:45:00', 'Debit',  'UPI',           2300.00,  216200.50, 'Swiggy order',               'REF2402220001', 'Swiggy',          'Food & Dining',   'Mobile App'),
-- Account 4 (Nikhil Joshi - Current / Business)
(4, '2024-01-08 11:00:00', 'Credit', 'RTGS',       500000.00, 1250000.00, 'Client payment - Invoice 221','REF2401080001','Client Corp',     'Transfer',        'Online'),
(4, '2024-01-20 14:00:00', 'Debit',  'NEFT',        200000.00, 1050000.00, 'Vendor payment - supplies',  'REF2401200001', 'Vendor ABC Ltd',  'Other',           'Online'),
(4, '2024-02-08 11:00:00', 'Credit', 'RTGS',       750000.00, 1800000.00, 'Client payment - Invoice 222','REF2402080001','Client Corp',     'Transfer',        'Online'),
(4, '2024-02-25 15:30:00', 'Debit',  'NEFT',        350000.00, 1450000.00, 'Staff salary disbursement',  'REF2402250001', 'Payroll System',  'Other',           'Online'),
-- Account 7 (Aditya Thakur - Current / Business)
(7, '2024-01-05 09:30:00', 'Credit', 'RTGS',      1000000.00, 2800000.00, 'Import payment received',    'REF2401050002', 'Overseas Buyer',  'Transfer',        'Online'),
(7, '2024-01-15 16:00:00', 'Debit',  'RTGS',        800000.00, 2000000.00, 'Raw material import',        'REF2401150002', 'Import Supplier', 'Other',           'Online'),
(7, '2024-02-05 09:30:00', 'Credit', 'RTGS',      1200000.00, 3200000.00, 'Import payment received',    'REF2402050002', 'Overseas Buyer',  'Transfer',        'Online'),
-- Account 9 (Rajeev Malhotra - Current / Business)
(9, '2024-01-02 10:00:00', 'Credit', 'RTGS',      2000000.00, 5500000.00, 'Q4 client settlement',       'REF2401020001', 'Enterprise Client','Transfer',       'Online'),
(9, '2024-01-22 11:30:00', 'Debit',  'RTGS',       1500000.00, 4000000.00, 'Advance to subsidiary',      'REF2401220001', 'BizGroup Sub',    'Transfer',        'Online'),
(9, '2024-02-02 10:00:00', 'Credit', 'RTGS',      3000000.00, 7000000.00, 'Feb client settlement',      'REF2402020001', 'Enterprise Client','Transfer',       'Online'),
(9, '2024-02-28 14:00:00', 'Debit',  'RTGS',       2500000.00, 4500000.00, 'Quarterly tax payment',      'REF2402280001', 'Income Tax Dept', 'Other',           'Online'),
-- Account 10 (Sunita Bhatia - Savings)
(10, '2024-01-04 08:55:00', 'Credit','NEFT',        72000.00,  410000.00, 'January salary',              'REF2401040001', 'Gov Employer',    'Salary',          'Online'),
(10, '2024-01-14 12:20:00', 'Debit', 'UPI',          5500.00,  404500.00, 'Myntra shopping',             'REF2401140001', 'Myntra',          'Shopping',        'Mobile App'),
(10, '2024-01-25 10:00:00', 'Debit', 'Cheque',      25000.00,  379500.00, 'School fee payment',          'REF2401250001', 'DPS School',      'Other',           'Branch'),
(10, '2024-02-04 08:55:00', 'Credit','NEFT',        72000.00,  451500.00, 'February salary',             'REF2402040001', 'Gov Employer',    'Salary',          'Online'),
(10, '2024-02-20 15:45:00', 'Debit', 'ATM',         20000.00,  431500.00, 'ATM withdrawal',              'REF2402200001', NULL,              'ATM Withdrawal',  'ATM'),
-- Account 14 (Deepa Nair - Savings)
(14, '2024-01-06 09:10:00', 'Credit','NEFT',        58000.00,  175000.00, 'January salary',              'REF2401060001', 'IT Company',      'Salary',          'Online'),
(14, '2024-01-16 14:30:00', 'Debit', 'Auto-debit',   9500.00,  165500.00, 'Personal loan EMI',           'REF2401160001', 'HDFC Loans',      'EMI',             'Online'),
(14, '2024-01-21 18:00:00', 'Debit', 'UPI',          2800.00,  162700.00, 'BookMyShow tickets',          'REF2401210001', 'BookMyShow',      'Travel',          'Mobile App'),
(14, '2024-02-06 09:10:00', 'Credit','NEFT',        58000.00,  220700.00, 'February salary',             'REF2402060001', 'IT Company',      'Salary',          'Online'),
(14, '2024-02-16 14:30:00', 'Debit', 'Auto-debit',   9500.00,  211200.00, 'Personal loan EMI',           'REF2402160001', 'HDFC Loans',      'EMI',             'Online'),
-- Account 18 (Kavitha Sundaram - Savings)
(18, '2024-01-07 09:45:00', 'Credit','NEFT',        55000.00,  225000.00, 'January salary',              'REF2401070001', 'Pharma Company',  'Salary',          'Online'),
(18, '2024-01-17 11:20:00', 'Debit', 'Auto-debit',   8000.00,  217000.00, 'Two-wheeler loan EMI',        'REF2401170001', 'Bajaj Finance',   'EMI',             'Online'),
(18, '2024-01-28 20:30:00', 'Debit', 'UPI',          3500.00,  213500.00, 'Apollo Pharmacy',             'REF2401280001', 'Apollo Pharmacy', 'Healthcare',      'Mobile App'),
(18, '2024-02-07 09:45:00', 'Credit','NEFT',        55000.00,  268500.00, 'February salary',             'REF2402070001', 'Pharma Company',  'Salary',          'Online'),
(18, '2024-02-17 11:20:00', 'Debit', 'Auto-debit',   8000.00,  260500.00, 'Two-wheeler loan EMI',        'REF2402170001', 'Bajaj Finance',   'EMI',             'Online'),
-- Suspicious / fraud-pattern transactions
(5,  '2024-03-10 02:14:00', 'Debit', 'UPI',          9999.00,    2001.00, 'Unknown merchant',            'REF2403100002', 'Merchant X',      'Other',           'Mobile App'),
(5,  '2024-03-10 02:31:00', 'Debit', 'UPI',          9000.00,   -6999.00, 'Unknown merchant',            'REF2403100003', 'Merchant X',      'Other',           'Mobile App'),
(5,  '2024-03-10 02:47:00', 'Debit', 'UPI',          9500.00,  -16499.00, 'Unknown merchant',            'REF2403100004', 'Merchant X',      'Other',           'Mobile App'),
(23, '2024-11-01 03:05:00', 'Debit', 'ATM',         10000.00,    4200.00, 'ATM withdrawal odd hours',    'REF2411010001', NULL,              'ATM Withdrawal',  'ATM'),
(23, '2024-11-01 03:22:00', 'Debit', 'ATM',         10000.00,   -5800.00, 'ATM withdrawal odd hours',    'REF2411010002', NULL,              'ATM Withdrawal',  'ATM'),
-- Round-number transactions (fraud signal)
(4,  '2024-04-05 11:00:00', 'Credit','RTGS',       100000.00, 1350000.00, 'Suspicious round transfer',   'REF2404050001', 'Unknown Corp',    'Transfer',        'Online'),
(4,  '2024-04-05 11:03:00', 'Debit', 'NEFT',       100000.00, 1250000.00, 'Immediate transfer out',      'REF2404050002', 'Unknown Corp',    'Transfer',        'Online'),
(7,  '2024-05-12 23:58:00', 'Credit','RTGS',        50000.00, 2050000.00, 'Late night credit',           'REF2405120001', 'Anonymous',       'Transfer',        'Online'),
(7,  '2024-05-12 23:59:00', 'Debit', 'NEFT',        50000.00, 2000000.00, 'Late night debit',            'REF2405120002', 'Anonymous',       'Transfer',        'Online'),
-- Additional normal transactions
(22, '2024-01-09 10:00:00', 'Credit','NEFT',        60000.00,  380000.00, 'January salary',              'REF2401090001', 'Bank Employer',   'Salary',          'Online'),
(22, '2024-01-19 13:40:00', 'Debit', 'UPI',          4200.00,  375800.00, 'Reliance Smart grocery',      'REF2401190001', 'Reliance Smart',  'Food & Dining',   'Mobile App'),
(30, '2024-01-11 09:20:00', 'Credit','NEFT',        78000.00,  275000.00, 'January salary',              'REF2401110001', 'Consulting Firm', 'Salary',          'Online'),
(30, '2024-01-21 16:10:00', 'Debit', 'Auto-debit',  15000.00,  260000.00, 'Housing loan EMI',            'REF2401210001', 'LIC Housing',     'EMI',             'Online'),
(30, '2024-02-11 09:20:00', 'Credit','NEFT',        78000.00,  338000.00, 'February salary',             'REF2402110001', 'Consulting Firm', 'Salary',          'Online'),
(1,  '2024-12-28 12:00:00', 'Debit', 'UPI',         50000.00,  195000.00, 'Year-end investment',         'REF2412280001', 'Zerodha',         'Investment',      'Mobile App'),
(10, '2024-12-27 10:00:00', 'Debit', 'NEFT',        30000.00,  349500.00, 'Transfer to RD account',      'REF2412270001', 'Self Transfer',   'Investment',      'Online');


INSERT INTO loans (customer_id, branch_id, account_id, loan_type, principal, interest_rate, tenure_months, emi_amount, disbursed_on, first_emi_date, end_date, outstanding, status, loan_officer_id, collateral) VALUES
(1,  1,  1,  'Home Loan',      7500000.00, 8.50, 240, 65068.00, '2020-01-15', '2020-02-15', '2040-01-15', 6820000.00, 'Active',      3,  'Flat at Nariman Point'),
(2,  1,  3,  'Car Loan',        850000.00, 9.25,  60, 17720.00, '2022-03-10', '2022-04-10', '2027-03-10',  510000.00, 'Active',      3,  'Honda City 2022'),
(4,  1,  5,  'Personal Loan',   200000.00,14.50,  36,  6873.00, '2023-02-01', '2023-03-01', '2026-02-01',  137460.00, 'Active',      3,  NULL),
(8,  2,  9,  'Personal Loan',   350000.00,13.75,  48,  9458.00, '2022-06-15', '2022-07-15', '2026-06-15',  207276.00, 'Active',      NULL,'NULL'),
(10, 3, 10,  'Car Loan',        650000.00, 9.00,  60, 13488.00, '2021-09-20', '2021-10-20', '2026-09-20',  323712.00, 'Active',      10, 'Maruti Brezza 2021'),
(13, 4, 15,  'Business Loan', 5000000.00, 11.25, 120, 68467.00, '2019-04-01', '2019-05-01', '2029-04-01', 3492817.00, 'Active',      NULL,'Office property Koramangala'),
(14, 4, 14,  'Personal Loan',   300000.00,13.50,  36,  10207.00,'2022-11-10', '2022-12-10', '2025-11-10',   91863.00, 'Active',      NULL,NULL),
(17, 5, 19,  'Business Loan', 8000000.00, 10.75, 120, 107890.00,'2018-01-15', '2018-02-15', '2028-01-15', 4731960.00, 'Active',      16, 'Factory land Chennai'),
(18, 5, 18,  'Personal Loan',   150000.00,14.00,  24,  7208.00, '2023-07-01', '2023-08-01', '2025-07-01',   72080.00, 'Active',      16, NULL),
(21, 6, 23,  'Business Loan', 3500000.00, 11.00, 120, 48175.00, '2020-07-10', '2020-08-10', '2030-07-10', 2505100.00, 'Active',      NULL,'Warehouse Salt Lake'),
(22, 6, 24,  'Home Loan',     3200000.00,  8.75, 240, 28339.00, '2019-09-05', '2019-10-05', '2039-09-05', 2690205.00, 'Active',      NULL,'Flat Ballygunge'),
(25, 2,  7,  'Business Loan', 10000000.00,10.50, 120, 134935.00,'2017-03-20', '2017-04-20', '2027-03-20', 4777570.00, 'Active',      7,  'Industrial plot Bandra'),
(27, 4, 29,  'Business Loan', 4000000.00, 11.50, 120, 55714.00, '2020-11-01', '2020-12-01', '2030-11-01', 2228560.00, 'Active',      NULL,'Tech Park office'),
(9,  3,  9,  'Business Loan', 15000000.00,10.25, 120, 200370.00,'2016-01-10', '2016-02-10', '2026-01-10', 4207770.00, 'Active',      10, 'Commercial building Delhi'),
(3,  1,  4,  'Business Loan', 2000000.00, 11.75, 120, 27923.00, '2018-05-15', '2018-06-15', '2028-05-15', 1228612.00, 'Active',      3,  'Office space Nariman Pt'),
(29, 6, 31,  'Business Loan', 1000000.00, 14.00, 60,  23268.00, '2022-04-15', '2022-05-15', '2027-04-15',  697200.00, 'Defaulted',   NULL,'None'),
(11, 3, 13,  'Personal Loan',   100000.00,15.00,  24,  4850.00, '2023-04-01', '2023-05-01', '2025-04-01',   43650.00, 'Active',      NULL,NULL),
(23, 6, 25,  'Education Loan',  400000.00, 9.50,  60,  8393.00, '2021-09-01', '2021-10-01', '2026-09-01',  268576.00, 'Active',      NULL,'Academic guarantee'),
(19, 5, 21,  'Gold Loan',       80000.00, 10.50,  12,  7035.00, '2024-06-01', '2024-07-01', '2025-06-01',   42210.00, 'Active',      16, '22kt gold jewellery'),
(30, 1, 41,  'Home Loan',      4500000.00, 8.60, 240, 39501.00, '2021-11-22', '2021-12-22', '2041-11-22', 4150605.00, 'Active',      3,  'Apartment Juhu');


INSERT INTO loan_repayments (loan_id, payment_date, amount_paid, principal_paid, interest_paid, penalty, payment_mode, status) VALUES
(1, '2024-01-15', 65068.00, 11905.00, 53163.00, 0.00, 'Auto-debit', 'Paid'),
(1, '2024-02-15', 65068.00, 11989.00, 53079.00, 0.00, 'Auto-debit', 'Paid'),
(1, '2024-03-15', 65068.00, 12074.00, 52994.00, 0.00, 'Auto-debit', 'Paid'),
(2, '2024-01-10', 17720.00,  4660.00, 13060.00, 0.00, 'Auto-debit', 'Paid'),
(2, '2024-02-10', 17720.00,  4696.00, 13024.00, 0.00, 'Auto-debit', 'Paid'),
(2, '2024-03-10', 17720.00,  4733.00, 12987.00, 0.00, 'Auto-debit', 'Paid'),
(3, '2024-01-01',  6873.00,  4465.00,  2408.00, 0.00, 'Auto-debit', 'Paid'),
(3, '2024-02-01',  6873.00,  4519.00,  2354.00, 0.00, 'Auto-debit', 'Paid'),
(3, '2024-03-01',  6873.00,  4573.00,  2300.00, 0.00, 'Auto-debit', 'Paid'),
(5, '2024-01-20', 13488.00,  4620.00,  8868.00, 0.00, 'Auto-debit', 'Paid'),
(5, '2024-02-20', 13488.00,  4655.00,  8833.00, 0.00, 'Auto-debit', 'Paid'),
(7, '2024-01-10', 10207.00,  5067.00,  5140.00, 0.00, 'Auto-debit', 'Paid'),
(7, '2024-02-10', 10207.00,  5124.00,  5083.00, 0.00, 'Auto-debit', 'Paid'),
(7, '2024-03-10', 10207.00,  5181.00,  5026.00, 0.00, 'Auto-debit', 'Paid'),
(9, '2024-01-01',  7208.00,  2534.00,  4674.00, 0.00, 'Auto-debit', 'Paid'),
(9, '2024-02-01',  7208.00,  2564.00,  4644.00, 0.00, 'Auto-debit', 'Paid'),
(16,'2024-01-15', 23268.00,  9601.00, 13667.00, 0.00, 'Auto-debit', 'Paid'),
(16,'2024-02-15',     0.00,     0.00,     0.00, 2000.00,'Auto-debit','Missed'),
(16,'2024-03-15', 25268.00,  9601.00, 13667.00, 2000.00,'Branch',   'Paid'),
(17,'2024-01-01',  4850.00,  2600.00,  2250.00, 0.00, 'Auto-debit', 'Paid'),
(17,'2024-02-01',  4850.00,  2633.00,  2217.00, 0.00, 'Auto-debit', 'Paid'),
(14,'2024-01-10',200370.00, 65370.00,135000.00, 0.00, 'Auto-debit', 'Paid'),
(14,'2024-02-10',200370.00, 65928.00,134442.00, 0.00, 'Auto-debit', 'Paid'),
(12,'2024-01-20', 48175.00, 16025.00, 32150.00, 0.00, 'Auto-debit', 'Paid'),
(12,'2024-02-20', 48175.00, 16172.00, 32003.00, 0.00, 'Auto-debit', 'Paid'),
(6, '2024-01-01', 68467.00, 22559.00, 45908.00, 0.00, 'Auto-debit', 'Paid'),
(6, '2024-02-01', 68467.00, 22770.00, 45697.00, 0.00, 'Auto-debit', 'Paid'),
(8, '2024-01-15',107890.00, 36070.00, 71820.00, 0.00, 'Auto-debit', 'Paid'),
(19,'2024-07-01',  7035.00,  5335.00,  1700.00, 0.00, 'Auto-debit', 'Paid'),
(19,'2024-08-01',  7035.00,  5382.00,  1653.00, 0.00, 'Auto-debit', 'Paid');


INSERT INTO cards (account_id, customer_id, card_type, card_network, card_number_last4, issued_on, expiry_date, credit_limit, outstanding_due, status) VALUES
(1,  1,  'Debit',  'Visa',       '4521', '2018-03-10', '2028-03-31', NULL,      0.00,      'Active'),
(1,  1,  'Credit', 'Mastercard', '7834', '2020-01-15', '2026-01-31', 200000.00, 45000.00,  'Active'),
(3,  2,  'Debit',  'RuPay',      '6612', '2019-07-15', '2027-07-31', NULL,      0.00,      'Active'),
(3,  2,  'Credit', 'Visa',       '9901', '2021-09-01', '2025-09-30', 150000.00, 22000.00,  'Active'),
(4,  3,  'Debit',  'Visa',       '3345', '2017-01-20', '2027-01-31', NULL,      0.00,      'Active'),
(5,  4,  'Debit',  'RuPay',      '8820', '2022-05-05', '2026-05-31', NULL,      0.00,      'Active'),
(7,  6,  'Debit',  'Visa',       '1109', '2020-09-08', '2028-09-30', NULL,      0.00,      'Active'),
(7,  6,  'Credit', 'Mastercard', '4478', '2022-01-10', '2026-01-31', 300000.00, 78000.00,  'Active'),
(9,  7,  'Debit',  'Visa',       '6633', '2016-11-03', '2026-11-30', NULL,      0.00,      'Active'),
(10, 9,  'Debit',  'Visa',       '5512', '2014-06-18', '2026-06-30', NULL,      0.00,      'Active'),
(10, 9,  'Credit', 'Mastercard', '2291', '2016-09-01', '2026-09-30', 500000.00, 125000.00, 'Active'),
(11,10,  'Debit',  'RuPay',      '7743', '2019-02-14', '2027-02-28', NULL,      0.00,      'Active'),
(16,14,  'Debit',  'Visa',       '0034', '2018-12-25', '2026-12-31', NULL,      0.00,      'Active'),
(16,14,  'Credit', 'Visa',       '8867', '2021-03-01', '2025-03-31', 100000.00, 33000.00,  'Active'),
(20,17,  'Debit',  'Visa',       '4411', '2013-05-22', '2025-05-31', NULL,      0.00,      'Expired'),
(20,17,  'Credit', 'Mastercard', '9923', '2019-01-01', '2025-01-31', 750000.00, 210000.00, 'Active'),
(24,22,  'Debit',  'RuPay',      '3356', '2018-07-23', '2026-07-31', NULL,      0.00,      'Active'),
(29,25,  'Debit',  'Visa',       '7789', '2012-02-14', '2026-02-28', NULL,      0.00,      'Active'),
(29,25,  'Credit', 'Mastercard', '1122', '2017-06-01', '2027-06-30', 1000000.00,380000.00, 'Active'),
(32,29,  'Debit',  'Visa',       '5544', '2022-04-03', '2026-04-30', NULL,      0.00,      'Hotlisted');


INSERT INTO fixed_deposits (account_id, customer_id, principal, interest_rate, tenure_months, maturity_date, maturity_amount, payout_type, status, auto_renew) VALUES
(2,  1,  500000.00, 7.10, 24, '2023-06-15', 574025.00, 'On Maturity', 'Matured',  FALSE),
(34, 8,  200000.00, 7.10, 12, '2024-01-10', 214200.00, 'Quarterly',   'Matured',  TRUE),
(35,11,  100000.00, 7.10, 12, '2023-05-15', 107100.00, 'On Maturity', 'Matured',  FALSE),
(39,26,  300000.00, 7.25, 12, '2023-09-01', 321750.00, 'Monthly',     'Matured',  TRUE);


INSERT INTO kyc_documents (customer_id, doc_type, doc_number, submitted_on, verified_on, verified_by, expiry_date, status) VALUES
(1,  'PAN Card',        'ABCPS1234A', '2018-03-08', '2018-03-10', 4,  NULL,         'Verified'),
(1,  'Aadhaar',         '****1234',   '2018-03-08', '2018-03-10', 4,  NULL,         'Verified'),
(2,  'PAN Card',        'BCDQT5678B', '2019-07-12', '2019-07-15', 4,  NULL,         'Verified'),
(2,  'Passport',        'Z1234567',   '2019-07-12', '2019-07-15', 4,  '2029-08-01', 'Verified'),
(3,  'PAN Card',        'CDERU9012C', '2017-01-18', '2017-01-20', 4,  NULL,         'Verified'),
(3,  'Aadhaar',         '****9012',   '2017-01-18', '2017-01-20', 4,  NULL,         'Verified'),
(5,  'PAN Card',        'EFGHW7890E', '2023-01-10', NULL,         NULL,NULL,         'Pending'),
(5,  'Aadhaar',         '****7890',   '2023-01-10', NULL,         NULL,NULL,         'Pending'),
(9,  'PAN Card',        'IJKLA4567I', '2014-06-15', '2014-06-18', 9,  NULL,         'Verified'),
(9,  'Passport',        'A9876543',   '2014-06-15', '2014-06-18', 9,  '2024-12-01', 'Expired'),
(10, 'PAN Card',        'JKLMB8901J', '2019-02-10', '2019-02-14', 9,  NULL,         'Verified'),
(10, 'Voter ID',        'ABC1234567', '2019-02-10', '2019-02-14', 9,  NULL,         'Verified'),
(12, 'PAN Card',        'LMNOD6789L', '2023-03-05', NULL,         NULL,NULL,         'Pending'),
(13, 'PAN Card',        'MNOPE0123M', '2015-10-08', '2015-10-11', 12, NULL,         'Verified'),
(13, 'Passport',        'K1122334',   '2015-10-08', '2015-10-11', 12, '2025-06-15', 'Verified'),
(17, 'PAN Card',        'QRSTI6789Q', '2013-05-19', '2013-05-22', 16, NULL,         'Verified'),
(17, 'Aadhaar',         '****6789',   '2013-05-19', '2013-05-22', 16, NULL,         'Verified'),
(21, 'PAN Card',        'UVWXM2345U', '2016-04-05', '2016-04-08', 19, NULL,         'Verified'),
(21, 'Driving License', 'WB0120150012','2016-04-05','2016-04-08', 19, '2030-01-01', 'Verified'),
(25, 'PAN Card',        'YZABQ8901Y', '2012-02-10', '2012-02-14', 6,  NULL,         'Verified'),
(25, 'Passport',        'H8877665',   '2012-02-10', '2012-02-14', 6,  '2027-09-01', 'Verified'),
(29, 'PAN Card',        'CDEFU4567C', '2022-04-01', '2022-04-03', 19, NULL,         'Rejected'),
(29, 'Aadhaar',         '****4567',   '2022-04-01', NULL,         NULL,NULL,         'Pending'),
(30, 'PAN Card',        'DEFGV8901D', '2020-06-14', '2020-06-17', 4,  NULL,         'Verified'),
(30, 'Aadhaar',         '****8901',   '2020-06-14', '2020-06-17', 4,  NULL,         'Verified');


INSERT INTO fraud_alerts (account_id, txn_id, alert_type, severity, flagged_on, resolution, notes) VALUES
(5,  51, 'Rapid Succession', 'High',     '2024-03-10 03:00:00', 'Under Review', '3 UPI debits in 33 mins at 2am to same merchant'),
(5,  52, 'Unusual Hour',     'High',     '2024-03-10 03:00:00', 'Under Review', 'Transaction at 02:14'),
(23, 53, 'Unusual Hour',     'Critical', '2024-11-01 04:00:00', 'Confirmed Fraud','ATM withdrawals at 3am - card cloning suspected'),
(4,  55, 'Round Amount',     'Medium',   '2024-04-05 12:00:00', 'False Positive','Business RTGS - verified with customer'),
(7,  57, 'Unusual Hour',     'Medium',   '2024-05-13 08:00:00', 'Open',          'Transfer at 23:58, needs review');


INSERT INTO interest_postings (account_id, posting_date, period_start, period_end, principal_used, rate_applied, interest_amount, tds_deducted, net_posted) VALUES
(1,  '2024-03-31', '2024-01-01', '2024-03-31', 240000.00, 3.50, 2100.00, 210.00, 1890.00),
(3,  '2024-03-31', '2024-01-01', '2024-03-31', 180000.00, 3.50, 1575.00, 157.50, 1417.50),
(7,  '2024-03-31', '2024-01-01', '2024-03-31',2800000.00, 2.00, 14000.00, 1400.00,12600.00),
(10, '2024-03-31', '2024-01-01', '2024-03-31', 400000.00, 3.50, 3500.00, 350.00, 3150.00),
(11, '2024-03-31', '2024-01-01', '2024-03-31', 170000.00, 3.50, 1487.50, 148.75, 1338.75),
(14, '2024-03-31', '2024-01-01', '2024-03-31', 170000.00, 3.50, 1487.50, 148.75, 1338.75),
(18, '2024-03-31', '2024-01-01', '2024-03-31', 220000.00, 3.50, 1925.00, 192.50, 1732.50),
(22, '2024-03-31', '2024-01-01', '2024-03-31', 375000.00, 3.50, 3281.25, 328.13, 2953.12),
(24, '2024-03-31', '2024-01-01', '2024-03-31', 110000.00, 3.50,  962.50,  96.25,  866.25),
(30, '2024-03-31', '2024-01-01', '2024-03-31', 265000.00, 3.50, 2318.75, 231.88, 2086.87),
(34, '2024-03-31', '2024-01-01', '2024-03-31', 200000.00, 7.10, 3550.00, 355.00, 3195.00),
(12, '2024-03-31', '2024-01-01', '2024-03-31',3100000.00, 2.00, 15500.00, 1550.00,13950.00);





