![](https://raw.githubusercontent.com/jainvandit/Memes-For-All/master/Memes%20For%20All/Assets.xcassets/AppIcon.appiconset/Icon-App-83.5x83.5%402x.png)
# Memestagram!
Memestagram is a light weight iOS Application that lets you browse through the different meme templates and view individual submissions for the same.

## Design
The app uses a simple ```UITableView``` for the home screen and a simple ```UICollectionView``` to implement the grid on the submissions screen.

<img src="https://raw.githubusercontent.com/jainvandit/Memes-For-All/master/Final%20Look%20Assets/HomeScreen.png" width="250"><img src="https://raw.githubusercontent.com/jainvandit/Memes-For-All/master/Final%20Look%20Assets/SubmissionsScreen.png" width="250"><img src="https://raw.githubusercontent.com/jainvandit/Memes-For-All/master/Final%20Look%20Assets/ErrorScreen.png" width="250">
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
