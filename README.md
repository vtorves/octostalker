# Octostalker
[![Build Status](https://travis-ci.org/arthurnn/octostalker.svg?branch=master)](https://travis-ci.org/arthurnn/octostalker)

http://octostalker.com/

An app to follow friends and organizations on GitHub

## How to run locally

Create a new [GitHub application](https://github.com/settings/applications/new) for test, you should use those urls:

- URL: `http://localhost:4567`
- Callback URL: `http://localhost:4567/auth/github/callback`

Create a `.env` file on the root of the project using the credentials from the app:

```
GITHUB_KEY=<Client ID>
GITHUB_SECRET=<Client Secret>
```

Run:
```bash
bundle install
foreman start -p 4567
```

open [http://localhost:4567](http://localhost:4567)

## Screenshots

![octostalker_640](https://f.cloud.github.com/assets/833383/1847298/cda51bb0-7642-11e3-9edc-b335f98785ef.gif)

## Credits

[@luanmuniz](https://github.com/luanmuniz) - For the frontend + design  
@jsncostello - For the octocat

