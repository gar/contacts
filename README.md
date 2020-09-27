# Named Contacts

Some customers may not be able to manage their own communication and they want to be able to assign a named contact person to handle their communication. This app allows you to store and update the named contact for a customer based on their case ID.

Privacy is at the core of this app and a full Audit Log is kept of access to the named contacts, while making sure that no PII is stored. Autentication happens via a JWT token in the request headers.


## Development

This is a Rails app using Postgresql as a database. Please ensure you have Ruby 2.7.1 and Postgresql 12.4 installed.

You should then be able to set up this project by running:

```sh
bundle install
bin/rails db:create
bin/rails db:migrate
```

Run the app by running `bin/rails server`

### Authentication in development

A user authenticates with the app through a valid JWT bearer token in the `Authorization` header of each request. In development, you can use a test JWT token and set the headers in the Postman app.

To bypass authentication in development, define an environment variable called `SKIP_AUTH`. For example, you will not have to authenticate if you start your devleopment server with this command:

```sh
SKIP_AUTH=true bin/rails server
```

## Deployment and production

This app is not yet in production, and there are a few things to consider before it is deployed.

This app contains PII, so European customers will require their data to remain in Europe. While providers like AWS allow you to create server instances in European data centers, you must make sure that no logging data etc. is sent outside of Europe. In addition, all communication with the server should be encrypted using TLS. A further precaution would be to make sure all data is encrypted at rest, possibly using an encrypted filesyste, and making sure all backups are also encrypted.

A simple first step for getting this into production would be to use Heroku. However, this is built on AWS so there may be GDPR concerns.

An alternative would be to create a Digital Ocean server using their Ruby on Rails template. This includes a full stack for Rails apps including nginx, SSL certs, postgres etc. Deployment could be configured with capistrano. You can also configure backups on Digital Ocean.

Next steps, if required, could be:

- Create a hardened server using Ansible or some other provisioning tool
- Restrict access to the service from a set of IPs using a firewall
- Have a replica database, allowing you to hot-swap a database in case of failure
- Create a docker image to deploy this into a cluster
