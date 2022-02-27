SET SEARCH_PATH TO soft_project--;
-------Database Users-----
/*TODO Define privileges of the users: Administrator, Scrum Master, Quality Assurance tester
*/
--------------------------

;
------Client Users--------
--View his/her tickets and their status
SELECT * FROM ticket WHERE user_id=18;

--Create new tickets +++ADMIN+++
INSERT INTO ticket (/*user_id=,*/version_id, request_cause, request)
VALUES
()
--if user_


--View, modify and delete HIS??? unassigned tickets (not accepted or rejected yet)
SELECT * FROM ticket
    WHERE status='submitted' OR status='scrum_rejected' AND user_id=<????>;

INSERT INTO ticket (request_cause, request)
    WHERE status='submitted' OR status='scrum_rejected' AND user_id=<????>
    VALUES ('', '')

DELETE FROM ticket
    WHERE status='submitted' OR status='scrum_rejected' AND user_id=<????>;


--View, modify, delete personal information
UPDATE software_user
    SET username='vavav',
        fullname='Vava Pupkin',
        email='vava@mail.ru'
    WHERE id=5
;

SELECT * FROM software_user;
-- WHERE id=5;


-------Client Administrator---------------
/* (similar to Client User)
(similar to Client User) Modify and delete unassigned tickets (not accepted or rejected yet)
(similar to Client User) View, modify, delete personal information
TODO Create a new ticket with high priority
*/

--(similar to Client User) View his/her tickets and their status
--View all the tickets of the users of the client company
--SELECT * FROM ticket WHERE user_id=<??a user from the same client company??>


--Modify and delete unassigned tickets (not accepted or rejected yet) of the users
-- Delete a solved ticket
DELETE FROM ticket
    WHERE status='submitted' OR status='scrum_rejected' OR status='solved' AND user_id=<??a user from the same client company??>;

--View the number of tickets per software
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
SELECT id, username, fullname, is_admin, client_id FROM software_user
WHERE client_id IN (SELECT client_id FROM software_user WHERE id=18);


SELECT * FROM ticket
    WHERE status='submitted' OR status='scrum_rejected' 
        AND user_id IN
            (SELECT id
            FROM software_user
            WHERE user_id IN
                (SELECT user_id
                FROM software_user
                WHERE user_id=2
                )
            )
;

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
