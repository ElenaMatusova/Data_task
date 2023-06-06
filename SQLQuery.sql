 
CREATE DATABASE Web_Articl  
ON   
( NAME = Students,  
    FILENAME = 'D:\Task_data\webArticl.mdf',  
    SIZE = 5,  
    MAXSIZE = 100,  
    FILEGROWTH = 1 )  
LOG ON  
( NAME = Students_log,  
    FILENAME = 'D:\Task_data\webarticllog.ldf',  
    SIZE = 3MB,  
    MAXSIZE = 20MB,  
    FILEGROWTH = 10% ) ;  
GO

Use Web_Articl
GO

CREATE TABLE Users
(
UserId INT NOT NULL PRIMARY KEY IDENTITY (1, 1),
Name varchar(50) NOT NULL,
Surname varchar(50) NOT NULL,
Gender varchar(50),
DateofBirth date,
DateofRegistration date
)

CREATE TABLE Country
(
CountryId INT NOT NULL PRIMARY KEY IDENTITY (1, 1),
Name varchar(100) NOT NULL,

)

CREATE TABLE Sports
(
SportId INT NOT NULL PRIMARY KEY IDENTITY (1, 1),
Name varchar(100) NOT NULL,

)

CREATE TABLE City
(
CityId INT NOT NULL PRIMARY KEY IDENTITY (1, 1),
Name varchar(100) NOT NULL,
CountryId INT NOT NULL REFERENCES Country (CountryId)

)

CREATE TABLE Leagues
(
LeagueId INT NOT NULL PRIMARY KEY IDENTITY (1, 1),
Name varchar(50) NOT NULL,
SportId INT NOT NULL REFERENCES Sports (SportId),
CountryId INT NOT NULL REFERENCES Country (CountryId),

)

CREATE TABLE Teams
(
TeamId INT NOT NULL PRIMARY KEY IDENTITY (1, 1),
Name varchar(50) NOT NULL,
CreationDate date NOT NULL,
CityId INT NOT NULL REFERENCES City (CityId),
LeagueId INT NOT NULL REFERENCES Leagues (LeagueId),
 
)

CREATE TABLE Articles
(
ArticleId INT NOT NULL PRIMARY KEY IDENTITY (1, 1),
Title varchar(250) NOT NULL,
AText text NOT NULL,
Author varchar(100) NOT NULL,
Pub_date date,
TeamId INT REFERENCES Teams (TeamId),
LeagueId INT REFERENCES Leagues (LeagueId)
)

CREATE TABLE Games
(
GameId INT NOT NULL PRIMARY KEY IDENTITY (1, 1),
Title varchar(250) NOT NULL,
Game_date date NOT NULL,
Team_score int NOT NULL,
CityId INT REFERENCES City (CityId),
TeamId INT REFERENCES Teams (TeamId),
LeagueId INT REFERENCES Leagues (LeagueId)
)

CREATE TABLE Media
(
MediaId INT NOT NULL PRIMARY KEY IDENTITY (1, 1),
Title varchar(50) NOT NULL,
Picture image NOT NULL,
Filetype varchar(25) NOT NULL,
ArticleId INT NOT NULL REFERENCES Articles (ArticleId),
GameId INT NOT NULL REFERENCES Games (GameId),
LeagueId INT NOT NULL REFERENCES Leagues (LeagueId),
TeamId INT NOT NULL REFERENCES Teams (TeamId)  
)

CREATE TABLE Players
(
PlayerId INT NOT NULL PRIMARY KEY IDENTITY (1, 1),
Name varchar(50) NOT NULL,
Surname varchar(50) NOT NULL,
DateofBirth date,
DateofCareerStart date
)

CREATE TABLE GamesEvents
(
EventId INT NOT NULL PRIMARY KEY IDENTITY (1, 1),
Name varchar(50) NOT NULL,
EventTime time NOT NULL,
GameId INT NOT NULL REFERENCES Games (GameId),
TeamId INT NOT NULL REFERENCES Teams (TeamId)  
)

CREATE TABLE PlayerEvents
(
PEId INT NOT NULL PRIMARY KEY IDENTITY (1, 1),
PlayerId INT NOT NULL REFERENCES Players (PlayerId),
EventId INT NOT NULL REFERENCES GamesEvents (EventId)  
)

CREATE TABLE Advertisements
(
ADId INT NOT NULL PRIMARY KEY IDENTITY (1, 1),
Title varchar(250) NOT NULL,
Ad_date date NOT NULL,
Ad_text text NOT NULL,
MediaId INT REFERENCES Media (MediaId),
TeamId INT REFERENCES Teams (TeamId),
LeagueId INT REFERENCES Leagues (LeagueId)
)

CREATE TABLE Comments
(
CommentId INT NOT NULL PRIMARY KEY IDENTITY (1, 1),
Title varchar(250) NOT NULL,
C_date date NOT NULL,
C_text text NOT NULL,
UserId INT REFERENCES Users (UserId),
ArticleId INT REFERENCES Articles (ArticleId)
)

CREATE TABLE ArticleViews
(
AWId INT NOT NULL PRIMARY KEY IDENTITY (1, 1),
AW_date date NOT NULL,
UserId INT REFERENCES Users (UserId),
ArticleId INT REFERENCES Articles (ArticleId)
)

CREATE TABLE ADViews
(
ADVId INT NOT NULL PRIMARY KEY IDENTITY (1, 1),
ADV_date date NOT NULL,
UserId INT REFERENCES Users (UserId),
ADId INT REFERENCES Advertisements (ADId)
)

