namespace :env do
    desc 'Bootstrap environment'
    task :up do
        # Initialize Docker swarm
        sh 'docker swarm init || echo "Swarm already up and running"'

        # Deploy registry and prometheus stack
        sh "docker stack deploy --compose-file registry/stack.yml registry"
        sh "docker build -t #{ENV['REGISTRY']||'localhost:5000'}/prometheus prometheus"
        sh "docker stack deploy --compose-file prometheus/stack.yml prometheus"

        # Deploy wordpress application
        sh "docker stack deploy --compose-file blog/stack.yml blog"
    end

    desc 'Shutdown environment'
    task :down do
        sh "docker stack rm blog"
        sh "docker stack rm prometheus"
        sh "docker stack rm registry"
    end

    desc 'Reprovision environment'
    task :reup do
        Rake::Task["env:down"].invoke
        Rake::Task["env:up"].invoke
    end
end