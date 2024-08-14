import pymysql
from prettytable import PrettyTable

# Connect to the MySQL database
conn = pymysql.connect(
    host='localhost',
    user='bruh',
    passwd='Password@123',
    database='COC_Database'
)

# Create a cursor object
cursor = conn.cursor()

while True:

 
 print("Query 1: Retrieve a list of all opponents faced by a particular player")
 print("Query 2: Retrieve name of defense having maximum hitpoints")
 print("Query 3: Retrieve the names of players in a league")
 print("Query 4: Retrieve the names of all members of a clan")
 print("Query 5: Calculate the highest win-lose ratio of a clan")
 print("Query 6: Calculate the average medals of a clan")
 print("Query 7: Searching for clan names that contain the string 'War'")
 print("Query 8: Searching for player names that start with the alphabet 'U'")
 print("Query 9: Adding the details of a new player who joins the game")
 print("Query 10: Adding the details of new troop added to the game")
 print("Query 11: Update the Town Hall of a player who got upgraded")
 print("Query 12: Update the Trophy Count of a player after a battle")
 print("Query 13: Delete the details of a clan whose member count is 0")
 print("Query 14: Delete the details of a troop who has been removed from the game")
 print("Query 15: Investigate how the attack timing is affected at a particular Town Hall")
 print("Query 16: Analyze the popularity of troop")
 query_number = input("Enter the query number (1-16): ")



 if query_number == "1":
   
    print("")
    q1 = input("Enter The ID of the Player: ")

    query = """
    SELECT
        p.PlayerID AS OpponentId,
        p.PlayerName AS OpponentName
    FROM
        Players_Attack_Log pal
    JOIN
        Player p ON pal.Defender_ID = p.PlayerId
    WHERE
        pal.Attacker_ID = %s
    UNION
    SELECT
        p.PlayerID AS OpponentId,
        p.PlayerName AS OpponentName
    FROM
        Players_Attack_Log pal
    JOIN
        Player p ON pal.Attacker_ID = p.PlayerID
    WHERE
        pal.Defender_ID = %s;
    """
    # parameter = ('some_value',)  # Replace 'some_value' with the actual value you're looking for
    cursor.execute(query, (q1, q1))

    # Fetch the results of the query
    results = cursor.fetchall()

    # Process the results'
    table = PrettyTable()
    table.field_names = ["OpponentId", "OpponentName"]

    # Process the results
    for row in results:
        table.add_row(row)

    # Print the table
    print("\nOutput:\n")
    if len(results) != 0:
        print(table)
    else:
        print("No Match Found!")

 elif query_number == "2":
   
    print("")

    query = """
    SELECT
        Name AS MaxHitpointsDefense
    FROM
        Defences
    ORDER BY
        Hitpoints DESC
    LIMIT 1;
    """
    # parameter = ('some_value',)  # Replace 'some_value' with the actual value you're looking for
    cursor.execute(query)

    # Fetch the results of the query
    results = cursor.fetchall()

    # Process the results'
    table = PrettyTable()
    table.field_names = ["Name Of Defence"]

    # Process the results
    for row in results:
        table.add_row(row)

    # Print the table
    print("\nOutput:\n")
    if len(results) != 0:
        print(table)
    else:
        print("No Match Found!")

 elif query_number == "3":
   
    print("")
    q3 = input("Enter The Name of the League: ")

    query = """
    SELECT
        p.PlayerName
    FROM
        Player p, Leagues l
    WHERE
        l.Name = %s AND p.Trophies BETWEEN l.LowerLimitOfTrophyRange AND l.UpperLimitOfTrophyRange;
    """
    # parameter = ('some_value',)  # Replace 'some_value' with the actual value you're looking for
    cursor.execute(query, (q3,))

    # Fetch the results of the query
    results = cursor.fetchall()

    # Process the results'
    table = PrettyTable()
    table.field_names = ["Player Name"]

    # Process the results
    for row in results:
        table.add_row(row)

    # Print the table
    print("\nOutput:\n")
    if len(results) != 0:
        print(table)
    else:
        print("No Match Found!")

 elif query_number == "4":
   
    print("")
    q2 = input("Enter The ID of the Clan: ")

    query = """
    SELECT
        p.PlayerName
    FROM
        Player p
    JOIN
        Player_part_of_clan pc ON p.PlayerID = pc.PlayerID
    WHERE
        pc.Clan_ID = %s;
    """
    # parameter = ('some_value',)  # Replace 'some_value' with the actual value you're looking for
    cursor.execute(query, q2)

    # Fetch the results of the query
    results = cursor.fetchall()

    # Process the results'
    table = PrettyTable()
    table.field_names = ["Player Name"]

    # Process the results
    for row in results:
        table.add_row(row)

    # Print the table
    print("\nOutput:\n")
    if len(results) != 0:
        print(table)
    else:
        print("No Match Found!")

 elif query_number == "5":
   
    print("")

    query = """
    SELECT
        c.Name,
        COALESCE(c.Num_Wins / NULLIF(c.Num_Losses, 0), NULL) AS WinLoseRatio
    FROM
        Clan c
    ORDER BY
        WinLoseRatio DESC
    LIMIT 1;
    """
    # parameter = ('some_value',)  # Replace 'some_value' with the actual value you're looking for
    cursor.execute(query)

    # Fetch the results of the query
    results = cursor.fetchall()

    # Process the results'
    table = PrettyTable()
    table.field_names = ["Clan Name", "Win Loss Ratio"]

    # Process the results
    for row in results:
        table.add_row(row)

    # Print the table
    print("\nOutput:\n")
    if len(results) != 0:
        print(table)
    else:
        print("No Match Found!")

 elif query_number == "6":
 
    print("")
    q2 = input("Enter The ID of the Clan: ")

    query = """
    SELECT
        c.Name,
        COALESCE(c.Medals / NULLIF(c.NumberOfMembers, 0), NULL) AS Average_Medals
    FROM
        Clan c
    WHERE
        c.Clan_ID=%s;
    """
    # parameter = ('some_value',)  # Replace 'some_value' with the actual value you're looking for
    cursor.execute(query, q2)

    # Fetch the results of the query
    results = cursor.fetchall()

    # Process the results'
    table = PrettyTable()
    table.field_names = ["Clan Name", "Number of Medals"]

    # Process the results
    for row in results:
        table.add_row(row)

    # Print the table
    print("\nOutput:\n")
    if len(results) != 0:
        print(table)
    else:
        print("No Match Found!")

 elif query_number == "7":
  
    print("")

    query = """
    SELECT
        Name
    FROM
        Clan
    WHERE
        Name LIKE '%War%';
    """
    # parameter = ('some_value',)  # Replace 'some_value' with the actual value you're looking for
    cursor.execute(query)

    # Fetch the results of the query
    results = cursor.fetchall()

    # Process the results'
    table = PrettyTable()
    table.field_names = ["Clan Name"]

    # Process the results
    for row in results:
        table.add_row(row)

    # Print the table
    print("\nOutput:\n")
    if len(results) != 0:
        print(table)
    else:
        print("No Match Found!")

 elif query_number == "8":
 
    print("")

    query = """
    SELECT
        PlayerName
    FROM
        Player
    WHERE
        PlayerName LIKE 'U%';
    """
    # parameter = ('some_value',)  # Replace 'some_value' with the actual value you're looking for
    cursor.execute(query)

    # Fetch the results of the query
    results = cursor.fetchall()

    # Process the results'
    table = PrettyTable()
    table.field_names = ["Player Name"]

    # Process the results
    for row in results:
        table.add_row(row)

    # Print the table
    print("\nOutput:\n")
    if len(results) != 0:
        print(table)
    else:
        print("No Match Found!")

 elif query_number == "9":
   
    print("")
    PlayerID = input("New PlayerID: ")
    PlayerName = input("New PlayerName: ")

    query = """
    INSERT INTO Player (PlayerID, PlayerName, Elixir, Gold, DarkElixir, Gems, Trophies, XPLevel, TownHallLevel)
    VALUES (%s, %s, 0, 0, 0, 0, 0, 0, 0);
    """
    # parameter = ('some_value',)  # Replace 'some_value' with the actual value you're looking for
    cursor.execute(query, (PlayerID, PlayerName))

 elif query_number == "10":
   
    print("")
    Name = input("New Name: ")
    Hitpoints = int(input("New Hitpoints: "))
    DamagePerSec = int(input("New DamagePerSec: "))
    TrainingTime = input("New TrainingTime (in HH:MM:SS format): ")
    DamageType = input("New DamageType: ")
    MovementSpeed = int(input("New MovementSpeed: "))
    BarrackLevelUnlock = int(input("New BarrackLevelUnlock: "))
    Currency = input("New Currency: ")
    UpgradeTime = input("New UpgradeTime (in HH:MM:SS format): ")
    UpgradeCost = int(input("New UpgradeCost: "))
    Targets = input("New Targets: ")
    HousingSpace = int(input("New HousingSpace: "))

    query = """
    INSERT INTO Troops (
        Name, Hitpoints, DamagePerSec, TrainingTime, DamageType, MovementSpeed, BarrackLevelUnlock,
        Currency, UpgradeTime, UpgradeCost, Targets, HousingSpace
    )
    VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s);
    """

    cursor.execute(query, (
        Name, Hitpoints, DamagePerSec, TrainingTime, DamageType, MovementSpeed, BarrackLevelUnlock,
        Currency, UpgradeTime, UpgradeCost, Targets, HousingSpace
    ))

 elif query_number == "11":

    print("")
    PlayerID = input("PlayerID: ")
    TownLevel = input("New Town Hall Level: ")

    query = """
    UPDATE Player
    SET TownHallLevel = %s
    WHERE PlayerID = %s;
    """

    cursor.execute(query, (TownLevel, PlayerID))

 elif query_number == "12":
   
    print("")
    Attacker_ID = input("Enter Attacker ID: ")
    Defender_ID = input("Enter Defender ID: ")
    Result = input("Enter Result (e.g., 'Victory' or 'Defeat'): ")
    Trophy_Transaction = (input("Enter Trophy Transaction: "))
    Battle_Time = input("Enter Battle Time (in HH:MM:SS format): ")

    query = """
    INSERT INTO Players_Attack_Log (Attacker_ID, Defender_ID, Result, Trophy_Transaction, Battle_Time)
    VALUES (%s, %s, %s, %s, %s);
    """

    cursor.execute(query, (Attacker_ID, Defender_ID, Result, Trophy_Transaction, Battle_Time))

    query1 = """
    UPDATE Player
    SET Trophies = Trophies + %s
    WHERE PlayerID = %s;
    """

    query2 = """
    UPDATE Player
    SET Trophies = Trophies - %s
    WHERE PlayerID = %s;
    """

    cursor.execute(query1, (Trophy_Transaction,Attacker_ID))
    cursor.execute(query2, (Trophy_Transaction, Defender_ID))

 elif query_number == "13":
 
    print("")

    query = """
    DELETE FROM Clan
    WHERE NumberOfMembers = 0;
    """

    cursor.execute(query)

 elif query_number == "14":
  
    print("")
    troop = input("Enter Removed Troop Name: ")

    query = """
    DELETE FROM Troops
    WHERE Name = %s;
    """

    cursor.execute(query, troop)


 elif query_number == "15":
  
    print("")
    Town_Hall = input("Enter Town Hall to Analyze: ")

    query = """
    SELECT
        p.TownHallLevel,
        SEC_TO_TIME(AVG(TIME_TO_SEC(pa.Battle_Time))) AS AvgAttackTiming
    FROM
        Players_Attack_Log pa
    JOIN
        Player p ON pa.Attacker_ID = p.PlayerID
    WHERE
        p.TownHallLevel = %s
    GROUP BY
        p.TownHallLevel;
    """

    cursor.execute(query, Town_Hall)

    # Fetch the results of the query
    results = cursor.fetchall()

    # Process the results'
    table = PrettyTable()
    table.field_names = ["Town Hall Level", "Average Attack Time"]

    # Process the results
    for row in results:
        table.add_row(row)

    # Print the table
    print("\nOutput:\n")
    if len(results) != 0:
        print(table)
    else:
        print("No Match Found!")

 elif query_number == "16":
   
    print("")

    query_spell = """SELECT Spells.Name AS MostPopularSpell
        FROM Troops_Spells_Heroes_part_of_Army_composition
        LEFT JOIN Spells ON Troops_Spells_Heroes_part_of_Army_composition.SpellName = Spells.Name
        GROUP BY Spells.Name
        ORDER BY COUNT(*) DESC
        LIMIT 1;
    """

    cursor.execute(query_spell)

    # Fetch the results of the query
    results_spell = cursor.fetchall()

    # Process the results'
    table_spell = PrettyTable()
    table_spell.field_names = ["Spell"]

    # Process the results
    for row in results_spell:
        table_spell.add_row(row)

    # Print the table
    print("\nOutput (Most Popular Spell):\n")
    if len(results_spell) != 0:
        print(table_spell)
    else:
        print("No Match Found!")

    query_troop = """SELECT Troops.Name AS MostPopularTroop
        FROM Troops_Spells_Heroes_part_of_Army_composition
        LEFT JOIN Troops ON Troops_Spells_Heroes_part_of_Army_composition.TroopName = Troops.Name
        GROUP BY Troops.Name
        ORDER BY COUNT(*) DESC
        LIMIT 1;
    """

    cursor.execute(query_troop)

    # Fetch the results of the query
    results_troop = cursor.fetchall()

    # Process the results'
    table_troop = PrettyTable()
    table_troop.field_names = ["Troop"]

    # Process the results
    for row in results_troop:
        table_troop.add_row(row)

    # Print the table
    print("\nOutput (Most Popular Troop):\n")
    if len(results_troop) != 0:
        print(table_troop)
    else:
        print("No Match Found!")

    query_hero = """SELECT Heroes.Name AS MostPopularHero
        FROM Troops_Spells_Heroes_part_of_Army_composition
        LEFT JOIN Heroes ON Troops_Spells_Heroes_part_of_Army_composition.HeroName = Heroes.Name
        GROUP BY Heroes.Name
        ORDER BY COUNT(*) DESC
        LIMIT 1;
    """

    cursor.execute(query_hero)

    # Fetch the results of the query
    results_hero = cursor.fetchall()

    # Process the results'
    table_hero = PrettyTable()
    table_hero.field_names = ["Hero"]

    # Process the results
    for row in results_hero:
        table_hero.add_row(row)

    # Print the table
    print("\nOutput (Most Popular Hero):\n")
    if len(results_hero) != 0:
        print(table_hero)
    else:
        print("No Match Found!")


 conn.commit()


# Close the cursor and connection when done
cursor.close()
conn.close()
