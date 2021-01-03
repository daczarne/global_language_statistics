# Global language statistics

![stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)

Builds a plot of all used languages by a given GitHub user. The plot displays percentage of code (as linguist does) and the number of repos in which each language has been used. If you wish to use this project, you'll have to register your own GitHub PAT. After that create a file called `credentials.json` in the `data` directory with the following:

``` json
{
  "user_name": "the_github_user_name",
  "pat": "personal_access_token"
}
```
