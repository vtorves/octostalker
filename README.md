# Octostalker

http://octostalker.herokuapp.com/

An app to follow friends and organizations on github

## How to run locally

Create a new github app. [here](https://github.com/settings/applications/new)

Create a `.env` file on the root of the project:

```
GITHUB_KEY=<Client ID>
GITHUB_SECRET=<Client Secret>
```

Run:
```bash
bundle install
foreman start
```



