Задача
Задание №1

Цель задания

Установить Ansible и использовать его для запуска ReactJS-приложения на сервере, запущенном при помощи Terraform.

Что нужно сделать

1. Зарегистрируйте аккаунт в AWS, активируйте бесплатный доступ и получите 300 долларов на счёт. 
2. Установите AWS CLI любой версии и сконфигурируйте его для управления аккаунтом и ресурсами. 
3. Перейдите в настройки, на панели навигации выберите Key Pairs и загрузите свой SSH-ключ, его имя будет использоваться в Terraform-скрипте.
4. Скачайте и установите Terraform.
5. Установите Ansible.
6. Возьмите код из репозитория.
7. Перейдите в папку OneServer/TerraformOneServer и инициализируйте ресурсы при помощи Terraform.
8. Добавьте IP-адрес полученного сервера в инвентори-файл.
9. Добавьте Environment переменную REACT_APP_WEBSITE_PREFIX=”FirstName SecondName” глобально или в блоке Yarn Build.
10. Добавьте свой репозиторий в файле reactjs.yaml в блоке переменных vars.
11. Запустите плейбук ansible-playbook -b reactjs.yaml -vv.
12. После запуска плейбука убедитесь, что приложение ReactJS доступно из браузера.

Что оценивается

Запущенный инстанс при помощи Terraform.
Запущенный сайт помощи Ansible.
На сайте в заголовке браузера есть хедер из ваших имени и фамилии.


Как отправить задание на проверку

Пришлите скриншот и ссылку на сайт через форму для сдачи домашней работы. Не забудьте удалить созданные ресурсы после того, как у вас приняли ДЗ, при помощи terraform destroy -auto-approve.


https://cloud.yandex.ru/docs/network-load-balancer/operations/load-balancer-create

https://terraform-eap.website.yandexcloud.net/docs/providers/yandex/index.html

https://cloud.yandex.ru/docs/cli/quickstart

https://registry.tfpla.net/providers/yandex-cloud/yandex/latest/docs

https://cloud.yandex.ru/docs/tutorials/infrastructure-management/terraform-quickstart

https://cloud.yandex.ru/docs/compute/operations/vm-create/create-linux-vm

https://github.com/glavk/terraform-yandex-compute/blob/master/main.tf

https://www.dmosk.ru/instruktions.php?object=terraform


