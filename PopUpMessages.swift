//
//  PopUpMessages.swift
//  scrum-ios
//
//  Created by Intermedia on 11/15/18.
//  Copyright © 2018 Matias Glessi. All rights reserved.
//

import Foundation
import SwiftEntryKit


enum PopUpMessageType {
    
    case completion
    case completionWithAction
    case taskCompleted
    
}

class PopUpMessages {
    
    
    static func showCompletedTaskWithCompletion(with title: String, description: String, buttonMessage: String, messageType: PopUpMessageType, dismissAction: @escaping () -> ()){
        let attributes = getAttributesFor(messageType: messageType)

        let image = UIImage(named: "")
        
        var themeImage: EKPopUpMessage.ThemeImage?
        
        if let image = image {
            themeImage = .init(image: .init(image: image, size: CGSize(width: 60, height: 60), contentMode: .scaleAspectFit))
        }
        
        let title = EKProperty.LabelContent(text: title, style: .init(font: Font.HelveticaNeue.medium.with(size: 24), color: .white, alignment: .center))
        let description = EKProperty.LabelContent(text: description, style: .init(font: Font.HelveticaNeue.light.with(size: 16), color: .white, alignment: .center))
        let button = EKProperty.ButtonContent(label: .init(text: buttonMessage, style: .init(font: Font.HelveticaNeue.bold.with(size: 16), color: .gray)), backgroundColor: .white, highlightedBackgroundColor: UIColor.gray.withAlphaComponent(0.05))
        let message = EKPopUpMessage(themeImage: themeImage, title: title, description: description, button: button) {
            SwiftEntryKit.dismiss()
            dismissAction()
        }
        
        let contentView = EKPopUpMessageView(with: message)
        setGradientBackground(to: contentView)
        SwiftEntryKit.display(entry: contentView, using: attributes)
    
    }
    
    
    static func test() {
        let attributes = getAttributesFor(messageType: .taskCompleted)
        self.showPopupMessage(attributes: attributes, title: "DONE", titleColor: .black, description: "", descriptionColor: .black, buttonTitleColor: .white, buttonBackgroundColor: .black)
        
    }
    
    
    static func showCompletedMessage(with title: String, description: String, buttonMessage: String, messageType: PopUpMessageType) {
        let attributes = getAttributesFor(messageType: messageType)
        
        
        let image = UIImage(named: "")
        
        var themeImage: EKPopUpMessage.ThemeImage?
        
        if let image = image {
            themeImage = .init(image: .init(image: image, size: CGSize(width: 60, height: 60), contentMode: .scaleAspectFit))
        }
        
        let title = EKProperty.LabelContent(text: title, style: .init(font: Font.HelveticaNeue.medium.with(size: 24), color: .white, alignment: .center))
        let description = EKProperty.LabelContent(text: description, style: .init(font: Font.HelveticaNeue.light.with(size: 16), color: .white, alignment: .center))
        let button = EKProperty.ButtonContent(label: .init(text: buttonMessage, style: .init(font: Font.HelveticaNeue.bold.with(size: 16), color: .gray)), backgroundColor: .white, highlightedBackgroundColor: UIColor.gray.withAlphaComponent(0.05))
        let message = EKPopUpMessage(themeImage: themeImage, title: title, description: description, button: button) {
            SwiftEntryKit.dismiss()
        }
        
        let contentView = EKPopUpMessageView(with: message)
        setGradientBackground(to: contentView)
        SwiftEntryKit.display(entry: contentView, using: attributes)
        
    }
    
    private static func getAttributesFor(messageType: PopUpMessageType) -> EKAttributes{
        
        var attributes: EKAttributes
        
        switch messageType {
        case .taskCompleted:
            attributes = EKAttributes.bottomFloat
            attributes.hapticFeedbackType = .success
            attributes.displayDuration = .infinity
            attributes.entryBackground = .color(color: .white)
            attributes.screenBackground = .color(color: UIColor(white: 100.0/255.0, alpha: 0.3))
            attributes.shadow = .active(with: .init(color: .black, opacity: 0.3, radius: 8))
            attributes.screenInteraction = .dismiss
            attributes.entryInteraction = .absorbTouches
            attributes.scroll = .enabled(swipeable: false, pullbackAnimation: .jolt)
            attributes.roundCorners = .all(radius: 25)
            attributes.entranceAnimation = .init(translate: .init(duration: 0.7, spring: .init(damping: 1, initialVelocity: 0)),
                                                 scale: .init(from: 1.05, to: 1, duration: 0.4, spring: .init(damping: 1, initialVelocity: 0)))
            attributes.exitAnimation = .init(translate: .init(duration: 0.2))
            attributes.popBehavior = .animated(animation: .init(translate: .init(duration: 0.2)))
            attributes.positionConstraints.verticalOffset = 10
            attributes.positionConstraints.size = .init(width: .offset(value: 20), height: .intrinsic)
            attributes.positionConstraints.maxSize = .init(width: .constant(value: UIScreen.main.bounds.minEdge), height: .intrinsic)
            attributes.statusBar = .dark
        default:
            attributes = EKAttributes.centerFloat
            attributes.hapticFeedbackType = .success
            attributes.displayDuration = .infinity
            attributes.shadow = .active(with: .init(color: .black, opacity: 0.3, radius: 8))
            attributes.screenInteraction = .dismiss
            attributes.entryInteraction = .absorbTouches
            attributes.scroll = .enabled(swipeable: true, pullbackAnimation: .jolt)
            attributes.roundCorners = .all(radius: 8)
            attributes.entranceAnimation = .init(translate: .init(duration: 0.7, spring: .init(damping: 0.7, initialVelocity: 0)),
                                                 scale: .init(from: 0.7, to: 1, duration: 0.4, spring: .init(damping: 1, initialVelocity: 0)))
            attributes.exitAnimation = .init(translate: .init(duration: 0.2))
            attributes.popBehavior = .animated(animation: .init(translate: .init(duration: 0.35)))
            attributes.positionConstraints.size = .init(width: .offset(value: 20), height: .intrinsic)
            attributes.positionConstraints.maxSize = .init(width: .constant(value: UIScreen.main.bounds.minEdge), height: .intrinsic)
            attributes.statusBar = .dark
            
        }
        
        return attributes
    
    }
    
    private static func showPopupMessage(attributes: EKAttributes, title: String, titleColor: UIColor, description: String, descriptionColor: UIColor, buttonTitleColor: UIColor, buttonBackgroundColor: UIColor, image: UIImage? = nil) {
        
        var themeImage: EKPopUpMessage.ThemeImage?
        
        if let image = image {
            themeImage = .init(image: .init(image: image, size: CGSize(width: 60, height: 60), contentMode: .scaleAspectFit))
        }
        
        let title = EKProperty.LabelContent(text: title, style: .init(font: Font.HelveticaNeue.medium.with(size: 24), color: titleColor, alignment: .center))
        let description = EKProperty.LabelContent(text: description, style: .init(font: Font.HelveticaNeue.light.with(size: 16), color: descriptionColor, alignment: .center))
        let button = EKProperty.ButtonContent(label: .init(text: "Got it!", style: .init(font: Font.HelveticaNeue.bold.with(size: 16), color: buttonTitleColor)), backgroundColor: buttonBackgroundColor, highlightedBackgroundColor: buttonTitleColor.withAlphaComponent(0.05))
        let message = EKPopUpMessage(themeImage: themeImage, title: title, description: description, button: button) {
            SwiftEntryKit.dismiss()
        }
        
        let contentView = EKPopUpMessageView(with: message)
        SwiftEntryKit.display(entry: contentView, using: attributes)
    }
    
    
    private static func setGradientBackground(to view: UIView) {
        let backgroundLayer = Colors().gl
        backgroundLayer.frame = view.frame
        view.layer.insertSublayer(backgroundLayer, at: 0)
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
    }
    
}

enum Font {
    enum HelveticaNeue: String {
        case ultraLightItalic = "UltraLightItalic"
        case medium = "Medium"
        case mediumItalic = "MediumItalic"
        case ultraLight = "UltraLight"
        case italic = "Italic"
        case light = "Light"
        case thinItalic = "ThinItalic"
        case lightItalic = "LightItalic"
        case bold = "Bold"
        case thin = "Thin"
        case condensedBlack = "CondensedBlack"
        case condensedBold = "CondensedBold"
        case boldItalic = "BoldItalic"
        
        func with(size: CGFloat) -> UIFont {
            return UIFont(name: "HelveticaNeue-\(rawValue)", size: size)!
        }
    }
}

extension CGRect {
    var minEdge: CGFloat {
        return min(width, height)
    }
}
