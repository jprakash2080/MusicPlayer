# MusicPlayer
A Simple Music player using SwitUI and MVVM pattern

**Player Flow**
On after App launch, you will see two Tabs at the bottom of the screen first one is Home View, it will show you the main home screen where  you can see current playing song thumb , song name  and artist name on center of the screen and as well as on player bar , on player bar user can play and pause the song. Second tabs is to view all top recently played songs . 

**The Model**
The application contains one model classes. It class holds the properties of a Song.
The model also contains a PlayingMusic_Base struct that holds a collection of songs that make up the list of songs to be played.

**Services**
The application contains one service called APIService. This service loads the songs into the song list from the provided API URL path.

**The View**
The view is made from SwiftUI code. It uses standard swift ui components like View, Text, VStack, List etc. this view shows the data from the model view.


**View Model**
The final piece is the view model. The view model contains everything needed to drive the view. This includes properties displayed in the view and the commands that are executed by the user through the UI. This application has two view so the view model is named PlayingMusicModel and RecentMusicModel

![alt text](https://github.com/jprakash2080/MusicPlayer/blob/MusicPlayerMVVM-Main/PlayingSong.png?raw=true "PlayingSong")


------------


 ![alt text](https://github.com/jprakash2080/MusicPlayer/blob/MusicPlayerMVVM-Main/RecentSongs.png?raw=true "RecentSongs")


**Technology and Methodology which used**
MVVM - MVVM stands for Model, View, View Model. It is a structural design pattern that allows for the separation of code into 3 groups
SwiftUI - building user interface
CocoaPods - CocoaPods is a dependency manager

**Libraries used**
SwiftUI
AVKit
UIKit
GoogleMobileAds

**TODO:**
1. Music background play
2. Show  ads before stream music .


