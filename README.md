# OctoFollow

An app to follow friends and organizations on github

The app is not live yet, still waiting for a good design

## How to run locally

Create a new github app. [here](https://github.com/settings/applications/new)

Create a `.env` file on the root of the project, and the apps keys:

```
GITHUB_KEY=<Client ID>
GITHUB_SECRET=<Client Secret>
```

Run:
```bash
bundle install
foreman start
```



