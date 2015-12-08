# PinkFlamingQueue

PinkFlamingoQueue is the O'Reilly interview iOS application. It is a simplified version of our real application, Safari Queue. The problems here are meant to be similar to the ones we solve on a daily basis.

The application contains two view controllers, one which displays all the books available to download on the server, and another one which displays all the items that the user has "downloaded". All of this data comes from a real API, but please note that the books have no real content.

There are two parts to this technical interview: Fixing bugs, and implementing new functionality.

## Part 1: Bugs

We have chosen three bugs for you to fix.

1. The test suite is failing due to the test `testAddToQueueFailure`.
2. In lieu of providing real cover images, we have chosen a filler image for books. However, there seems to be a problem with the way this image is animating. When the `UITableView` is scrolled, the covers resize and look strange.
3. Every time a user taps the "Add To Queue" button, a POST request is sent to the server and added to the database, but the "Downloads" section of the application fails to refresh and display the updated queue. We need to fix this so the user doesn't have to force close and reopen the application to see their updated downloads.

![Alt text](app_screenshot.png?raw=true "Bad Covers")

## Part 2: Features

In addition to the three bugs above, please implement the following features.

1. Items can be added to the queue, but not deleted. Please add a button, or something similar, which allows users to delete queued items from their queue on the server.
2. The data returned from the API endpoint `/api/books/` has a cover URL. Please modify the search view controller, and anything else you think is necessary, to download and display these cover images.
3. In addition to cover images, there is other information provided by the API, including the time the user queued an item, the author, the publisher, and the ISBN. Using this data, provide one additional feature or improvement of your choice. If you are having a hard time coming up with a feature to implement, here are a couple of choices:
    - In the "Downloads" section, display the real amount of time elapsed since the user added the item to their queue.
    - In the "Search" section, add a detail view controller which displays other information about the book, for example, a larger cover, publisher information, ISBN, and author.

## Submission
Once you have made your changes, commit them to the git repository, push them up to GitHub, and open a pull request.

## Feedback
We appreciate and welcome any feedback you have. Good luck!
