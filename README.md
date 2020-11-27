# Stay Safe
This is a repository for CS476 course project

Project Summary
People feel danger to visit public spaces due to possibility of infection, but still needs to visit some public spaces for important purposes. Therefore, we create a safety reviewing system for public spaces to acknowledge users of its safety. Safety of public spaces are crowdsourced by reviews, and reviews themselves are quality controlled by other users.

Instruction
1. Add Reviews by pressing '+' button
2. Search for public spaces, and find their safety
3. See recommended public spaces


Main code is implemented at stay_safe/lib/main.dart

`class HomePageState` implements the main screen with the bottom navigationbar, and the google map picker when search button or add review button is pressed <br />
`class HomeScreen` implements recommendation system based on recent search, or reviewed location <br />
`class SearchResult` implements the name, picture, safety/ overall experience level of the search result <br />
`class AllReviews, AllReviews2` implements showing all reviews for specific location. <br />
`class MakeReview` implements making a review with star ratings and comments. <br />

database code is implemented at stay_safe/lib/database.dart

## Setup
1. Install `flutter` and connect virtual device
3. `flutter run`

## Futures
1. Login/SignUp future
2. Search/Review future
3. Suggested places nearby

## Incoming Futures
1. Setting to control your profile
2. More profound way of providing safety level information
3. Fixing the UI failures(pationatily we are waiting feedback from users)
