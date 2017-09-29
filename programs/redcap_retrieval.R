#------------------------------------------------------------------------------#
#     TITLE: Access data from REDCap
#      DATE: 2017SEP29
#    AUTHOR: B. Saul
#      DESC:
# CHANGELOG:
#------------------------------------------------------------------------------#

library(REDCapR)

uri <- ""
token <- ""

all_data <- redcap_read(redcap_uri=uri, token=token)$data