//
//  Card.swift
//  gameSet
//
//  Created by Anna Shuryaeva on 20.03.2022.
//

import Foundation
import UIKit

struct Cards: CustomStringConvertible, Equatable {

    var description: String { return ("\(howMany)\(shape)\(fill)\(color)")}
    var howMany: Variant
    var shape: Variant
    var fill: Variant
    var color: Variant

    enum Variant: Int {
        case one = 0
        case two = 1
        case three = 2

        static var all = [Variant.one, .three, .two]

        var description: Int { return rawValue}
    }

    static func isSet(cards: [Cards]) -> Bool {
        guard cards.count == 3 else { return false }
        let sum = [
        cards.reduce(0, { $0 + $1.howMany.rawValue}),
        cards.reduce(0, { $0 + $1.color.rawValue}),
        cards.reduce(0, { $0 + $1.shape.rawValue}),
        cards.reduce(0, { $0 + $1.fill.rawValue})
        ]
        return sum.reduce(true, { $0 && ($1 % 3 == 0) })
    }
}
