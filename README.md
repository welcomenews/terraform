#### Download Terraform

```
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update && sudo apt-get install terraform
terraform -help
```

#### Installing Ansible on Ubuntu

```
$ sudo apt update
$ sudo apt install software-properties-common
$ sudo add-apt-repository --yes --update ppa:ansible/ansible
$ sudo apt install ansible
```

#### Installing Atom on Linux

```
wget -qO - https://packagecloud.io/AtomEditor/atom/gpgkey | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main" > /etc/apt/sources.list.d/atom.list'
sudo apt-get update
sudo apt-get install atom
```

#### Linter for Terraform

```
TFLint
https://github.com/terraform-linters/tflint
```
#### Satatic analizator

```
Chekov
https://github.com/bridgecrewio/checkov
```
#### Terraform docs  Автоматическая генерация документации
```
https://terraform-docs.io/
```
#### Интеграционные тесты 
```
TFTets
```
#### Деплоим Yandex Cloud с помощью Terraform и GitLab
```
https://cloud.yandex.ru/events/779?utm_source=mailing&utm_medium=email&utm_campaign=digest_march_ru_12_04_23&utm_content=B
```


