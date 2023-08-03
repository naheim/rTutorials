# Using PostgreSQL with R

## more coming soon ... 

[Install PostgreSQL on MacOS](https://www.postgresqltutorial.com/postgresql-getting-started/install-postgresql-macos/)

[Install PostgreSQL on Windows](https://www.postgresqltutorial.com/postgresql-getting-started/install-postgresql/)

[Download and install sample database](https://www.postgresqltutorial.com/postgresql-getting-started/postgresql-sample-database/)

#### Preparing references for entry into database using DOI

```` r
library('rcrossref')

x <- cr_works(c("10.1139/cjes-2023-0036","10.1016/j.tree.2020.09.001","10.1515/9781400874750"))

````