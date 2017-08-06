namespace :grafana do
    terraform_discovery_cmd = 'terraform output -state=aws/terraform/terraform.tfstate docker_swarm_node'
    grafana_host = (ENV['AWS'] and `#{terraform_discovery_cmd}`.strip) || 'localhost'

    desc "Deploy datasource and dashboard"
    task :deploy do
        sh "curl 'http://admin:admin@#{grafana_host}:8083/api/datasources' -X POST -H 'Content-Type: application/json;charset=UTF-8' --data-binary @./grafana/prometheus.json"
        sh "curl -X POST 'http://admin:admin@#{grafana_host}:8083/api/dashboards/import' -H 'Content-Type: application/json' -d @./grafana/containers_dashboard.json"
        sh "curl -X POST 'http://admin:admin@#{grafana_host}:8083/api/dashboards/import' -H 'Content-Type: application/json' -d @./grafana/system_dashboard.json"
    end
end
