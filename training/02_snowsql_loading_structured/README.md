# Snowsql
This section will walk you through running Snowflake's snowsql (cli) as your first hands-on.

## Requirements
* Run the following: 01_internal_stage.sql
* Open a terminal and run the following command
    ```
    snowsql --config /workspaces/sfc-snowflake-training/training/02_snowsql_loading_structured/config -c demo -f /workspaces/sfc-snowflake-training/training/02_snowsql_loading_structured/02_loading_from_internal_stage.sql
    ```
* Once the data has been loaded to an internal Stage run 03_copy_into.sql
