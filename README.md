# BeastKeeper

A 7hr flutter demo application that keeps track of your animals .

## Objectives

The goal was to enable the following use cases:

1. Add animal to app; this would mean creating a view/form were user can set name,image, animal type/breed, age, and additional information(health issue etc). (4 hours)

2. Show a list of animal items; this would be a view similar to the first sketch you made. (1.5 hour)

3. Show expanded animal information on item press. This would be similar to the second sketch. (1.5 hour)

   

## Accomplished

The first usecase was made where user create a new beast by uploading an image from their gallery and assign a name, age and additional info for their beast. This is took around 5 and 1/2 hrs. 

The second usecase was being developed. A list of beast was shown once only after a crash. The list isn't refreshed when the user navigates to the page. I had 1 hr and 1/2 to work on this.



## How

The MVP architecural pattern was followed. There were two main pages, one to add a beast and one to display them (home page). Each had a Widget.dart, Presenter.dart, and View.dart file. The widget file handled the UI logic and the presenter had access to the model classes. 



The Beast model class held name, age, additional info, and image path of object. It also contained functions to enable json encoding for later storage. 



The Storage model class had access to sharedPrefrences and had save and get functions that saved or retrieved a list of beasts. 



## Problems

1. Making the Storage.dart class a singleton. Due to time constraints, I opted with creating a new sharedPref instance everytime a save or get method is called. 
2. Copying the image to the application directory. Spent some time working on this but didn't test it out as I could demo without it. 
3. Displaying beast list on homepage. List isn't displayed after user creates a beast. Also doesn't show items on startup, this only happened once and it may have been after a crash. 

I also struggled a bit with the asynchronous aspect of dart, namely when function returned a Future<> instead of the other types. This played a role problems 2 and 3.

## To Run this

1. `git clone https://github.com/Resay2k/BeastKeeper.git`

2. a) Using Android Studio -> try [this](https://medium.com/codespace69/how-to-import-existing-flutter-project-in-android-studio-aa9d9e5c77b)  

   b) Using VScode -> try [this](https://flutter.dev/docs/development/tools/vs-code#opening-a-project-from-existing-source-code)

3. run `open -a simulator` 

