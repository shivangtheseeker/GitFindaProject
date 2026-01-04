//
//  GFBodyLabel.swift
//  GitFinda
//
//  Created by Shivang on 27/12/25.
//

import UIKit

class GFBodyLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been used")
    }
    
    init(textAlignement: NSTextAlignment){
        super.init(frame: .zero)
        self.textAlignment = textAlignement
        configure()
    }
    
    private func configure(){
        textColor = .secondaryLabel
        font = UIFont.preferredFont(forTextStyle: .body)
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.75
        lineBreakMode = .byWordWrapping
        translatesAutoresizingMaskIntoConstraints = false
    }

}
