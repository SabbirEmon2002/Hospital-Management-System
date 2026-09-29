# Hospital Management System

A database-based Hospital Management System developed using **Oracle SQL and PL/SQL** as a Database Management System Lab project.

## 📌 Project Overview

The Hospital Management System is designed to store, organize, and manage important hospital information such as doctors, patients, rooms, prescriptions, bills, and payments.

The project demonstrates how relational database concepts and PL/SQL programming can be applied to a real-life hospital management scenario.

The database uses **primary keys and foreign keys** to establish relationships between the different entities and provides SQL queries and PL/SQL programs for retrieving and processing hospital information.

---

## 🎯 Objectives

The main objectives of this project are:

* Create a database for a Hospital Management System.
* Store and manage doctor information.
* Store and manage patient information.
* Maintain patient room assignments.
* Manage prescriptions and medicines.
* Manage hospital bills and payment information.
* Establish relationships using primary keys and foreign keys.
* Retrieve useful information using SQL queries.
* Apply SQL concepts such as joins, aggregate functions, subqueries, views, and set operators.
* Apply PL/SQL concepts such as `%TYPE`, `%ROWTYPE`, IF-ELSE, loops, exception handling, procedures, functions, and cursors.
* Generate useful hospital-related reports.

---

## 🏥 Main Database Entities

The system contains six main tables:

| Table          | Description                                        |
| -------------- | -------------------------------------------------- |
| `DOCTOR`       | Stores information about hospital doctors          |
| `PATIENT`      | Stores patient information and assigned doctors    |
| `ROOM`         | Stores patient room assignments                    |
| `PRESCRIPTION` | Stores prescribed medicines and dosage information |
| `BILL`         | Stores patient billing information                 |
| `PAYMENT`      | Stores payment information related to bills        |

### Database Relationships

* A doctor can treat multiple patients.
* A patient is assigned to a doctor.
* A patient can have a room assignment.
* A patient can have prescriptions.
* A patient can have bills.
* A bill can have payment information.

---

## 🗃️ Relational Schema

### DOCTOR

```text
DOCTOR(
    doctor_id PK,
    doctor_name,
    specialization,
    phone
)
```

### PATIENT

```text
PATIENT(
    patient_id PK,
    doctor_id FK,
    patient_name,
    age,
    gender
)
```

### ROOM

```text
ROOM(
    room_id PK,
    patient_id FK,
    room_no,
    room_type
)
```

### PRESCRIPTION

```text
PRESCRIPTION(
    prescription_id PK,
    patient_id FK,
    doctor_id FK,
    medicine,
    dosage
)
```

### BILL

```text
BILL(
    bill_id PK,
    patient_id FK,
    amount,
    bill_date
)
```

### PAYMENT

```text
PAYMENT(
    payment_id PK,
    bill_id FK,
    payment_method,
    payment_status
)
```

---

## 🛠️ Technologies Used

* **Oracle Database**
* **Oracle SQL**
* **PL/SQL**
* SQL Developer / Oracle-compatible SQL environment

---

## 💻 SQL Concepts Demonstrated

The project demonstrates a range of SQL concepts, including:

* `CREATE TABLE`
* `INSERT INTO`
* `SELECT`
* `WHERE`
* `AND`
* `OR`
* `NOT`
* `IN`
* `NOT IN`
* `LIKE`
* `SOME`
* `ALL`
* `EXISTS`
* `GROUP BY`
* `HAVING`
* `ORDER BY`
* `JOIN`
* `INNER JOIN`
* `LEFT JOIN`
* `RIGHT JOIN`
* `FULL JOIN`
* `UNION`
* `UNION ALL`
* `INTERSECT`
* `MINUS`
* Aggregate functions:

  * `COUNT()`
  * `SUM()`
  * `AVG()`
  * `MAX()`
  * `MIN()`
* Views
* `ALTER TABLE`

---

## 🔄 PL/SQL Concepts Demonstrated

The project also demonstrates several PL/SQL programming concepts:

* `%TYPE`
* `%ROWTYPE`
* Variables
* IF-ELSE
* Arrays
* LOOP
* WHILE LOOP
* FOR LOOP
* Exception Handling
* Procedures
* Functions
* Cursors

The project includes examples of retrieving patient information, processing records, handling exceptions, calculating hospital billing information, and processing patient-doctor records using cursors.

---

## 📊 Example Reports and Queries

The system includes SQL queries for realistic hospital operations, including:

### Patient and Doctor Information

Retrieves patient information together with the assigned doctor's name and specialization.

### Patient Billing Report

Displays patient billing information together with payment method and payment status.

### Patient, Doctor and Prescription Report

Combines patient, doctor, and prescription information.

### Total Hospital Billing

Calculates the total amount of hospital bills using `SUM()`.

### Highest Patient Bill

Identifies the patient associated with the highest bill amount.

### ICU Patient Report

Retrieves patients assigned to ICU rooms.

### Pending Payment Report

Retrieves bills whose payment status is pending.

---

## 🧩 PL/SQL Examples

The project includes PL/SQL examples for:

### `%TYPE`

Used to declare variables based on database column data types.

### `%ROWTYPE`

Used to store an entire row from the `PATIENT` table.

### IF-ELSE

Used to classify a patient based on age.

### Loops

The project demonstrates:

* Basic LOOP
* WHILE LOOP
* FOR LOOP

### Exception Handling

Handles situations such as:

* Patient record not found
* Multiple records returned
* Other unexpected errors

### Function

A `hospital_bill` function is included to calculate a total amount by applying a service charge to the bill amount.

### Cursor

A cursor processes patient and doctor information and displays:

* Patient ID
* Patient name
* Doctor name
* Doctor specialization

---

## 📁 Repository Structure

```text
Hospital-Management-System/
│
├── README.md
│
├── database/
│   └── hospital_management_system.sql
│
├── er-diagram/
│   └── hospital_management_er_diagram.png
│
├── screenshots/
│   ├── database_tables.png
│   ├── patient_doctor_report.png
│   ├── billing_payment_report.png
│   ├── statistical_report.png
│   ├── plsql_output.png
│   └── database_view_output.png
│
└── report/
    └── Hospital_Management_System_Report.pdf
```

> The exact screenshot filenames may differ depending on the files included in the repository.

---

## 🚀 How to Run the Project

### 1. Install / Open Oracle Database

Use an Oracle Database environment with SQL Developer or another Oracle-compatible SQL interface.

### 2. Open the SQL File

Open:

```text
database/hospital_management_system.sql
```

### 3. Execute the Database Script

Run the SQL statements to create the required tables and insert the sample records.

The database contains the following main tables:

```text
DOCTOR
PATIENT
ROOM
PRESCRIPTION
BILL
PAYMENT
```

### 4. Run the Queries

Execute the SQL queries included in the script to generate patient, doctor, prescription, billing, payment, and statistical information.

### 5. Run the PL/SQL Programs

Enable the appropriate output functionality in your Oracle environment and execute the PL/SQL blocks for:

* `%TYPE`
* `%ROWTYPE`
* IF-ELSE
* Loops
* Exception handling
* Functions
* Cursors
* Procedures

---

## 📷 Project Screenshots

Selected screenshots demonstrating database tables, SQL query results, reports, and PL/SQL outputs are available in:

```text
screenshots/
```

The project report also documents selected output examples.

---

## 📄 Project Report

The complete project report is available in:

```text
report/Hospital_Management_System_Report.pdf
```

The report contains the project introduction, objectives, problem statement, database requirements, ER diagram, relational schema, implementation, SQL concepts, SQL queries, PL/SQL examples, outputs, discussion, conclusion, and references.

---

## 🔮 Future Improvements

The current project can be extended with additional features such as:

* Appointment management
* User login and authentication
* Medicine management
* Online payment
* Graphical User Interface (GUI)

These improvements are identified as possible future extensions of the project.
