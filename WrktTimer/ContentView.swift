//
//  ContentView.swift
//  WrktTimer
//
//  Created by Sam Barton on 4/10/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var selectedPickerIndexMin = 0
    @State var selectedPickerIndexSec = 0
    @ObservedObject var timerManager = TimerManager()

    let avaliableMinutes = Array(0...59)
    let avaliableSeconds = Array(0...59)
    
    var body: some View {
        NavigationView {
            VStack {
                Text(secToMinPlusSec(seconds: timerManager.secondsLeft))
                    .font(.system(size: 80))
                    .padding(.top, 80)
                Image(systemName: timerManager.timerMode == .running ? "pause.circle.fill" : "play.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 180, height: 180)
                    .foregroundColor(.green)
                    .onTapGesture(perform: {
                        if self.timerManager.timerMode == .initial {
                            self.timerManager.setTimerLength(minutes: self.avaliableMinutes[self.selectedPickerIndexMin]*60, seconds: self.selectedPickerIndexSec)
                        }
                        self.timerManager.timerMode == .running ? self.timerManager.pause() : self.timerManager.start()
                    })
                if timerManager.timerMode == .paused {
                    Image(systemName: "gobackward")
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                        .padding(.top, 40)
                        .onTapGesture(perform: {
                            self.timerManager.reset()
                        })
                    
                } else if timerManager.timerMode == .initial {
                    HStack{
                        Picker(selection: $selectedPickerIndexMin, label: Text("")) {
                            ForEach(0 ..< avaliableMinutes.count) {
                                Text("\(self.avaliableMinutes[$0]) min")
                            }
                        }
                        .labelsHidden()
                        Picker(selection: $selectedPickerIndexSec, label: Text("")) {
                            ForEach(0 ..< avaliableSeconds.count) {
                                Text("\(self.avaliableSeconds[$0]) sec")
                            }
                        }
                        .labelsHidden()
                    }
                    Spacer()
                }
                
            }
            .navigationBarTitle("Timer")
        }
        .environment(\.colorScheme, .dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
