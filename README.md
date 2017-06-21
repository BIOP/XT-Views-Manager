# XT Views Manager
A simple Imaris XTension to store and reload camera positions within Imaris

# Installation
Copy the following files into your Imaris XTensions folder, usually `C:\Program Files\Bitplane\Imaris x64 X.X.X\XT\matlab`
- **XTViewsManager.m** - The file that creates the menu item in Imaris and launches the application
- **saveView.fig** - The Matlab GUIDE figure that contains the user interface
- **saveView.m** - The Matlab GUIDE function that contains the core of the application

# Running the XTension
After restarting Imaris, you should find the XTension in `Image Processing > Camera Function > Views Manager`

# User Interface

The user interface is fairly simple
## Buttons 
- **Save View** Saves the current Imaris Camera position to an internal array and updates the list
- **Load Selected View** Loads the view that was clicked upon by the user from the list
- **Delete View** Deletes the currently selected view and renames all views so that the naming remains sequential
- **Import Views...** Prompts the user for a `.mat` file which contains views saved using **Export Views...**
- **Export Views...** Asks the user for a location to save a `.mat` file that contains all the views in the Views Manager.

## Reset Extents
Some datasets in Imaris have the starting coordinates of their volumes set at values other than (X,Y,Z) = (0,0,0). this can cause 
discrepancies when loading views from one image to another in the form of offsets.
To avoid this, either make sure that the Extents always start at 0,0,0 through `Edit > Image Properties...` and set the `Min` row to all zeros.

Alternatively you can activate this checkbox, but please note that this offset only affects the Volume and any spots/surfaces or other elements will be now offset from the volume.
