# AIDE ServerComp
![release version](https://img.shields.io/badge/release%20version-3.3.9.0-blue)

This is the server component of AIDE. This includes the database, scheduled tasks and miscellaneous components that reside on the server.

## Technology Stack
- MS SQL Server
- Windows 10 Pro

## Folder Structure

- All SQL scripts are in the 'src' folder. 
- The PS script to install is the 'installdb.ps1'
- The version is on the 'version.reg' file.
- All required scripts for full install is in the 'src\full' folder.  Any changes that will affect the full install should go here.
- The 'src\delta' folder contains all the changes after the full install.
- The 'src\delta\all' folder should be applied to all.
- The 'src\delta\account' folder are specific to the account or department.
- All modifications to tables , functions, stored procedures , and functions that needs to be applied as a service pack and does not require a full install goes into this folder.  Note that if the change is a large one and affects the full install, full install scripts at 'src\full' must also be updated.

#### NOTE
Be careful when adding data in the repo. <span style='color:red'>Personal information must not be included.</span>

The base code is from AIDE v3.3.2
