# frozen_string_literal: true

class AuthController < ApplicationController
  def sign_in
    @form = SignInForm.new
  end

  def do_sign_in
    @form = SignInForm.new(sign_in_params)

    if (pone = @form.perform)
      self.current_pone = pone

      redirect_to pone_path(pone.slug)
    else
      render 'sign_in'
    end
  end

private

  def sign_in_params
    params.require(:sign_in_form).permit(:name, :password)
  end
end
