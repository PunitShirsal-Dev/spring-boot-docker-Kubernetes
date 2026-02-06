.PHONY: help deploy destroy status logs port-forward cleanup

# Variables
NAMESPACE = spring-boot-namespace
APP_NAME = spring-boot-app
POSTGRES_NAME = postgres

help:
	@echo "Available commands:"
	@echo "  make deploy          - Deploy entire application"
	@echo "  make destroy         - Destroy entire deployment"
	@echo "  make status          - Show deployment status"
	@echo "  make logs-app        - Show application logs"
	@echo "  make logs-db         - Show database logs"
	@echo "  make port-forward    - Port forward to application"
	@echo "  make cleanup         - Clean up unused resources"

deploy:
	@./deploy-all.sh

destroy:
	@./teardown.sh

status:
	@kubectl get all -n $(NAMESPACE)

logs-app:
	@kubectl logs -l app=$(APP_NAME) -n $(NAMESPACE) --tail=100 -f

logs-db:
	@kubectl logs -l app=$(POSTGRES_NAME) -n $(NAMESPACE) --tail=100 -f

port-forward:
	@kubectl port-forward svc/spring-boot-service 8080:80 -n $(NAMESPACE)

cleanup:
	@kubectl delete pods --field-selector=status.phase=Succeeded -n $(NAMESPACE)
	@kubectl delete pods --field-selector=status.phase=Failed -n $(NAMESPACE)
	@echo "Cleanup completed"