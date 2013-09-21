module RestPack::Group::Service
  class Tasks
    def self.load_tasks
      load "restpack_group_service/tasks/db.rake"
    end
  end
end
