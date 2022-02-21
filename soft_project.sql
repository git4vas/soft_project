BEGIN;

DROP SCHEMA IF EXISTS soft_project CASCADE;

CREATE SCHEMA IF NOT EXISTS soft_project;

SET SEARCH_PATH TO soft_project;

CREATE TABLE IF NOT EXISTS employee
(
    employee_id SERIAL PRIMARY KEY,
    employee_name VARCHAR NOT NULL,
    employee_phone CHAR (10),

    is_sysadmin BOOLEAN DEFAULT 'false',
    is_programmer BOOLEAN DEFAULT 'false',

-- for programmers!--
-- https://stackoverflow.com/questions/34855197/sql-constraint-to-check-whether-value-doesnt-exist-in-another-table
    wrk_hrs INTERVAL,
    is_available_on_we BOOLEAN DEFAULT 'false'
---------------------
);

-----------------------------

CREATE TABLE IF NOT EXISTS software
(
    software_id SERIAL PRIMARY KEY ,
    sm_id INT
        REFERENCES employee(employee_id)
        ON DELETE SET NULL,
    qa_id INT 
        REFERENCES employee(employee_id)
        ON DELETE SET NULL
        CHECK (qa_id!=sm_id) --seems useful but does not allow workflow with only one employee in team

-- if an employee gets fired his/her qa/sm position gets vacant 
-- cf. version
);

------------------------------

CREATE TABLE IF NOT EXISTS dev_team
(
    employee_id INT
        REFERENCES employee(employee_id)
	    ON DELETE CASCADE,
	software_id INT
        REFERENCES software (software_id)
        ON DELETE CASCADE,
PRIMARY KEY (employee_id, software_id)
);

------------------------------


CREATE TYPE software_state AS ENUM ('stable', 'buggy', 'old');
CREATE TABLE IF NOT EXISTS software_version
(
    version_id SERIAL PRIMARY KEY,
    software_id INT
        REFERENCES software (software_id)
        ON DELETE CASCADE,    
    version_state software_state,
      --CHECK (version_state IN ('stable', 'buggy', 'old')),
        -- 
    initial_release DATE NOT NULL,
    final_circulation DATE,
    comments TEXT

-- actualization_dates DATETIME >>>>> WTF??
);

------------------------------

CREATE TABLE IF NOT EXISTS client
(
    client_id SERIAL PRIMARY KEY,
    client_name VARCHAR UNIQUE,
    contact_info TEXT,
    client_address TEXT
);

------------------------------

CREATE TABLE IF NOT EXISTS software_user
(
    user_id SERIAL PRIMARY KEY,
    username VARCHAR UNIQUE,
    is_admin BOOLEAN DEFAULT 'false',
    client_id INT
      REFERENCES client(client_id)
      ON DELETE CASCADE,
    user_mail VARCHAR UNIQUE,
    
    user_fullname VARCHAR,
    user_position VARCHAR,
    creation_date DATE ,-- CHECK (creation_date > now()) 
    contact_info TEXT,
    client_address TEXT
    
);


------------------------------

CREATE TABLE IF NOT EXISTS license
(
    client_id INT 
        REFERENCES client(client_id),
    software_id INT 
        REFERENCES software(software_id),

initial_date DATE,
end_date DATE CHECK (initial_date < end_date),
PRIMARY KEY (client_id, software_id)
);

	
-----------------------------

CREATE TYPE workflow AS ENUM ('submitted', 'scrum_accept', 'dev_assigned', 'scrum_reject', 'dev_solved', 'qa_approved', 'scrum_approved' );
CREATE TABLE IF NOT EXISTS ticket
(
    ticket_id SERIAL PRIMARY KEY,
    user_id INT
        REFERENCES software_user (user_id),
    version_id INT
        REFERENCES software_version (version_id),
    version_status workflow,
 -- version_status VARCHAR CHECK (version_status IN ('submitted', 'scrum_accept', 'dev_assigned', 'scrum_reject', 'dev_solved', 'qa_approved', 'scrum_approved' )),
    employee_id INT, --fk
    ticket_priority INT, 
  -- (depends on user(is_admin), software_version(version_state))
    submitted DATE,
    closed DATE CHECK (closed is NULL OR closed >= submitted)
 -- ticket_time PERIOD =closed-submitted

);

COMMIT;