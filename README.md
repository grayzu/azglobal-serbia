# azglobal-serbia
This repo contains demos and presentation from Azure Global Serbia presentation, Terraform: First Class IaC in Azure.

## Overview
In this presentation I talk about IaC trends in the industry and Microsoft's commitment to ensuring that our customers have the best experience in Azure. A significant component of IaC for many customers is Terraform. Terraform integration with Azure is very good and will only get better as Microsoft, HashiCorp and the growing community continue invest in it. The remainder of the presentation focuses on a high level overview of using Terraform to provision to Azure including Terraform concepts such as state, variables, secrets, iterators, functions, etc.

## Slides
The slide deck can be found [here](terraform_in_azure.pptx).

## Demo Pre-Requisites
1. In order to start this demo, you will need to create a storage account and container. This container will be used by Terrraform to store its state.

2. You will need to have an existing user assigned identity named monitor-api. This identity will be assigned a role on the resource group.

## Demo 1
This demo introduces Terraform state and remote backends, specifically AzureRM backend.

### Branch
[demo1](https://github.com/grayzu/azglobal-serbia/tree/demo1)

## Demo 2
This demo builds on demo 1 by introducing the concept of resources and data sources a well as the concept of expressions and dependencies.

### Branch
[demo2](https://github.com/grayzu/azglobal-serbia/tree/demo2)

## Demo 3
The final demo jumps into the deep end and introduces real world concept such as variables, secrets, functions and a few different (count and dynamic blocks) iteration approaches.

### Branch
[demo3](https://github.com/grayzu/azglobal-serbia/tree/demo3)
