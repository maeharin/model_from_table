class <%= @resource.class_name %> < ActiveRecord::Base
<%- if @resource.table_name_required? -%>
  self.table_name = "<%= @resource.table_name %>"
<%- end -%>
<%- if @resource.primary_key_required? -%>
  self.primary_key = "<%= @resource.primary_key %>"
<%- end -%>
<%- @resource.belongs_to_syms.each do |sym| -%>
  belongs_to :<%= sym %>
<%- end -%>
end
