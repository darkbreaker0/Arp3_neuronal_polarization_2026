<!--
================================================================================
file_sorting__r_scripts_41d6a5fd.R — (panel mapping pending)
================================================================================

What this file does: File-organization utility. Two G:\ variants merge into one helper (one wins; second goes to duplicates).

Manuscript panel(s): (panel mapping pending)
Source Data sheet(s): (none — see source_data_audit.md)

Original source on G:\: G:/Figure 3_Arp3/Fig. 3o-r_local_perfusion/R_scripts/fileSorting_dateModified.R
File-organization utility. Two G:\ variants merge into one helper (one wins; second goes to duplicates).

Header added 2026-05-08. For deeper
annotation see CONTRIBUTORS.md and code_organization_plan.md. The file's
analysis logic below this header is bit-faithful to the G:\ original; only
comments above this point have been added.
================================================================================
-->
# Load required libraries
library(fs)        # For file handling and file metadata
library(lubridate) # For date manipulation
library(dplyr)     # For sorting and organizing

# Define the folder containing the files
source_folder <- "D:\\Andreas_MicroPerfusion\\Microperfusion\\sorting"  # Replace with your folder path

# List all files and their metadata
files_info <- file_info(dir_ls(source_folder, type = "file"))

# Sort files by "date modified"
sorted_files <- files_info %>%
  arrange(modification_time)  # Sort by modification time in ascending order

# Function to move files into folders based on "date modified"
move_files_by_date_modified <- function(files_info) {
  
  # Loop through each file
  for (i in 1:nrow(files_info)) {
    # Get file path and modified date
    file_path <- files_info$path[i]
    mod_time <- files_info$modification_time[i]
    
    # Extract date in 'YYYYMMDD' format
    folder_name <- format(as_date(mod_time), "%Y%m%d")
    cat("Processing file:", basename(file_path), "with date:", folder_name, "\n")
    
    # Create the folder if it doesn't exist
    folder_path <- file.path(source_folder, folder_name)
    if (!dir_exists(folder_path)) {
      dir_create(folder_path)
      cat("Created folder:", folder_path, "\n")
    }
    
    # Move the file to the corresponding folder
    file_new_path <- file.path(folder_path, basename(file_path))
    file_move(file_path, file_new_path)
    cat("Moved file:", basename(file_path), "->", folder_name, "\n")
  }
}

# Run the function to organize files
move_files_by_date_modified(sorted_files)

# Final message
cat("File sorting by modification date complete!\n")
