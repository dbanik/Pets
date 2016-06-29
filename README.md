# Pets
Pets Classifieds

--------------------

This is an iPhone app for listing ads about Pets. One can find two
groups namely Server & Client. The Server group contains a class
ECService which mocks service calls. This singleton class provides two
services - getting the list of Pet ads and updating any particular Pet
detail.

The client has been built based on MVC design pattern. The PetData is
the model class consisting of few important attributes of each Pet. The
view class is Main.storyboard consisting of master-detail views
embedded in navigation controllers. The controller has two view
controllers - one for the Master view and another for the Detail view.

The app fetches the pet list on launch showing the activity progress
indicator. Tapping on any item from the Master screen opens the Detail
screen which has 3 fields - Name, Price and Contact. Each of these 3
fields can be edited. Once edited, user can just tap on the back button
to initiate update service. No ‘save’ button has been provided to give
the user the feeling of seamlessness between editing & saving the
edited data. Once in Master screen, user can refresh by tapping on the
refresh button. This simply re-fetches the updated pet list.
