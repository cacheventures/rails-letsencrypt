# frozen_string_literal: true

require_dependency 'lets_encrypt/application_controller'

module LetsEncrypt
  # :nodoc:
  class VerificationsController < ApplicationController
    def show
      return render_verification_string if certificate.present?

      render plain: 'Verification not found', status: :not_found
    end

    protected

    def render_verification_string
      render plain: certificate.verification_string
    end

    def certificate
      LetsEncrypt.certificate_model.find_by(verification_path: filename)
    end

    def filename
      ".well-known/acme-challenge/#{params[:verification_path]}"
    end
  end
end
