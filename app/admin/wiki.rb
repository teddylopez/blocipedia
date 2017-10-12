ActiveAdmin.register Wiki do
  permit_params do
    params = [:user, :title, :body, :private]
  end

  index do
      column :id
      column :title
      column :private
      column :user
      column :created_at
      column :updated_at
      actions
  end

  form do |f|
    f.inputs "New Wiki" do
      f.input :user, :label => "User"
      f.input :title, :label => "Title"
      f.input :body, :label => "Body"
      f.input :private, :label => "Private"
      f.actions
    end
  end
end
