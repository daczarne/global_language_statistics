#====================#
#### ANALYZE DATA ####
#====================#


`%>%` <- magrittr::`%>%`

source(
   file = here::here("assets", "language_colors.R"),
   encoding = "UTF-8",
   local = TRUE
)

languages <- readr::read_csv(
   file = here::here("data", "languages.csv")
)


# Analyze data ------------------------------------------------------------


lang_percents <- languages %>%
   dplyr::group_by(
      language
   ) %>%
   dplyr::summarise(
      size = base::sum(size, na.rm = TRUE),
      repos = dplyr::n_distinct(repo_name, na.rm = TRUE),
      .groups = "drop"
   ) %>%
   dplyr::transmute(
      language,
      size,
      prop_size = size / base::sum(size, na.rm = TRUE),
      repos,
      prop_repos = repos / dplyr::n_distinct(languages[["repo_name"]], na.rm = TRUE),
   ) %>%
   dplyr::mutate(
      language = forcats::as_factor(language)
   )


# Define plot sizes
plot_columns <- 3L
plot_rows <- base::ceiling(base::dim(lang_percents)[1L] / plot_columns)


# Build x_axis
x_axis <- base::c()

for (i in 1L:plot_columns) {

   x_axis <- base::c(x_axis, base::rep(i, plot_rows))

}

x_axis <- x_axis[1L:base::dim(lang_percents)[1L]]


# Build y_axis
y_axis = base::c()

for (i in 1L:plot_rows) {

   y_axis <- base::c(y_axis, plot_rows:1L)

}

y_axis <- y_axis[1L:base::dim(lang_percents)[1L]]


# Build plot
languages_plot <- lang_percents %>%
   dplyr::arrange(
      dplyr::desc(prop_size)
   ) %>%
   dplyr::mutate(
      lang_label = dplyr::case_when(
         base::round(prop_size * 100L, 2L) < 0.01 ~ glue::glue("{language} (<0.01%)"),
         TRUE ~ glue::glue("{language} ({formattable::percent(prop_size)})")
      )
   ) %>%
   dplyr::left_join(
      language_colors,
      by = "language"
   ) %>%
   ggplot2::ggplot(
      ggplot2::aes(
         x = x_axis,
         y = y_axis
      )
   ) +
   ggplot2::geom_point(
      ggplot2::aes(
         color = base::I(color)
      ),
      size = 3L
   ) +
   ggplot2::geom_text(
      ggplot2::aes(
         label = lang_label,
         hjust = "left"
      ),
      color = "#f0f6fc",
      nudge_x = 0.05
   ) +
   ggplot2::labs(
      x = NULL,
      y = NULL
   ) +
   ggplot2::xlim(
      base::min(x_axis),
      base::max(x_axis) + 0.6
   ) +
   ggplot2::ylim(
      base::min(y_axis) - 0.3,
      base::max(y_axis) + 0.3
   ) +
   ggplot2::theme_void() +
   ggplot2::theme(
      axis.text = ggplot2::element_blank(),
      axis.ticks = ggplot2::element_blank(),
      plot.margin = ggplot2::margin(
         t = 0, r = 0, b = 0, l = 0, unit = "pt"
      ),
      plot.background = ggplot2::element_rect(
         fill = "#181a1f"
      )
   )

ggplot2::ggsave(
   filename = here::here("analysis", "language_distribution.png"),
   plot = languages_plot
)
