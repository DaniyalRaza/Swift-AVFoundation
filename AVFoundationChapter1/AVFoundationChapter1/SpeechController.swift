//
//  SpeechController.swift
//  AVFoundationChapter1
//
//  Created by PanaCloud on 03/03/2015.
//  Copyright (c) 2015 PanaCloud. All rights reserved.
//

import UIKit
import AVFoundation

class SpeechController: NSObject {
   
    var synthesizer=AVSpeechSynthesizer()
    var voices:[AVSpeechSynthesisVoice]!
    var speechStrings:[String]!
    
    override init(){
        super.init()
        voices=[AVSpeechSynthesisVoice(language: "en-US"),AVSpeechSynthesisVoice(language: "en-GB")]
        speechStrings=self.buildSpeechStrings()
        
    }
    
    func buildSpeechStrings()->[String]{
        return ["Kamal Hunzai","Hello AV Foundation. How are you?",
            "I'm well! Thanks for asking.",
            "Are you excited about the book?",
            "Very! I have always felt so misunderstood.",
            "What's your favorite feature?",
            "Oh, they're all my babies.  I couldn't possibly choose.",
            "It was great to speak with you!",
            "The pleasure was all mine!  Have fun!"]
    }
    
    func beginConversation(){
        for(var i=0;i<self.speechStrings.count;i++){
            var utterance=AVSpeechUtterance(string: self.speechStrings[i])
            utterance.voice=self.voices[i%2]
            utterance.rate=0.3
            utterance.pitchMultiplier=0.8
            utterance.postUtteranceDelay=0.1
            self.synthesizer.speakUtterance(utterance)
            
        }
    }
}