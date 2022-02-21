DROP SCHEMA IF EXISTS soft_project CASCADE;
CREATE SCHEMA IF NOT EXISTS soft_project;

SET SEARCH_PATH TO soft_project;

CREATE TABLE IF NOT EXISTS employee
(
    employee_id SMALLSERIAL PRIMARY KEY,
    employee_name VARCHAR NOT NULL,
    phone BIGINT,
    wrk_hrs INTERVAL,
    we_availability BOOLEAN DEFAULT 'false',
    sysadmin BOOLEAN DEFAULT 'false'
);

-----------------------------

CREATE TABLE IF NOT EXISTS software
(
    soft_id SMALLSERIAL PRIMARY KEY,
    sm_id SMALLINT UNIQUE ,
    qa_id SMALLINT UNIQUE ,
FOREIGN KEY (sm_id)
    REFERENCES employee(employee_id)
    ON DELETE SET NULL,
FOREIGN KEY (qa_id)
    REFERENCES employee(employee_id)
    ON DELETE SET NULL
);

------------------------------

CREATE TABLE IF NOT EXISTS dev_team
(
    employee_id SMALLINT,
	soft_id SMALLINT,

--fk    phone BIGINT NOT NULL,
--     starting_date DATE,
--    we_avail BOOLEAN DEFAULT 'false', 
--    wrk_hrs INTERVAL,


FOREIGN KEY (soft_id)
	REFERENCES software (soft_id)
    ON DELETE CASCADE,
FOREIGN KEY (employee_id)
	REFERENCES employee(employee_id)
	ON DELETE CASCADE,

PRIMARY KEY (employee_id, soft_id)
);


------------------------------

CREATE TABLE IF NOT EXISTS soft_version
(
    version_id SERIAL PRIMARY KEY,
    soft_id SMALLINT,
    sm_id SMALLINT ,
    qa_id SMALLINT ,

version_state VARCHAR
    CHECK (version_state IN ('stable', 'buggy', 'old')),
initial_release DATE NOT NULL,
final_circulation DATE,
comments TEXT,
-- actualization_dates DATETIME >>>>> WTF??

FOREIGN KEY (soft_id)
    REFERENCES software (soft_id),
FOREIGN KEY (sm_id)
    REFERENCES software (sm_id),
FOREIGN KEY (qa_id)
    REFERENCES software (qa_id)
);


------------------------------

CREATE TABLE IF NOT EXISTS client
(
    client_name VARCHAR PRIMARY KEY,
    contact_info TEXT,
    client_address TEXT
);


------------------------------

CREATE TABLE IF NOT EXISTS soft_user
(
    user_id SMALLSERIAL PRIMARY KEY,
    username VARCHAR UNIQUE,
    user_admin BOOLEAN DEFAULT 'false',
    client_name VARCHAR, --fk
    user_mail VARCHAR UNIQUE,
    
    user_name VARCHAR,
    user_position VARCHAR,
    creation_date DATE ,-- CHECK (creation_date > ...) 
    contact_info TEXT,
    client_address TEXT,
    
FOREIGN KEY (client_name)
    REFERENCES client (client_name)
    ON DELETE CASCADE
);


------------------------------

CREATE TABLE IF NOT EXISTS license
(
    client_name VARCHAR ,--fk
    soft_id SMALLINT ,--fk

initial_date DATE,
end_date DATE CHECK (initial_date < end_date),

PRIMARY KEY (client_name, soft_id)
);


------------------------------

CREATE TABLE IF NOT EXISTS ticket
(
    ticket_id SMALLSERIAL PRIMARY KEY,
    user_id SMALLINT, 
    version_id INT,
    status VARCHAR CHECK (status IN ('submitted', 'scrum_accept', 'dev_assigned', 'scrum_reject', 'dev_solved', 'qa_approved', 'scrum_approved' )),
    employee_id SMALLINT, --fk
    priority SMALLINT, --check...
    submitted DATE,
    closed DATE CHECK (submitted < closed),

FOREIGN KEY (user_id)
    REFERENCES soft_user (user_id),
FOREIGN KEY (version_id)
    REFERENCES soft_version (version_id)

);

COMMIT;