# Database-levelup-bookClub
Login repo:
Jira: DB level-up: Book club 

Draw.io: https://app.diagrams.net/#HSamanthaVS-BBD%2FDatabase-levelup-bookClub%2Fmain%2FERD_BookClub.drawio 

Confluence: Database level-up: Book club 

Github repo: https://github.com/SamanthaVS-BBD/Database-levelup-bookClub/tree/main/bookClubConnect your Github account

How to set up Terraform, AWS and Flyway Setting Up AWS RDS, Terraform, SQL Server, and Flyway.pdf 

Overview
This document outlines the requirements and instructions for setting up the database for a book club management system. The system is designed to manage meetings among club members, record notes/thoughts about book topics, and store information about the books discussed.

Deployment Requirements
Database on AWS Cloud: Utilize any free tier relational database or SQL Server on AWS.

No Serverless Databases: Ensure non-serverless databases are used.

Infrastructure Deployment Scripted: Deploy AWS infrastructure using tools like Terraform, AWS CloudFormation, or AWS CDK.

Database Change Management: Utilize tools like Flyway or Liquibase for database deployment and changes.

Automated Deployment (CI/CD): Automate the deployment process using Continuous Integration/Continuous Deployment practices.

System Requirements
Table Population: Populate tables such as Members, Meetings, Books, Topics, etc., with relevant data.

Database Objects: Implement at least 1 view, 1 stored procedure, 1 scalar function, and 1 table-valued function with clear business use-cases. For example, a MonthlySummary to display notes from past meetings.

Normalization: Ensure the database design is normalized to efficiently manage club data.

Deliverables
Deployed Database: Database should be deployed on AWS.

Source Code: Git repository with access provided.

Database Design Documentation: Entity-Relationship Diagram (ERD) in source control using tools like draw.io.

Infrastructure as Code: Infrastructure scripts source controlled.

Database Change Management: Code for managing database changes source controlled.

CI/CD Pipeline: Continuous Integration/Continuous Deployment scripts source controlled.

Complete README: Instructions on setting up the database from scratch with links to relevant resources.

Project Progress Tracking: Utilize a JIRA board for tracking project progress.

Documentation: Confluence pages for detailed documentation.

Setup Instructions
1. Prerequisites:
AWS Account

Git installed.

You are using Visual Studio Code (VSCode).

You have created an IAM user on AWS that allows CLI access.

You have generated access keys and secret keys from AWS using the IAM.

2. Clone Repository:
git clone <repository-url>

3. Setting Up Terraform for AWS RDS:
Install Terraform from the official website.

Unzip Terraform to a local directory (e.g., C:\Terraform).

Edit the PATH variable to include the Terraform binary:

Search for "edit environment variable settings" in the search bar.

Open the system properties tab.

Click on the "Environment Variables" button at the bottom.

Double click on the PATH variable.

Add C:\Terraform to the PATH.

To check if Terraform is configured correctly by running terraform -version in the terminal.

Open your repository in VSCode and create a file called main.tf and a secrets.tfvars file. Add sensitive variables to secrets.tfvars to prevent them from being exposed over the internet such as.

Access key

Secrets key 

DB username 

DB password

Edit the Terraform configuration code for creating an RDS instance in main.tf to your credentials, and what you need.

Initializing and Applying Terraform Configuration:
Once done with setting up the main.tf script Initialize Terraform by running terraform init in the terminal.

Run terraform plan -var-file="secrets.tfvars" to check the Terraform configuration.

Apply the Terraform configuration using terraform apply -var-file="secrets.tfvars".

Setting Up SQL Server/ Access Database: 
Wait for the AWS RDS instance to be created after running terraform apply, as this may take some time.

Open Microsoft SQL Server Manager or any SQL client of your choice.

Connect to the SQL Server using the following credentials: 

Server name: Endpoint from AWS

Authentication: SQL Server Authentication

Login: Username created in secrets.tfvars

Password: Password created in secrets.tfvars

4. Setting Up Flyway for Database Migration:
Download Flyway from the official website.

Unzip Flyway to a local directory (e.g., C:\flyway-10.7.2).

Edit the PATH variable to include the Flyway binary:

Follow the same steps as for Terraform to edit the PATH variable.

Add C:\flyway-10.7.2 to the PATH.

Check if Flyway is configured correctly by running flyway --version in the terminal.

Open your repository in VSCode and edit the flyway.conf script with your credentials: 

flyway.url=

flyway.user=""

flyway.password=""

flyway.locations=

(Suggest using some sort of secrets manager such as GitHub secrets)

Navigate to the folder called migration and set this folder as your flyway.location. This folder contains the SQL scripts for Flyway to execute during deployment.

Each migration script must be named with the prefix V1__FileName, where the numbers dictate the order of execution. For example:

V1_1__TableCreation

V1_2__TableConstraints

V2_1__InsertBookData

V2_2__InsertMemberData

(Each prefix must be unique; you can't have two V1_1__FileName)

Remove USE [Database name] from Flyway migration scripts, as Flyway is already configured to your database in the flyway.url=.

Run flyway migrate in your terminal or set up a GitHub Action to automatically run flyway migrate when you push to the main branch.

5. Setting Up Flyway with GitHub actions
Once Flyway is set up in your repo, navigate to your repo on GitHub 

Select Actions

Then navigate to New Workflow.

Then select set up a workflow yourself 

Here you can name your workflow such as Flyway CI/CD

Create your Flyway GitHub action script here and commit the changes, to view the script click here.

Now when you push to main, flyway migrate should automatically trigger and the SQL scripts in the migration folder should deploy to your database.

6. Additional Configuration:
Update configuration files as needed.

7. Project Progress
Track project progress on the JIRA board provided.

Scalar rating calculation
This script set comprises two SQL files designed to perform specific tasks related to book ratings within the BookClub database.

 

V4_2__ScalarRatingCalculation.sql

Purpose: This file creates a scalar-valued function named `CalculateAverageRating`.

The function accepts a `BookID` as input and calculates the average rating of the book based on reviews stored in the `BookReviews` table.

It returns the calculated average rating as a decimal with precision of 3 digits and scale of 2 digits.

If there are no reviews for the specified book, it returns 0 as a default value.

 

Select.sql

Purpose: This file demonstrates the usage of the `CalculateAverageRating` function.

It selects and displays the average rating for a specific book (BookID = 1 in this example) using the `CalculateAverageRating` function.

The result is labeled as `AverageRatingForBook1`.

 

Note:

Before executing the `Select.sql` file, ensure that the `CalculateAverageRating` function has been created by executing the `V4_2__ScalarRatingCalculation.sql` script.

You may need to adjust the input parameter value (`BookID`) in the `Select.sql` file to match the ID of the book for which you want to retrieve the average rating.

 

Monthly Report View
 

This set of SQL files is designed to create and utilize a view named `MonthlySummary` within the BookClub database. The `MonthlySummary` view provides a comprehensive report of monthly meeting statistics.

 

V4_1__MonthlyReportView.sql

Purpose: This file creates or updates the `MonthlySummary` view with corrected logic for calculating meeting statistics.

It first checks if the `MonthlySummary` view already exists. If it does, it renames the existing view to a temporary name.

Next, it recreates the `MonthlySummary` view with corrected logic.

The view selects data from the `Meetings` and `Attendance` tables to calculate the total number of meetings (`TotalMeetings`) and total number of attendees (`TotalAttendees`) for each month and year.

It groups the results by year, month, and month name.

Finally, it drops the temporary view if it was renamed.

 

Select.sql

Purpose: This file demonstrates the usage of the `MonthlySummary` view.

It selects and displays all columns from the `MonthlySummary` view.

The result provides a comprehensive report of monthly meeting statistics, including the year, month name, total meetings, and total attendees.

 

Note:

Before executing the `Select.sql` file, ensure that the `MonthlySummary` view has been created or updated by executing the `V4_1__MonthlyReportView.sql` script.

You can customize the `Select.sql` file to perform additional analysis or filtering on the data retrieved from the `MonthlySummary` view.

 

Attendance Ranking TVF
 

This set of SQL files introduces a table-valued function (`GetMemberAttendanceRanking`) to rank members based on their meeting attendance for a given year within the BookClub database.

 

V4_4__AttendanceRankingTVF.sql

Purpose: This file creates a table-valued function named `GetMemberAttendanceRanking`.

The function accepts one input parameter, `@Year`, representing the year for which the attendance ranking is to be calculated.

It returns a table containing information about members' attendance, including their `MemberID`, `FirstName`, `LastName`, `MeetingsAttended`, and `AttendanceRank`.

The `AttendanceRank` column represents the rank of each member based on the number of meetings attended, with higher ranks assigned to members attending more meetings.

 

Select.sql

Purpose: This file demonstrates the usage of the `GetMemberAttendanceRanking` function.

It selects and displays all columns from the result of calling the `GetMemberAttendanceRanking` function with the parameter value set to 2023.

The result provides a table with information about members' attendance ranking for the year 2023.

 

Note:

Before executing the `Select.sql` file, ensure that the `GetMemberAttendanceRanking` function has been created by executing the `V4_4__AttendanceRankingTVF.sql` script.

You can customize the `Select.sql` file to filter or analyze the data retrieved from the `GetMemberAttendanceRanking` function further, such as by specifying a different year.

 

Procedure Insert Book Review
 

This procedure inserts a book into the table given the parameters:
@bookID
@rating
@memberID
@comment

which will be inserted into the BookReviews table within the respective columns:

BookID
Rating
MemberID
Comment

The procedure first checks:
-If the @BookID is not in the Books table.
-If the @memberID is not in the Members table
-If the rating is not between 1 and 5
-If there is already the @MemberID and @BookID in the same record within the BookReviews table (meaning the member has already reviewed this book)

If any of these checks are true, corresponding errors will be shown and then the procedure will terminate without inserting a book review.

Procedure Insert Book
 This procedure inserts a new book into the Books table given the following parameters:

 @book_title
@author_firstname
@author_lastname
@genre
@book_description

 The Books table has he following columns:

 Title
authorID
BookGenreID
BookDescription

 This procedure prevents the need to individually add an author and genre to their dedicated tables before adding the book.

 The procedure will insert the @author_firstname and @author_lastname into the Authors table if the author does not exist.
It will then insert the @genre into the Genres table if the genre does not exist.

 The procedure will get the last AuthorID and GenreID corresponding to the given @author_firstname, @author_lastname and the @genre and then store it into the variables:

 @variable_genreid
@variable_authorid

 At this point the @book_title, @variable_genreid, @variable_authorid and
@book_description will be inserted into the Books table as record within their corresponding columns.

This README provides an overview of the database setup for the book club management system. For any further assistance, please refer to the provided resources or contact the project supervisor.
