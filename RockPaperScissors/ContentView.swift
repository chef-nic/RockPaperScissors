//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Nicholas Johnson on 7/10/24.
//

import SwiftUI

struct ContentView: View {
    private let moves = ["🪨", "📄", "✂️"]
    @State private var jeffsChoice: Int = Int.random(in: 0...2)
    @State private var shouldWin = false
    @State private var userPick: String = ""
    @State private var score: Int = 0
    @State private var numberOfRounds: Int = 0
    @State private var gameOver = false
    
    var body: some View {
        ZStack {
            Color.indigo
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text("Your score: \(score)")
                    .font(.title)
                Text("Jeff's move:")
                Text(moves[jeffsChoice])
                    .font(.system(size: 200))
                if shouldWin {
                    Text("How would you win?")
                } else {
                    Text("How would you let Jeff win?")
                }
                HStack(spacing: 20) {
                    ForEach(moves, id: \.self) { move in
                        Button {
                            userPick = move
                            updateScore()
                            nextQuestion()
                        } label: {
                            Text(move)
                                .font(.system(size: 60))
                        }
                    }
                }
            }
            .foregroundStyle(.white)
            .padding()
            .alert("Game Over", isPresented: $gameOver) {
                Button {
                    resetGame()
                } label: {
                    Text("Restart Game")
                }
            } message: {
                Text("You scored \(score) in 10 rounds. Would you like to play again?")
            }
        }
    }
    
    func updateScore() {
        shouldWin ? playerShouldWin() : jeffShouldWin()
    }
    
    func nextQuestion() {
        numberOfRounds += 1
        if numberOfRounds == 10 {
            gameOver = true
        }
        shouldWin.toggle()
        jeffsChoice = Int.random(in: 0...2)
    }
    
    func resetGame() {
        jeffsChoice = Int.random(in: 0...2)
        numberOfRounds = 0
        score = 0
    }
    
    func playerShouldWin() {
        if moves[jeffsChoice] == "📄" && userPick == "✂️" {
            score += 1
        } else if moves[jeffsChoice] == "✂️" && userPick == "🪨" {
            score += 1
        } else if moves[jeffsChoice] == "🪨" && userPick == "📄" {
            score += 1
        } else {
            score -= 1
        }
    }
    
    func jeffShouldWin() {
        if moves[jeffsChoice] == "📄" && userPick == "🪨" {
            score += 1
        } else if moves[jeffsChoice] == "✂️" && userPick == "📄" {
            score += 1
        } else if moves[jeffsChoice] == "🪨" && userPick == "✂️" {
            score += 1
        } else {
            score -= 1
        }
    }
}

#Preview {
    ContentView()
}
