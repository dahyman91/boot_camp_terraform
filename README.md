## Prep

-- Open an AWS account and purchase a domain
-- Add credentials in the command line as environement variables for terraform to pick them up with the following commands
`export AWS_ACCESS_KEY_ID=<accessKeyId>`
`export AWS_SECRET_ACCESS_KEY=<sectretAccesKey>`
-- Run a build of your static site
-- Add that build folder (sometimes this has different naming conventions) to the root level of this repository.

## Deployment

-- Move into the terraform folder with `cd terraform`
-- Run `terraform init`
-- Run `terraform apply`
-- When prompted, add the domain, that you purchased, including the extension as a variable.

## Destroying all Resources

-- One of the benefits of terraform is that as easily as you create resources, you can also destroy them. To revert everything you've done, just run `terraform destroy` and once again enter the name of the domain you purchased.
