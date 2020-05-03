# app/controllers/overrides/omniauth_callbacks_controller.rb
module Overrides
  class OmniauthCallbacksController < DeviseTokenAuth::OmniauthCallbacksController

    def get_resource_from_auth_hash
      # find or create user by provider and provider uid
      @resource = resource_class.where(
        uid: auth_hash['info']['email'],
        refresh_token: auth_hash['credentials']['refresh_token'],
        provider: auth_hash['provider']
      ).first_or_initialize

      if @resource.new_record?
        handle_new_resource
      end

      # sync user info with provider, update/generate auth token
      assign_provider_attrs(@resource, auth_hash)

      # assign any additional (whitelisted) attributes
      if assign_whitelisted_params?
        extra_params = whitelisted_params
        @resource.assign_attributes(extra_params) if extra_params
      end

      @resource
    end

    def assign_provider_attrs(user, auth_hash)
      all_attrs = auth_hash["info"].slice(*user.attributes.keys)
      orig_val = ActionController::Parameters.permit_all_parameters
      ActionController::Parameters.permit_all_parameters = true
      permitted_attrs = ActionController::Parameters.new(all_attrs)
      permitted_attrs.permit({})
      user.assign_attributes(permitted_attrs)
      ActionController::Parameters.permit_all_parameters = orig_val
      user.refresh_token = auth_hash['credentials']['refresh_token']
      # user.uid = user.email
      user
    end
  end
end
