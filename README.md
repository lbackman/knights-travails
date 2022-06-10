# Knight's travails

The objective of this project is to find the shortest path between two squares on a chessboard.
Pretty easy if you're a queen, but in this case we are interested in knights.

A knight in chess can move either 1 square horizontally then 2 vertically, or: 2 horizontally and 1 vertically. This means that a knight have potentially eight other squares it can move to from any other square. Edges and corners are of course more limited.

Anyway, a breadth-first-search algorithm was implemented to find the shortest path. A depth-first-search
would add too many dead-end searches down the wrong branches.

In my program I added the ability to choose your own chessboard size, but I found it started to get
noticeably slower as the board got larger, say at 100x100. But the search algorithm itself was still pretty
fast even then. 

All in all a pretty interesting project, and I think this kind of algorithm may be used when designing an chess-playing AI later on in the final Ruby project.