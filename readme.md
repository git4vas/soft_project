# Tables

## Employee

* employee_id
* name, antiquity, characteristics of his work devices (computer, monitor, etc.) and phone number
* (system administrator)?
  * (prog) availability
  * (prog) work hours

## Software

* soft_id        -PK
* (name)
* scrum master        - FK empl
* quality assurance    - FK empl

## Dev_team

(a set of programmers -> dev table)
fk_employee

* fk_soft
* PK(emp,soft)
* Version
* version_id    - PK
* fk_Soft_id    - FK to Soft
* fk_employee_qa_works
* fk_employee_scrum_works

name???

* version_state ENUM(
  * 'stable',
  * 'buggy',
  * 'improving')
* initial_release
* final_circulation
* comments
* actualization dates

## Client

* name,
* contact information,
* address,

## User

* user_id        INT, autoincrement
* client_id        -FK
* Administrator role y/n
* Name
* creation 
* position
* email

## Contract/Licence

* soft_id            FK: soft.soft_id
* client_name        
* initial_date        datetime
* final_date        datetime

## Ticket

* PK ticket_id    - INT, autoincrement        Ticket Number
* user_id    - FK user.user_id, NOT_NULL        User (reporter)
* version_id    - FK version.version_id, NOT_NULL    Version
* Status        - ENUM(
    - 'submitted',
    - 'scrum_accept',
    - 'dev_assigned',
    - 'scrum_reject',
    - 'dev_solved',
    - 'qa_approved',
    -'scr_approved')
