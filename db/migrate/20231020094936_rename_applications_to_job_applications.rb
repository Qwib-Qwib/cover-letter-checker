class RenameApplicationsToJobApplications < ActiveRecord::Migration[7.0]
  def change
    rename_table :applications, :job_applications
  end
end
