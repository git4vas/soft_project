# Project: Ticketing Service Management for a Company

Lorraine Goeuriot <Lorraine.Goeuriot@univ-grenoble-alpes.fr>; Gabriela Gonzalez <gabriela-nicole.gonzalez-saez@univ-grenoble-alpes.fr>

Lpro CNMS — SGBD — 2020/2021

> **Objectives**
> Modelization and creation of a database for a errors and requirements (as a bug tracker/ticketing service). Development of scripts allowing maintenance, edition and queries on the database.

# 1. Description of the project

## 1.1. Objectives

The purpose of the project is to create a system to manage the bugs and requirements as tickets for the software of the company. This project requires the modelization of the database, its implementation and its edition. Scripts allowing modification, visualization and maintenance will be required.

This document describes the company’s need, the steps required to achieve the project, and the evaluation.

The company provides Software As a Service to several client companies. When the final users of the software find an error or a change they would like in the softwares, they have to report it to a bug tracker system that should be followed by the development team.

## 1.2. Company’s needs

In the company, all the employees of the development department are assigned to one or several softwares, except for the system administrator, who manages the bug tracker. Each software has: a scrum master as the leader of the software project, a set of programmers and a quality assurance (QA) tester. For each member of the development team is stored the name, antiquity, characteristics of his work devices (computer, monitor, etc.) and phone number. For the programmers is also required to register the regular weekly work hours and the outside work’s availability.

The software has different versions. The stable version of the software is registered. For each version is stored the initial release datetime and final circulation datetime, also the difference between the versions (updates comments). States of the version:

- Stable (it’s the state of a new version)
- With errors (when arrives a ticket of an error)
- Improving (when arrived a ticket with requirement)

The client companies contract one or more software. It is important to register the current version of the software that each client company is using (the current version could differ among them), and the actualization dates. For each client company is registered the name, the contact information, address, contract initial date and contract final date.

Several users of the client company have access to the software. These users have different roles on the system, they can be Administrators or Normal users. For each user, the username is stored, along with the name, the user’s creation datetime, his/her position in the company and his/her email. When a user finds an error on the software, they send a ticket to the development team using the bug tracker form. It is possible to send new requirements and ideas using the same form, as a request for change. The tickets submitted by an Administrator user have a higher priority.

The scrum master will accept or reject the tickets and manage their priority, then he/she assigns the ticket to a specific programmer. When the programmer has solved a ticket, the QA has to test it and approve the change (if it is not approved, the ticket is re-assigned to the programmer). Finally, the scrum master approves the change(s) and creates a new version of the software. For each ticket,the different states and the time spent on it by the development team are stored.

The new version of the software is updated for all the companies that have a current contract.

## 1.3. Required scripts

You will write scripts containing queries allowing to perform actions described in the following table:
<!--
### Table 1. Required Scripts

| User category | Actions |
| --- | --- |
| Database Users | Define privileges of the users that will access directly to the database: <br>  - Database Administrator.<br>  - Scrum Master.<br>  - Quality Assurance tester. |
| Client User |View his/her tickets and their status<br>Create new tickets<br>View, modify and delete unassigned tickets (not accepted or rejected yet)<br>View, modify, delete personal information |
| Client Administrator | (similar to Client User) Create a new ticket with high priority <br>(similar to Client User) View his/her tickets and their status <br>(similar to Client User) Modify and delete unassigned tickets (not accepted or rejected yet) <br>(similar to Client User) View, modify, delete personal information <br>View all the tickets of the users of the client company <br>Modify and delete unassigned tickets (not accepted or rejected yet) of the users <br>View the number of tickets per software <br>Delete a solved ticket <br>View, modify, delete personal information of a user of the company |
| Scrum Master | View the tickets to assign and their priority <br>View the number of tickets per company <br>Accept or reject a ticket <br>Assign a ticket to the programmer and update the state of the software version (**as a transaction**) <br>Approve a ticket and create a new version of the software (**as a transaction**) <br>View the software versions’ list <br>View, modify, delete personal information |
| Programmer | Update the status of an assigned ticket and store the historical state (**as a transaction**) <br>View all the assigned tickets (current and historical) <br>View, modify, delete personal information |
| QA tester | Update the status of an assigned ticket and store the historical state (**as a transaction**) <br>View all the assigned tickets (current and historical) <br>View, modify, delete personal information |
| System Administrator | Same scripts as scrum master (for all softwares) <br>View, create, modify, delete personal information of the development team <br>View, create, modify, delete scrum masters <br>Queries to: <br>- List of all the tickets ongoing <br>- List the closed tickets <br>- Number of tickets in the different states <br>- Show the programmers with more than a year in the company <br>- Show the softwares with more than 5 versions <br>- For each software: How many tickets had been solved, How many are ongoing, how many have been rejected <br>- Show all the client users who got more than two tickets rejected |
-->



**Table 1. Required Scripts**
User category / Actions

Database Users

- Define privileges of the users that will access directly to the database:
  - Database Administrator.
  - Scrum Master.
  - Quality Assurance tester.

Client User

- View his/her tickets and their status
- Create new tickets
- View, modify and delete unassigned tickets (not accepted or rejected yet)
- View, modify, delete personal information

Client Administrator

- (similar to Client User) Create a new ticket with high priority
- (similar to Client User) View his/her tickets and their status
- (similar to Client User) Modify and delete unassigned tickets (not accepted or rejected yet)
- (similar to Client User) View, modify, delete personal information
- View all the tickets of the users of the client company
- Modify and delete unassigned tickets (not accepted or rejected yet) of the users
- View the number of tickets per software
- Delete a solved ticket
- View, modify, delete personal information of a user of the company

Scrum Master

- View the tickets to assign and their priority
- View the number of tickets per company
- Accept or reject a ticket
- Assign a ticket to the programmer and update the state of the software version (**as a transaction**)
- Approve a ticket and create a new version of the software (**as a transaction**)
- View the software versions’ list
- View, modify, delete personal information

Programmer

- Update the status of an assigned ticket and store the historical state (**as a transaction**)
- View all the assigned tickets (current and historical)
- View, modify, delete personal information

QA tester

- Update the status of an assigned ticket and store the historical state (**as a transaction**)
- View all the assigned tickets (current and historical)
- View, modify, delete personal information

System Administrator

- Same scripts as scrum master (for all softwares)
- View, create, modify, delete personal information of the development team
- View, create, modify, delete scrum masters
- Queries to:
  - List of all the tickets ongoing
  - List the closed tickets
  - Number of tickets in the different states
  - Show the programmers with more than a year in the company
  - Show the softwares with more than 5 versions
  - For each software: How many tickets had been solved, How many are ongoing, how many have been rejected
  - Show all the client users who got more than two tickets rejected

## 1.4. Optional functionalities

Following functionalities will give you extra points. Difficulty is given with stars (\*, easy, ** **, difficult)

**Table 2. Optional functionalities (pick one or more)**
| Name | Difficulty | Description |
| --- | :---: | --- |
| Static web interface | ** | HTML pages allowing to view tables |
| Dynamic web interface | ** * | Pages allowing to add dynamically data in the tables |
| Constrained update of the database | ** | Add constraints to data given by users via the HTML interface |
| Replicates | ** | Create a replicate for the database using publication. |

## 1.5. Documentation

You will document your database: describe the modelization and creation of your databas. Also describe and comment your scripts.

# 2. Implementation

You must use the implementation framework provided during the labs. Your database must be PostgreSQL.

## 2.1. Modelization of the database

The purpose of this step is to modelize and implement your database. To do so, you need to follow the steps given in the lectures:

- Entity-association model
- Logical model
- Implementation
- Insertion of data in the tables

The evaluation will be based on these elements. Make sure you define everything carefully, paying attention to constraints, primary and foreign keys. Describe these steps in the documentation.

## 2.2. Add data in the tables

Insert data in your tables. Avoid using generic names as user1, user2, company1, company2 (will be penalized). If it’s hard for you, try to use [autogenerators](https://www.generatedata.com/). Scripts of data insert will be evaluated.

## 2.3. Scripts SQL

Give SQL scripts allowing to perform [Required scripts](#1.3.%20Required%20scripts).

## 2.4. Optional functionalities

If you pick some of the optional functionalities, you can use frameworks such as [bootstrap](http://getbootstrap.com/).

(Last updated 2021-02-10 21:46:52 CET)
