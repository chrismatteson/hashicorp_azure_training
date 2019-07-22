# HashiCorp Azure Training Instructor Setup
This branch is for setting up the user accounts for each student.

## Process
First authenticate run az login in this directory and authenticate to your @hashicorptraining.onmicrosoft.com account.

Navigate into Terraform folder

Create a terraform.tfvars file for the class of the format:

users = ["student1", "student2", ...]

Run Terraform Plan and Apply

Distribute usernames and passwords to students to use.
