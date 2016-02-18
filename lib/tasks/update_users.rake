desc "Update users github data"
task :update_all_users do
  UpdateUsers.new.update
end
