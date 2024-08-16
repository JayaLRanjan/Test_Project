//
//  BFootNote.swift
//  LinkedText
//
//  Created by Jaya Lakshmi on 13/08/24.
//

import SwiftUI

struct BFootNote: View {
    @ObservedObject private var viewModel: BFootnoteViewModel
    
    public var body: some View {
        HStack(alignment: .top){
            if viewModel.footnoteModel.isIcon {
                Image("Information")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .padding(.top, 6)
                    .accessibilityLabel("Information")
            }
            BFootNoteView(viewModel: viewModel)
        }
        .padding()
        .border(Color.black)
    }
    
    public init(model: BFootnoteModel) {
        self.viewModel = BFootnoteViewModel(footnoteModel: model)
    }
}

struct BFootNoteView: View {
    @ObservedObject var viewModel: BFootnoteViewModel
    let sentence: String
    let linkedWord: String
    let footnoteType: FootnoteType
    
    var body: some View {
        VStack(spacing: 0){
            GeometryReader { geometry in
                let availableWidth = geometry.size.width
            
                WrappedText(viewModel: viewModel, sentence: sentence, availableWidth: availableWidth, linkedWord: linkedWord)
                    .fixedSize(horizontal: false, vertical: true)
                    .accessibilityElement(children: .combine)
                    .accessibilityLabel(Text((viewModel.footnoteModel.accessibilityLabel ?? "") + sentence))
            }
            .frame(height: calculateHeight(for: sentence, availableWidth: UIScreen.main.bounds.width * 0.7))
            .padding(.vertical, 4)
            .padding(.horizontal, 4)
        }
    }
    
    init(viewModel: BFootnoteViewModel) {
        self.viewModel = viewModel
        self.sentence = viewModel.footnoteModel.footnote
        self.linkedWord = viewModel.footnoteModel.linkWord
        self.footnoteType = viewModel.footnoteModel.footnoteType
    }
}

struct WrappedText: View {
    var viewModel: BFootnoteViewModel
    let sentence: String
    let availableWidth: CGFloat
    let linkedWord: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            let lines = calculateLines(for: sentence, linkedWord: linkedWord, availableWidth: availableWidth)
            
            ForEach(lines, id: \.self) { line in
                HStack(spacing: 4) {
                    ForEach(line, id: \.self) { word in
                        if linkedWord.contains(word) {
                            Text(word)
                                .foregroundColor(.blue)
                                .font(.body)
                                .onTapGesture {
                                    viewModel.linkTap()
                                }
                                .accessibilityAddTraits(.isLink)
                                
                        } else {
                            Text(word)
                                .font(.body)
                                .foregroundStyle(viewModel.footnoteModel.footnoteColorType == .Primary ? Color.black : Color.gray)
                        }
                    }
                }
            }
        }
    }

    private func calculateLines(for sentence: String, linkedWord: String, availableWidth: CGFloat) -> [[String]] {
        var lines: [[String]] = []
        var currentLine: [String] = []
        var currentLineWidth: CGFloat = 0
        let font = UIFont.preferredFont(forTextStyle: .body)
        let words = sentence.split(separator: " ").map { String($0) }

        func textWidth(_ text: String) -> CGFloat {
            return text.size(withAttributes: [.font: font]).width
        }

        for word in words {
            let wordWidth = textWidth(word)
            
            if currentLineWidth + wordWidth + (currentLine.isEmpty ? 0 : 4) > availableWidth {
                lines.append(currentLine)
                currentLine = [word]
                currentLineWidth = wordWidth
            } else {
                currentLine.append(word)
                currentLineWidth += wordWidth + (currentLine.count > 1 ? 4 : 0)
            }
        }

        if !currentLine.isEmpty {
            lines.append(currentLine)
        }

        return lines
    }
}

private func calculateHeight(for sentence: String, availableWidth: CGFloat) -> CGFloat {
    let font = UIFont.preferredFont(forTextStyle: .body)
    let text = NSString(string: sentence)
    let constraintRect = CGSize(width: availableWidth, height: .greatestFiniteMagnitude)
    
    let boundingBox = text.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
    
    return ceil(boundingBox.height)
}






