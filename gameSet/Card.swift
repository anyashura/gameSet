//
//  Card.swift
//  gameSet
//
//  Created by Anna Shuryaeva on 20.03.2022.
//

import Foundation

struct Cards: CustomStringConvertible {
    
    var description: String { return ("\(howMany)\(shape)\(fill)\(color)")}
    
    var howMany : HowMany
    var shape : Shape
    var fill : Fill
    var color : Color

    enum HowMany : Int {
        case one = 1
        case two = 2
        case three = 3
        
        static var all = [HowMany.one, .three, .two]
        
        var description : Int { return rawValue}
    }

    enum Shape : String {
        case round = "●"
        case square = "◼︎"
        case triangle = "▲"
    
        static var all = [Shape.round, .square, .triangle]
        
        var description : String { return rawValue}
    }

    enum Color : String {
        case blue = "blue"
        case red = "red"
        case green = "green"
        
        static var all = [Color.blue, .green, .red]
        
        var description : String { return rawValue}
    }

    enum Fill : String {
        case filled = "filled"
        case striped = "striped"
        case clear = "clear"
        
        static var all = [Fill.clear, .filled, .striped]
        
        var description : String { return rawValue}
    }
}

