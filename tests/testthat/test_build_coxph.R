context("test build_coxph")

test_that("test build_coxph.fast", {
  df <- survival::lung # this data has NAs.
  df <- df %>% rename(`ti me`=time, `sta tus`=status, `a ge`=age)
  df <- df %>% mutate(ph.ecog = factor(ph.ecog, ordered=TRUE)) # test handling of ordered factor
  df <- df %>% mutate(sex = sex==1) # test handling of logical
  model_df <- df %>% build_coxph.fast(`ti me`, `sta tus`, `a ge`, sex, ph.ecog, ph.karno, pat.karno, meal.cal, wt.loss, predictor_n = 2)
  expect_equal(class(model_df$model[[1]]), c("coxph_exploratory","coxph"))
  ret <- model_df %>% broom::tidy(model)
  ret <- model_df %>% broom::glance(model, pretty.name=TRUE)
})

# Note: we used to have Japanese column name test, but removed since
# it was not a simple matter to make it work on Windows where we need to use
# SJIS. We test multibyte column names with other test suite.
