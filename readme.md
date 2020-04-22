# AIDE DBComp

This is the database component of AIDE

## Technology Stack
- MS SQL Server

## Folder Structure

- All SQL scripts are in the 'src' folder
- All required scripts for full install is in the 'src\full' folder.  Any changes that will affect the full install should go here.
- All data are in the 'src\data' folder. All required data during full install are in 'src\data\required_data' folder. Account specific data are in 'src\data\account_data' folder.
- All modifications to tables , functions, stored procedures , and functions that needs to be applied as a service pack and does not require a full install goes into this folder.  Note that if the change is a large one and affects the full install, full install scripts at 'src\full' must also be updated.

#### NOTE
Be careful when adding data in the repo. <span style='color:red'>Personal information must not be included.</span>