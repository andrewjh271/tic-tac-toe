# Tic Tac Toe

Created as part of The Odin Project curriculum. 

View in [repl.it](https://repl.it/@andrewjh271/tictactoe)

### Functionality

Board uses chess-style coordinates for squares. The board checks for a win after every move, and highlights the winning line in color if a player has won. The board also checks for a stalemate in the case of a full board.

The program also has the option of making one, or both, players computers. The computer setting has three levels of difficulty:

- Easy: Computer chooses random empty squares
- Medium: If the computer is one away from a win, it completes the row. If the computer's opponent is one away from a win, it blocks the row.
- Difficult: As far as I can tell, plays optimally to look for a win and cannot be beaten. There is some randomness in the opening if the computer is first to move (will choose either the center or a corner). Otherwise there is some randomness in trivial choices (i.e. which empty corner to choose (in some cases) or which winning row to complete if there are two options)

### Thoughts

The implementation started off pretty organized — I had the Classes and their functionality mostly planned out before starting. The main change I made later on was filling the `@winning_lines` hash with indexes for the `@squares` array instead of its values. This allowed me to make the code in the `#best_squares` method more concise because I could directly refer to the `@squares` array with the index I wanted. I also no longer needed to update the values of `@winning_lines` after every move.

I could have planned out the algorithm for the Difficult mode better. I would have been better off really ironing out the algorithm for optimal play before beginning to code it.

-Andrew Hayhurst