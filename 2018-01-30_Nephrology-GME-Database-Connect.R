
# Connect to ASN Nephrology GME Database ----------------------------------


# 1. Load Packages --------------------------------------------------------

  require(tidyverse)
  require(RMySQL)
  require(DBI)     
  require(glue)
  require(skimr)
  require(stringr)
  require(fuzzyjoin)
  require(extrafont)
  require(tidyverse)
  require(scales)
  loadfonts(quiet=TRUE)


# 2. Database Review Function  ---------------------------------------------

    setGeneric(
    "dbDescribeTable",
    function(conn, name, ...)
      standardGeneric("dbDescribeTable"),
    valueClass = "character"
  )
  
  
  setMethod(
    "dbDescribeTable",
    signature(conn="MySQLConnection", name="character"),
    def = function(conn, name, ...){
      rs <- dbGetQuery(conn, paste("describe", name))
      fields <- rs$Type
      names(fields) <- rs$Field
      if(length(fields)==0)
        fields <- character()
      fields
    },
    valueClass = "character"
  )
  
  ## Sample Usage
  dbDescribeTable(con, "program")
  

# 3. Connect with ASN Nephrology GME Database -----------------------------

  
  con <- dbConnect(RMySQL::MySQL(), host = "www.asn-interactive.org", 
              username = "kpivert", password = "T1m1stNdB", 
              dbname ="nephrology_gme") ## WORKS!
  on.exit(dbDisconnect(con)) # Great function to close the connection 
  ## upon ending R Session
  

# 4. Pull Table  ----------------------------------------------------------

  dbDescribeTable(con, "program")
  dbDescribeTable(con, "program")
  RMySQL::dbListTables(con)
  

  program <- dbReadTable(con, "program")
  gmecurr <- dbReadTable(con, "gmecurr")  
  add_train <- dbReadTable(con, "add_train")
  
  View(left_join(gmecurr, program, by = c("gmecurr_program_id" = "program_id")))
  
  View(left_join(gmecurr, program, by = c("gmecurr_program_id" = "program_id")) %>% 
    select("program_name", "gmecurr_acad_year", "gmecurr_first_yr", "gmecurr_program_id") %>% 
    filter(gmecurr_first_yr == 0) %>% group_by("program_name"))
  
  db_list_tables(con = con)
  
  
  
  left_join(add_train, program, by=c("add_train_program_id"="program_id")) %>% 
    
  