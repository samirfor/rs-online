# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_rsonline_session',
  :secret      => '244d76d49915e626a21d7474adeefed44c20d4805cfadfbba278463c23ac51dbbe361002ee0720ec0269047e8706a8b6e700fb63521c4c2f599835370af42fe0'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
