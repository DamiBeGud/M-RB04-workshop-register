Rails.application.routes.draw do
 get '/health/live',to:'health#live'
 get '/health/ready',to:'health#ready'
post '/workshops',to:'workshops#create'
get '/workshops/:code',to:'workshops#show'
post '/workshops/:code/register',to:'workshops#register'
post '/workshops/:code/cancel',to:'workshops#cancel'
end
