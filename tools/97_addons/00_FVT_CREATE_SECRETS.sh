echo "*****************************************************************************************************************************"
echo " ✅ STARTING: CREATE SECRETS"
echo "*****************************************************************************************************************************"
echo ""
echo ""


echo "------------------------------------------------------------------------------------------------------------------------------"
echo " 🧻 Delete existing Secrets"
oc delete secret ibm-aiops-pull-secret -n cp4waiops
oc delete secret ibm-aiops-pull-secret -n cp4waiops
oc delete secret ibm-aiops-pull-secret -n cp4waiops-evtmgr
oc delete secret ibm-aiops-pull-secret -n cp4waiops-evtmgr
oc delete secret ibm-aiops-pull-secret -n openshift-marketplace
oc delete secret ibm-aiops-pull-secret -n openshift-marketplace
oc delete secret ibm-aiops-pull-secret -n openshift-operators
oc delete secret ibm-aiops-pull-secret -n openshift-operators
echo ""
echo ""



echo "------------------------------------------------------------------------------------------------------------------------------"
echo " 🚀 Creating Namespaces"
oc create ns cp4waiops
oc create ns cp4waiops-evtmgr
echo ""
echo ""



echo "------------------------------------------------------------------------------------------------------------------------------"
echo " 📥 Set Logins"
export DOCKER_USER=your_docker_username
export DOCKER_PWD=your_docker_password

# The pull token for cp.icr.com from https://myibm.ibm.com/products-services/containerlibrary
export ICR_TOKEN=your_IBM_PULL_TOKEN

export ARTIFACTORY_USER=yourIBMeMail
export ARTIFACTORY_TOKEN=changeme
echo ""
echo ""



echo "------------------------------------------------------------------------------------------------------------------------------"
echo " 🔐 Create Pull Secret File"
oc get secret/pull-secret -n openshift-config -oyaml > pull-secret-backup.yaml
oc get secret/pull-secret -n openshift-config --template='{{index .data ".dockerconfigjson" | base64decode}}' > temp-pull-secret.yaml
oc registry login --registry="docker.io" --auth-basic="$DOCKER_USER:$DOCKER_PWD" --to=temp-pull-secret.yaml
oc registry login --registry="hyc-katamari-cicd-team-docker-local.artifactory.swg-devops.com" --auth-basic="$ARTIFACTORY_USER:$ARTIFACTORY_TOKEN" --to=temp-pull-secret.yaml
oc registry login --registry="cp.icr.io" --auth-basic="cp:$ICR_TOKEN" --to=temp-pull-secret.yaml
oc registry login --registry="cp.stg.icr.io" --auth-basic="cp:$ICR_TOKEN" --to=temp-pull-secret.yaml
oc set data secret/pull-secret -n openshift-config --from-file=.dockerconfigjson=temp-pull-secret.yaml

oc get secret/pull-secret -n openshift-config --template='{{index .data ".dockerconfigjson" | base64decode}}' > temp-ibm-aiops-pull-secret.yaml
echo ""
echo ""



echo "------------------------------------------------------------------------------------------------------------------------------"
echo " 🚀 Creating Pull Secrets"
oc create secret generic ibm-aiops-pull-secret -n cp4waiops --type=kubernetes.io/dockerconfigjson --from-file=.dockerconfigjson=temp-ibm-aiops-pull-secret.yaml
oc create secret generic ibm-aiops-pull-secret -n cp4waiops-evtmgr --type=kubernetes.io/dockerconfigjson --from-file=.dockerconfigjson=temp-ibm-aiops-pull-secret.yaml
oc create secret generic ibm-aiops-pull-secret -n openshift-marketplace --type=kubernetes.io/dockerconfigjson --from-file=.dockerconfigjson=temp-ibm-aiops-pull-secret.yaml
oc create secret generic ibm-aiops-pull-secret -n openshift-operators --type=kubernetes.io/dockerconfigjson --from-file=.dockerconfigjson=temp-ibm-aiops-pull-secret.yaml

oc create secret generic ibm-aiops-pull-secret -n cp4waiops --type=kubernetes.io/dockerconfigjson --from-file=.dockerconfigjson=temp-ibm-aiops-pull-secret.yaml
oc create secret generic ibm-aiops-pull-secret -n cp4waiops-evtmgr --type=kubernetes.io/dockerconfigjson --from-file=.dockerconfigjson=temp-ibm-aiops-pull-secret.yaml
oc create secret generic ibm-aiops-pull-secret -n openshift-marketplace --type=kubernetes.io/dockerconfigjson --from-file=.dockerconfigjson=temp-ibm-aiops-pull-secret.yaml
oc create secret generic ibm-aiops-pull-secret -n openshift-operators --type=kubernetes.io/dockerconfigjson --from-file=.dockerconfigjson=temp-ibm-aiops-pull-secret.yaml
echo ""
echo ""

echo "*****************************************************************************************************************************"
echo " ✅ DONE"
echo "*****************************************************************************************************************************"




exit 1


# Then run
ansible-playbook ./ansible/99_test.yaml  -e CP_ENTITLEMENT_KEY=$ICR_TOKEN


# If you get pull errors execute this
kubectl patch -n openshift-marketplace serviceaccount default -p '{"imagePullSecrets": [{"name": "ibm-aiops-pull-secret"}]}'
kubectl patch -n openshift-marketplace serviceaccount ibm-operator-catalog -p '{"imagePullSecrets": [{"name": "ibm-aiops-pull-secret"}]}'
oc delete pod $(oc get po -n openshift-marketplace|grep ImagePull|awk '{print$1}') -n openshift-marketplace


kubectl patch -n cp4waiops serviceaccount aiops-insights-ui -p '{"imagePullSecrets": [{"name": "ibm-aiops-pull-secret"}]}'

