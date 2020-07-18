##### Сборка докер-образа #####
#Собрать докер-образ
docker build -t svkrivonos/hello-service:1.0 .

#Запустить контейнер
docker run --rm --name hello-service-nodejs -p 8000:8080 -d svkrivonos/hello-service:1.0

#Выложить в DockerHub
docker push svkrivonos/hello-service:1.0

#Докер-образ приложения на NodeJS расположен в DockerHub
https://hub.docker.com/repository/docker/svkrivonos/hello-service


##### Запуск докер-образа в Kubernetes #####
1. Создать отдельный namespace
kubectl apply -f namespace.yaml -n svkrivonos

2. Переключиться на новый namespace в текущем контексте (в этом случае не нужно в конце команды дописывать в каком namespace выполнить команду)
kubectl config set-context --current --namespace=svkrivonos

3. Создать Pod
kubectl apply -f pod.yaml -n svkrivonos

4. Проверить что сервис запустился (статус = Running)
kubectl get po hello-service -n svkrivonos

5. Пробрасываем порт, чтобы проверить что сервис работает
kubectl port-forward hello-service 8000:8080 -n svkrivonos

6. Выполняем запрос на сервис (в браузере, через curl, либо другими инструментами)
http://localhost:8000/health

7. Смотрим логи работы сервиса
kubectl logs hello-service -n svkrivonos
