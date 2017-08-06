namespace :aws do
    namespace :terraform do
        desc "Terraform plan"
        task :plan do
            Dir.chdir('aws/terraform') do
                sh 'terraform plan -var-file=config.tfvars'
            end
        end

        desc "Terraform Apply"
        task :apply do
            Dir.chdir('aws/terraform') do
                sh 'terraform apply -var-file=config.tfvars'
            end
        end

        desc "Terraform Destroy"
        task :destroy do
            Dir.chdir('aws/terraform') do
                sh 'terraform destroy -var-file=config.tfvars'
            end
        end
    end
end