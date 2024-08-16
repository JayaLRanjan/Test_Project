//
//  BFootnoteViewModel.swift
//  LinkedText
//
//  Created by Jaya Lakshmi on 13/08/24.
//

import Foundation
import SwiftUI
//import Theme

class BFootnoteViewModel:ObservableObject{
    
    @Published var footnoteModel:BFootnoteModel
    
    init(footnoteModel: BFootnoteModel){
        self.footnoteModel = footnoteModel
    }
    
    // Method to handle link tap
    func linkTap() {
        footnoteModel.linkAction() // Execute the action provided when the link is tapped
        print("linkTap-----")
    }
}
