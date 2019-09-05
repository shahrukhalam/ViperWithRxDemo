import UIKit

struct TextStyle {
    let color: UIColor
    let font: UIFont
    let align: NSTextAlignment

    init(color: UIColor,
         font: UIFont,
         align: NSTextAlignment) {
        self.color = color
        self.font = font
        self.align = align
    }

    var attributes: [NSAttributedStringKey: Any] {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byTruncatingTail
        paragraphStyle.alignment = align

        return [
            .paragraphStyle: paragraphStyle,
            .foregroundColor: color,
            .font: font
        ]
    }
}

struct TextElement {
    let text: String
    let style: TextStyle

    func attributedString() -> NSAttributedString {
        let attributedString = NSMutableAttributedString(
            string: text,
            attributes: style.attributes
        )

        return attributedString
    }
}
