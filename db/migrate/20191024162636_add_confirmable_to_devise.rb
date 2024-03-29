class AddConfirmableToDevise < ActiveRecord::Migration[5.2]
 # Note: You can't use change, as User.update_all will fail in the down migration
 def change
    change_table(:users) do |t|
    #t.string   :confirmation_token
    t.datetime :confirmed_at
    t.datetime :confirmation_sent_at
    t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
    #t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
    #t.string   :unlock_token # Only if unlock strategy is :email or :both
    #t.datetime :locked_at
    end
  end
end