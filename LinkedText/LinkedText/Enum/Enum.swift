//
//  Enum.swift
//  LinkedText
//
//  Created by Jaya Lakshmi on 13/08/24.
//

import Foundation

/// FootnoteType
///     - Notice: Text without link.
///     - NoticeWithLink: Complete text as a link.
///     - withLink: Text with one link

public enum FootnoteType: CaseIterable {
    case Notice
    case NoticeWithLink
    case withLink
}

/// FootnoteColorType
///     - Primary: Text color in black
///     - Secondary: Text color in gray
public enum FootnoteColorType: CaseIterable {
    case Primary
    case Secondary
}
