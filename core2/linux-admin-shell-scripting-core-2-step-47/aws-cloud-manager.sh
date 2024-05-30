#!/bin/bash

# Environment variables
ENVIRONMENT=$1

check_num_of_args() {
# Checking the number of arguments
if [ "$#" -ne 0 ]; then
    echo "Usage: $0 <environment>"
    exit 1
fi
}

activate_infra_environment() {
# Acting based on the argument value
if [ "$ENVIRONMENT" == "local" ]; then
  echo "Running script for Local Environment..."
elif [ "$ENVIRONMENT" == "testing" ]; then
  echo "Running script for Testing Environment..."
elif [ "$ENVIRONMENT" == "production" ]; then
  echo "Running script for Production Environment..."
else
  echo "Invalid environment specified. Please use 'local', 'testing', or 'production'."
  exit 2
fi
}

# Function to check if AWS CLI is installed
check_aws_cli() {
    if ! command -v aws &> /dev/null; then
        echo "AWS CLI is not installed. Please install it before proceeding."
        return 1
    fi
}

# Function to check if AWS profile is set
check_aws_profile() {
    if [ -z "$AWS_PROFILE" ]; then
        echo "AWS profile environment variable is not set."
        return 1
    fi
}

# Function to create the group with name admin.
create_iam_group() {
aws iam create-group \
    --group-name "admin"
}

# Function to create iam users for five employees
create_iam_users() {
    # Define a company name as prefix
    company="datawise"
    # Array of employee names
    names=("John" "James" "Blessing" "Jenifer" "Uchechi")
    
    # Loop through the array and create iam users
    for name in "${names[@]}"; do
        employee_name="${company}-${name}"

        # Create iam users for five employees
        aws iam create-user --user-name "$employee_name"
        if [ $? -eq 0 ]; then
            echo "IAM user '$employee_name' created successfully."
        else
            echo "Failed to IAM user '$employe_name'."
        fi
    done
}

# Function to add users to the admin group
add_users_to_group() {
    # Define a company name as prefix
    company="datawise"
    # Array of employee names
    names=("John" "James" "Blessing" "Jenifer" "Uchechi")
    
    # Loop through the array and add users
    for name in "${names[@]}"; do
        employee_name="${company}-${name}"

        # add users to group
        aws iam add-user-to-group --user-name "$employee_name" --group-name admin
         if [ $? -eq 0 ]; then
            echo "IAM user '$employee_name' added successfully."
        else
            echo "Failed to add IAM user '$employe_name'."
        fi
    done
}

# Function to verify that the admin group contains the IAM users, use the get-group command.
verify_iam_users() {
aws iam get-group --group-name admin
}

# Function to attach aws-managed policy (AdministratorAccess) to admin group.
attach_policy_to_group() {
aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AdministratorAccess --group-name admin
}

check_num_of_args
activate_infra_environment
check_aws_cli
check_aws_profile
create_iam_group
create_iam_users
add_users_to_group
verify_iam_users
attach_policy_to_group