# Boom-Boom-Tracker

An interactive visualization tool created using Processing. Boom-Boom tracker is designed to help users visualize Volcanic eruptions and find trends or patterns in Volcanic data. 

## Running Boom-Boom-Tracker

To run **Boom-Boom-Tracker** follow these steps:

1. Download Processing 3 from [processing.org](https://processing.org).
2. Download the [G4P processing library](http://www.lagers.org.uk/g4p/download.html) and add it to your libs folder inside processing.
3. Download our project from github, it should run smoothly once you add the G4P library to your libs folder in processing.

## Data

**Boom-Boom-Tracker** uses data from the [Smithsonian Institute Global Volcanism Program](http://volcano.si.edu). This data includes eruption data and SO2 emissions, downloaded as CSV files from the Smithsonian's database. 

We downloaded files for both eruption data and emission data, and then processed the data files to combine them into one usable data file by matching eruptions and emissions using a combination of Volcano Name and Start Date. The code for this processing can be found in our 
