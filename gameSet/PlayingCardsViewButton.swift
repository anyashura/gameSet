//
//  PlayingCardsViewButton.swift
//  gameSet
//
//  Created by Anna Shuryaeva on 25.03.2022.
//

import UIKit

class PlayingCardsViewButton: UIButton {

    let colors: [UIColor] = [.magenta, .blue, .brown]
    let withAlpha = [0.15, 1.0, 0.50]
    let strokeWidths = [-8, -8, 8]
    let shape = ["●", "◼︎", "▲"]
    let number = [1, 2, 3]

    var identifier: String?

    override func draw(_ rect: CGRect) {
//        let roundedRect = UIBezierPath(roundedRect: bounds, cornerRadius: 16.0)
//        roundedRect.addClip()
//        UIColor.white.setFill()
//        roundedRect.fill()
    }

    func attributedName(for card: Card, fontSize: CGFloat ) -> NSAttributedString {
        var newString: String = shape[card.shape.rawValue]
        if card.howMany.rawValue == 1 {
            newString = shape[card.shape.rawValue]
        } else if card.howMany.rawValue == 2 {
            newString = shape[card.shape.rawValue] + shape[card.shape.rawValue]
        } else {
            newString = shape[card.shape.rawValue] + shape[card.shape.rawValue] + shape[card.shape.rawValue]
        }
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: colors[card.color.rawValue].withAlphaComponent(withAlpha[card.fill.rawValue]), .strokeWidth: strokeWidths[card.fill.rawValue], .strokeColor: colors[card.color.rawValue], .font: UIFont.preferredFont(forTextStyle: .body).withSize(fontSize)]

        return NSAttributedString(string: newString, attributes: attributes)
    }
}
