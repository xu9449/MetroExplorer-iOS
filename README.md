# ios-project-xu9449
ios-project-xu9449 created by GitHub Classroom
### MetroExplorer Introduction:  

When you open the app, it will ask for the location authorization and for 5 diferent cases, it will show 4 different situation.

My app has 6 view controller. 

From the 1) MainTabBarController, we have:

2) MenuView : It will show the menu list with 2 buttons: Select Station and Nearest Station

3) FavLandMarkTableViewController: It is a TableView has the list of our favorite landmarks' name, address and the saving time.  You can add from the landmarkDetailView and delete it if you make a left slide gesture. 

4) MetroStationTableViewController: If you press the Select Station, it will show a list of 95 metro stations in DC. We can use search bar to find your ideal station.  

5) LandmarkViewController: It will show the famous landmarks according to your station's location. The Title will show your nearest Station's name. 

6) StationDetailViewController: It should call the LandmarkDetailViewController. We add the landmark image, name, address and rating in this view. Also it has two button: 

SAVE: It will add this landmark to your FavLandmark list.( the badgeValue will show how many landmarks you saved, I am still trying to figure out how to update the badgeValue when we hit the save and delete button)

SHOW ME DIRECTION: It will hit the apple map and show how to get to the landmark you choose.  
