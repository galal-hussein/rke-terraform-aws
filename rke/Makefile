MODULE := $(shell basename $$PWD)

.PHONY: init get plan plan-destroy plan-output apply

state-pull:
	@terraform remote pull

init:
	@terraform init

get:
	@terraform get

plan: get
	@terraform plan -var-file ../main-vars.tfvars -var-file ./$(MODULE).tfvars

plan-output: get
	@terraform plan -var-file ../main-vars.tfvars -var-file ./$(MODULE).tfvars -out $(MODULE).plan

plan-destroy: get
	@terraform plan -var-file ../main-vars.tfvars -var-file ./$(MODULE).tfvars -destroy -out $(MODULE)-destroy.plan

apply: get
	@terraform apply -var-file ../main-vars.tfvars -var-file ./$(MODULE).tfvars

apply-plan:
	@terraform apply $(PLAN)

clean:
	@rm *.plan
