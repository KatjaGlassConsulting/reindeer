# Release Notes

## Release Version 1.3 (2021-03-05)

A new version of Reindeer has been released! The following changes are performed:

* Batch support
    * Reindeer can now batch process multiple files
    * New keyword "batch" available in the configuration
    * To run the batch example, include the "config_batch.txt" as "General" -> "Configuration"
* Macintosh support
    * Documentation added: To avoid multi-file-request access, use a workaround to rename files to using "~$" as prefix

## Release Version 1.2 (2021-01-22)

* PDF Output
    * The final result can additionally or instead of the Word file be saved. Just use the configuration "Tool PDF Output" to store the PDF file.
* Page X of Y Support
    * A special "Page X of Y" in the title lines are supported now. To activate this special handling use the configuration "SpecialPageHandling" with the value YES
* Many additional examples have been included
* Allow Renaming
    * The "Reindeer.docm" can be renamed to a different file name and will still work
* Navigation Pane
    * Additional investigations has been undertaken to support a navigation pane
    * By using special styles (derived from heading) - a navigation is created as well
    * Be aware that navigation cannot be created when inside a table (like for TAGSETS.RTF)
    * The new template "Reindeer_TemplateCourierNav.docx" contains the navigation caption style
* Macintosh is partly supported (RTF and TAGSETS.RTF, not Listing)
* [todayDate] had been incorrectly working on a German Word, this is now fixed
* Documentation is updated accordingly