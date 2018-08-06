//
//  Icon.swift
//  Streaks
//
//  Created by Vaed Prasad on 8/6/18.
//  Copyright © 2018 Vaed Prasad. All rights reserved.
//

import Foundation
import UIKit

class Icon {
    let iconName: String
    let iconImageIdentifier: String

    init(iconName: String, iconImageIdentifier: String) {
        self.iconName = iconName
        self.iconImageIdentifier = iconImageIdentifier
    }
    
    func getIcon() -> UIImage {
        guard let image = UIImage(named: "\(iconImageIdentifier)") else {
            fatalError("icon image not found for the name: \(iconImageIdentifier)")
        }
        return image
    }
}
