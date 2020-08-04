//
//  ContentView.swift
//  TTS
//
//  Created by dkab on 8/3/20.
//  Copyright © 2020 dkab. All rights reserved.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    
    @State var text: String = "Apple"
    @State var volume: Double = 0.5 // create State
    @State var rate: Double = 0.5 // create State
    
    let synthesizer = AVSpeechSynthesizer()
    @State var selectedVoice : Int = 6
    
    let voices = AVSpeechSynthesisVoice.speechVoices()
    
    
    var body: some View {
        VStack (spacing: 0){
            VStack {
                Text("Text")
                TextField("Title", text: $text)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .font(.system(size:28))
                    .padding()
            }.padding(.vertical)
            Divider()
            VStack {
                Text("Volume")
                Slider(value: $volume, in: 0.0...1.0, step: 0.01)
                    .accentColor(.green)
                    .padding(.horizontal)
            }.padding(.vertical)
//            .background(Color.green.opacity(0.2))
            Divider()
            VStack {
                Text("Rate")
                Slider(value: $rate, in: 0.0...1.0, step: 0.01)
                    .accentColor(.yellow)
                    .padding(.horizontal)
            }
            .padding(.vertical)
//            .background(Color.yellow.opacity(0.2))
            Divider()
            VStack {
                Text("Voice")
                Picker(selection: $selectedVoice, label: Text("")) {
                    ForEach(0..<voices.capacity) {voice in
                        Text("\(self.voices[voice].name) : \(self.voices[voice].language)")
                    }
                }
                .labelsHidden()
            }.padding(.vertical)
            Divider()
            VStack {
                Text("Play")
                Button(action: {
                    let utterance = AVSpeechUtterance(string: self.text)
                    utterance.voice = self.voices[self.selectedVoice]
                    utterance.rate = Float(self.rate)
                    utterance.volume = Float(self.volume)
                    
                    
                    
                    
                    if self.synthesizer.isSpeaking {
                        self.synthesizer.stopSpeaking(at: AVSpeechBoundary(rawValue: 0)!)
                    } else {
                        self.synthesizer.speak(utterance)
                    }
                }) {
                    Image(systemName:  self.synthesizer.isSpeaking ? "stop.fill" : "play.fill" )
                        .font(.system(size:40))
                }.padding()
            }.padding(.vertical)
            
            
            Spacer()
        }.background(Color.blue.opacity(0.15))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
