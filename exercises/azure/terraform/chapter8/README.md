### Chapter 8 - Exercise 1 - Destroy Workspace
* Add CONFIRM_DESTROY environment variable to your workspace.
* Either from the command line, or the GUI, destroy your workspace.

https://www.terraform.io/docs/enterprise/workspaces/settings.html#destruction-and-deletion

`HINT 1:  Do not click the red Destroy from Terraform Enterprise button. This will delete your entire workspace. Remember to confirm the destroy action from within the UI.`

### Chapter 8 - Exercise 2 - Create a New Sentinel
* Create new Sentinel policy calledrestrict_allowed_vm_types.
* Copy the following Sentinel code into your policy: restrict_allowed_vm_types.hcl
* Create a new policy set that applies to your workspace
* Add the restrict_allowed_vm_types policy you created in the previous step to your policy set.
* Run a new Terraform plan and apply and see the Sentinel results

https://www.terraform.io/docs/enterprise/sentinel/index.html
https://www.terraform.io/docs/enterprise/sentinel/manage-policies.html 
