Rails.application.config.middleware.use OmniAuth::Builder do
  #provider :twitter, 'CONSUMER_KEY', 'CONSUMER_SECRET'
  provider :facebook, '222424071230782', '902cce4522a3185b00a9bf7fa83f5334'
  #provider :linked_in, 'CONSUMER_KEY', 'CONSUMER_SECRET'
end