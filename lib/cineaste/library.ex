defmodule Cineaste.Library do
  use Ash.Domain,
    otp_app: :cineaste

  resources do
    resource Cineaste.Library.Film
  end
end
