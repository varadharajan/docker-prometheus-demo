namespace :dev do
    STACK_NAME = 'docker-prometheus-demo'

    desc 'Bootstrap dev environment'
    task :up do
        sh 'docker swarm init || echo "Swarm already up and running"'
        sh "docker stack deploy --compose-file stack.yml #{STACK_NAME}"
    end

    desc 'Shutdown dev environment'
    task :down do
        sh "docker stack rm #{STACK_NAME}"
    end
end