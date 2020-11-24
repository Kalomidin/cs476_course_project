# Stay Safe
This is a repository for CS476 course project

Project Summary
People feel danger to visit public spaces due to possibility of infection, but still needs to visit some public spaces for important purposes. Therefore, we create a safety reviewing system for public spaces to acknowledge users of its safety. Safety of public spaces are crowdsourced by reviews, and reviews themselves are quality controlled by other users.

Instruction
1. Add Reviews by pressing '+' button
2. Search for public spaces, and find their safety
3. See recommended public spaces


Main code is implemented at stay_safe/lib/main.dart

class HomePageState implements the main screen with the bottom navigationbar, and the google map picker when search button or add review button is pressed
class HomeScreen implements recommendation system based on recent search, or reviewed location
class SearchResult implements the name, picture, safety/ overall experience level of the search result
class AllReviews, AllReviews2 implements showing all reviews for specific location.

database code is implemented at stay_safe/lib/database.dart
