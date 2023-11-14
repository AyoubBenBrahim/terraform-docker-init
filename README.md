
🔻 terraform init

🔻 terraform apply -> yes

🔻 docker ps

🔻 terraform destroy

```
Error: Error pinging Docker server: Cannot connect to the Docker daemon at unix:///var/run/docker.sock. Is the docker daemon running?
│
│   with provider["registry.terraform.io/kreuzwerker/docker"],
│   on main.tf line 43, in provider "docker":
│   43: provider "docker" {}
```

docker context ls
```
provider "docker" {
    host = "unix:///Users/my_login/.docker/run/docker.sock"
}
```
`export TF_VAR_login="my_login"`

`host = "unix:///Users/${var.login}/.docker/run/docker.sock"`

```
Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

docker_container.nginx: Creating...
docker_container.nginx: Creation complete after 2s [id=c0009a892a9519151518a067ec0caf780e42d924cda137c038059b1c74fb92f5]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
```

```
➜  terraform docker ps
CONTAINER ID   IMAGE          COMMAND                  CREATED          STATUS          PORTS                    NAMES
c0009a892a95   nginx:latest   "/docker-entrypoint.…"   45 seconds ago   Up 43 seconds   0.0.0.0:8080->80/tcp     nginx_container
```

nginx runing at http://localhost:8080/

