<!--
================================================================================
file_sorting__r_scripts_24420cbb.R — (panel mapping pending)
================================================================================

What this file does: File-organization utility. Two G:\ variants merge into one helper (one wins; second goes to duplicates).

Manuscript panel(s): (panel mapping pending)
Source Data sheet(s): (none — see source_data_audit.md)

Original source on G:\: G:/Figure 3_Arp3/Fig. 3o-r_local_perfusion/R_scripts/fileSorting.R
File-organization utility. Two G:\ variants merge into one helper (one wins; second goes to duplicates).

Header added 2026-05-08. For deeper
annotation see CONTRIBUTORS.md and code_organization_plan.md. The file's
analysis logic below this header is bit-faithful to the G:\ original; only
comments above this point have been added.
================================================================================
-->
# Load required libraries
library(stringr)   # For string manipulation
library(fs)        # For file handling

# Define the folder containing the files
source_folder <- "D:\\Andreas_MicroPerfusion\\Microperfusion\\sorting"  # Replace with your folder path

# List all files in the folder
files <- dir_ls(source_folder, type = "file")

# Function to extract the correct date and move files
move_files_by_date <- function(files) {
  
  # Loop through each file
  for (file in files) {
    # Extract the base file name
    file_name <- basename(file)
    cat("Processing file:", file_name, "\n")  # Debug: print filename being processed
    
    # Regex to extract the 8-digit date immediately before the underscore
    date_match <- str_match(file_name, "(\\d{8})_")
    cat("Regex match result:", date_match, "\n")  # Debug: print regex match output
    
    # Check if the match is valid
    if (!is.na(date_match[, 2])) {
      # Extract the date
      folder_name <- date_match[, 2]
      cat("Extracted date:", folder_name, "\n")  # Debug: print the extracted date
      
      # Create folder if it doesn't exist
      folder_path <- file.path(source_folder, folder_name)
      if (!dir_exists(folder_path)) {
        dir_create(folder_path)
        cat("Created folder:", folder_path, "\n")
      }
      
      # Move file into the corresponding folder
      file_new_path <- file.path(folder_path, file_name)
      file_move(file, file_new_path)
      cat("Moved file:", file_name, "->", folder_name, "\n")
    } else {
      cat("No date found in file:", file_name, "\n")  # Debug: no match found
    }
  }
}

# Run the function to organize files
move_files_by_date(files)

# Final message
cat("File sorting complete!\n")
