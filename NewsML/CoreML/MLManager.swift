//
//  MLManager.swift
//  NewsML
//
//  Created by Tallal Javed on 11/6/18.
//  Copyright © 2018 Tallal Javed. All rights reserved.
//

import UIKit

class MLManager: NSObject {
    
    static let sharedInstance = MLManager()

    var model: DocumentClassification!
    
    private let options: NSLinguisticTagger.Options = [.omitWhitespace, .omitPunctuation, .omitOther]
    private lazy var tagger: NSLinguisticTagger = {
        let tagSchemes = NSLinguisticTagger.availableTagSchemes(forLanguage: "en")
        return NSLinguisticTagger(tagSchemes: tagSchemes, options: Int(self.options.rawValue))
    }()
    
    private override init() {
        super.init()
        self.modelInitlizer()
    }
    
    func modelInitlizer() -> Void {
        self.model = DocumentClassification()
    }
    
    // Classifies the text and sends in return a output class label
    func classifyText(input: String) -> (String, Dictionary<String, Double>){
        let modelInput = extractFeatures(from: input)
        guard let modelOutput = try? model.prediction(input: modelInput) else{
            //fatalError("Unexpected runtime error.")
            return ("",Dictionary())
        }
        return (modelOutput.classLabel, modelOutput.classProbability)
    }
    
    func extractFeatures(from text: String) -> [String: Double] {
        var wordCounts = [String: Double]()
        tagger.string = text
        let range = NSRange(location: 0, length: text.count)
        tagger.enumerateTags(in: range, scheme: .tokenType, options: options) { _, tokenRange, _, _ in
            let token = (text as NSString).substring(with: tokenRange).lowercased()
            guard token.count >= 3 else { return }
            guard let value = wordCounts[token] else {
                wordCounts[token] = 1.0
                return
            }
            wordCounts[token] = value + 1.0
        }
        return wordCounts
    }
}
