#!/bin/bash

if command -v jq &> /dev/null
then
  ADMIN_SERVICE_URL="https://demo-admin-rehabilitation.wehost.asia/api/admin"

  # Get ongoing organization
  ORG=`curl -s "${ADMIN_SERVICE_URL}/get-ongoing-organization"`

  if [ ! -z "$ORG" ]
  then
    ORG_EMAIL=`jq -r '.admin_email' <<< $ORG`
    ORG_SUBDOMAIN=`jq -r '.sub_domain_name' <<< $ORG`

    # Deploy new organization
    ansible-playbook -l localhost -t build,deploy \
                    -e stage=demo \
                    -e git_branch=HI-SaaS \
                    -e org_name=$ORG_SUBDOMAIN \
                    -e org_email=$ORG_EMAIL \
                    -e org_domain=$ORG_SUBDOMAIN.wehost.asia \
                    -e keycloak_domain=https://demo-admin-rehabilitation.wehost.asia \
                    -e k8s_namespace=hiv \
                    -e k8s_config=~/.kube/config \
                    config/ansible/playbook.yaml -vv

  else
    echo "Nothing"
  fi
fi
