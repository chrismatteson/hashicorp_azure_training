#!/bin/bash
source terraform.tfvars
echo $groups
string2=${groups#"["}
string2=${string2%"]"}
echo $string2
echo ${string[1]}
#IFS=',' read -r -a array <<< $string2
array=($(echo $string2 | tr "," "\n"))
echo $array
echo ${array[1]}
for ((i = 0; i < ${#array[@]}; ++i))
do terraform import azurerm_resource_group.groups[$i] /subscriptions/4e84075e-2c45-48ba-a46a-b1345f9e74f2/resourceGroups/${array[$i]}
done
