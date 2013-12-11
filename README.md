# Octostalker

http://octostalker.com/

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
foreman start -p 4567
```

open [http://localhost:4567](http://localhost:4567)

## Credits

@luanmuniz - For the frontend help  
@jsncostello - For the octocat




[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/arthurnn/octostalker/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

