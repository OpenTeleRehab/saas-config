## Status: Actively Maintained 🚀
This project is actively maintained. Contributions, issues, and discussions are welcome!

## License  
This project is open-source and licensed under the Apache License 2.0. See the [LICENSE](./LICENSE) file for details.

# Prerequisite
1. Deploy keycloak realm and get authenticate key
2. Deploy rocketchat and get token
3. Deploy services (admin, therapist, patient, krakend)
4. Deploy webapp (admin-webapp, therapist-webapp)

## Ansible
   - python3
   - python3-pip
   - pip install docker-compose
   - pip install pymysql

# Configuration Rocket.Chat
New version rocket not allow create admin user you need create difference name for administrator account

    My Account -> Security -> Disable 2FA
    My Account -> Personal Access Token -> Generate new token "Tick ignore 2FA"
    Administrator -> Permission -> Edit Message -> Tick "User"
    Administrator -> Permission -> Delete Direct Messages > Tick "Owner, User"
    Administrator -> General -> REST API -> Select Enable CORE

# Install JQ (JSON processor)
    sudo apt-get update
    sudo apt-get install jq

# Deploy Web Essentials server with Kubernetes

    ansible-playbook -l localhost -t build,deploy \
                    -e stage=demo \
                    -e git_branch=master \
                    -e org_name=webessentials \
                    -e org_email=devops@web-essentials.co \
                    -e org_domain=webessentials.wehost.asia \
                    -e keycloak_domain=https://demo-admin-rehabilitation.wehost.asia \
                    -e k8s_namespace=hiv \
                    -e k8s_config=~/.kube/config \
                    config/ansible/playbook.yaml -vv

# Deploy to Hi AWS server with docker

    ansible-playbook -l live -t build \
                    -e stage=live \
                    -e git_branch=master \
                    -e base_image=wehostasia/nginx-php:7.4 \
                    -e org_name=webessentials \
                    -e org_email=devops@opentelerehab.com \
                    -e org_domain=webessentials.opentelerehab.com \
                    -e keycloak_domain=https://admin.opentelerehab.com \
                    config/ansible/playbook.yaml -vv


# Manual helm
    helm-we upgrade --install --recreate-pods admin-webessentials-webapp --set image.service=admin --set image.stage=demo --set image.org_name=webessentials --set ingress.hosts[0].host=admin-webessentials.wehost.asia,ingress.hosts[0].paths[0].path=/,ingress.hosts[0].paths[0].pathType=ImplementationSpecific --set image.tag=f2dd648 charts/webapp --create-namespace --namespace hiv

