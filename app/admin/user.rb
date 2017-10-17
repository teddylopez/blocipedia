ActiveAdmin.register User do
  permit_params :email, :password, :role, :admin

  index do
    column :email
    column :role
    column :admin
    column :created_at
    column :updated_at
    column :last_sign_in_at
    actions
  end

  form do |f|
    f.inputs "New User" do
      f.input :email, :label => "Email"
      f.input :password, :label => "Password"
      f.input :role, :label => "Role"
      f.actions
    end
  end
end
