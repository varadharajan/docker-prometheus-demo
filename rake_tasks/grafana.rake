namespace :grafana do
    desc "Deploy datasource and dashboard"
    task :deploy do
        sh 'curl "http://admin:admin@localhost:8083/api/datasources" -X POST -H "Content-Type: application/json;charset=UTF-8" --data-binary \'{"name":"Prometheus","type":"prometheus","url":"http://prometheus:9090","access":"proxy","isDefault":true}\''
        sh 'curl -X POST "http://admin:admin@localhost:8083/api/dashboards/import" -H "Content-Type: application/json" -d @./grafana/dashboard.json'
    end
end
