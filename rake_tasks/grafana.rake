namespace :grafana do
    grafana_host = ENV['GRAFANA_HOST'] || 'localhost'
    desc "Deploy datasource and dashboard"
    task :deploy do
        sh "curl 'http://admin:admin@#{grafana_host}:8083/api/datasources' -X POST -H 'Content-Type: application/json;charset=UTF-8' --data-binary @./grafana/prometheus.json"
        sh "curl -X POST 'http://admin:admin@#{grafana_host}:8083/api/dashboards/import' -H 'Content-Type: application/json' -d @./grafana/containers_dashboard.json"
        sh "curl -X POST 'http://admin:admin@#{grafana_host}:8083/api/dashboards/import' -H 'Content-Type: application/json' -d @./grafana/system_dashboard.json"
    end
end
