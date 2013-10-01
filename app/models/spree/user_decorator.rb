Spree::User.class_eval do

  # For Refinery
  has_and_belongs_to_many :roles, :join_table => :spree_roles_users

  attr_accessible :roles_attributes, :roles
  has_many :plugins, :class_name => "Refinery::UserPlugin", :order => "position ASC", :dependent => :destroy

  attr_accessible :plugins_attributes, :plugins

  roles_table_name = Spree::Role.table_name
  scope :refinery_admin, lambda { includes(:roles).where("#{roles_table_name}.name" => "Refinery") }

  has_many :plugins, :class_name => "::Refinery::UserPlugin", :order => "position ASC", :dependent => :destroy

  def plugins=(plugin_names)
    if persisted? # don't add plugins when the user_id is nil.
      ::Refinery::UserPlugin.delete_all(:user_id => id)

      plugin_names.each_with_index do |plugin_name, index|
        plugins.create(:name => plugin_name, :position => index) if plugin_name.is_a?(String)
      end
    end
  end

  def authorized_plugins
    plugins.collect { |p| p.name } | ::Refinery::Plugins.always_allowed.names - ["refinery_users"]
  end

  def add_role(title)
    raise ArgumentException, "Role should be the title of the role not a role object." if title.is_a?(Spree::Role)
    roles << Spree::Role[title] unless has_role?(title)
  end

  def has_role?(title)
    title = title.to_s.camelize
    raise ArgumentException, "Role should be the title of the role not a role object." if title.is_a?(Spree::Role)
    if title == "Superuser"
      roles.detect{|r| r.title == "Refinery"}
    else
      roles.any?{|r| r.title == title}
    end
  end

  def can_edit?(user_to_edit = self)
    user_to_edit.persisted? && (
      user_to_edit == self ||
      self.has_role?(:superuser)
    )
  end

  def can_delete?(user_to_delete = self)
    user_to_delete.persisted? and
      id != user_to_delete.id and
      !user_to_delete.has_role?(:superuser) and
      Spree::Role[:refinery].users.count > 1
  end

  def title
    self.name
  end
end