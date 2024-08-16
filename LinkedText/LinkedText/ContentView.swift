//
//  ContentView.swift
//  LinkedText
//
//  Created by Jaya Lakshmi on 13/08/24.
//

import Foundation
import SwiftUI

struct ContentView: View {
    var body: some View {
        ScrollView{
            VStack {
                BFootNote(model: BFootnoteModel(footnote: "If you are signed in on multiple devices and update your sign-in details, you will need to sign in again on those other devices.", linkWord: "", linkAction: {
                    
                }, footnoteType: .Notice, footnoteColorType: .Secondary))
                BFootNote(model: BFootnoteModel(footnote: "Learn more about your digital card.", linkWord: "Learn more about your digital card.", linkAction: {
                    
                }, footnoteType: .NoticeWithLink, footnoteColorType: .Primary))
                
                BFootNote(model: BFootnoteModel(footnote: "If other options are not available for some reason, check your contact details and try again later.", linkWord: "contact details", linkAction: {
                    
                }, footnoteType: .withLink, footnoteColorType: .Primary))
                
                BFootNote(model: BFootnoteModel(footnote: "Please check out Terms and conditions", linkWord: "Terms and conditions", linkAction: {
                    
                }, footnoteType: .withLink, footnoteColorType: .Secondary, isIcon: false))
            }
        }
    }
}
