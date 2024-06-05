import tkinter as tk
from tkinter import messagebox
from pyswip import Prolog


class TicTacToe:

    def __init__(self, root):
        self.prolog = Prolog()
        self.prolog.consult("tictactoe.pl")

        self.root = root
        self.root.title("Tic-Tac-Toe")
        #self.root.configure(background='black')

        self.buttons = []
        for i in range(3):
            row = []
            for j in range(3):

                button = tk.Button(self.root,
                                   text=' ',
                                   font='normal 20 bold',
                                   bg="gray15",
                                   height=4,
                                   width=8,
                                   command=lambda row=i, col=j: self.
                                   player_move(row * 3 + col + 1))
                button.grid(row=i, column=j)
                row.append(button)
            self.buttons.append(row)

        self.current_player = 'o'
        self.game_over = False

    def player_move(self, pos):
        if self.game_over:
            return

        row, col = divmod(pos - 1, 3)

        if self.buttons[row][col]['text'] == ' ':
            self.buttons[row][col]['text'] = self.current_player
            self.buttons[row][col][
                'fg'] = 'red' if self.current_player == 'x' else 'blue'
            self.prolog.assertz(f"{self.current_player}({pos})")

            if self.check_win():
                self.game_over = True
                messagebox.showinfo("Game Over",
                                    f"Player {self.current_player} wins!")
            elif self.check_draw():
                self.game_over = True
                messagebox.showinfo("Game Over", "It's a draw!")
            else:
                self.current_player = 'x' if self.current_player == 'o' else 'o'

    def check_win(self):
        win_query = f"ordered_line(A, B, C), {self.current_player}(A), {self.current_player}(B), {self.current_player}(C)"
        return bool(list(self.prolog.query(win_query)))

    def check_draw(self):
        return all(self.buttons[row][col]['text'] != ' ' for row in range(3)
                   for col in range(3))


if __name__ == "__main__":
    root = tk.Tk()
    game = TicTacToe(root)
    root.mainloop()
