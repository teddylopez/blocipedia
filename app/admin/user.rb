ActiveAdmin.register User do
  permit_params do
    params = [:email, :password]
  end

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
    f.inputs "New Admin User" do
      f.input :email, :label => "Email"
      f.input :password, :label => "Password"
      f.actions
    end
  end
end
