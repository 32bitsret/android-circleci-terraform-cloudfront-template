## Setup Auto Update Site for Android APK

## Requirements
Make sure your [update-changelog.json](update-changelog.json) is in the root directory

## Files to Ignore
Copy from [.gitignore](.gitignore) lines starting from "# Local .terraform directories" and add to your gitignore

## Setup CI/CD with CircleCI
1. Copy .circleci directory into your projects
2. Tell CircleCI which branch to upload to S3. Change main to whatever in [.circleci/config.yml](.circleci/config.yml)
```yml
filters:
    branches:
        only:
            - main
```

## Allocate your infrastructure with Terraform. 
1. Copy all *.tf into your project
2. Change from the default apkupdate-template in [variable.tf](variable.tf) for both app and subdomain
3. Then in [main.tf](main.tf), update apkupdate-template-deployment in the following
```yml
terraform {
  cloud {
    organization = "LogicalAddressLtd"
    workspaces {
      name = "apkupdate-template"
    }
  }
}
```