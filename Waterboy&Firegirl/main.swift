//
//  main.swift
//  Waterboy&Firegirl
//
//  Created by Абзал Бухарбай on 28.04.2023.
//

import Foundation

class Game {
    enum Direction {
        case up, down, left, right
    }
    
    enum Tile: String {
        case empty = "  "
        case wall = "◼️"
        case waterboy = "🌊"
        case firegirl = "🔥"
        case lever = "🔧"
        case gate = "🚪"
        case dangerousLiquid = "☠️"
    }
    
    struct Position {
        var x: Int
        var y: Int
    }
    
    var map: [[Tile]]
    var waterboyPosition: Position
    var firegirlPosition: Position
    var leverActivated: Bool
    var gateOpen: Bool
    
    init(map: [[Tile]]) {
        self.map = map
        self.waterboyPosition = Position(x: 1, y: 1)
        self.firegirlPosition = Position(x: map[0].count - 2, y: map.count - 2)
        self.leverActivated = false
        self.gateOpen = false
    }
    
    func isMoveValid(position: Position, direction: Direction) -> Bool {
        var newPosition = position
        switch direction {
        case .up: newPosition.y -= 1
        case .down: newPosition.y += 1
        case .left: newPosition.x -= 1
        case .right: newPosition.x += 1
        }
        let tile = map[newPosition.y][newPosition.x]
        return tile != .wall && tile != .dangerousLiquid
    }
    
    func move(player: inout Position, direction: Direction) {
        guard isMoveValid(position: player, direction: direction) else { return }
        let oldTile: Tile = (map[player.y][player.x] == .waterboy) ? .empty : .firegirl
        var newPlayerPosition = Position(x: player.x, y: player.y)
        switch direction {
        case .up: newPlayerPosition.y -= 1
        case .down: newPlayerPosition.y += 1
        case .left: newPlayerPosition.x -= 1
        case .right: newPlayerPosition.x += 1
        }
        map[player.y][player.x] = .empty
        player = newPlayerPosition
        map[player.y][player.x] = (oldTile == .waterboy) ? .waterboy : .firegirl
    }
    
    func activateLever() {
        leverActivated = !leverActivated
        for y in 0..<map.count {
            for x in 0..<map[y].count {
                if map[y][x] == .gate {
                    map[y][x] = leverActivated ? .empty : .gate
                }
            }
        }
    }
    
    func handleInput(_ input: String) {
        switch input.lowercased() {
        case "w": move(player: &waterboyPosition, direction: .up)
        case "a": move(player: &waterboyPosition, direction: .left)
        case "s": move(player: &waterboyPosition, direction: .down)
        case "d": move(player: &waterboyPosition, direction: .right)
        case "↑": move(player: &firegirlPosition, direction: .up)
        case "←": move(player: &firegirlPosition, direction: .left)
        case "↓": move(player: &firegirlPosition, direction: .down)
        case "→": move(player: &firegirlPosition, direction: .right)
        case "l": activateLever()
        default: break
        }
    }
    
    func drawMap() {
        for row in map {
            print(row.map { $0.rawValue }.joined(separator: ""))
        }
    }
}

let map1: [[Game.Tile]] = [
    [.wall, .wall, .wall, .wall, .wall, .wall],
    [.wall, .empty, .empty, .empty, .lever, .wall],
    [.wall, .dangerousLiquid, .empty, .wall, .wall, .wall],
    [.wall, .empty, .empty, .empty, .gate, .wall],
    [.wall, .wall, .wall, .wall, .wall, .wall]
]

let map2: [[Game.Tile]] = [
    [.wall, .wall, .wall, .wall, .wall, .wall],
    [.wall, .empty, .empty, .empty, .lever, .wall],
    [.wall, .empty, .wall, .wall, .dangerousLiquid, .wall],
    [.wall, .empty, .gate, .empty, .empty, .wall],
    [.wall, .wall, .wall, .wall, .wall, .wall]
]

var game = Game(map: map1)
game.drawMap()

while true {
    print("Enter a move (W, A, S, D, ↑,←, ↓, →) or L to activate the lever:")
    if let input = readLine() {
        game.handleInput(input)
        game.drawMap()
    }
}
