SET SEARCH_PATH TO soft_project--;
-------Database Users-----
/*TODO Define privileges of the users: Administrator, Scrum Master, Quality Assurance tester
*/

----------------------------------
----------Client Users------------+is_admin
----------------------------------

/*View his/her tickets and their status
TODO user_id=<AUTO>
-- if user.is_admin ticket.user_id=* via database users and permissions according to is_admin
*/;
SELECT id AS ticket, version_id, status, request_cause, request FROM ticket
WHERE user_id=10;
/*Create new tickets +++ADMIN+++*/
INSERT INTO ticket (id, user_id, version_id, request_cause, request, programmer_id, submitted_date, closed_date)
VALUES
 (12, 18, 7, 'feature', 'make round buttons square', DEFAULT,now(), DEFAULT);
/*
BUG DEFAULT id does not self-increment
TODO x3: user_id=<AUTO>,
-- CHECK version_id via {user_version.user_id, user_version.version_id} 
-- if user.is_admin ticket.user_id=* via database users and permissions according to is_admin
*/;
SELECT * FROM ticket WHERE id>10;

;
--------scrum rejects 12th ticket----------
UPDATE ticket SET status='scrum_rejected' WHERE id=12;

/*
delete HIS??? unassigned tickets (not accepted or rejected yet)
TODO user_id=<AUTO>
*/
DELETE FROM ticket
    WHERE user_id=18 AND status='submitted' OR status='scrum_rejected';
/*
View, and modify HIS??? unassigned tickets (not accepted or rejected yet)
TODO user_id=<AUTO>
*/
UPDATE ticket
    SET text='new request'
    WHERE id=12 AND status='submitted' -- OR status='scrum_rejected'; --seems unreasonable

/*+++ADMIN+++
View, modify and delete unassigned tickets of (same client) users  (rejected or not accepted yet)
TODO user_id=<AUTO>
TODO
*/

/*
View, modify, delete=(SET NULL)?? personal information
/*DONE*/

SELECT * FROM software_user
    WHERE id=5;

UPDATE software_user
    SET username='vavav',
        fullname='Vava Pupkin',
        email='vava@mail.ru'
    WHERE id=5;
/*
DELETE FROM software_user
    WHERE id=5;
if one can self-destruct...*/
/*TODO user_id=<AUTO>*/
;

SELECT * FROM software_user
 WHERE id=5;




-------Client Administrator---------------
/* (similar to Client User)
(similar to Client User) Modify and delete unassigned tickets (not accepted or rejected yet)
(similar to Client User) View, modify, delete personal information
TODO Create a new ticket with high priority


--(similar to Client User) View his/her tickets and their status
--View all the tickets of the users of the client company
--SELECT * FROM ticket WHERE user_id=<??a user from the same client company??>

TODO for admin-user:
*/
;
SELECT id AS ticket, version_id, status, request_cause, request FROM ticket
WHERE user_id IN
    (SELECT user_id FROM user_version.user_id
    WHERE version.id IN
        (SELECT version_id FROM user_version
        WHERE user_id=18 /*this admin*/
        )
    )
;


--Modify and delete unassigned tickets (not accepted or rejected yet) of the users
-- Delete a solved ticket
DELETE FROM ticket
    WHERE status='submitted' OR status='scrum_rejected' OR status='solved'
    AND user_id IN
    (
    SELECT user_id FROM user_version.user_id
    WHERE version.id IN
        (SELECT version_id FROM user_version
        WHERE user_id=18 /*this admin*/
        )
    );

/*
--View the number of tickets per software
*/

SELECT
   version_id,
   COUNT(id)
FROM 
   ticket
WHERE user_id IN
    (SELECT id
    FROM software_user
    WHERE user_id IN
        (SELECT user_id
        FROM software_user
        WHERE user_id=18
        )
    );






--show users of admin18--
/*WORKS!!*/
SELECT id, username, fullname, is_admin, client_id FROM software_user
WHERE client_id IN (SELECT client_id FROM software_user WHERE id=18);


--query all tickets for the client whose admin is 2
/*DOES NOT WORK: 
shows ALL tickets

*/
SELECT id AS ticket_id, * FROM ticket
    WHERE status='submitted' OR status='scrum_rejected' 
        AND user_id IN
            (SELECT id
            FROM software_user
            WHERE user_id IN
                (SELECT user_id
                FROM software_user
                WHERE user_id=18
                )
            )
;

SELECT s.id as software_id, t.id as ticket_id, v.id as version_id
FROM software as s, ticket as t, software_version as v
WHERE v.software_id = s.id
AND v.id = t.version_id;



------------------------------
INSERT INTO ticket (request_cause, request)
    WHERE status='submitted' OR status='scrum_rejected' AND user_id IN AND id=1
            (SELECT id
            FROM software_user
            WHERE user_id IN
                (SELECT user_id
                FROM software_user
                WHERE user_id=2
                )
            ) 
    VALUES ('', '')
;

DELETE FROM ticket
    WHERE status='submitted' OR status='scrum_rejected' AND user_id IN
            (SELECT id
            FROM software_user
            WHERE user_id IN
                (SELECT user_id
                FROM software_user
                WHERE user_id=<??this_user_id??>
                )
            ) 
;

------------------------------------------



SELECT * FROM  employee;
SELECT * FROM  client;
SELECT * FROM  software_user



/*

Scrum Master

TODO View the tickets to assign and their priority
TODO View the number of tickets per company
TODO Accept or reject a ticket
TODO Assign a ticket to the programmer and update the state of the software version (**as a transaction**)
TODO Approve a ticket and create a new version of the software (**as a transaction**)
TODO View the software versions’ list
TODO View, modify, delete personal information


Programmer

TODO Update the status of an assigned ticket and store the historical state (**as a transaction**)
TODO View all the assigned tickets (current and historical)
TODO View, modify, delete personal information

QA tester

TODO Update the status of an assigned ticket and store the historical state (**as a transaction**)
TODO View all the assigned tickets (current and historical)
TODO View, modify, delete personal information

System Administrator

TODO Same scripts as scrum master (for all softwares)
TODO View, create, modify, delete personal information of the development team
TODO View, create, modify, delete scrum masters
- Queries to:
  TODO List of all the tickets ongoing
  TODO List the closed tickets
  TODO Number of tickets in the different states
  TODO Show the programmers with more than a year in the company
  TODO Show the softwares with more than 5 versions
  TODO For each software: How many tickets had been solved, How many are ongoing, how many have been rejected
  TODO Show all the client users who got more than two tickets rejected

*/