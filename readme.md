# Tables

## Employee

* employee_id   -PK
* name,
* phone number

---

* (prog)?
  * (prog) work hours
  * (prog) availability
* (system administrator)?
* (join_date)
  * antiquity=now()-join_date,
* characteristics of his work devices (computer, monitor, etc.)

---

## Software

* software_id        -PK
* (name)
* scrum master sm_id        - FK empl
* quality assurance qa_id   - FK empl
  * check that different from sm

*NULLable FKs!!*

## Dev_team

(a set of programmers -> dev table)
fk_employee

* fk_soft
* PK(emp,soft)

## Version

* version_id    - PK
* fk_Soft_id    - FK to Soft
* fk_employee_qa_works
* fk_employee_scrum_works

soft_name???

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
* client_id          FK: client.client_id
* initial_date        datetime
* final_date        datetime

## Ticket

* PK ticket_id    - INT, autoincrement        Ticket Number
* user_id    - FK user.user_id, NOT_NULL        User (reporter)
* version_id    - FK version.version_id, NOT_NULL    Version
* Status        - ENUM(
  * 'submitted',
  * 'scrum_accept',
  * 'dev_assigned',
  * 'scrum_reject',
  * 'dev_solved',
  * 'qa_approved',
  * 's cr_approved')
\- trigger: version_id++, (NB default version_state='stable')

---

* priority        SMALLINT or:
  * 'low',
  * 'medium',
  * 'high'

---
_\- if ticket submitted by a user(is_admin=true) then priority++_
\- if ticket belongs to version(version_state='buggy') then priority++

---

* employee_id        Developer
    \- constraint: only employee from specified software-version

* submission_date    datetime
* closure_date        datetime

---

?? For each ticket, the different states and the time spent on it by the development team are stored.

---

CHECK *user_id* rights to issue ***<- PK ticket(ticket_id) ->*** to a specific *version_id* via:

-> PK software_user(user_id), FK software_user(client_id) -> PK client(client_id) <- PK(FK licence(client_id), FK licence(software_id)) -> PK software(software_id) <- FK software_version(software_id), PK software_version(version_id) <-

---

## Notes

*NULLable FKs in **soft** table, mind when referencing from **version***
