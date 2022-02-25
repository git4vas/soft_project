BEGIN;

DROP SCHEMA IF EXISTS soft_project CASCADE;

CREATE SCHEMA IF NOT EXISTS soft_project;

SET SEARCH_PATH TO soft_project;

DROP TABLE IF EXISTS employee;
CREATE TABLE IF NOT EXISTS employee
(
    id SERIAL PRIMARY KEY,
    name VARCHAR NOT NULL,
    phone VARCHAR (100),
    email VARCHAR (255),
    is_sysadmin BOOLEAN DEFAULT 'false',
    is_programmer BOOLEAN DEFAULT 'false',

-- for programmers!--
-- https://stackoverflow.com/questions/34855197/sql-constraint-to-check-whether-value-doesnt-exist-in-another-table
    wrk_hrs INTERVAL,
    is_available_on_we BOOLEAN DEFAULT 'false'
---------------------
);

-----------------------------

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

------------------------------

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

------------------------------


CREATE TYPE software_state AS ENUM ('stable', 'buggy', 'old');
DROP TABLE IF EXISTS software_version;
CREATE TABLE IF NOT EXISTS software_version
(
    software_id INT
        REFERENCES software(id)
        ON DELETE CASCADE,
    id SERIAL PRIMARY KEY,
    
    state software_state,
      --CHECK (state IN ('stable', 'buggy', 'old')),
        -- 
    initial_release DATE NOT NULL,
    final_circulation DATE,
    comments TEXT
 -- actualization_dates DATETIME >>>>> WTF??
 -- what if PK (software_id,id) how to reference from ticket????
);

------------------------------

DROP TABLE IF EXISTS client;
CREATE TABLE IF NOT EXISTS client
(
    id SERIAL PRIMARY KEY,
    name VARCHAR UNIQUE,
    phone varchar (14) default NULL,
    email varchar(255) default NULL,
    address varchar(255) default NULL,
    city varchar(255),
    zip varchar(5) default NULL,
    contact_info TEXT
);

------------------------------

CREATE TABLE IF NOT EXISTS software_user
(
    id SERIAL PRIMARY KEY,
    username VARCHAR UNIQUE,
    fullname VARCHAR,
    email VARCHAR UNIQUE,
    client_id INT
      REFERENCES client(id)
      ON DELETE CASCADE,
    position VARCHAR,
    creation_date DATE ,-- CHECK (creation_date > now()) 
    is_admin BOOLEAN DEFAULT 'false'
);


---------------------------------
--table to assign version to user
---------------------------------

DROP TABLE IF EXISTS user_version;
CREATE TABLE IF NOT EXISTS user_version
(
	version_id INT
        REFERENCES software_version (id)
        ON DELETE CASCADE,
    user_id INT
        REFERENCES software_user(id)
        ON DELETE CASCADE,
PRIMARY KEY (user_id, version_id)
);

------------------------------


CREATE TABLE IF NOT EXISTS license
(
    client_id INT 
        REFERENCES client(id),
    software_id INT 
        REFERENCES software(id),

initial_date DATE,
end_date DATE CHECK (initial_date < end_date),
PRIMARY KEY (client_id, software_id)
);

	
-----------------------------

CREATE TYPE workflow AS ENUM ('submitted', 'scrum_accept', 'dev_assigned', 'scrum_reject', 'dev_solved', 'qa_approved', 'scrum_approved');


DROP TABLE IF EXISTS ticket;
CREATE TABLE IF NOT EXISTS ticket
(
    ticket_id SERIAL PRIMARY KEY,
    user_id INT
        REFERENCES software_user(id),
    version_id INT
        REFERENCES software_version(id),
    version_status workflow,
/*TODO version_status VARCHAR CHECK (version_status IN ('submitted', 'scrum_accept', 'dev_assigned', 'scrum_reject', 'dev_solved', 'qa_approved', 'scrum_approved' )),
*/
    programmer_id INT
        REFERENCES employee(id),
/*TODO CHECK employee(is_programmer='true')  */

    ticket_priority INT, 
/*TODO ++ if user(is_admin), ++ if software_version(state)='buggy') */
    submitted DATE,
    closed DATE CHECK (closed is NULL OR closed >= submitted)
-- ticket_time PERIOD =closed-submitted
);

COMMIT;