//
//  Clock.swift
//  WatchGameTeste Extension
//
//  Created by Pedro Gomes Branco on 26/09/16.
//  Copyright © 2016 Pedro Gomes Branco. All rights reserved.
//

import SpriteKit

class Clock: SKLabelNode {
    
    var endTime:Date!
    
    func startWithDuration(_ duration: TimeInterval){
        let timeNow = Date();
        endTime = timeNow.addingTimeInterval(duration)
    }

    func hasFinished() -> Bool{
        return timeLeft() == 0
    }
    
    func timeLeft() -> TimeInterval{
        let now = Date()
        let remainSeconds = endTime.timeIntervalSince(now)
        return(max(remainSeconds, 0))
    }
}
