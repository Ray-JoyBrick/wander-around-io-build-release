```sh
# first do an init to pull down plugins
docker run -it --rm -v "$(pwd)/.terrform":/.terraform/ -v "$(pwd)"/terraform:/terraform hashicorp/terraform:light init /terraform/before-setup

# then do a plan out to a file
docker run -it --rm -v "$(pwd)/.terrform":/.terraform/ -v "$(pwd)"/terraform:/terraform hashicorp/terraform:light plan -out /terraform/before-setup/main.plan /terraform/before-setup

# apply the plan
docker run -it --rm -v "$(pwd)/.terrform":/.terraform/ -v "$(pwd)"/terraform:/terraform hashicorp/terraform:light apply -state /terraform/before-setup/main.tfstate /terraform/before-setup/main.plan

# lastly destroy everything
docker run -it --rm -v "$(pwd)/.terrform":/.terraform/ -v "$(pwd)"/terraform:/terraform hashicorp/terraform:light destroy -auto-approve -state /terraform/before-setup/main.tfstate /terraform/before-setup
```


```sh
# first do an init to pull down plugins
docker run -it --rm -v "$(pwd)/.terrform":/.terraform/ -v "$(pwd)"/terraform:/terraform hashicorp/terraform:light init /terraform/setup

# then do a plan out to a file
docker run -it --rm -v "$(pwd)/.terrform":/.terraform/ -v "$(pwd)"/terraform:/terraform hashicorp/terraform:light plan -out /terraform/setup/main.plan /terraform/setup

# apply the plan
docker run -it --rm -v "$(pwd)/.terrform":/.terraform/ -v "$(pwd)"/terraform:/terraform hashicorp/terraform:light apply -state /terraform/setup/main.tfstate /terraform/setup/main.plan

# lastly destroy everything
docker run -it --rm -v "$(pwd)/.terrform":/.terraform/ -v "$(pwd)"/terraform:/terraform hashicorp/terraform:light destroy -auto-approve -state /terraform/setup/main.tfstate /terraform/setup
```
