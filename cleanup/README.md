# Lab Cleanup

`Warning: This is a really hacky script which is more likely to blow away things you don't want than to do what you do want. Be really careful using this`

The purpose of this code is to enable easy deletion of resource groups in mass as Azure doesn't provide for this behavior by default. It's really really easy to break things doing this, so be very careful.

## Step 1:
Create list of resource groups:

`az login`
`az group list | jq .[].name | tr "\n" ","`

Copy output into groups variable of terraform.tfvars. MAKE SURE TO REMOVE ANY RESOURCE GROUPS YOU DO NOT WANT TO DELETE.

## Step 2:
Run `./script.sh`. This will loop through all of the resource groups specified in terraform.tfvars and import them into a terraform state file.

## Step 3:
Run `terraform destroy`. Double check the resource groups to be destroyed. If you're happy with the list, choose yes.
