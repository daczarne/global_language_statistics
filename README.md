# Personal language statistics

![stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)

Builds a linguist-style plot of all languages used in your repositories. You can read more about the default linguist behavior [here](https://github.com/github/linguist). The program will skip repositories that you are not the owner of, and forked repositories. If you wish to use this project, you'll have to register your own GitHub PAT. After that create a file called `credentials.json` in the `data` directory with the following:

``` json
{
  "user_name": "your_github_user_name",
  "pat": "personal_access_token"
}
```
