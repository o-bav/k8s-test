# k8s-test
Для поднятия кластера K8S используются уже оттестированные модули

https://github.com/terraform-aws-modules/terraform-aws-vpc

https://github.com/terraform-aws-modules/terraform-aws-eks


Для деплоя APP

1. Создать namespace:

kubectl create namespace postgres


2. Применить манифесты:

kubectl apply -f postgres-pvc.yaml
kubectl apply -f postgres-deployment.yaml
kubectl apply -f postgres-service.yaml
kubectl apply -f backup-cronjob.yaml


3. Проверить статус:

kubectl get pods,svc,cronjobs,pvc -n postgres


📌 Проверка бекапов:
Запусти вручную, чтобы проверить немедленно:

kubectl create job --from=cronjob/postgres-backup manual-backup -n postgres


Посмотреть бекапы внутри контейнера:

kubectl exec -it deployment/postgres -n postgres -- ls /var/lib/postgresql/data
