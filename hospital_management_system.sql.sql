SET NUMWIDTH 380;
SET LINESIZE 250;
SET PAGESIZE 100;
SET SERVEROUTPUT ON;

-- DOSCTOR TABLE
CREATE TABLE doctor
(
    doctor_id NUMBER(5),
    doctor_name VARCHAR2(30),
    specialization VARCHAR2(30),
    phone NUMBER(11),
    PRIMARY KEY(doctor_id)
);

DESC doctor;
-- DOCTOR DATA
INSERT INTO doctor VALUES(101,'Shuvro','Cardiology',1712345678);
INSERT INTO doctor VALUES(102,'Rafid','Neurology',1812345678);
INSERT INTO doctor VALUES(103,'Tanvir','Orthopedics',1912345678);
INSERT INTO doctor VALUES(104,'Nusrat','Dermatology',1612345678);
INSERT INTO doctor VALUES(105,'Farhan','Pediatrics',1512345678);
INSERT INTO doctor VALUES(106,'Mim','Gynecology',1312345678);

SELECT * FROM doctor;

-- PATIENT TABLE
CREATE TABLE patient
(
    patient_id NUMBER(5),
    doctor_id NUMBER(5),
    patient_name VARCHAR2(30),
    age NUMBER(3),
    gender VARCHAR2(10),
    PRIMARY KEY(patient_id),
    FOREIGN KEY(doctor_id) REFERENCES doctor(doctor_id)
);

DESC patient;

-- ALTER TABLE OPERATIONS
ALTER TABLE patient ADD blood_group VARCHAR2(5);

DESC patient;

ALTER TABLE patient RENAME COLUMN blood_group TO blood_type;

DESC patient;

ALTER TABLE patient MODIFY blood_type VARCHAR2(10);

DESC patient;

ALTER TABLE patient DROP COLUMN blood_type;

DESC patient;

-- PATIENT DATA
INSERT INTO patient VALUES(201,101,'Emon',22,'Male');
INSERT INTO patient VALUES(202,102,'Shuchi',21,'Female');
INSERT INTO patient VALUES(203,103,'Sabbir',24,'Male');
INSERT INTO patient VALUES(204,104,'Nabila',28,'Female');
INSERT INTO patient VALUES(205,105,'Rakib',31,'Male');
INSERT INTO patient VALUES(206,106,'Tania',26,'Female');

SELECT * FROM patient;

-- ROOM TABLE
CREATE TABLE room
(
    room_id NUMBER(5),
    patient_id NUMBER(5),
    room_no NUMBER(4),
    room_type VARCHAR2(20),
    PRIMARY KEY(room_id),
    FOREIGN KEY(patient_id) REFERENCES patient(patient_id)
);

DESC room;

-- ROOM DATA
INSERT INTO room VALUES(301,201,101,'General');
INSERT INTO room VALUES(302,202,102,'Cabin');
INSERT INTO room VALUES(303,203,103,'ICU');
INSERT INTO room VALUES(304,204,104,'General');
INSERT INTO room VALUES(305,205,105,'Cabin');
INSERT INTO room VALUES(306,206,106,'VIP');

SELECT * FROM room;

-- PRESCRIPTION TABLE
CREATE TABLE prescription
(
    prescription_id NUMBER(5),
    patient_id NUMBER(5),
    doctor_id NUMBER(5),
    medicine VARCHAR2(40),
    dosage VARCHAR2(30),
    PRIMARY KEY(prescription_id),
    FOREIGN KEY(patient_id) REFERENCES patient(patient_id),
    FOREIGN KEY(doctor_id) REFERENCES doctor(doctor_id)
);

DESC prescription;

-- PRESCRIPTION DATA

INSERT INTO prescription VALUES(401,201,101,'Napa','1+1+1');
INSERT INTO prescription VALUES(402,202,102,'Monas 10','1+0+1');
INSERT INTO prescription VALUES(403,203,103,'Ace','1+1+0');
INSERT INTO prescription VALUES(404,204,104,'Ceevit','1+0+0');
INSERT INTO prescription VALUES(405,205,105,'Seclo','1+1+1');
INSERT INTO prescription VALUES(406,206,106,'Maxpro','0+1+1');

SELECT * FROM prescription;

-- BILL TABLE

CREATE TABLE bill
(
    bill_id NUMBER(5),
    patient_id NUMBER(5),
    amount NUMBER(8),
    bill_date DATE,
    PRIMARY KEY(bill_id),
    FOREIGN KEY(patient_id) REFERENCES patient(patient_id)
);

DESC bill;

-- BILL DATA
INSERT INTO bill VALUES
(501,201,15000,TO_DATE('20-JUL-2026','DD-MON-YYYY'));

INSERT INTO bill VALUES
(502,202,22000,TO_DATE('21-JUL-2026','DD-MON-YYYY'));

INSERT INTO bill VALUES
(503,203,18000,TO_DATE('22-JUL-2026','DD-MON-YYYY'));

INSERT INTO bill VALUES
(504,204,12000,TO_DATE('23-JUL-2026','DD-MON-YYYY'));

INSERT INTO bill VALUES
(505,205,30000,TO_DATE('24-JUL-2026','DD-MON-YYYY'));

INSERT INTO bill VALUES
(506,206,25000,TO_DATE('25-JUL-2026','DD-MON-YYYY'));

SELECT * FROM bill;

-- PAYMENT TABLE
CREATE TABLE payment
(
    payment_id NUMBER(5),
    bill_id NUMBER(5),
    payment_method VARCHAR2(20),
    payment_status VARCHAR2(20),
    PRIMARY KEY(payment_id),
    FOREIGN KEY(bill_id) REFERENCES bill(bill_id)
);

DESC payment;

-- ALTER PAYMENT TABLE

ALTER TABLE payment ADD payment_date DATE;

DESC payment;

ALTER TABLE payment RENAME COLUMN payment_date TO pay_date;

DESC payment;

ALTER TABLE payment MODIFY pay_date DATE;

DESC payment;

ALTER TABLE payment DROP COLUMN pay_date;

DESC payment;

-- PAYMENT DATA
INSERT INTO payment VALUES(601,501,'Cash','Paid');
INSERT INTO payment VALUES(602,502,'Card','Pending');
INSERT INTO payment VALUES(603,503,'Cash','Paid');
INSERT INTO payment VALUES(604,504,'Mobile Banking','Paid');
INSERT INTO payment VALUES(605,505,'Card','Pending');
INSERT INTO payment VALUES(606,506,'Cash','Paid');

SELECT * FROM payment;

-- Find female patients above 25 who are receiving treatment from the hospital
SELECT p.patient_id,
       p.patient_name,
       p.age,
       p.gender,
       d.doctor_name,
       d.specialization
FROM patient p
JOIN doctor d
ON p.doctor_id = d.doctor_id
WHERE p.age > 25
AND p.gender = 'Female';

-- Find patients who are either older than 25 or female
SELECT patient_id,
       patient_name,
       age,
       gender
FROM patient
WHERE age > 25
OR gender = 'Female';

-- Find patients who are not above 25 years old
SELECT patient_id,
       patient_name,
       age,
       gender
FROM patient
WHERE NOT age > 25;

-- Find unique doctor IDs available in either doctor records or prescription records
SELECT doctor_id
FROM doctor
UNION
SELECT doctor_id
FROM prescription;

-- Show all doctor IDs from both tables including duplicate values
SELECT doctor_id
FROM doctor
UNION ALL
SELECT doctor_id
FROM prescription;

-- Find doctors who have issued prescriptions
SELECT doctor_id
FROM doctor
INTERSECT
SELECT doctor_id
FROM prescription;

-- Find doctors who have not issued any prescription
SELECT doctor_id
FROM doctor
MINUS
SELECT doctor_id
FROM prescription;

-- Find patients assigned to selected specialties
SELECT p.patient_id,
       p.patient_name,
       d.doctor_name,
       d.specialization
FROM patient p
JOIN doctor d
ON p.doctor_id = d.doctor_id
WHERE d.specialization IN
('Cardiology','Orthopedics','Pediatrics');

-- Find patients outside the selected specialties
SELECT p.patient_id,
       p.patient_name,
       d.doctor_name,
       d.specialization
FROM patient p
JOIN doctor d
ON p.doctor_id = d.doctor_id
WHERE d.specialization NOT IN
('Cardiology','Orthopedics','Pediatrics');

-- Find patients older than at least one female patient
SELECT patient_id,
       patient_name,
       age
FROM patient
WHERE age > SOME
(
    SELECT age
    FROM patient
    WHERE gender = 'Female'
);

-- Find doctors whose ID is greater than all doctors who have written prescriptions
SELECT doctor_id,
       doctor_name,
       specialization
FROM doctor
WHERE doctor_id > ALL
(
    SELECT doctor_id
    FROM prescription
);
-- Find patients who have at least one bill
SELECT p.patient_id,
       p.patient_name,
       p.age
FROM patient p
WHERE EXISTS
(
    SELECT 1
    FROM bill b
    WHERE p.patient_id = b.patient_id
);

-- Find patients who have exactly one bill
SELECT p.patient_id,
       p.patient_name,
       COUNT(b.bill_id) AS total_bills
FROM patient p
JOIN bill b
ON p.patient_id = b.patient_id
GROUP BY p.patient_id,
         p.patient_name
HAVING COUNT(b.bill_id) = 1

-- Find patients whose names start with S
SELECT patient_id,
       patient_name,
       age,
       gender
FROM patient
WHERE patient_name LIKE 'S%';

-- Display patients with their assigned doctors
SELECT p.patient_id,
       p.patient_name,
       p.age,
       d.doctor_name,
       d.specialization
FROM patient p
INNER JOIN doctor d
ON p.doctor_id = d.doctor_id;

-- Display all patients and their doctors

SELECT p.patient_id,
       p.patient_name,
       d.doctor_name,
       d.specialization
FROM patient p
LEFT JOIN doctor d
ON p.doctor_id = d.doctor_id;

-- Display all doctors and their patients
SELECT d.doctor_id,
       d.doctor_name,
       d.specialization,
       p.patient_name
FROM patient p
RIGHT JOIN doctor d
ON p.doctor_id = d.doctor_id;

-- Display all doctors and all patients
SELECT p.patient_id,
       p.patient_name,
       d.doctor_id,
       d.doctor_name
FROM patient p
FULL JOIN doctor d
ON p.doctor_id = d.doctor_id;
SELECT COUNT(*) AS total_patients
FROM patient;

SELECT SUM(amount) AS total_hospital_bill
FROM bill;

-- AVG
SELECT ROUND(AVG(age),2) AS average_patient_age
FROM patient;

-- MAX
SELECT MAX(age) AS oldest_patient_age
FROM patient;
-- MIN
SELECT MIN(age) AS youngest_patient_age
FROM patient;

-- PRACTICAL HOSPITAL REPORT
SELECT p.patient_id,
       p.patient_name,
       d.doctor_name,
       d.specialization,
       r.room_no,
       r.room_type,
       b.amount,
       b.bill_date
FROM patient p
JOIN doctor d
ON p.doctor_id = d.doctor_id
JOIN room r
ON p.patient_id = r.patient_id
JOIN bill b
ON p.patient_id = b.patient_id;

-- PAYMENT STATUS REPORT

SELECT p.patient_id,
       p.patient_name,
       b.bill_id,
       b.amount,
       pay.payment_method,
       pay.payment_status
FROM patient p
JOIN bill b
ON p.patient_id = b.patient_id
JOIN payment pay
ON b.bill_id = pay.bill_id
WHERE pay.payment_status = 'Pending';

-- PAID BILL REPORT
SELECT p.patient_name,
       b.bill_id,
       b.amount,
       pay.payment_method,
       pay.payment_status
FROM patient p
JOIN bill b
ON p.patient_id = b.patient_id
JOIN payment pay
ON b.bill_id = pay.bill_id
WHERE pay.payment_status = 'Paid';

-- PATIENT PRESCRIPTION REPORT
SELECT p.patient_id,
       p.patient_name,
       d.doctor_name,
       d.specialization,
       pr.medicine,
       pr.dosage
FROM patient p
JOIN prescription pr
ON p.patient_id = pr.patient_id
JOIN doctor d
ON pr.doctor_id = d.doctor_id;
-- DOCTOR PATIENT COUNT
SELECT d.doctor_id,
       d.doctor_name,
       d.specialization,
       COUNT(p.patient_id) AS total_patients
FROM doctor d
LEFT JOIN patient p
ON d.doctor_id = p.doctor_id
GROUP BY d.doctor_id,
         d.doctor_name,
         d.specialization;

-- TOTAL BILL BY PATIENT
SELECT p.patient_id,
       p.patient_name,
       SUM(b.amount) AS total_bill
FROM patient p
JOIN bill b
ON p.patient_id = b.patient_id
GROUP BY p.patient_id,
         p.patient_name;

-- HIGHEST BILL
SELECT p.patient_name,
       b.bill_id,
       b.amount
FROM patient p
JOIN bill b
ON p.patient_id = b.patient_id
WHERE b.amount =
(
    SELECT MAX(amount)
    FROM bill
);

-- ICU PATIENT REPORT
SELECT p.patient_id,
       p.patient_name,
       p.age,
       d.doctor_name,
       d.specialization,
       r.room_no,
       r.room_type
FROM patient p
JOIN doctor d
ON p.doctor_id = d.doctor_id
JOIN room r
ON p.patient_id = r.patient_id
WHERE r.room_type = 'ICU';

-- VIEW
CREATE OR REPLACE VIEW Patient_Doctor_View AS
SELECT p.patient_id,
       p.patient_name,
       p.age,
       p.gender,
       d.doctor_name,
       d.specialization
FROM patient p
JOIN doctor d
ON p.doctor_id = d.doctor_id;

SELECT *
FROM Patient_Doctor_View;

-- SELECT INTO %TYPE

DECLARE

    p_name patient.patient_name%TYPE;
    p_age patient.age%TYPE;
    p_gender patient.gender%TYPE;

BEGIN

    SELECT patient_name,
           age,
           gender
    INTO p_name,
         p_age,
         p_gender
    FROM patient
    WHERE patient_id = 201;

    DBMS_OUTPUT.PUT_LINE(
        'Patient Name : ' || p_name
    );

    DBMS_OUTPUT.PUT_LINE(
        'Age          : ' || p_age
    );

    DBMS_OUTPUT.PUT_LINE(
        'Gender       : ' || p_gender
    );

END;
/

-- SELECT INTO %ROWTYPE
DECLARE

    p1 patient%ROWTYPE;

BEGIN

    SELECT *
    INTO p1
    FROM patient
    WHERE patient_id = 204;

    DBMS_OUTPUT.PUT_LINE(
        'Patient ID   : ' || p1.patient_id
    );

    DBMS_OUTPUT.PUT_LINE(
        'Patient Name : ' || p1.patient_name
    );

    DBMS_OUTPUT.PUT_LINE(
        'Age          : ' || p1.age
    );

    DBMS_OUTPUT.PUT_LINE(
        'Gender       : ' || p1.gender
    );

    DBMS_OUTPUT.PUT_LINE(
        'Doctor ID    : ' || p1.doctor_id
    );

END;
/
-- IF-ELSE STATEMENT

DECLARE

    p_age patient.age%TYPE;
    p_name patient.patient_name%TYPE;

BEGIN

    SELECT patient_name,
           age
    INTO p_name,
         p_age
    FROM patient
    WHERE patient_id = 205;

    DBMS_OUTPUT.PUT_LINE(
        'Patient : ' || p_name
    );

    IF p_age >= 60 THEN

        DBMS_OUTPUT.PUT_LINE(
            'Category : Senior Patient'
        );

    ELSIF p_age >= 18 THEN

        DBMS_OUTPUT.PUT_LINE(
            'Category : Adult Patient'
        );

    ELSE

        DBMS_OUTPUT.PUT_LINE(
            'Category : Child Patient'
        );

    END IF;

END;
/

-- IF-ELSE WITH PAYMENT STATUS

DECLARE

    p_name patient.patient_name%TYPE;
    p_status payment.payment_status%TYPE;

BEGIN

    SELECT p.patient_name,
           pay.payment_status
    INTO p_name,
         p_status
    FROM patient p
    JOIN bill b
    ON p.patient_id = b.patient_id
    JOIN payment pay
    ON b.bill_id = pay.bill_id
    WHERE p.patient_id = 202;

    DBMS_OUTPUT.PUT_LINE(
        'Patient : ' || p_name
    );

    IF p_status = 'Paid' THEN

        DBMS_OUTPUT.PUT_LINE(
            'Payment Status : Bill Paid'
        );

    ELSE

        DBMS_OUTPUT.PUT_LINE(
            'Payment Status : Payment Pending'
        );

    END IF;

END;
/

-- ARRAY IN SQL ASSOCIATIVE ARRAY
DECLARE

    TYPE department_array IS TABLE OF VARCHAR2(30)
    INDEX BY PLS_INTEGER;

    departments department_array;

BEGIN

    departments(1) := 'Cardiology';
    departments(2) := 'Neurology';
    departments(3) := 'Orthopedics';
    departments(4) := 'Dermatology';
    departments(5) := 'Pediatrics';
    departments(6) := 'Gynecology';

    DBMS_OUTPUT.PUT_LINE(
        'Department 1 : ' || departments(1)
    );

    DBMS_OUTPUT.PUT_LINE(
        'Department 2 : ' || departments(2)
    );

    DBMS_OUTPUT.PUT_LINE(
        'Department 3 : ' || departments(3)
    );

    DBMS_OUTPUT.PUT_LINE(
        'Department 4 : ' || departments(4)
    );

    DBMS_OUTPUT.PUT_LINE(
        'Department 5 : ' || departments(5)
    );

    DBMS_OUTPUT.PUT_LINE(
        'Department 6 : ' || departments(6)
    );

END;
/

-- ARRAY IN SQL VARRAY
DECLARE

    TYPE medicine_array IS VARRAY(5) OF VARCHAR2(50);

    medicines medicine_array := medicine_array(
        'Napa',
        'Monas 10',
        'Seclo',
        'Ceevit',
        'Maxpro'
    );

BEGIN

    DBMS_OUTPUT.PUT_LINE(
        'Medicine 1 : ' || medicines(1)
    );

    DBMS_OUTPUT.PUT_LINE(
        'Medicine 2 : ' || medicines(2)
    );

    DBMS_OUTPUT.PUT_LINE(
        'Medicine 3 : ' || medicines(3)
    );

    DBMS_OUTPUT.PUT_LINE(
        'Medicine 4 : ' || medicines(4)
    );

    DBMS_OUTPUT.PUT_LINE(
        'Medicine 5 : ' || medicines(5)
    );

END;
/

-- LOOP

DECLARE

    room_counter NUMBER := 101;

BEGIN

    LOOP

        DBMS_OUTPUT.PUT_LINE(
            'Checking Room No : ' || room_counter
        );

        room_counter := room_counter + 1;

        EXIT WHEN room_counter > 106;

    END LOOP;

END;
/

-- WHILE LOOP
DECLARE

    p_id NUMBER := 201;

BEGIN

    WHILE p_id <= 206 LOOP

        DBMS_OUTPUT.PUT_LINE(
            'Processing Patient ID : ' || p_id
        );

        p_id := p_id + 1;

    END LOOP;

END;
/

-- FOR LOOP

BEGIN

    FOR p IN
    (
        SELECT patient_id,
               patient_name,
               age
        FROM patient
        ORDER BY patient_id
    )

    LOOP

        DBMS_OUTPUT.PUT_LINE(
            'Patient ID: ' || p.patient_id ||
            ' | Name: ' || p.patient_name ||
            ' | Age: ' || p.age
        );

    END LOOP;

END;
/

-- EXCEPTION HANDLING

DECLARE

    total_bill NUMBER := 30000;
    patient_count NUMBER := 0;
    average_bill NUMBER;

BEGIN

    average_bill := total_bill / patient_count;

    DBMS_OUTPUT.PUT_LINE(
        'Average Bill : ' || average_bill
    );

EXCEPTION

    WHEN ZERO_DIVIDE THEN

        DBMS_OUTPUT.PUT_LINE(
            'Error: Cannot calculate average bill because patient count is zero.'
        );

END;
/

-- EXCEPTION HANDLING

DECLARE

    p_name patient.patient_name%TYPE;

BEGIN

    SELECT patient_name
    INTO p_name
    FROM patient
    WHERE patient_id = 999;

    DBMS_OUTPUT.PUT_LINE(
        'Patient Name : ' || p_name
    );

EXCEPTION

    WHEN NO_DATA_FOUND THEN

        DBMS_OUTPUT.PUT_LINE(
            'Error: No patient found with the given patient ID.'
        );

END;
/

-- PROCEDURE

CREATE OR REPLACE PROCEDURE patient_summary
(
    p_patient_id NUMBER
)

IS

    p_name patient.patient_name%TYPE;
    p_age patient.age%TYPE;
    d_name doctor.doctor_name%TYPE;
    d_specialization doctor.specialization%TYPE;

BEGIN

    SELECT p.patient_name,
           p.age,
           d.doctor_name,
           d.specialization
    INTO p_name,
         p_age,
         d_name,
         d_specialization
    FROM patient p
    JOIN doctor d
    ON p.doctor_id = d.doctor_id
    WHERE p.patient_id = p_patient_id;

    DBMS_OUTPUT.PUT_LINE(
        '--------------------------------'
    );

    DBMS_OUTPUT.PUT_LINE(
        'PATIENT SUMMARY'
    );

    DBMS_OUTPUT.PUT_LINE(
        '--------------------------------'
    );

    DBMS_OUTPUT.PUT_LINE(
        'Patient Name : ' || p_name
    );

    DBMS_OUTPUT.PUT_LINE(
        'Age          : ' || p_age
    );

    DBMS_OUTPUT.PUT_LINE(
        'Doctor       : ' || d_name
    );

    DBMS_OUTPUT.PUT_LINE(
        'Specialization : ' || d_specialization
    );

    DBMS_OUTPUT.PUT_LINE(
        '--------------------------------'
    );

EXCEPTION

    WHEN NO_DATA_FOUND THEN

        DBMS_OUTPUT.PUT_LINE(
            'No patient found with ID ' || p_patient_id
        );

END;
/

EXEC patient_summary(201);

-- FUNCTION HOSPITAL BILL CALCULATION

CREATE OR REPLACE FUNCTION hospital_bill
(
    p_amount NUMBER
)

RETURN NUMBER

IS

    service_charge NUMBER := 1000;
    final_amount NUMBER;

BEGIN

    final_amount := p_amount + service_charge;

    RETURN final_amount;

END;
/

SELECT patient_id,
       amount,
       hospital_bill(amount) AS final_bill
FROM bill;

-- FUNCTION (PAYMENT STATUS)

CREATE OR REPLACE FUNCTION bill_status
(
    p_bill_id NUMBER
)

RETURN VARCHAR2

IS

    p_status payment.payment_status%TYPE;

BEGIN

    SELECT payment_status
    INTO p_status
    FROM payment
    WHERE bill_id = p_bill_id;

    RETURN p_status;

EXCEPTION

    WHEN NO_DATA_FOUND THEN

        RETURN 'Payment Record Not Found';

END;
/

SELECT b.bill_id,
       p.patient_name,
       b.amount,
       bill_status(b.bill_id) AS payment_status
FROM bill b
JOIN patient p
ON b.patient_id = p.patient_id;

-- CURSOR BASICS

DECLARE

    CURSOR patient_cursor IS

        SELECT p.patient_id,
               p.patient_name,
               p.age,
               d.doctor_name,
               d.specialization
        FROM patient p
        JOIN doctor d
        ON p.doctor_id = d.doctor_id
        ORDER BY p.patient_id;

    p_id patient.patient_id%TYPE;
    p_name patient.patient_name%TYPE;
    p_age patient.age%TYPE;
    d_name doctor.doctor_name%TYPE;
    d_specialization doctor.specialization%TYPE;

BEGIN

    OPEN patient_cursor;

    LOOP

        FETCH patient_cursor
        INTO p_id,
             p_name,
             p_age,
             d_name,
             d_specialization;

        EXIT WHEN patient_cursor%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE(
            'Patient ID: ' || p_id ||
            ' | Patient: ' || p_name ||
            ' | Age: ' || p_age ||
            ' | Doctor: ' || d_name ||
            ' | Department: ' || d_specialization
        );

    END LOOP;

    CLOSE patient_cursor;

END;
/
