# nanoparquet_cli_main

    Code
      nanoparquet_cli_main("--help")
    Output
      Usage:
        nanoparquet ( --help | --version )
        nanoparquet info <parquet-file>
        nanoparquet schema <parquet-file>
        nanoparquet export <parquet-file> [ <csv-file> ]
      
      Commands:
        info    Show information about a Parquet file.
        schema  Show the schema of tha Parquet file.
        export  Export a Parquet file to a CSV file.
      
      Arguments:
        <parquet-file>  Parquet file.
        <csv-file>      CSV file. Uses standard output if missing.
      
      Options:
        --help     Print this help message.
        --version  Print nanoparquet version. 
    Condition

---

    Code
      nanoparquet_cli_main("--version")
    Message
      nanoparquet 0.3.1.9000

---

    Code
      nanoparquet_cli_main(c("info", test_path("fixtures/mtcars-arrow.parquet")))
    Output
      file_name: fixtures/mtcars-arrow.parquet
      num_cols: 13
      num_rows: 32
      num_row_groups: 1
      file_size: 7237
      parquet_version: 2
      created_by: parquet-cpp-arrow version 15.0.1

---

    Code
      nanoparquet_cli_main(c("schema", test_path("fixtures/mtcars-arrow.parquet")))
    Output
      # A data frame: 14 x 12
         file_name                     name   r_type    type       type_length repetition_type converted_type logical_type num_children scale precision field_id
         <chr>                         <chr>  <chr>     <chr>            <int> <chr>           <chr>          <I<list>>           <int> <int>     <int>    <int>
       1 fixtures/mtcars-arrow.parquet schema <NA>      <NA>                NA REQUIRED        <NA>           <NULL>                 13    NA        NA       NA
       2 fixtures/mtcars-arrow.parquet name   character BYTE_ARRAY          NA OPTIONAL        UTF8           <STRING>               NA    NA        NA       NA
       3 fixtures/mtcars-arrow.parquet mpg    double    DOUBLE              NA OPTIONAL        <NA>           <NULL>                 NA    NA        NA       NA
       4 fixtures/mtcars-arrow.parquet cyl    double    DOUBLE              NA OPTIONAL        <NA>           <NULL>                 NA    NA        NA       NA
       5 fixtures/mtcars-arrow.parquet disp   double    DOUBLE              NA OPTIONAL        <NA>           <NULL>                 NA    NA        NA       NA
       6 fixtures/mtcars-arrow.parquet hp     double    DOUBLE              NA OPTIONAL        <NA>           <NULL>                 NA    NA        NA       NA
       7 fixtures/mtcars-arrow.parquet drat   double    DOUBLE              NA OPTIONAL        <NA>           <NULL>                 NA    NA        NA       NA
       8 fixtures/mtcars-arrow.parquet wt     double    DOUBLE              NA OPTIONAL        <NA>           <NULL>                 NA    NA        NA       NA
       9 fixtures/mtcars-arrow.parquet qsec   double    DOUBLE              NA OPTIONAL        <NA>           <NULL>                 NA    NA        NA       NA
      10 fixtures/mtcars-arrow.parquet vs     double    DOUBLE              NA OPTIONAL        <NA>           <NULL>                 NA    NA        NA       NA
      11 fixtures/mtcars-arrow.parquet am     double    DOUBLE              NA OPTIONAL        <NA>           <NULL>                 NA    NA        NA       NA
      12 fixtures/mtcars-arrow.parquet gear   double    DOUBLE              NA OPTIONAL        <NA>           <NULL>                 NA    NA        NA       NA
      13 fixtures/mtcars-arrow.parquet carb   factor    DOUBLE              NA OPTIONAL        <NA>           <NULL>                 NA    NA        NA       NA
      14 fixtures/mtcars-arrow.parquet fac    character BYTE_ARRAY          NA OPTIONAL        UTF8           <STRING>               NA    NA        NA       NA

---

    Code
      nanoparquet_cli_main(c("export", test_path("fixtures/mtcars-arrow.parquet")))
    Output
      "name","mpg","cyl","disp","hp","drat","wt","qsec","vs","am","gear","carb","fac"
      "Mazda RX4",21,6,160,110,3.9,2.62,16.46,0,1,4,4,"a"
      "Mazda RX4 Wag",21,6,160,110,3.9,2.875,17.02,0,1,4,4,"a"
      "Datsun 710",22.8,4,108,93,3.85,2.32,18.61,1,1,4,1,"a"
      "Hornet 4 Drive",21.4,6,258,110,3.08,3.215,19.44,1,0,3,1,"b"
      "Hornet Sportabout",18.7,8,360,175,3.15,3.44,17.02,0,0,3,2,"c"
      "Valiant",18.1,6,225,105,2.76,3.46,20.22,1,0,3,1,"e"
      "Duster 360",14.3,8,360,245,3.21,3.57,15.84,0,0,3,4,"e"
      "Merc 240D",24.4,4,146.7,62,3.69,3.19,20,1,0,4,2,"c"
      "Merc 230",22.8,4,140.8,95,3.92,3.15,22.9,1,0,4,2,"a"
      "Merc 280",19.2,6,167.6,123,3.92,3.44,18.3,1,0,4,4,"e"
      "Merc 280C",17.8,6,167.6,123,3.92,3.44,18.9,1,0,4,4,"b"
      "Merc 450SE",16.4,8,275.8,180,3.07,4.07,17.4,0,0,3,3,"e"
      "Merc 450SL",17.3,8,275.8,180,3.07,3.73,17.6,0,0,3,3,"c"
      "Merc 450SLC",15.2,8,275.8,180,3.07,3.78,18,0,0,3,3,"b"
      "Cadillac Fleetwood",10.4,8,472,205,2.93,5.25,17.98,0,0,3,4,"b"
      "Lincoln Continental",10.4,8,460,215,3,5.424,17.82,0,0,3,4,"e"
      "Chrysler Imperial",14.7,8,440,230,3.23,5.345,17.42,0,0,3,4,"e"
      "Fiat 128",32.4,4,78.7,66,4.08,2.2,19.47,1,1,4,1,"c"
      "Honda Civic",30.4,4,75.7,52,4.93,1.615,18.52,1,1,4,2,"d"
      "Toyota Corolla",33.9,4,71.1,65,4.22,1.835,19.9,1,1,4,1,"a"
      "Toyota Corona",21.5,4,120.1,97,3.7,2.465,20.01,1,0,3,1,"d"
      "Dodge Challenger",15.5,8,318,150,2.76,3.52,16.87,0,0,3,2,"e"
      "AMC Javelin",15.2,8,304,150,3.15,3.435,17.3,0,0,3,2,"b"
      "Camaro Z28",13.3,8,350,245,3.73,3.84,15.41,0,0,3,4,"c"
      "Pontiac Firebird",19.2,8,400,175,3.08,3.845,17.05,0,0,3,2,"c"
      "Fiat X1-9",27.3,4,79,66,4.08,1.935,18.9,1,1,4,1,"a"
      "Porsche 914-2",26,4,120.3,91,4.43,2.14,16.7,0,1,5,2,"c"
      "Lotus Europa",30.4,4,95.1,113,3.77,1.513,16.9,1,1,5,2,"c"
      "Ford Pantera L",15.8,8,351,264,4.22,3.17,14.5,0,1,5,4,"d"
      "Ferrari Dino",19.7,6,145,175,3.62,2.77,15.5,0,1,5,6,"c"
      "Maserati Bora",15,8,301,335,3.54,3.57,14.6,0,1,5,8,"a"
      "Volvo 142E",21.4,4,121,109,4.11,2.78,18.6,1,1,4,2,"e"

# version

    Code
      version()
    Message
      nanoparquet 0.3.1.9000

# info

    Code
      info(list(`<parquet-file>` = test_path("fixtures/mtcars-arrow.parquet")))
    Output
      file_name: fixtures/mtcars-arrow.parquet
      num_cols: 13
      num_rows: 32
      num_row_groups: 1
      file_size: 7237
      parquet_version: 2
      created_by: parquet-cpp-arrow version 15.0.1

# schema

    Code
      schema(list(`<parquet-file>` = test_path("fixtures/mtcars-arrow.parquet")))
    Output
      # A data frame: 14 x 12
         file_name                     name   r_type    type       type_length repetition_type converted_type logical_type num_children scale precision field_id
         <chr>                         <chr>  <chr>     <chr>            <int> <chr>           <chr>          <I<list>>           <int> <int>     <int>    <int>
       1 fixtures/mtcars-arrow.parquet schema <NA>      <NA>                NA REQUIRED        <NA>           <NULL>                 13    NA        NA       NA
       2 fixtures/mtcars-arrow.parquet name   character BYTE_ARRAY          NA OPTIONAL        UTF8           <STRING>               NA    NA        NA       NA
       3 fixtures/mtcars-arrow.parquet mpg    double    DOUBLE              NA OPTIONAL        <NA>           <NULL>                 NA    NA        NA       NA
       4 fixtures/mtcars-arrow.parquet cyl    double    DOUBLE              NA OPTIONAL        <NA>           <NULL>                 NA    NA        NA       NA
       5 fixtures/mtcars-arrow.parquet disp   double    DOUBLE              NA OPTIONAL        <NA>           <NULL>                 NA    NA        NA       NA
       6 fixtures/mtcars-arrow.parquet hp     double    DOUBLE              NA OPTIONAL        <NA>           <NULL>                 NA    NA        NA       NA
       7 fixtures/mtcars-arrow.parquet drat   double    DOUBLE              NA OPTIONAL        <NA>           <NULL>                 NA    NA        NA       NA
       8 fixtures/mtcars-arrow.parquet wt     double    DOUBLE              NA OPTIONAL        <NA>           <NULL>                 NA    NA        NA       NA
       9 fixtures/mtcars-arrow.parquet qsec   double    DOUBLE              NA OPTIONAL        <NA>           <NULL>                 NA    NA        NA       NA
      10 fixtures/mtcars-arrow.parquet vs     double    DOUBLE              NA OPTIONAL        <NA>           <NULL>                 NA    NA        NA       NA
      11 fixtures/mtcars-arrow.parquet am     double    DOUBLE              NA OPTIONAL        <NA>           <NULL>                 NA    NA        NA       NA
      12 fixtures/mtcars-arrow.parquet gear   double    DOUBLE              NA OPTIONAL        <NA>           <NULL>                 NA    NA        NA       NA
      13 fixtures/mtcars-arrow.parquet carb   factor    DOUBLE              NA OPTIONAL        <NA>           <NULL>                 NA    NA        NA       NA
      14 fixtures/mtcars-arrow.parquet fac    character BYTE_ARRAY          NA OPTIONAL        UTF8           <STRING>               NA    NA        NA       NA

# export

    Code
      export(list(`<parquet-file>` = test_path("fixtures/mtcars-arrow.parquet")))
    Output
      "name","mpg","cyl","disp","hp","drat","wt","qsec","vs","am","gear","carb","fac"
      "Mazda RX4",21,6,160,110,3.9,2.62,16.46,0,1,4,4,"a"
      "Mazda RX4 Wag",21,6,160,110,3.9,2.875,17.02,0,1,4,4,"a"
      "Datsun 710",22.8,4,108,93,3.85,2.32,18.61,1,1,4,1,"a"
      "Hornet 4 Drive",21.4,6,258,110,3.08,3.215,19.44,1,0,3,1,"b"
      "Hornet Sportabout",18.7,8,360,175,3.15,3.44,17.02,0,0,3,2,"c"
      "Valiant",18.1,6,225,105,2.76,3.46,20.22,1,0,3,1,"e"
      "Duster 360",14.3,8,360,245,3.21,3.57,15.84,0,0,3,4,"e"
      "Merc 240D",24.4,4,146.7,62,3.69,3.19,20,1,0,4,2,"c"
      "Merc 230",22.8,4,140.8,95,3.92,3.15,22.9,1,0,4,2,"a"
      "Merc 280",19.2,6,167.6,123,3.92,3.44,18.3,1,0,4,4,"e"
      "Merc 280C",17.8,6,167.6,123,3.92,3.44,18.9,1,0,4,4,"b"
      "Merc 450SE",16.4,8,275.8,180,3.07,4.07,17.4,0,0,3,3,"e"
      "Merc 450SL",17.3,8,275.8,180,3.07,3.73,17.6,0,0,3,3,"c"
      "Merc 450SLC",15.2,8,275.8,180,3.07,3.78,18,0,0,3,3,"b"
      "Cadillac Fleetwood",10.4,8,472,205,2.93,5.25,17.98,0,0,3,4,"b"
      "Lincoln Continental",10.4,8,460,215,3,5.424,17.82,0,0,3,4,"e"
      "Chrysler Imperial",14.7,8,440,230,3.23,5.345,17.42,0,0,3,4,"e"
      "Fiat 128",32.4,4,78.7,66,4.08,2.2,19.47,1,1,4,1,"c"
      "Honda Civic",30.4,4,75.7,52,4.93,1.615,18.52,1,1,4,2,"d"
      "Toyota Corolla",33.9,4,71.1,65,4.22,1.835,19.9,1,1,4,1,"a"
      "Toyota Corona",21.5,4,120.1,97,3.7,2.465,20.01,1,0,3,1,"d"
      "Dodge Challenger",15.5,8,318,150,2.76,3.52,16.87,0,0,3,2,"e"
      "AMC Javelin",15.2,8,304,150,3.15,3.435,17.3,0,0,3,2,"b"
      "Camaro Z28",13.3,8,350,245,3.73,3.84,15.41,0,0,3,4,"c"
      "Pontiac Firebird",19.2,8,400,175,3.08,3.845,17.05,0,0,3,2,"c"
      "Fiat X1-9",27.3,4,79,66,4.08,1.935,18.9,1,1,4,1,"a"
      "Porsche 914-2",26,4,120.3,91,4.43,2.14,16.7,0,1,5,2,"c"
      "Lotus Europa",30.4,4,95.1,113,3.77,1.513,16.9,1,1,5,2,"c"
      "Ford Pantera L",15.8,8,351,264,4.22,3.17,14.5,0,1,5,4,"d"
      "Ferrari Dino",19.7,6,145,175,3.62,2.77,15.5,0,1,5,6,"c"
      "Maserati Bora",15,8,301,335,3.54,3.57,14.6,0,1,5,8,"a"
      "Volvo 142E",21.4,4,121,109,4.11,2.78,18.6,1,1,4,2,"e"

---

    Code
      writeLines(readLines(tmp))
    Output
      "name","mpg","cyl","disp","hp","drat","wt","qsec","vs","am","gear","carb","fac"
      "Mazda RX4",21,6,160,110,3.9,2.62,16.46,0,1,4,4,"a"
      "Mazda RX4 Wag",21,6,160,110,3.9,2.875,17.02,0,1,4,4,"a"
      "Datsun 710",22.8,4,108,93,3.85,2.32,18.61,1,1,4,1,"a"
      "Hornet 4 Drive",21.4,6,258,110,3.08,3.215,19.44,1,0,3,1,"b"
      "Hornet Sportabout",18.7,8,360,175,3.15,3.44,17.02,0,0,3,2,"c"
      "Valiant",18.1,6,225,105,2.76,3.46,20.22,1,0,3,1,"e"
      "Duster 360",14.3,8,360,245,3.21,3.57,15.84,0,0,3,4,"e"
      "Merc 240D",24.4,4,146.7,62,3.69,3.19,20,1,0,4,2,"c"
      "Merc 230",22.8,4,140.8,95,3.92,3.15,22.9,1,0,4,2,"a"
      "Merc 280",19.2,6,167.6,123,3.92,3.44,18.3,1,0,4,4,"e"
      "Merc 280C",17.8,6,167.6,123,3.92,3.44,18.9,1,0,4,4,"b"
      "Merc 450SE",16.4,8,275.8,180,3.07,4.07,17.4,0,0,3,3,"e"
      "Merc 450SL",17.3,8,275.8,180,3.07,3.73,17.6,0,0,3,3,"c"
      "Merc 450SLC",15.2,8,275.8,180,3.07,3.78,18,0,0,3,3,"b"
      "Cadillac Fleetwood",10.4,8,472,205,2.93,5.25,17.98,0,0,3,4,"b"
      "Lincoln Continental",10.4,8,460,215,3,5.424,17.82,0,0,3,4,"e"
      "Chrysler Imperial",14.7,8,440,230,3.23,5.345,17.42,0,0,3,4,"e"
      "Fiat 128",32.4,4,78.7,66,4.08,2.2,19.47,1,1,4,1,"c"
      "Honda Civic",30.4,4,75.7,52,4.93,1.615,18.52,1,1,4,2,"d"
      "Toyota Corolla",33.9,4,71.1,65,4.22,1.835,19.9,1,1,4,1,"a"
      "Toyota Corona",21.5,4,120.1,97,3.7,2.465,20.01,1,0,3,1,"d"
      "Dodge Challenger",15.5,8,318,150,2.76,3.52,16.87,0,0,3,2,"e"
      "AMC Javelin",15.2,8,304,150,3.15,3.435,17.3,0,0,3,2,"b"
      "Camaro Z28",13.3,8,350,245,3.73,3.84,15.41,0,0,3,4,"c"
      "Pontiac Firebird",19.2,8,400,175,3.08,3.845,17.05,0,0,3,2,"c"
      "Fiat X1-9",27.3,4,79,66,4.08,1.935,18.9,1,1,4,1,"a"
      "Porsche 914-2",26,4,120.3,91,4.43,2.14,16.7,0,1,5,2,"c"
      "Lotus Europa",30.4,4,95.1,113,3.77,1.513,16.9,1,1,5,2,"c"
      "Ford Pantera L",15.8,8,351,264,4.22,3.17,14.5,0,1,5,4,"d"
      "Ferrari Dino",19.7,6,145,175,3.62,2.77,15.5,0,1,5,6,"c"
      "Maserati Bora",15,8,301,335,3.54,3.57,14.6,0,1,5,8,"a"
      "Volvo 142E",21.4,4,121,109,4.11,2.78,18.6,1,1,4,2,"e"

# dq

    Code
      dq(letters[1:5])
    Output
      [1] "\"a\"" "\"b\"" "\"c\"" "\"d\"" "\"e\""

