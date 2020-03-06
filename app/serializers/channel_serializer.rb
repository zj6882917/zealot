# frozen_string_literal: true

class ChannelSerializer < ApplicationSerializer
  attributes :slug, :name, :device_type, :bundle_id, :git_url, :has_password

  def has_password
    object.password.persent?
  end
end
