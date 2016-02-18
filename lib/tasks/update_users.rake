desc "Update users github data"
task :update_all_users => :environment do
  UpdateUsers.new.update
end
