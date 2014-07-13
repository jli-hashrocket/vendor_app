QB_KEY = "df3f8ad2b154fb4773b90eab1da9ea4df487"
QB_SECRET = "jRcCcIjSsgFOoowGhOHL72Hpvn7RSXWR26TzqXfG"

$qb_oauth_consumer = OAuth::Consumer.new(QB_KEY, QB_SECRET, {
  site: "https://oauth.intuit.com",
  request_token_path: "/oauth/v1//get_request_token",
  authorize_url: "https://appcenter.intuit.com/Connect/Begin",
  access_token_path: "/oauth/v1/get_access_token"
})
