![](https://raw.githubusercontent.com/jainvandit/Memes-For-All/master/Memes%20For%20All/Assets.xcassets/AppIcon.appiconset/Icon-App-83.5x83.5%402x.png)
# Memestagram!
Memestagram is a light weight iOS Application that lets you browse through the different meme templates and view individual submissions for the same.

[![GitHub version](https://badge.fury.io/gh/jainvandit99%2FMemes-For-All.svg)](https://badge.fury.io/gh/jainvandit99%2FMemes-For-All)
![Platform](https://img.shields.io/badge/platform-iOS-blue.svg)
![badge-languages](https://img.shields.io/badge/swift-4.2%20%7C%205.0-red.svg)
[![license](https://img.shields.io/github/license/jainvandit99/Memes-for-all.svg)](LICENSE)
![Release](https://img.shields.io/github/release/jainvandit99/Memes-for-all.svg)
## Design
The app uses a simple ```UITableView``` for the home screen and a simple ```UICollectionView``` to implement the grid on the submissions screen.

<img src="https://raw.githubusercontent.com/jainvandit/Memes-For-All/master/Final%20Look%20Assets/HomeScreen.png" width="250"><img src="https://raw.githubusercontent.com/jainvandit/Memes-For-All/master/Final%20Look%20Assets/SubmissionsScreen.png" width="250"><img src="https://raw.githubusercontent.com/jainvandit/Memes-For-All/master/Final%20Look%20Assets/ErrorScreen.png" width="250">

### TagListView
The ```TagListView``` library is implemented in each off the ```UITableViewCell```.

<img src="https://raw.githubusercontent.com/jainvandit/Memes-For-All/master/Final%20Look%20Assets/TagListView.png" width="400">

### GridView
```UICollectionViewCell``` is dimensioned such that only 2 columns fit the frame. Each cell has one ```UIImageView``` and two ```UILabels``` for the top text and bottom text. The ```impact``` font, generally used in memes is included in assets.

<img src="https://raw.githubusercontent.com/jainvandit/Memes-For-All/master/Final%20Look%20Assets/GridView.png" height="300">

## API
The [Meme Maker API](https://mememaker.github.io/API/) is used to get content. In particular, for the time being only the following functionality is being used.
* [Get a Meme](http://alpha-meme-maker.herokuapp.com/1) - used to get the memes based on the page number.
* [Get Submissions](http://alpha-meme-maker.herokuapp.com/memes/1/submissions/) - used to get all the submissions for a particular meme.

## Optimization
* To save data consumption, the ```Kingfisher``` image caching library is used. It doesn't fetch the image repeatedly unless its contents are changed and only loads the image once.
* To conserve the data consumption and also make queries load faster, the memes are fetched based on the page number. The furthur a user scrolls, the other memes are fetched and appended to the same TableView.

## External Frameworks Used
* [```NVActivityIndicatorView```](https://github.com/ninjaprox/NVActivityIndicatorView) - is a collection of awesome loading animations.
* [```Kingfisher```](https://github.com/onevcat/Kingfisher) - is a powerful, pure-Swift library for downloading and caching images from the web.
* [```TagListView```](https://github.com/ElaWorkshop/TagListView) - is a simple and highly customizable iOS tag list view.

## Author
[Vandit Jain](https://www.github.com/jainvandit99)
[![GitHub followers](https://img.shields.io/github/followers/jainvandit99.svg?style=social&label=Follow&maxAge=2592000)](https://github.com/jainvandit99?tab=followers)  
[![Twitter](https://img.shields.io/twitter/follow/jainvandit99?style=social)](https://twitter.com/jainvandit99)

## Acknowledgements
This project is part of an interview task. The author holds full ownership to any part of the project that may be used as part of another project.
