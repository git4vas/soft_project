SET SEARCH_PATH TO soft_project;

INSERT INTO client (id,name,phone,email,address,city,zip)
VALUES
  ('1','Donec Felis','06 83 88 75 11','ullamcorper.eu.euismod@icloud.com','Ap #298-9774 Nullam St.','Vandoeuvre-lès-Nancy','50745'),
  ('2','It Smart Group','03 15 55 50 49','fermentum@icloud.net','Ap #224-5158 Curabitur Avenue','Illkirch-Graffenstaden','19134'),
  ('3','Fabricator','08 71 82 33 81','id.ante@protonmail.com','3883 Urna. Av.','Saint-Dié-des-Vosges','71064'),
  ('4','BuzzFeed','07 21 68 97 75','ac@protonmail.edu','P.O. Box 166, 6447 Sagittis. Ave','Angoulême','21343'),
  ('5','Arcu Vivamus Indus','02 68 72 47 67','nullam@protonmail.org','723-3277 Pharetra Av.','Villenave-d''Ornon','80941');

INSERT INTO employee (id,name,phone,email)
VALUES
  ('1','Chancellor Rich','09 65 86 88 78','chancellorrich@google.edu'),
  ('2','Lora Poor','09 65 86 88 78','chancellorrich@google.edu'),
  ('3','Sean Bridges','08 77 88 82 64','seanbridges@hotmail.org'),
  ('4','Martena Watkins','02 82 18 93 03','martenawatkins@yahoo.ca'),
  ('5','Maxwell Benson','03 94 89 64 39','maxwellbenson4877@icloud.org'),
  ('6','Juliet Hendrix','02 48 61 36 37','juliethendrix@hotmail.net'),
  ('7','Hannah Maldonacds','06 19 61 91 50','hannahmaldonado1225@hotmail.ca'),
  ('8','Bevis Brady','03 14 92 22 70','bevisbrady1170@aol.ca'),
  ('9','Harrison Thompson','03 84 78 89 57','harrisonthompson@aol.org'),
  ('10','Minerva Roberts','04 24 02 51 84','minervaroberts@google.edu'),
  ('11','Felix Evadams','07 46 38 35 66','felixadams638@icloud.edu'),
  ('12','Amaya Oneal','09 16 35 37 54','amayaoneal7001@yahoo.com'),
  ('13','Brock Rice','03 38 91 16 86','brockrice@protonmail.couk'),
  ('14','Brett Ortega','05 48 48 57 34','brettortega9648@protonmail.com'),
  ('15','Althea Hobbits','09 76 06 61 13','altheahobbs9249@yahoo.net'),
  ('16','Ross Singleton','07 18 66 65 55','rosssingleton4493@google.org'),
  ('17','Aileen Engels','05 65 48 45 79','aileenmarks@outlook.net'),
  ('18','Trevor Vaughan','06 55 45 57 86','trevorvaughn1028@yahoo.edu');

  INSERT INTO software_user (id,username,fullname,email,client_id,position,creation_date,is_admin)
VALUES
('1','enoch','Enoch Lowe','Enoch_Lowe7757@hourpy.biz','1','Service Supervisor','2021-11-16','False'),
('2','Denis','Denis Everett','Denis_Everett3271@muall.tech','1','Executive Director','2023-01-14 02:07:29Z','False'),
('3','Bob','Bob Little','Bob_Little615@deons.tech','1','Auditor','2022-09-26 02:23:37Z','False'),
('4','Jolene','Jolene Walsh','Jolene_Walsh2209@sheye.org','1','Ambulatory Nurse','2021-07-03','False'),
('5','Mabel','Mabel Oldfield','Mabel_Oldfield8849@guentu.biz','1','Ambulatory Nurse','2021-08-24','False'),
('6','Carter','Carter Randall','Carter_Randall6805@liret.org','1','Cook','2021-04-27','False'),
('7','Kurt','Kurt Jarvis','Kurt_Jarvis2812@naiker.biz','2','Chef Manager','2022-11-10 13:32:26Z','False'),
('8','Ryan','Ryan Wellington','Ryan_Wellington3114@irrepsy.com','2','Auditor','2021-11-15','False'),
('9','Kendra','Kendra Brett','Kendra_Brett3883@twace.org','3','Ambulatory Nurse','2021-05-03','False'),
('10','Denny','Denny Robinson','Denny_Robinson6604@elnee.tech','2','Cashier','2021-11-22','False'),
('11','Carrie','Carrie Oldfield','Carrie_Oldfield8976@deons.tech','2','Electrician','2022-02-17 07:18:29Z','True'),
('12','Bart','Bart Salt','Bart_Salt1211@liret.org','3','Systems Administrator','2021-05-29','False'),
('13','Ethan','Ethan Campbell','Ethan_Campbell5120@typill.biz','3','Mobile Developer','2021-12-13','False'),
('14','Logan','Logan Rowlands','Logan_Rowlands7762@naiker.biz','5','Ambulatory Nurse','2021-09-18','True'),
('15','Josh','Josh Samuel','Josh_Samuel519@fuliss.net','2','Production Painter','2022-05-31 11:26:45Z','False'),
('16','Isabella','Isabella Jones','Isabella_Jones5621@mafthy.com','4','Food Technologist','2022-11-28 20:41:35Z','False'),
('17','Sebastian','Sebastian Parker','Sebastian_Parker6326@ubusive.com','5','IT Support Staff','2021-10-08','True'),
('18','Rylee','Rylee Harrington','Rylee_Harrington247@jiman.org','4','Treasurer','2022-03-23 16:14:42Z','True'),
('19','Enoch','Enoch Wellington','Enoch_Wellington5825@muall.tech','4','Assistant Buyer','2022-01-08 00:26:28Z','False'),
('20','Benjamin','Benjamin Yates','Benjamin_Yates6434@bauros.biz','4','IT Support Staff','2023-01-18 14:37:54Z','False');

  INSERT INTO license (client_id,software_id, initial_date,end_date)
VALUES
('1','1','2021-09-04','2022-09-06'),
('1','3','2022-04-06','2022-12-29'),
('1','5','2021-04-05','2023-01-17'),
('2','2','2021-04-17','2021-11-13'),
('2','4','2021-12-05','2023-07-28'),
('2','5','2021-09-04','2022-09-06'),
('3','1','2021-04-06','2021-12-29'),
('3','2','2021-04-05','2023-01-17'),
('5','3','2022-04-17','2021-10-13'),
('5','3','2022-12-05','2024-07-24'),
('4','3','2022-12-05','2024-07-24');

  INSERT INTO software (id,name,sm_id,qa_id)
VALUES
('1','turbomail','1','2'),
('2','turbomail','3','4'),
('3','turbomail','5','6'),
('4','turbomail','7','8'),
('5','turbomail','9','10');

  INSERT INTO software_version (id,software_id,state,initial_release,final_circulation)
VALUES
('1','1','buggy','2022-01-01','2022-02-18'),
('2','1','old','2022-02-18','2022-02-23'), --check initial_release=final_circulation of previous one
('3','1','stable','2022-02-23',NULL),
('4','2',NULL,'2022-01-02',NULL),
('5','3',NULL,'2022-01-03',NULL),
('6','4',NULL,'2022-01-04',NULL),
('7','5',NULL,'2022-01-05',NULL);


  INSERT INTO used_version (user_id,version_id)
VALUES --check??? 1-6, ,7 8 10 11 15, 9 12 13, 16 18-20, 14 17 34567
('1','3'),
('2','3'),
('3','3'),
('4','3'),
('5','3'),
('6','3'),
('7','4'),
('8','4'),
('10','4'),
('11','4'),
('15','4'),
('9','5'),
('12','5'),
('13','5'),
('16','6'),
('18','6'),
('19','6'),
('20','6'),
('14','7'),
('17','7');

  INSERT INTO dev_team (employee_id,software_id)
VALUES --check??? 1-6, ,7 8 10 11 15, 9 12 13, 16 18-20, 14 17 12345
('1','1'),
('2','1'),
('3','2'),
('4','2'),
('5','3'),
('6','3'),
('7','4'),
('8','4'),
('9','5'),
('10','5'),
('11','1'),
('12','2'),
('13','3'),
('14','4'),
('15','5'),
('16','1'),
('17','3'),
('18','5');


  --INSERT INTO ticket (id,software_id,state,initial_release,final_circulation)
--VALUES