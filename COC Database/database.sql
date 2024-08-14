DROP DATABASE IF EXISTS `COC_Database`;
CREATE SCHEMA `COC_Database`;
USE `COC_Database`;

-- Leagues Table
DROP TABLE IF EXISTS Leagues;
CREATE TABLE IF NOT EXISTS Leagues (
    Name VARCHAR(30) PRIMARY KEY,
    UpperLimitOfTrophyRange INT NOT NULL,
    LowerLimitOfTrophyRange INT NOT NULL
);

-- Player Table
DROP TABLE IF EXISTS Player;
CREATE TABLE IF NOT EXISTS Player (
    PlayerID CHAR(8) PRIMARY KEY,
    PlayerName VARCHAR(20) NOT NULL,
    Elixir INT NOT NULL,
    Gold INT NOT NULL,
    DarkElixir INT NOT NULL,
    Gems INT NOT NULL,
    Trophies INT NOT NULL,
    XPLevel INT NOT NULL,
    TownHallLevel INT NOT NULL
);

-- "Players" Attack Log Table
DROP TABLE IF EXISTS Players_Attack_Log;
CREATE TABLE IF NOT EXISTS Players_Attack_Log (
    Attacker_ID CHAR(8),
    Defender_ID CHAR(8),
    Result VARCHAR(8) NOT NULL,
    Trophy_Transaction INT NOT NULL,
    Battle_Time TIME NOT NULL,
    PRIMARY KEY (Attacker_ID, Defender_ID),
    FOREIGN KEY (Attacker_ID) REFERENCES Player(PlayerID) ON DELETE CASCADE,
    FOREIGN KEY (Defender_ID) REFERENCES Player(PlayerID) ON DELETE CASCADE
);

-- Defences Table
DROP TABLE IF EXISTS Defences;
CREATE TABLE IF NOT EXISTS Defences (
    Name VARCHAR(30) PRIMARY KEY,
    Hitpoints INT NOT NULL,
    DamagePerSecond INT NOT NULL,
    Currency VARCHAR(20) NOT NULL,
    Targets VARCHAR(20) NOT NULL,
    DamageType VARCHAR(30) NOT NULL,
    `Range` INT NOT NULL, -- Fixed by enclosing "Range" in backticks
    UpgradeCost INT NOT NULL,
    UpgradeTime TIME NOT NULL,
    BuildCost INT NOT NULL
);

-- Buildings Table
DROP TABLE IF EXISTS Buildings;
CREATE TABLE IF NOT EXISTS Buildings (
    Name VARCHAR(30) PRIMARY KEY,
    Hitpoints INT NOT NULL,
    UpgradeTime TIME NOT NULL,
    BuildCost INT NOT NULL,
    Currency VARCHAR(20) NOT NULL,
    UpgradeCost INT NOT NULL
);

-- Achievements Table
DROP TABLE IF EXISTS Achievements;
CREATE TABLE IF NOT EXISTS Achievements (
    Name VARCHAR(30) PRIMARY KEY,
    PlayerID CHAR(8),
    Status VARCHAR(3)
);

-- PlayersAchievements Table
DROP TABLE IF EXISTS PlayersAchievements;
CREATE TABLE IF NOT EXISTS PlayersAchievements (
    PlayerID CHAR(8),
    AchievementName VARCHAR(30),
    PRIMARY KEY (PlayerID, AchievementName),
    FOREIGN KEY (PlayerID) REFERENCES Player(PlayerID) ON DELETE CASCADE,
    FOREIGN KEY (AchievementName) REFERENCES Achievements(Name) ON DELETE CASCADE
);

-- Clan Table
DROP TABLE IF EXISTS Clan;
CREATE TABLE IF NOT EXISTS Clan (
    Clan_ID CHAR(8) PRIMARY KEY,
    Name VARCHAR(30) NOT NULL UNIQUE,
    Medals INT NOT NULL,
    NumberOfMembers INT NOT NULL,
    Num_Wins INT NOT NULL,
    Num_Losses INT NOT NULL
);

-- Player "part of" clan Table
DROP TABLE IF EXISTS Player_part_of_clan;
CREATE TABLE IF NOT EXISTS Player_part_of_clan (
    Clan_ID CHAR(8),
    PlayerID CHAR(8),
    PRIMARY KEY (PlayerID),
    FOREIGN KEY (Clan_ID) REFERENCES Clan(Clan_ID) ON DELETE CASCADE,
    FOREIGN KEY (PlayerID) REFERENCES Player(PlayerID) ON DELETE CASCADE
);

-- ClanWar Table
DROP TABLE IF EXISTS ClanWar;
CREATE TABLE IF NOT EXISTS ClanWar (
    Clan1_ID CHAR(8),
    Clan2_ID CHAR(8),
    Result VARCHAR(8) NOT NULL,
    PRIMARY KEY (Clan1_ID, Clan2_ID),
    FOREIGN KEY (Clan1_ID) REFERENCES Clan(Clan_ID) ON DELETE CASCADE,
    FOREIGN KEY (Clan2_ID) REFERENCES Clan(Clan_ID) ON DELETE CASCADE
);

-- ClanChat Table
DROP TABLE IF EXISTS ClanChat;
CREATE TABLE IF NOT EXISTS ClanChat (
    Clan_ID CHAR(8),
    PlayerID CHAR(8),
    Time TIME NOT NULL,
    PRIMARY KEY (PlayerID),
    FOREIGN KEY (Clan_ID) REFERENCES Clan(Clan_ID) ON DELETE CASCADE,
    FOREIGN KEY (PlayerID) REFERENCES Player(PlayerID) ON DELETE CASCADE
);

-- Spells Table
DROP TABLE IF EXISTS Spells;
CREATE TABLE IF NOT EXISTS Spells (
    Name VARCHAR(30) PRIMARY KEY,
    DamageType VARCHAR(30) NOT NULL,
    TotalDamage INT NOT NULL,
    Targets VARCHAR(20) NOT NULL,
    HousingSpace INT NOT NULL,
    UpgradeTime TIME NOT NULL,
    Currency VARCHAR(20) NOT NULL,
    UpgradeCost INT NOT NULL,
    BrewingTime TIME NOT NULL,
    SpellFactoryLvlUnlock INT NOT NULL
);

-- Heroes Table
DROP TABLE IF EXISTS Heroes;
CREATE TABLE IF NOT EXISTS Heroes (
    Name VARCHAR(20) PRIMARY KEY,
    Hitpoints INT NOT NULL,
    DamagePerSecond INT NOT NULL,
    Currency VARCHAR(20) NOT NULL,
    Targets VARCHAR(20) NOT NULL,
    DamageType VARCHAR(20) NOT NULL,
    RegenerationTime TIME NOT NULL,
    MovementSpeed INT NOT NULL,
    UpgradeCost INT NOT NULL,
    UpgradeTime TIME NOT NULL,
    UnlockCost INT NOT NULL,
    HousingSpace INT NOT NULL
);

-- Troops Table
DROP TABLE IF EXISTS Troops;
CREATE TABLE IF NOT EXISTS Troops (
    Name VARCHAR(30) PRIMARY KEY,
    Hitpoints INT NOT NULL,
    DamagePerSec INT NOT NULL,
    TrainingTime TIME NOT NULL,
    DamageType VARCHAR(30) NOT NULL,
    MovementSpeed INT NOT NULL,
    BarrackLevelUnlock INT NOT NULL,
    Currency VARCHAR(30) NOT NULL,
    UpgradeTime TIME NOT NULL,
    UpgradeCost INT NOT NULL,
    Targets VARCHAR(20) NOT NULL,
    HousingSpace INT NOT NULL
);

-- PopularArmyComposition Table
DROP TABLE IF EXISTS PopularArmyComposition;
CREATE TABLE IF NOT EXISTS PopularArmyComposition (
    Name VARCHAR(30) PRIMARY KEY
);

-- Troops, Spells and Heroes part of Army composition Table
DROP TABLE IF EXISTS Troops_Spells_Heroes_part_of_Army_composition;
CREATE TABLE IF NOT EXISTS Troops_Spells_Heroes_part_of_Army_composition (
    TroopName VARCHAR(30),
    SpellName VARCHAR(30),
    HeroName VARCHAR(20),
    ArmyName VARCHAR(30),
    PRIMARY KEY (TroopName, SpellName, HeroName, ArmyName),
    FOREIGN KEY (TroopName) REFERENCES Troops(Name) ON DELETE CASCADE,
    FOREIGN KEY (SpellName) REFERENCES Spells(Name) ON DELETE CASCADE,
    FOREIGN KEY (HeroName) REFERENCES Heroes(Name) ON DELETE CASCADE,
    FOREIGN KEY (ArmyName) REFERENCES PopularArmyComposition(Name) ON DELETE CASCADE
);

-- SpellsInArmyCompositions Table
DROP TABLE IF EXISTS SpellsInArmyCompositions;
CREATE TABLE IF NOT EXISTS SpellsInArmyCompositions (
    Spell VARCHAR(30),
    ArmyComposition VARCHAR(30) NOT NULL,
    Count INT NOT NULL,
    PRIMARY KEY (Spell, ArmyComposition),
    FOREIGN KEY (Spell) REFERENCES Spells(Name) ON DELETE CASCADE,
    FOREIGN KEY (ArmyComposition) REFERENCES PopularArmyComposition(Name) ON DELETE CASCADE
);

-- TroopsInArmyCompositions Table
DROP TABLE IF EXISTS TroopsInArmyCompositions;
CREATE TABLE IF NOT EXISTS TroopsInArmyCompositions (
    Troop VARCHAR(30),
    ArmyComposition VARCHAR(30) NOT NULL,
    Count INT NOT NULL,
    PRIMARY KEY (Troop, ArmyComposition),
    FOREIGN KEY (Troop) REFERENCES Troops(Name) ON DELETE CASCADE,
    FOREIGN KEY (ArmyComposition) REFERENCES PopularArmyComposition(Name) ON DELETE CASCADE
);

-- Leagues table
INSERT INTO Leagues (Name, UpperLimitOfTrophyRange, LowerLimitOfTrophyRange)
VALUES
    ('Bronze League', 1000, 500),
    ('Silver League', 2000, 1000),
    ('Gold League', 3000, 2001),
    ('Crystal League', 4000, 3001),
    ('Master League', 5000, 4001);

-- Player table
INSERT INTO Player (PlayerID,PlayerName, Elixir, Gold, DarkElixir, Gems, Trophies, XPLevel, TownHallLevel)
VALUES
    ('P001',  'Uranus',  8000, 4000, 1500, 200, 1800, 25, 7),
    ('P002',  'Player2',  12000, 6000, 2500, 300, 2500, 35, 9),
    ('P003',  'Ut',  10000, 5000, 2000, 150, 2200, 30, 8),
    ('P004',  'Player4',  9000, 4500, 1800, 250, 2000, 28, 7),
    ('P005', 'Player5', 7500, 3800, 1300, 180, 1600, 23, 6);

-- Players_Attack_Log table
INSERT INTO Players_Attack_Log (Attacker_ID, Defender_ID, Result, Trophy_Transaction, Battle_Time)
VALUES
    ('P001', 'P002', 'Victory', 30, '2023-01-01 08:30:00'),
    ('P002', 'P001', 'Defeat', -25, '2023-01-02 15:45:00'),
    ('P003', 'P004', 'Victory', 20, '2023-01-03 12:10:00'),
    ('P004', 'P003', 'Defeat', -15, '2023-01-04 09:20:00'),
    ('P005', 'P002', 'Victory', 25, '2023-01-05 18:55:00');

-- Defences table
INSERT INTO Defences (Name, Hitpoints, DamagePerSecond, Currency, Targets, DamageType, `Range`, UpgradeCost, UpgradeTime, BuildCost)
VALUES
    ('Archer Tower', 800, 40, 'Gold', 'Ground & Air', 'Single Target', 10, 1000, '08:00:00', 500),
    ('Cannon', 1000, 30, 'Gold', 'Ground', 'Single Target', 8, 800, '06:00:00', 400),
    ('Wizard Tower', 1200, 50, 'Elixir', 'Ground & Air', 'Splash Damage', 12, 1500, '12:00:00', 700),
    ('Mortar', 1500, 35, 'Gold', 'Ground', 'Splash Damage', 15, 1200, '10:00:00', 600),
    ('Air Defense', 1000, 60, 'Elixir', 'Air', 'Single Target', 18, 1800, '14:00:00', 900);

-- Buildings table
INSERT INTO Buildings (Name, Hitpoints, UpgradeTime, BuildCost, Currency, UpgradeCost)
VALUES
    ('Clan Castle', 1500, '24:00:00', 1000, 'Gold', 500),
    ('Laboratory', 1200, '18:00:00', 800, 'Elixir', 400),
    ('Spell Factory', 1000, '12:00:00', 600, 'Gold', 300),
    ('Gold Mine', 800, '10:00:00', 300, 'Gold', 150),
    ('Elixir Collector', 1000, '12:00:00', 400, 'Elixir', 200);

-- Achievements table
INSERT INTO Achievements (Name, PlayerID, Status)
VALUES
    ('War Hero', 'P001', 'Com'),
    ('Friend in Need', 'P002', 'IP'),
    ('Unbreakable', 'P003', 'NS'),
    ('Dragon Slayer', 'P004', 'IP'),
    ('Master Strategist', 'P005', 'NS');

-- PlayersAchievements table
INSERT INTO PlayersAchievements (PlayerID, AchievementName)
VALUES
    ('P001', 'War Hero'),
    ('P002', 'Friend in Need'),
    ('P003', 'Unbreakable'),
    ('P004', 'Dragon Slayer'),
    ('P005', 'Master Strategist');

-- Clan table
INSERT INTO Clan (Clan_ID, Name, Medals, NumberOfMembers, Num_Wins, Num_Losses)
VALUES
    ('C001', 'Wars', 1200, 15, 8, 3),
    ('C002', 'Wat', 1500, 20, 10, 5),
    ('C003', 'Clan C', 1800, 25, 15, 8),
    ('C004', 'Warrior', 1600, 18, 12, 6),
    ('C005', 'Clan E', 2000, 30, 20, 10),
    ('C006', 'Clan trap', 0, 0, 0, 0);

-- Player_part_of_clan table
INSERT INTO Player_part_of_clan (Clan_ID, PlayerID)
VALUES
    ('C001', 'P001'),
    ('C002', 'P002'),
    ('C003', 'P003'),
    ('C004', 'P004'),
    ('C001', 'P005');

-- ClanWar table
INSERT INTO ClanWar (Clan1_ID, Clan2_ID, Result)
VALUES
    ('C001', 'C002', 'Victory'),
    ('C003', 'C004', 'Defeat'),
    ('C002', 'C005', 'Victory'),
    ('C001', 'C003', 'Defeat'),
    ('C004', 'C005', 'Victory');

-- ClanChat table
INSERT INTO ClanChat (Clan_ID, PlayerID, Time)
VALUES
    ('C001', 'P001', '2023-01-01 14:30:00'),
    ('C002', 'P002', '2023-01-02 20:45:00'),
    ('C003', 'P003', '2023-01-03 10:10:00'),
    ('C004', 'P004', '2023-01-04 15:20:00'),
    ('C005', 'P005', '2023-01-05 08:55:00');

-- Spells table
INSERT INTO Spells (Name, DamageType, TotalDamage, Targets, HousingSpace, UpgradeTime, Currency, UpgradeCost, BrewingTime, SpellFactoryLvlUnlock)
VALUES
    ('Lightning Spell', 'Area Damage', 200, 'Ground', 2, '02:00:00', 'Elixir', 300, '00:30:00', 3),
    ('Healing Spell', 'Heal', 100, 'Ground & Air', 2, '01:30:00', 'Elixir', 250, '00:45:00', 3),
    ('Rage Spell', 'Damage Boost', 150, 'Ground & Air', 2, '02:30:00', 'Elixir', 350, '00:40:00', 4),
    ('Freeze Spell', 'Freeze', 5, 'Ground & Air', 2, '03:00:00', 'Elixir', 400, '01:00:00', 5),
    ('Poison Spell', 'Damage over Time', 50, 'Ground & Air', 2, '01:45:00', 'Elixir', 280, '00:35:00', 4);

-- Heroes table
INSERT INTO Heroes (Name, Hitpoints, DamagePerSecond, Currency, Targets, DamageType, RegenerationTime, MovementSpeed, UpgradeCost, UpgradeTime, UnlockCost, HousingSpace)
VALUES
    ('Barbarian King', 1500, 120, 'Dark Elixir', 'Ground', 'Single Target', '12:00:00', 10, 1000, '14:00:00', 200, 25),
    ('Archer Queen', 1200, 180, 'Dark Elixir', 'Ground & Air', 'Single Target', '16:00:00', 12, 1200, '18:00:00', 250, 20),
    ('Grand Warden', 1800, 80, 'Elixir', 'Ground & Air', 'Splash Damage', '20:00:00', 8, 800, '22:00:00', 180, 30),
    ('Royal Champion', 1600, 150, 'Dark Elixir', 'Ground & Air', 'Splash Damage', '18:00:00', 14, 1500, '20:00:00', 220, 22),
    ('Battle Machine', 2000, 100, 'Gold', 'Ground', 'Single Target', '24:00:00', 6, 600, '26:00:00', 150, 15);

-- Troops table
INSERT INTO Troops (Name, Hitpoints, DamagePerSec, TrainingTime, DamageType, MovementSpeed, BarrackLevelUnlock, Currency, UpgradeTime, UpgradeCost, Targets, HousingSpace)
VALUES
    ('Barbarian', 100, 10, '00:45:00', 'Single Target', 12, 1, 'Elixir', '01:00:00', 50, 'Ground', 1),
    ('Archer', 80, 15, '01:00:00', 'Single Target', 16, 2, 'Elixir', '01:30:00', 80, 'Air & Ground', 1),
    ('Giant', 300, 25, '02:00:00', 'Single Target', 10, 3, 'Elixir', '02:30:00', 150, 'Ground', 5),
    ('Wizard', 120, 50, '02:30:00', 'Splash Damage', 12, 5, 'Elixir', '03:00:00', 200, 'Ground & Air', 4),
    ('Dragon', 800, 100, '10:00:00', 'Splash Damage', 8, 7, 'Elixir', '12:00:00', 800, 'Air', 20);

-- PopularArmyComposition table
INSERT INTO PopularArmyComposition (Name)
VALUES
    ('Barch'),
    ('GoWiPe'),
    ('LavaLoon'),
    ('Hog Riders'),
    ('Goblin Knife');

-- Troops_Spells_Heroes_part_of_Army_composition table
INSERT INTO Troops_Spells_Heroes_part_of_Army_composition (TroopName, SpellName, HeroName, ArmyName)
VALUES
    ('Barbarian', 'Lightning Spell', 'Barbarian King', 'Barch'),
    ('Dragon', 'Healing Spell', 'Archer Queen', 'GoWiPe'),
    ('Giant', 'Freeze Spell', 'Grand Warden', 'LavaLoon'),
    ('Wizard', 'Freeze Spell', 'Barbarian King', 'Hog Riders'),
    ('Dragon', 'Poison Spell', 'Battle Machine', 'Goblin Knife');

-- SpellsInArmyCompositions table
INSERT INTO SpellsInArmyCompositions (Spell, ArmyComposition, Count)
VALUES
    ('Lightning Spell', 'Barch', 2),
    ('Healing Spell', 'GoWiPe', 3),
    ('Rage Spell', 'LavaLoon', 2),
    ('Freeze Spell', 'Hog Riders', 1),
    ('Poison Spell', 'Goblin Knife', 2);

-- TroopsInArmyCompositions table
INSERT INTO TroopsInArmyCompositions (Troop, ArmyComposition, Count)
VALUES
    ('Barbarian', 'Barch', 20),
    ('Archer', 'GoWiPe', 15),
    ('Giant', 'LavaLoon', 8),
    ('Wizard', 'Hog Riders', 10),
    ('Dragon', 'Goblin Knife', 5);
