# Application security policy
Use this guide to setup NSX-T security policy for applications.

## Software Requirements for Windows:
* Git for Windows
    * https://git-scm.com/download/win
* GitHub Desktop
    * https://desktop.github.com/
* Terraform
    * https://www.terraform.io/
* MS Visual Studio Code
    * https://code.visualstudio.com/download
* AWS CLI
    * https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html

## How to run:
* Install Terraform.

### Move template files on local machine
* Copy: ./Applications/templates/secret.auto.tfvars.template > ./Applications/secret.auto.tfvars
```bash
# secret.auto.tfvars
admin_username = "adm-firstlast@domain.com"
admin_password = "xxxxxxxxxxxxxxxxxxxxxxx"
```
* Copy: ./Applications/templates/credentials.template > ~/.aws/credentials
```ini
[default]
#Update with your AWS key and secret
aws_access_key_id=XXXXXXXXXXXXXXXXXXXX
aws_secret_access_key=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
```

### Prepare to run
```bash
# Run the following from:
TF-NSX-T/Applications/<PROJECT NAME>$

# Make sure that terraform is setup
terraform init

# If needed (MAC) ulimit adjustment for too many open files
ulimit -n 1024
```

### Deploy application
```bash
terraform plan -var-file="../terraform.tfvars" -var-file="../secret.auto.tfvars"
terraform plan -var-file="../terraform.tfvars" -var-file="../secret.auto.tfvars"
# You may have to apply more than once to verify the network is complete
# If there are issues E.G. Error:  Failed to read NAT Rule <ID>: Client '<User>' exceeded request rate of 100 per second (code 102)
# -parallelism=5
```

---

# Create a new project
* Copy existing folder
```bash
cp -r App_FTP-Server App_MyNewApp
```
* Update backend.tf
```bash
# ./Applications/<PROJECT NAME>/backend.tf
key = "app_<MyNewApp>/terraform.tfstate"
```
* Build groups, policy, services, etc.


# Applicaiton order
AKA sequence number. This is also how applications should be deployed. There are some instances that reference usually object groups from the back end. E.G. app-activedirectory is referenced in multiple projects.

#### Infrastructure
1. Multicast
2. Services-Internal
3. Services-External
4. Management - RDP access
5. Cisco ISE / FirePower
6. WSUS
7. SecretServer
8. Monitoring
9. Arctic Wolf
10. Backup
11. vSphere
12. -

#### Environment
1. RDP
2. IGEL
3. Bistrack
4. VoIP
5. Sharepoint
6. Email
7. File Print
8. BusinessIntelligence
9. FTP
10. DB
11. NSX-T Load Balancer
13. Horizon
19. Outbound
20. Drop

#### Application
1. Bistrack
2. VoIP
3. Sharepoint
4. Email
5. FilePrint
6. BusinessIntelligence
7. Horizon
8. -
9. FTP
10. DB
19. Outbound
20. Drop
