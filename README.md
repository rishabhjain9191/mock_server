# Welcome to EchoServer

These days with microservices growing at such a large scale, so our dependencies on APIs of some other services.
It is not possible to wait till our dependencies are resolved.
Echo Server gives the capability to mock your apis and continue with your work without worrying about APIs not being implemented by other team.

# Current Capabilities

- Register an endpoint with specific Veb (GET | POST | PATCH | DELETE) and path(valid uri) with response body and response code
- Update preexisting end point
- Delete an endpoint
- See the list of currently registered endpoints
- ** Access the resgistered endpoints as per your definition while registering**

> **Note:** These APIs follows JSON:API v1 standard.

## Registering an endpoint

One can simple register an endpoint vi POST /endpoints. For example:

```
POST /endpoints HTTP/1.1
{
     "data": {
         "type": "endpoints",
         "attributes": {
             "verb": "GET",
             "path": "/hello",
             "response": {
                 "code": 201,
                 "headers": {
                     "max-age": 1000,
                 },
                 "body": "{ \"message\": \"Hello, world\" }\""
             }
         }
     }
 }
```

This will register a new endpoint `GET /hello` which would return `{ message: 'Hello World'}` with `max-age` header set to `1000`

**Please note:**

- Path should be a valid url. For more details, about valid uri, Please refer [RFC3986](https://datatracker.ietf.org/doc/html/rfc3986)

## Updating and Deleting an endpoint

- Update exactly similar to creating a new endpoint except:
  - Use PATCH request
  - append id in url. For Example: `/endpoints/123`
- Use `DELETE /endpoints/123`

# Setup

**Requirements**

- Make sure ruby and bundler is installed (v2.6.5)

**Steps**

- Clone the repository
- `bundle install` to install required dependencies
- `bin/rails db:migrate` to set up database
- `bin/rails server` to spun up the local server

Your server will start on `localhost:3000` by default.
