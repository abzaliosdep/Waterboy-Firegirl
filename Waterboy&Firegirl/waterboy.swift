//
//  waterboy.swift
//  Waterboy&Firegirl
//
//  Created by Абзал Бухарбай on 30.04.2023.
//

import Foundation

class Waterboy {
    var x: Int // позиция по горизонтали
    var y: Int // позиция по вертикали
    var hasKey: Bool // флаг наличия ключа
    
    init() {
        self.x = 0
        self.y = 0
        self.hasKey = false
    }
    
    func moveLeft() {
        self.x -= 1
    }
    
    func moveRight() {
        self.x += 1
    }
    
    func moveUp() {
        self.y -= 1
    }
    
    func moveDown() {
        self.y += 1
    }
    
    func collectKey() {
        self.hasKey = true
    }
    
    func openDoor() -> Bool {
        if self.hasKey {
            self.hasKey = false
            return true
        } else {
            return false
        }
    }
}
