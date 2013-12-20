# Octostalker

http://octostalker.com/

An app to follow friends and organizations on github

## How to run locally

Create a new [GitHub application](https://github.com/settings/applications/new) for test, you should use those urls:

- URL: `http://localhost:4567`
- Callback URL: `http://localhost:4567/users/auth/github/callback`

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

## Credits

@luanmuniz - For the frontend help  
@jsncostello - For the octocat




[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/arthurnn/octostalker/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

