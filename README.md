# Global language statistics

![stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)

![github repo size](https://img.shields.io/github/repo-size/daczarne/global_language_statistics)
![github code size](https://img.shields.io/github/languages/code-size/daczarne/global_language_statistics)

![github languages](https://img.shields.io/github/languages/count/daczarne/global_language_statistics)
![top language](https://img.shields.io/github/languages/top/daczarne/global_language_statistics)

Builds a plot of all used languages by a given GitHub user. The plot displays percentaje of code (as linguist does) and the number of repos in which the language has been used. If you wish to use this project, you'll have to register your own GitHub App and PAT. After that create a script called `credentials.R` y the `data` directory with the following:

``` r
credentials <- tibble::tibble(
   user_name = "your_user_name",
   app_name = "name_of_your_registered_app",
   pat = "your_pat",
   key = "your_app_client_id",
   secret = "your_app_cliente_secret"
)
```
