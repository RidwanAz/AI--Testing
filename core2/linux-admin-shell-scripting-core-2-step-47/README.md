# CAPSTONE PROJECT : SHELL SCRIPT FOR AWS IAM MANAGEMENT

## Project Scenario

An organization Datawise solutions requires effective management of AWS Identity and Access Management (IAM) resourses. The company is expanding its team and needs to onboard five new employees to access AWS resources securely.

## Purpose

1. Script enhancement : To create more funtions that extends the functionality of "aws-cloud-manager.sh" script.

2. Define IAM UserNames Array : Stores the names of the five IAM users in an array for easy iteration during user creation.

3. Create IAM users : Iterate through the IAM use names array and create IAM users for each employee using AWS CLI command.

4. Create IAM Group : Define a function to create an IAM group named "admin" using AWS CLI.

5. Attachment of Administrative Policy to Group : Attach an AWS-managed administrativr policy (eg "AdministratorAccess") to the admin group to grant administrative privileges.

6. Assign Users to Group : Iterate through the array of IAM user names and assign each user to the "admin" group using AWS CLI commands.