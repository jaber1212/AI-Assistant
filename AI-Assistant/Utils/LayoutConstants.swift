//
//  LayoutConstants.swift
//  AI-Assistant
//
//  Created by M.jaber on 25/12/2025.
//

import Foundation
import UIKit

enum LayoutConstants {
    static let sidebarWidth: CGFloat = 280
    static let scenesBarHeight: CGFloat = 56
    static let sourcesRowHeight: CGFloat = 140
}
import UIKit

import UIKit

enum Colors {
    static let appBackground = UIColor.black
    static let panelBackground = UIColor(white: 0.12, alpha: 1)
    static let panelItemBackground = UIColor(white: 0.18, alpha: 1)
    static let pillBackground = UIColor(white: 0.25, alpha: 1)
    static let videoWallHeader = UIColor(red: 0.38, green: 0.38, blue: 0.38, alpha: 1)
    static let borderGray =  UIColor(white: 1, alpha: 0.25)
    static let activeGreen = UIColor(
        red: 0.12,
        green: 0.84,
        blue: 0.38,
        alpha: 1
    )
    static let inactiveRed = UIColor(
        red: 1.0,
        green: 0.23,
        blue: 0.19,
        alpha: 1
    )

}
import UIKit

enum Fonts {
    static let title = UIFont.systemFont(ofSize: 16, weight: .semibold)
    static let subtitle = UIFont.systemFont(ofSize: 13, weight: .medium)
    static let caption = UIFont.systemFont(ofSize: 12, weight: .regular)
}
struct Source {
    let name: String
    let image: UIImage?
    let isActive: Bool
}
import UIKit

enum SystemIcons {
    static let lights = UIImage(systemName: "lightbulb.fill")
    static let audio = UIImage(systemName: "speaker.wave.2.fill")
    static let microphone = UIImage(systemName: "mic.fill")
    static let privacy = UIImage(systemName: "eye.slash.fill")

    static let scenesMenu = UIImage(systemName: "line.3.horizontal")
    static let videoWall = UIImage(systemName: "display")
    static let power = UIImage(systemName: "power")
    static let dropdown = UIImage(systemName: "chevron.down")

    static let hdmi = UIImage(systemName: "cable.connector")
    static let appleTV = UIImage(systemName: "tv.fill")
    static let clickshare = UIImage(systemName: "rectangle.on.rectangle")
    static let mtr = UIImage(systemName: "video.fill")
}

extension UIView {
    func findViewController() -> UIViewController? {
        var responder: UIResponder? = self
        while responder != nil {
            if let vc = responder as? UIViewController {
                return vc
            }
            responder = responder?.next
        }
        return nil
    }
}
