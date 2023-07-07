-- IMDB Design a DB for IMDB 
-- 1. Movie should have multiple media(Video or Image) 
-- 2. Movie can belongs to multiple Genre 
-- 3. Movie can have multiple reviews and Review can belongs to a user 
-- 4. Artist can have multiple skills 5. Artist can perform multiple role in a single film

-- MySQL IMDB 

-- Creating movie table;

CREATE TABLE Movies(
    Movie_id INTEGER PRIMARY KEY,
    Name TEXT,
    Year INTEGER
);

-- Inserting movies data;

INSERT INTO Movies VALUES(001,'KGF',2022);
INSERT INTO Movies VALUES(002,'Witcher',2020);
INSERT INTO Movies VALUES(003,'Originals',2015);
INSERT INTO Movies VALUES(004,'Lost in space',2018);

-- Creating media table;

CREATE TABLE Media(
    Media_id INTEGER,
    Poster TEXT,
    Trailer TEXT
);

-- Inserting media data;

INSERT INTO Media VALUES(001, 'https://en.wikipedia.org/wiki/K.G.F:_Chapter_2#/media/File:K.G.F_Chapter_2.jpg','https://www.youtube.com/watch?v=Qah9sSIXJqk');
INSERT INTO Media VALUES(002,'https://en.wikipedia.org/wiki/The_Witcher_(TV_series)#/media/File:The_Witcher_Title_Card.png','https://www.youtube.com/watch?v=SzS8Ao0H6Co');
INSERT INTO Media VALUES(003,'https://en.wikipedia.org/wiki/The_Originals_(season_1)#/media/File:The_Originals_S1_Poster.jpg','https://www.youtube.com/watch?v=GXrDYboUnnw');
INSERT INTO Media VALUES(004,'https://en.wikipedia.org/wiki/Lost_in_Space_(2018_TV_series)#/media/File:Lost_in_Space_2018_series_Logo.jpg','https://www.youtube.com/watch?v=fzmM0AB60QQ');

SELECT * FROM Movies
inner join Media
on Movie_id=Media_id;

-- Creating artists table;

CREATE TABLE Artists(
    Artist TEXT,
    Role TEXT,
    M_id INTEGER
);

-- Inserting artists data;

INSERT INTO Artists VALUES('Dave erickson','Director',001);
INSERT INTO Artists VALUES('Felix Kammerer','Male Lead',001);
INSERT INTO Artists VALUES('Robert kirkman','Director',002);
INSERT INTO Artists VALUES('Henry cavill','Male Lead',002);
INSERT INTO Artists VALUES('Alicia','Female Lead',002);
INSERT INTO Artists VALUES('Nolan','Director',003);
INSERT INTO Artists VALUES('Klaus','Male Lead',003);
INSERT INTO Artists VALUES('Jordan Elija','Director',004);
INSERT INTO Artists VALUES('Daniel','Male Lead',004);

SELECT * FROM Movies
inner join Artists
on Movie_id=M_id;

-- Creating genre table;

CREATE TABLE Genre(
    Genre TEXT,
    Genre_id INTEGER
);

-- Inserting genre data;

INSERT INTO Genre VALUES('Action'001);
INSERT INTO Genre VALUES('War',001);
INSERT INTO Genre VALUES('Comedy',002);
INSERT INTO Genre VALUES('Drama',002);
INSERT INTO Genre VALUES('Drama',003);
INSERT INTO Genre VALUES('Action',003);
INSERT INTO Genre VALUES('Horror',004);
INSERT INTO Genre VALUES('Sci-Fi',004);

SELECT * FROM Movies
inner join Genre
on Movie_id=Genre_id;

-- Creating review table;

CREATE TABLE Review(
    Rating FLOAT,
    Review_id INTEGER
);

-- Inserting review data;

INSERT INTO Review VALUES(7.9,002);
INSERT INTO Review VALUES(7.6,003);
INSERT INTO Review VALUES(6.9,004);
INSERT INTO Review VALUES(7.8,001);

SELECT * FROM Movies
inner join Review
on Movie_id=Review_id;

---------------------------------------------------------
-- Another approach

CREATE DATABASE imdb;

-- 1. Movie should have multiple media(Video or Image) 

CREATE TABLE Movie ( Id INT PRIMARY KEY AUTO_INCREMENT, MovieName VARCHAR(255), Director VARCHAR(255), Language ENUM ('TAMIL'));


CREATE TABLE Media_img (ID INT PRIMARY KEY AUTO_INCREMENT, Name VARCHAR(255), Type VARCHAR(255), Size VARCHAR(255));
CREATE TABLE Media_video (ID INT PRIMARY KEY AUTO_INCREMENT, Name VARCHAR(255), Type VARCHAR(255), Size VARCHAR(255));


INSERT INTO Media_img (ID, Name, Type, Size) VALUES (1, "img1", "Image", "50MB" );
INSERT INTO Media_video (ID, Name, Type, Size) VALUES (1, "video1", "Video", "100MB" );


CREATE TABLE Movie ( Id INT PRIMARY KEY AUTO_INCREMENT, MovieName VARCHAR(255), Director VARCHAR(255), Language ENUM ('TAMIL'));

ALTER TABLE Media_img ADD FOREIGN KEY (MovieId) REFERENCES Movie(Id);
ALTER TABLE Media_img ADD COLUMN MovieId INT;
ALTER TABLE Media_video ADD COLUMN MovieId INT;


UPDATE Media_img SET MovieId=1 WHERE Id in (1);
UPDATE Media_video SET MovieId=1 WHERE Id in (1);


-------------------------------------------------------------------------------------------------------------------------------------------

-- 2. Movie can belongs to multiple Genre


INSERT INTO Movie (MovieName, Director, Language) VALUES ("KGF", "Prasanth", "Tamil");
INSERT INTO Movie (MovieName, Director, Language) VALUES ("Sathuranga Vettai", "Vinoth", "Tamil");
INSERT INTO Movie (MovieName, Director, Language) VALUES ("Cobra", "Nayamuthu", "Tamil");

CREATE TABLE Genre ( Id INT PRIMARY KEY AUTO_INCREMENT, Name VARCHAR(255));
INSERT INTO Genre (Name) VALUES ("Action");
INSERT INTO Genre (Name) VALUES ("Comedy");
INSERT INTO Genre (Name) VALUES ("Love");
INSERT INTO Genre (Name) VALUES ("Period");

ALTER TABLE Genre ADD COLUMN MovieId INT;

ALTER TABLE Genre ADD FOREIGN KEY (MovieId) REFERENCES Movie(Id);
UPDATE Genre SET MovieId=1 WHERE Id in (1);
UPDATE Genre SET MovieId=2 WHERE Id in (2);
UPDATE Genre SET MovieId=3 WHERE Id in (3);
UPDATE Genre SET MovieId=1 WHERE Id in (4);

-------------------------------------------------------------------------------------------------------------------------------------------

-- 3.Movie can have multiple reviews and Review can belongs to a user

CREATE TABLE Users ( Id INT PRIMARY KEY AUTO_INCREMENT, Name VARCHAR(255), Age INT);
INSERT INTO Users (Id, Name, Age) VALUES (1, "xxx", 22);
INSERT INTO Users (Id, Name, Age) VALUES (2, "yyy", 24);

CREATE TABLE Reviews ( Id INT PRIMARY KEY AUTO_INCREMENT, Rating INT);
INSERT INTO Reviews (Rating) VALUES (5);
INSERT INTO Reviews (Rating) VALUES (4);
INSERT INTO Reviews (Rating) VALUES (3);

ALTER TABLE Reviews ADD COLUMN MovieId INT;
ALTER TABLE Reviews ADD COLUMN UserId INT;
ALTER TABLE Reviews ADD FOREIGN KEY (MovieId) REFERENCES Movie(Id);
ALTER TABLE Reviews ADD FOREIGN KEY (UserId) REFERENCES Users(Id);

UPDATE Reviews SET MovieId=1,UserId=1 WHERE Id in (1);
UPDATE Reviews SET MovieId=1,UserId=2 WHERE Id in (2);
UPDATE Reviews SET MovieId=2,UserId=1 WHERE Id in (3);
UPDATE Reviews SET MovieId=2,UserId=2 WHERE Id in (4);

------------------------------------------------------------------------------------------------------------------------------------------

-- 4. Artist can have multiple skills 5. Artist can perform multiple role in a single film


CREATE TABLE Artist ( Id INT PRIMARY KEY AUTO_INCREMENT, Name VARCHAR(255), Experience VARCHAR(255), Average_Salary INT, Contact_Number INT);
INSERT INTO Artist (ID, Name, Experience, Average_Salary, Contact_Number) VALUES (1, "Vikram", "20Years" , 5000000, 235112 );
INSERT INTO Artist (ID, Name, Experience, Average_Salary, Contact_Number) VALUES (2, "Rajinikanth", "40Years" , 10000000, 215206 );
INSERT INTO Artist (ID, Name, Experience, Average_Salary, Contact_Number) VALUES (3, "PrakashRaj", "40Years" , 5000000, 250270 );
INSERT INTO Artist (ID, Name, Experience, Average_Salary, Contact_Number) VALUES (4, "Fazhil", "10Years" , 6000000, 226000 );

CREATE TABLE Skills (Id INT PRIMARY KEY AUTO_INCREMENT, Skill VARCHAR(255));
INSERT INTO Skills (Id, Skill) VALUES (1, "Dancer");
INSERT INTO Skills (Id, Skill) VALUES (2, "Fighter");
INSERT INTO Skills (Id, Skill) VALUES (3, "Mimicry");
INSERT INTO Skills (Id, Skill) VALUES (4, "Politician");

CREATE TABLE ArtistSkills (Id INT PRIMARY KEY AUTO_INCREMENT);
ALTER TABLE ArtistSkills ADD COLUMN ArtistId INT;
ALTER TABLE ArtistSkills ADD COLUMN SkillsId INT;
ALTER TABLE ArtistSkills ADD COLUMN Count INT;
ALTER TABLE ArtistSkills ADD FOREIGN KEY (ArtistId) REFERENCES Artist(Id);
ALTER TABLE ArtistSkills ADD FOREIGN KEY (SkillsId) REFERENCES Skills(Id);
INSERT INTO ArtistSkills (Id) VALUES (1);
INSERT INTO ArtistSkills (Id) VALUES (2);
INSERT INTO ArtistSkills (Id) VALUES (3);
INSERT INTO ArtistSkills (Id) VALUES (4);
INSERT INTO ArtistSkills (Id) VALUES (5);

UPDATE ArtistSkills SET ArtistId=1, SkillsId=1 WHERE Id in (1);
UPDATE ArtistSkills SET ArtistId=1, SkillsId=2 WHERE Id in (2);
UPDATE ArtistSkills SET ArtistId=2, SkillsId=1 WHERE Id in (3);
UPDATE ArtistSkills SET ArtistId=2, SkillsId=2 WHERE Id in (4);
UPDATE ArtistSkills SET ArtistId=2, SkillsId=3 WHERE Id in (5);



SELECT * FROM Media_img;
SELECT * FROM Media_video;
SELECT * FROM Movie;
SELECT * FROM Genre;
SELECT * FROM Users;
SELECT * FROM Reviews;
SELECT * FROM Artist;
SELECT * FROM Skills;
SELECT * FROM ArtistSkills;