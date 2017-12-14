# Boom-Boom-Tracker

An interactive visualization tool created using Processing. Boom-Boom tracker is designed to help users visualize Volcanic eruptions and find trends or patterns in Volcanic data. 

## Data

**Boom-Boom-Tracker** uses data from the [Smithsonian Institute Global Volcanism Program](http://volcano.si.edu). This data includes eruption data and SO2 emissions, downloaded as CSV files from the Smithsonian's database. 

We downloaded files for both eruption data and emission data, and then processed the data files to combine them into one usable data file by matching eruptions and emissions using a combination of Volcano Name and Start Date. The code for this processing can be found in our CSV_Merge folder which is located inside the Volcano_Vis folder.

The data attributes that we decided to track and encode into our visualization are VEI, Start Year, End Year, Latitude, Longitude, Total SO2 Mass, SO2 Altitude Range Start, and Volcano Name. 

## Features

### Windows

**Boom-Boom-Tracker** has three primary windows: The Geographic Map, Parallel Coordinate Plot, and Drop Down windows. All of these windows are linked, so that changes made in one window represent changes made in another. For example, filtering by year in a drop down will filter by year in both the Geographic Map and Parallel Coordinate Plot, and a highlight made in the parallel plot with be reflected in the geographic map.

### Interactions

#### Geographic Map

The Geographic Map displays volcanic eruptions as a triangle at their Latitude and Longitude on the map. Along with the latitude and longitude, VEI is encoded on a yellow to red scale, with yellow being a VEI of 0 and red a VEI of 6. A VEI of -1 means that there was no eruption, only an emission, and this is encoded with a green triangle. Emmision data is encoded as a circle around an eruption, with larger emissions being represented by larger circles on the map. If a volcano is moused over in the geographic map, it will appear light blue and display the volcano's name. Clicking on the volcano will toggle its highlight, and either highlight it or unhighlight it. Highlighted volcanos will appear in full color, while nonhighlighted volcanos will appear in greyscale. Users can also highlight a group of volcanos by clicking and dragging over an area. Highlights made in the geographic map will be reflected in the Parallel Plot.

#### Parallel Coordinate Plot

The Parallel Coordinate Plot displays our six quantitative attributes (VEI, Start Year, End Year, Latitude, Longitude, Total SO2 Mass, SO2 Altitude Range Start) as columns, with each line between a column reprenting a volcanic eruption. Our Parallel Plot supports basic parallel plot interactions, such as highlighting eruptions based on their column values and reording columns in the plot. Highlights made in the parallel plot will be reflected in the Geographic Map.

#### Drop Down Menus

The Drop Down windows allow a user to select a year, a VEI, and/or their data type. This toggle will remove volcanic eruptions from both the Parallel Plot and Geographic map that do not meet the selected criteria, instead of highlighting them.

#### Keyboard Interactions

Pressing the **C** key will reset the highlights made in the Parallel Coordinate plot and the Geographic Map, so that nothing appears highlighted in either. Pressing the **Space Bar** toggles between drawing only highlighted volcanic eruptions or all volcanic eruptions in both the Parallel Coordinate Plot and the Geographic Map. Pressing the **R** key resets the Drop Down windows to **ALL** for all drop down windows, and clears the highlighting from both the Parallel Coordinate Plot and the Geographic Map.

## Running Boom-Boom-Tracker

To run **Boom-Boom-Tracker** follow these steps:

1. Download Processing 3 from [processing.org](https://processing.org).
2. Download the [G4P processing library](http://www.lagers.org.uk/g4p/download.html) and add it to your libs folder inside processing.
3. Download our project from github, it should run smoothly once you add the G4P library to your libs folder in processing.


