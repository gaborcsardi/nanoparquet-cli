test_that("nanoparquet_cli_main", {
  expect_snapshot(error = TRUE, nanoparquet_cli_main("--help"))
  expect_snapshot(nanoparquet_cli_main("--version"))
  expect_snapshot(
    nanoparquet_cli_main(c(
      "info",
      test_path("fixtures/mtcars-arrow.parquet")
    ))
  )
  expect_snapshot(
    nanoparquet_cli_main(c(
      "schema",
      test_path("fixtures/mtcars-arrow.parquet")
    ))
  )
  expect_snapshot(
    nanoparquet_cli_main(c(
      "export",
      test_path("fixtures/mtcars-arrow.parquet")
    ))
  )
})

test_that("version", {
  expect_snapshot(version())
})

test_that("info", {
  expect_snapshot(info(list(
      "<parquet-file>" = test_path("fixtures/mtcars-arrow.parquet")
  )))
})

test_that("schema", {
  expect_snapshot(schema(list(
    "<parquet-file>" = test_path("fixtures/mtcars-arrow.parquet")
  )))
})

test_that("export", {
  expect_snapshot(export(list(
    "<parquet-file>" = test_path("fixtures/mtcars-arrow.parquet")
  )))

  tmp <- tempfile(fileext = ".csv")
  on.exit(unlink(tmp), add = TRUE)
  export(list(
    "<parquet-file>" = test_path("fixtures/mtcars-arrow.parquet"),
    "<csv-file>" = tmp
  ))
  expect_snapshot(writeLines(readLines(tmp)))
})
