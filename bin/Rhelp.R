#!/usr/bin/Rscript
# NAME: Peter Herbert 
# FILE: Rhelp.r
# DATE: 2015-08-10
# DESC: Send help commands to R  

# Load common libraries
library(data.table)
library(dplyr)

args <- commandArgs(TRUE)
for(i in 1:length(args)) {
    print(help(args[i]))
}
