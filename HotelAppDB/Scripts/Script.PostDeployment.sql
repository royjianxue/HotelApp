﻿/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/
if NOT EXISTS (SELECT 1 from dbo.RoomTypes)
begin
    insert into dbo.RoomTypes(Title, Description, Price)
    values ('King Size Bed', 'A room with a king-size bed and a window.', 100),
    ('Two QUeen Size Beds', 'A room with two queen-size beds and a window.', 115),
    ('Executive Suite', 'Two rooms, each with a king- size bed and a window.', 205);
end

if NOT EXISTS (SELECT 1 from dbo.Rooms)
begin
        
    /*
     declare 3 values to reference to the room title,
     map to the room title in the roomtypes table prevent data loss.
     when room titles are deleted and recreated in the table, this will always reference to the title not the Id
    */

    declare @roomId1 int; 
    declare @roomId2 int; 
    declare @roomId3 int; 

    select @roomId1 = Id from dbo.RoomTypes where Title = 'King Size Bed';
    select @roomId2 = Id from dbo.RoomTypes where Title = 'Two QUeen Size Beds';
    select @roomId3 = Id from dbo.RoomTypes where Title = 'Executive Suite';


    insert into dbo.Rooms (RoomNumber, RoomTypeId)
    values('101', @roomId1),
    ('102', @roomId1),
    ('103', @roomId2),
    ('201', @roomId2),
    ('202', @roomId2),
    ('301', @roomId3);
end

