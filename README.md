# Reindeer
Reindeer - Result Render tool for SAS outputs

![Reindeer Logo](./images/reindeer_001_200.png)

## About
The Reindeer Result Render open source tool contains a VBA macro which can be used to render multiple outputs created with SAS® into one Word document. 

Currently listing (.lst or .txt) and rtf outputs as well as graphics are supported. Detailed documentation is available in the file containing the macro as well called  "Reindeer.docm".

This open source tool is developed by Katja Glass Consulting and sponsored by ClinStat GmbH. By investing in open source ClinStat enabled this project, which is available under the MIT license. Feel free to use and modify this tool, but be aware that there is no warranty. Please feel free to perform push requests and document issues in GitHub or contact me. 

Additional sponsoring and funding opportunities are available. If you are interested in supporting this project, please get in touch with me.

## Usage

- Clone or Download the repository
- Open "Reindeer.docm"
- Update pathes in the top table
- Execute the VBA macro with an example by pressing the "Run" Button

Adapt files to your need

- Create SAS outputs
- Create custom template including title page(s) and styles
- Adapt settings 
- Run

## Supported file formats

- listing (lst, txt)
- rtf (TAGSETS.RTF, ODS RTF)
- figures (jpg, png, svn, ...)

## Repository Content

File | Description
--- | ---
doc/Reindeer.docm | Tool containing VBA Macro
doc/Reindeer.pdf | Reindeer.docm content as PDF for easy reading
doc/Reindeer_ExampleTemplate.doc | Example template
doc/config.txt | Example Configuration Text File
doc/content.txt | Example Content Text File
out/* | SAS outputs used as example inputs
programs/createExampleOutputs.sas | SAS program to create SAS example outputs
images/* | Images used for Readme

### Developed by:

<img src="./images/glacon_logo_small.png" height="90" alt="Logo Katja Glass Consulting">

[Katja Glass Consulting](https://www.glacon.eu)

### Sponsored by:

<img src="./images/clinstat_logo_small.png" height="70" alt="Logo ClinStat GmbH">

[ClinStat GmbH](https://clinstat.eu)