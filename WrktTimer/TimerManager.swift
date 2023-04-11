//
//  TimerManager.swift
//  WrktTimer
//
//  Created by Sam Barton on 4/10/23.
//

import Foundation
import SwiftUI

class TimerManager :ObservableObject {
    @Published var timerMode: TimerMode = .initial
    @Published var secondsLeft = UserDefaults.standard.integer(forKey: "timerLength")
    var timer = Timer()
    
    func setTimerLength(minutes: Int, seconds: Int) {
        let defaults = UserDefaults.standard
        defaults.set(minutes + seconds, forKey: "timerLength")
        secondsLeft = minutes + seconds
    }
    
    func start() {
        timerMode = .running
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { timer in
            if self.secondsLeft == 0 {
                self.timerMode = .initial
                self.secondsLeft = 60
                timer.invalidate()
            } else {
                self.secondsLeft -= 1
            }
        })
    }
    func reset() {
        self.timerMode = .initial
        self.secondsLeft = UserDefaults.standard.integer(forKey: "timerLength")
        timer.invalidate()
    }
    
    func pause() {
        self.timerMode = .paused
        timer.invalidate()
    }
}
