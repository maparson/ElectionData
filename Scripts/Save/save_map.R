#------------------------------#
# Save maps for use in website #
#------------------------------#

# BC

# Get the file and object names to save
temp.tosave.objc <- "gg_bc"
temp.tosave.file.back <-
  paste0("C:/Users/marc_/Documents/Projects/ElectionSite/static/_index_files/Maps/",
         toupper(substr(temp.tosave.objc, 4,6)), "/",
         temp.tosave.objc, "_",
         Sys.Date(), ".png")

temp.tosave.file.curr <-
  paste0("C:/Users/marc_/Documents/Projects/ElectionSite/static/_index_files/Maps/",
         toupper(substr(temp.tosave.objc, 4,6)), "/",
         temp.tosave.objc, ".png")

# Save the maps
ggsave(filename = temp.tosave.file.back, # save the backup
       get(temp.tosave.objc),
       dpi = "retina")
ggsave(filename = temp.tosave.file.curr, # save the image to use
       get(temp.tosave.objc),
       dpi = "retina")

# Remove temp. objects
rm(list=ls(pattern="temp."))



