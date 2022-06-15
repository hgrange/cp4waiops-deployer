ansible-playbook ./00_aimanager-install-all.yaml -e env_id=test -e CP_ENTITLEMENT_KEY=eyJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJJQk0gTWFya2V0cGxxxxxxLx4m9EH-abvdc53DYEkbYY

ansible-playbook ./01_aimanager-install-demo-content.yaml

ansible-playbook ./03_eventmanager-install-all.yaml -e CP_ENTITLEMENT_KEY=eyJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJJQk0gTWFya2V0cGxhY2UiLCJxxxxxxxI3RmLx4m9EH-abvdc53DYEkbYY