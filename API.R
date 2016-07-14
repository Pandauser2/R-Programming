library(httr)
library(httpuv)
library(jsonlite)
library(dplyr)

# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
github <- oauth_endpoints("github")
# 2. Register an application at https://github.com/settings/applications;
#    Use any URL you would like for the homepage URL (http://github.com is fine)
#    and http://localhost:1410 as the callback url
#
#    Insert your client ID and secret below - if secret is omitted, it will
#    look it up in the GITHUB_CONSUMER_SECRET environmental variable.
myapp <- oauth_app("github",key = "061a777424fdf6f91d07",secret = "24437ee2b4b31fa964f74b2872593da2da337125")


github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)



# 4. Use API

gtoken <- config(token = github_token)

req <- GET("https://api.github.com/users/jtleek/repos", gtoken)

stop_for_status(req)

content(req)

#JSON to Data Frame
json1 <- content(req)
json2 <- jsonlite::fromJSON(toJSON(json1))