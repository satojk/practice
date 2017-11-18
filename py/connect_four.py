# TODO: merge play and play_turn methods, and has_winner and check_winner methods.
# TODO: fix style. I know it's gross right now.
# TODO: make graphical interface.
import numpy as np

class Game(object):

    def __init__(self, width, height):
        self.board = np.full((height, width), "_") 
        self.height = height
        self.width = width

    def __repr__(self):
        return str(self.board)

    def play(self, token, col):
        for i in range(self.height):
            if self.board[self.height-i-1][col] == "_":
                self.board[self.height-i-1][col] = token
                break
        else:
            raise Exception("Column is full!")

    def has_winner(self):
        seqs = []
        for i in range(self.height-3): #get all 4-diags
            for j in range(self.width):
                cur_diag = []
                if j >= 3:
                    seqs.append([self.board[i]  [j],
                                 self.board[i+1][j-1],
                                 self.board[i+2][j-2],
                                 self.board[i+3][j-3]])
                if j <= (self.width-4):
                    seqs.append([self.board[i]  [j],
                                 self.board[i+1][j+1],
                                 self.board[i+2][j+2],
                                 self.board[i+3][j+3]])
        for i in range(self.height): #get all 4-rows
            for j in range(self.width-3):
                seqs.append((self.board[i][j:j+4]).tolist())
        for i in range(self.height-3): #get all 4-cols
            for j in range(self.width):
                seqs.append((self.board[i:i+4,j]).tolist())
        for seq in seqs:
            if seq == ["X"]*4:
                return "X"
            if seq == ["O"]*4:
                return "O"
        return "_"

    def play_turn(self, token):
        print("It's {}'s turn. Which column do you want to play?".format(token))
        play = int(input())
        self.play(token, play-1)
        print("\n")

    def check_winner(self):
        result = self.has_winner()
        if result != "_":
            print("{} has won the game!".format(result))
            return True

game = Game(7, 7)
while True:
    print(game)
    print("   1   2   3   4   5   6   7\n")
    if game.check_winner():
        break
    game.play_turn("X")
    print(game)
    print("   1   2   3   4   5   6   7\n")
    if game.check_winner():
        break
    game.play_turn("O")
