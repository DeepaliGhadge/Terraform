## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=0.12 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~>2.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~>3.0 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | ~>4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 2.99.0 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | 4.0.3 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_tfstateremote"></a> [tfstateremote](#module\_tfstateremote) | ./modules | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_availability_set.avset](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/availability_set) | resource |
| [azurerm_lb.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb) | resource |
| [azurerm_lb_backend_address_pool.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_backend_address_pool) | resource |
| [azurerm_lb_backend_address_pool_address.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_backend_address_pool_address) | resource |
| [azurerm_lb_nat_rule.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_nat_rule) | resource |
| [azurerm_lb_probe.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_probe) | resource |
| [azurerm_lb_rule.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_rule) | resource |
| [azurerm_managed_disk.test](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/managed_disk) | resource |
| [azurerm_managed_disk.test2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/managed_disk) | resource |
| [azurerm_network_interface.test2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_network_interface.tf-nic](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_network_interface_nat_rule_association.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface_nat_rule_association) | resource |
| [azurerm_network_security_group.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_network_security_group.example1](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_public_ip.test](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_resource_group.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_subnet.test1](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet.test2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet_network_security_group_association.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_subnet_network_security_group_association.example1](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_virtual_machine.test](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine) | resource |
| [azurerm_virtual_machine.test2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine) | resource |
| [azurerm_virtual_network.test](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |
| [tls_private_key.example_ssh](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_address_space"></a> [address\_space](#input\_address\_space) | Address space for virtual network. | `list` | <pre>[<br>  "10.0.0.0/16"<br>]</pre> | no |
| <a name="input_admin_password"></a> [admin\_password](#input\_admin\_password) | VM administrator password | `string` | `"Sela@123"` | no |
| <a name="input_admin_username"></a> [admin\_username](#input\_admin\_username) | VM administrator username | `string` | `"deepalig"` | no |
| <a name="input_app_vm_count"></a> [app\_vm\_count](#input\_app\_vm\_count) | vm count. | `string` | `"3"` | no |
| <a name="input_resource_group_location"></a> [resource\_group\_location](#input\_resource\_group\_location) | Location of the resource group. | `string` | `"Central India"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Resource Group name. | `string` | `"WTResourceGroup1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | n/a |
| <a name="output_vm_password"></a> [vm\_password](#output\_vm\_password) | VM administrator password |
| <a name="output_vm_username"></a> [vm\_username](#output\_vm\_username) | VM administrator username |
