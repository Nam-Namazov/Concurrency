//
//  PriorityInversion.swift
//  ConcurrencyProblems
//
//  Created by Намик on 11/6/22.
//

import Foundation

final class PrioirtyInversion {
    private static let high = DispatchQueue.global(qos: .userInteractive)
    private static let medium = DispatchQueue.global(qos: .userInitiated)
    private static let low = DispatchQueue.global(qos: .background)
    
    private static let semaphore = DispatchSemaphore(value: 1)
    
    static func run() {
        high.async {
            // Wait 2 seconds just to be sure all the other tasks have enqueued
            Thread.sleep(forTimeInterval: 2)
            semaphore.wait()
            defer {
                semaphore.signal()
            }
            print("High priority task is now running")
        }
        
        for i in 1 ... 10 {
            medium.async {
                let waitTime = Double(exactly: arc4random_uniform(7))!
                print("Running medium task \(i)")
                Thread.sleep(forTimeInterval: waitTime)
            }
        }
        
        low.async {
            semaphore.wait()
            defer { semaphore.signal() }
            print("Running long, lowest priority task")
            Thread.sleep(forTimeInterval: 5)
        }
    }
}
