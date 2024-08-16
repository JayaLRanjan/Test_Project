//
//  BFootnoteModel.swift
//  LinkedText
//
//  Created by Jaya Lakshmi on 13/08/24.
//

import Foundation
import SwiftUI

public struct BFootnoteModel {
    var footnote: String
    var linkWord:String
    var linkAction: () -> Void
    var footnoteType: FootnoteType
    var footnoteColorType: FootnoteColorType
    var isIcon:Bool
    var accessibilityLabel: String?
    
    public init(
        footnote: String,
        linkWord:String = "",
        linkAction: @escaping () -> Void,
        footnoteType: FootnoteType,
        footnoteColorType: FootnoteColorType,
        isIcon:Bool = true,
        accessibilityLabel: String? = ""
    ) {
        self.footnote = footnote
        self.linkWord = linkWord
        self.linkAction = linkAction
        self.footnoteType = footnoteType
        self.footnoteColorType = footnoteColorType
        self.isIcon = isIcon
        self.accessibilityLabel = accessibilityLabel
    }
}
