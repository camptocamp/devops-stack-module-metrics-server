# Changelog

## [3.0.0](https://github.com/camptocamp/devops-stack-module-metrics-server/compare/v2.1.0...v3.0.0) (2024-10-09)


### ⚠ BREAKING CHANGES

* point the Argo CD provider to the new repository ([#7](https://github.com/camptocamp/devops-stack-module-metrics-server/issues/7))

### Features

* point the Argo CD provider to the new repository ([#7](https://github.com/camptocamp/devops-stack-module-metrics-server/issues/7)) ([ebbbeee](https://github.com/camptocamp/devops-stack-module-metrics-server/commit/ebbbeee351b55129a08359d37a9c3cccee6db834))

### Migrate provider source `oboukili` -> `argoproj-labs`

We've tested the procedure found [here](https://github.com/argoproj-labs/terraform-provider-argocd?tab=readme-ov-file#migrate-provider-source-oboukili---argoproj-labs) and we think the order of the steps is not exactly right. This is the procedure we recommend (**note that this should be run manually on your machine and not on a CI/CD workflow**):

1. First, make sure you are already using version 6.2.0 of the `oboukili/argocd` provider.

1. Then, check which modules you have that are using the `oboukili/argocd` provider.

```shell
$ terraform providers

Providers required by configuration:
.
├── provider[registry.terraform.io/hashicorp/helm] 2.15.0
├── (...)
└── provider[registry.terraform.io/oboukili/argocd] 6.2.0

Providers required by state:

    (...)

    provider[registry.terraform.io/oboukili/argocd]

    provider[registry.terraform.io/hashicorp/helm]
```

3. Afterwards, proceed to point **ALL*  the DevOps Stack modules to the versions that have changed the source on their respective requirements. In case you have other personal modules that also declare `oboukili/argocd` as a requirement, you will also need to update them.

4. Also update the required providers on your root module. If you've followed our examples, you should find that configuration on the `terraform.tf` file in the root folder.

5. Execute the migration  via `terraform state replace-provider`:

```bash
$ terraform state replace-provider registry.terraform.io/oboukili/argocd registry.terraform.io/argoproj-labs/argocd
Terraform will perform the following actions:

  ~ Updating provider:
    - registry.terraform.io/oboukili/argocd
    + registry.terraform.io/argoproj-labs/argocd

Changing 13 resources:

  module.argocd_bootstrap.argocd_project.devops_stack_applications
  module.secrets.module.secrets.argocd_application.this
  module.metrics-server.argocd_application.this
  module.efs.argocd_application.this
  module.loki-stack.module.loki-stack.argocd_application.this
  module.thanos.module.thanos.argocd_application.this
  module.cert-manager.module.cert-manager.argocd_application.this
  module.kube-prometheus-stack.module.kube-prometheus-stack.argocd_application.this
  module.argocd.argocd_application.this
  module.traefik.module.traefik.module.traefik.argocd_application.this
  module.ebs.argocd_application.this
  module.helloworld_apps.argocd_application.this
  module.helloworld_apps.argocd_project.this

Do you want to make these changes?
Only 'yes' will be accepted to continue.

Enter a value: yes

Successfully replaced provider for 13 resources.
```

6. Perform a `terraform init -upgrade` to upgrade your local `.terraform` folder.

7. Run a `terraform plan` or `terraform apply` and you should see that everything is OK and that no changes are necessary. 

## [2.1.0](https://github.com/camptocamp/devops-stack-module-metrics-server/compare/v2.0.0...v2.1.0) (2024-04-17)


### Features

* add variable to set resources with default values ([#5](https://github.com/camptocamp/devops-stack-module-metrics-server/issues/5)) ([5f9af83](https://github.com/camptocamp/devops-stack-module-metrics-server/commit/5f9af83ebcdb2b63951182554ef7713b995e4f42))

## [2.0.0](https://github.com/camptocamp/devops-stack-module-metrics-server/compare/v1.0.0...v2.0.0) (2024-01-19)


### ⚠ BREAKING CHANGES

* remove the ArgoCD namespace variable
* remove the namespace variable

### Bug Fixes

* hardcode the release name to remove the destination cluster ([e866cc4](https://github.com/camptocamp/devops-stack-module-metrics-server/commit/e866cc4fe1bd178dccfb01365129327598e5e757))
* remove the ArgoCD namespace variable ([3ec3782](https://github.com/camptocamp/devops-stack-module-metrics-server/commit/3ec37829ffb8b029dff0b391d973fc2e6544e2e2))
* remove the namespace variable ([e903aab](https://github.com/camptocamp/devops-stack-module-metrics-server/commit/e903aabcf7294fe58ebf223b8a9b1ac41ba8737e))

## 1.0.0 (2023-10-19)


### Features

* first implementation ([#1](https://github.com/camptocamp/devops-stack-module-metrics-server/issues/1)) ([ab8402e](https://github.com/camptocamp/devops-stack-module-metrics-server/commit/ab8402edab10d17297311cdc6dd1ea0f034e1db5))
