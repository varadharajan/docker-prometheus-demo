# docker-prometheus-demo

This is a sample project for a Docker Swarm - Prometheus - Grafana setup. This project hosts a sample wordpress application on Docker Swarm. The cluster itself is monitored with Prometheus, scraping data from cadvisor and node-exporter.

## Dependencies

This project has been tested on the below specifications:

* Docker 1.13.1
* Ruby 2.2.3 (RVM)
* Terraform 0.9.11+

## Setup (DevBox)

```bash
$ bundle install
$ bundle exec rake -T # To list all the targets
$ bundle exec rake env:up # To bring up the dev environment
$ # Visit the wordpress app at http://localhost:8000
$ bundle exec rake end:down # TO bring down the dev environment
```

To view the Grafana dashboard, we need to import the dashboards. Once the dev environment is up, follow the below commands

```bash
$ bundle exec rake grafana:deploy
$ # Visit the dashboard at http://localhost:8083 credentials : admin:admin
```

## Setup (AWS)

To provision AWS resources, we use Terraform. Follow the below commands to get a working AWS environment.

```bash
$ export AWS_ACCESS_KEY_ID=<access key>
$ export AWS_SECRET_ACCESS_KEY=<secret>
$ export AWS_DEFAULT_REGION=us-east-1
$ bundle exec rake aws:terraform:plan # Terraform plan for the env
$ bundle exec rake aws:terraform:apply # To bring up AWS env
$ AWS=1 bundle exec rake env:up # Deploy Docker services to AWS cluster
$ AWS=1 bundle exec rake grafana:deploy # Deploy Grafana Dashboard
$ # Visit the wordpress blog at http://<IP>:8000
$ # Visit the dashboard at http://<IP>:8083. credentials : admin:admin
$ AWS=1 bundle exec rake env:down # Bring down Docker services
$ bundle exec rake aws:terraform:destroy # To tear down AWS env
```

## Grafana dashboard

This project makes use of following open sourced dashboards:

* [Node monitoring](https://grafana.com/dashboards/22)
* [Container monitoring](https://grafana.com/dashboards/179)