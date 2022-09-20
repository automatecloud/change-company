# change-company
Change the Company Name for a user email inside Lacework
## Requirements
You need to have the Lacework CLI installed and configured with your environment.
configure the variable LW_PROFILE with your profile configured in the lacework cli. By default it uses the profile default.
## What it does?
The current script updates a company name for a user account email.

You need to run it with the parameters email and new company name:
Usage: ./changecompany.sh test.user@company.com MyCompany

If you want to specify a company name with spaces you need to quote the second parameter:
Usage: ./changecompany.sh test.user@company.com "My Test Company"
## Updates
