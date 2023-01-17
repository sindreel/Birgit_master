###########################################################
#Clear memory
rm(list = ls(all = TRUE))
###########################################################

#########################################################################
#download Hellstranda-data
#########################################################################

#Last updated telemetry data file - 25.01.2021

#-----------------------------------------------------------------------
# Download data from external source. This is best practice for making 
# your code transportable among different computers.. 
#-----------------------------------------------------------------------

# This script downloads and merges the data needed for further analyses for the hellstranda project.
# End product of this script is a .csv file containing fish info and key migratory variables (timing of marine entry, timing of marine exit, marine residence duration and categorized migratory distance)


# first create new folder (./data/raw_data) to store the files 
# locally (cache down the data) - remember to update gitignore folder (add 
# the line */data/raw_data to the .gitignore file)
dir.create("data/raw_data", showWarnings = FALSE, recursive = TRUE)
dir.create("data/modified_data", showWarnings = FALSE, recursive = TRUE)

#change timeout option to fix problem with large files
options(timeout = max(999, getOption("timeout")))

#URL_tracking_data_joakim <- "https://ntnu.box.com/shared/static/qzts8g0hrdxe0o2z3orgv27u7476oh1g.csv" #Uploaded new version 21.09.2022

#URL_tagging_data <- "https://ntnu.box.com/shared/static/yovusv93xx2vnevbem7h15pzrey124at.csv" #Updated 29.09.2021
#URL_receiver_deployment <- "https://ntnu.box.com/shared/static/y5w2l306qhq18lea096os44jt1bwm3pn.csv" #Updated 29.09.2021


#download data
#download.file(url=URL_tracking_data_joakim,destfile="./data/raw_data/tracking_data_joakim.csv")  
#download.file(url=URL_tagging_data,destfile="./data/raw_data/tagging_data_hellstranda.csv")
#download.file(url=URL_receiver_deployment,destfile="./data/raw_data/receiver_deployment_hellstranda.csv")


#Download .rds files#change timeout option to fix problem with large files
options(timeout = max(999, getOption("timeout")))

#URL_tracking_data <- "https://ntnu.box.com/shared/static/5jk866d06ezuci3om9ca6i21pf1x3nkm.rds" #Uploaded new version 21.09.2022
#URL_tagging_data <- "https://ntnu.box.com/shared/static/jdzdjcu72fx9q4giad476agbyg2lm4sp.rds" #Updated 29.09.2021
#URL_receiver_deployment <- "https://ntnu.box.com/shared/static/tuf7z3v1rg62derm3gmlrpimdw4svmqu.rds" #Updated 29.09.2021


#download data
#download.file(url=URL_tracking_data,destfile="./data/raw_data/tracking_data.rds")  
#download.file(url=URL_tagging_data,destfile="./data/raw_data/tagging_data_hellstranda.rds")
#download.file(url=URL_receiver_deployment,destfile="./data/raw_data/receiver_deployment_hellstranda.rds")

#check downloaded data
#tracking_data <- readRDS("./data/raw_data/tracking_data.rds")
#str(tracking_data)
#fishdata <- readRDS("./data/raw_data/tagging_data_hellstranda.rds")
#str(fishdata)
#deployment_data <- readRDS("./data/raw_data/receiver_deployment_hellstranda.rds")
