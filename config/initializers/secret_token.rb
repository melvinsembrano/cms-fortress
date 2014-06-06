# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
if defined?(Cms::Fortress::Application)
  Cms::Fortress::Application.config.secret_key_base = 'cbc6b791655e760b3088f30198289fdc9cc321c024d04b56b4f24ae65a53bb934002c7047e714af25d36be7d54db40e7965a298314f7f7d5f0bb72cc18db7080'
end
