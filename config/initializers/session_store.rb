# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_relweather_session',
  :secret      => '3a9bf9f38ca74a83d9b19e0ecfe6493096b6fd9c80977d6a977edc6cac3a94c1aeaaff71ff93d62a660099d0cd21aaf0a15e99977cc1178d497f18fac1102b5a'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
