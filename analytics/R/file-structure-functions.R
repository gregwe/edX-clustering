## ===================================================== ##
# Title:        Functions for file-structure needs in edX clustering pipeline ####
#
#
# Author(s):    Taylor Williams
# Institution:  Purdue University
# 
# Project:      
# 
# Description:  []
# 
# Package dependancies: beepr
#
# Changelog:
#     2017.05.11.    initial function extraction from pipeline
## ===================================================== ##


#Function: Check for existance of subdirectory, create if it doesn't exist.
DirCheckCreate <- function(subDir) {
  #set directory variables
  mainDir <- getwd()
  
  #check for/create subdirectory
  if(!dir.exists(file.path(mainDir, subDir))){
    cat(paste(subDir, " does not exist in '", mainDir, "' -- creating"))
    dir.create(file.path(mainDir, subDir))
    subDirPath <- file.path(mainDir, subDir)
  }else{
    cat(paste(subDir, " exists in '", mainDir, "' -- continuing"))
    subDirPath <- file.path(mainDir, subDir)
  }
  return(subDirPath)
}




#Function: Check to see if the selected filename contains the expected text. 
#   Allow user to continue with provided file if desired
ExpectedFileCheck <- function(selectedFilename, expectedFileEnding) {
  #check to see if the user selected file contains the expected character string
  
  #grep is a regular expression string search.  It looks for the pattern within x.  The index positions in x are returned
  # where the pattern is found.  Here x only has a single entry, so if grep() returns 1 then the pattern matches.
  matchResult <- grepl(pattern = expectedFileEnding, x = selectedFilename)
  if(grepl(pattern = expectedFileEnding, x = selectedFilename)){
    #the pattern is found, inform user and exit the function
    cat("\n\nThe filename you provided MATCHES the expected text.")
    return("matched")
    # break
  }else {
    #otherwise, inform the user that the strings don't match and provide option to override (continue with provided file)
    cat("\n\nERROR: The filename you provided DOESN'T MATCH the expected text.",
        "\n       filename provided: ", selectedFilename,
        "\n       expected in filename: ", expectedFileEnding)
    
    repeat{
      #give the user the option to continue with the selected file
      beepr::beep(sound = 10)   #notify user to provide input
      overrideChoice <- readline(prompt="Enter 1 to use currently selected file, 2 to select a new file: ")
      
      if(overrideChoice == 1){
        return("overridden")
      }else if(overrideChoice == 2){
        return("reselect")
      }else{
        cat("Invalid entry.\n")
      }
    }
  }
}



#Function: Check for existance of file passed in
FileExistCheck <- function(subDir, filename) {
  
  #set parameters for file location
  mainDir <- getwd()
  
  #store the file path
  filePath <- file.path(mainDir, subDir, filename, fsep = "/")
  
  #check for existance of CSV module order file
  if(file.exists(filePath)){
    cat(paste(filename, "found -- continuing"))
    return(filePath)
  }else{
    cat(paste("ERROR: ", filename, "not found -- exiting script"))
    rm(list=ls()) ## Clear the environment
    return(FALSE)  #retun signal to exit script if file not found
  }
}
