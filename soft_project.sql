BEGIN;
DROP SCHEMA IF EXISTS soft_project CASCADE;
CREATE SCHEMA IF NOT EXISTS soft_project;
SET SEARCH_PATH TO soft_project;

-------------EMPLOYEE----------------------------------------------------------
--all employees, 1 sysadmin has max rights, programmers have additional options
-------------------------------------------------------------------------------

DROP TABLE IF EXISTS employee;
CREATE TABLE IF NOT EXISTS employee
(
    id SERIAL PRIMARY KEY,
    name VARCHAR NOT NULL,
    phone VARCHAR (100),
    email VARCHAR (255),
    is_sysadmin BOOLEAN DEFAULT 'false',
    is_programmer BOOLEAN DEFAULT 'false',
    date_join DATE,

/* FIXME */
-- for programmers!--
-- https://stackoverflow.com/questions/34855197/sql-constraint-to-check-whether-value-doesnt-exist-in-another-table
    wrk_hrs INTERVAL,
    is_available_on_we BOOLEAN DEFAULT 'false',
    wrk_dev VARCHAR (255) DEFAULT 'computer & monitor'
);

-------------SOFTWARE---------------------------------------------
--software with quality assurance tester and scrum master assigned
------------------------------------------------------------------

DROP TABLE IF EXISTS software;
CREATE TABLE IF NOT EXISTS software
(
    id SERIAL PRIMARY KEY,
    name VARCHAR (32) UNIQUE,
    sm_id INT
        REFERENCES employee(id)
        ON DELETE SET NULL,
    qa_id INT 
        REFERENCES employee(id)
        ON DELETE SET NULL
        CHECK (qa_id!=sm_id) --seems useful but does not allow workflow with only one employee in team

-- if an employee gets fired his/her qa/sm position gets vacant 
-- cf. version
);

-------------TEAM (employee_software)----------
--Employees associated with a specific software
-----------------------------------------------

DROP TABLE IF EXISTS dev_team;
CREATE TABLE IF NOT EXISTS dev_team
(
    employee_id INT
        REFERENCES employee(id)
	    ON DELETE CASCADE,
	software_id INT
        REFERENCES software(id)
        ON DELETE CASCADE,
PRIMARY KEY (employee_id, software_id)
);

-------------VERSION---------------------------
--Software version control---------------------
-----------------------------------------------

CREATE TYPE SOFTWARE_STATE AS ENUM ('stable', 'buggy', 'old');
DROP TABLE IF EXISTS software_version;
CREATE TABLE IF NOT EXISTS software_version
(
    id SERIAL PRIMARY KEY,
    software_id INT
        REFERENCES software(id)
        ON DELETE CASCADE,
    state SOFTWARE_STATE,
      --CHECK (state IN ('stable', 'buggy', 'old')),

    date_release DATE NOT NULL,
    date_final DATE,
    comments TEXT
);

-------------CLIENT------------------------------
--Companies using Software, details, contact info
-------------------------------------------------

DROP TABLE IF EXISTS client;
CREATE TABLE IF NOT EXISTS client
(
    id SERIAL PRIMARY KEY,
    name VARCHAR UNIQUE,
    phone varchar(14) default NULL,
    email varchar(255) default NULL,
    address varchar(255) default NULL,
    city varchar(255),
    zip varchar(5) default NULL,
    contact_info TEXT
);

-------------USER_-------------------------------
--users associated with a specific client company
-------------------------------------------------

DROP TABLE IF EXISTS user_;
CREATE TABLE IF NOT EXISTS user_
(
    id SERIAL PRIMARY KEY,
    username VARCHAR(100) UNIQUE,
    fullname VARCHAR(255),
    email VARCHAR(255) UNIQUE,
    client_id INT
      REFERENCES client(id)
      ON DELETE CASCADE,
    position VARCHAR(100),
    date_creation DATE ,-- CHECK (date_creation > now()) 
    is_admin BOOLEAN DEFAULT 'false'
);


-------------LICENSE----------------------
--table to assign software to client users
------------------------------------------

DROP TABLE IF EXISTS license;
CREATE TABLE IF NOT EXISTS license
(
    id SERIAL PRIMARY KEY, 
    client_id INT 
        REFERENCES client(id),
    software_id INT 
        REFERENCES software(id),
date_initial DATE,
date_end DATE CHECK (date_initial < date_end)
);


-------------user_license---------------------------
--table to include client users into license--------
----------------------------------------------------

DROP TABLE IF EXISTS user_license;
CREATE TABLE IF NOT EXISTS user_license
(
    user_id INT
        REFERENCES user_ (id)
        ON DELETE CASCADE,
	license_id INT
        REFERENCES license (id)
        ON DELETE CASCADE,
PRIMARY KEY (license_id, user_id)
);



-------------TICKET-----------------------------
--table to manage ticket information------------
------------------------------------------------

CREATE TYPE WORKFLOW AS ENUM ('submitted', 'scrum_accept', 'dev_assigned', 'scrum_rejected', 'dev_solved', 'qa_approved', 'solved');
CREATE TYPE TTYPE AS ENUM ('bug', 'feature');


DROP TABLE IF EXISTS ticket;
CREATE TABLE IF NOT EXISTS ticket
(
    id SERIAL PRIMARY KEY,
    user_id INT
        REFERENCES user_ (id)
        ON DELETE CASCADE,
    version_id INT
        REFERENCES software_version(id)
        ON DELETE CASCADE,
/*FIXME test on postgres or create user18
CHECK (version_id IN (SELECT version_id FROM user_version WHERE username IN (SELECT current_user)), --test =
*/
    status WORKFLOW DEFAULT 'submitted',
-- status VARCHAR CHECK (version_status IN ('submitted', 'scrum_accept', 'dev_assigned', 'scrum_reject', 'dev_solved', 'qa_approved', 'solved')),

/*TODO trigger the correct workflow*/

    ticket_type TTYPE,
    description TEXT UNIQUE, --(U) prevents from submitting the same ticket accidentally
    programmer_id INT
        REFERENCES employee(id) DEFAULT NULL,
/*TODO CHECK employee(is_programmer='true')  */

/*TODO trigger: if ticket_type='bug' software_version.state='buggy' 
                if ticket_type='feature' software_version.state='old' */

    ticket_priority INT DEFAULT 0, 

/*
TODO $$ if (SELECT is_admin FROM user) ticket_priority++
TODO $$ if software_version(state)='buggy' ticket_priority++ */

    date_submitted DATE DEFAULT now() NOT NULL,
    date_closed DATE CHECK (date_closed is NULL OR date_closed >= date_submitted) DEFAULT NULL

/*
FIXME ticket_time_spent INTERVAL
SELECT id, (date_closed - date_submitted) as ticket_time_spent 
FROM ticket

--OR--

SELECT id, AGE(date_closed, date_submitted) as ticket_time_spent 
FROM ticket
*/

);

COMMIT;