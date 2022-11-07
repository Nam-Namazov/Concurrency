//
//  RaceCondition.swift
//  ConcurrencyProblems
//
//  Created by Намик on 11/6/22.
//

import Foundation

final class RaceCondition {
    
    private static let firstQueue = DispatchQueue.global()
    private static let secondQueue = DispatchQueue.global()
    private static var counter = 0 {
        didSet {
            print(counter)
        }
    }
    
    static func run() {
        firstQueue.async {
            for i in 0...10 {
                counter = i
            }
        }

        secondQueue.async {
            for i in 0...10 {
                counter = i
            }
        }
    }
    
    final class Solution {
        private static let serialQueue = DispatchQueue(label: "RaceCondition")

        private static var _counter = 0 {
            didSet {
                print(_counter)
            }
        }
        
        private static var counter: Int {
            get {
                serialQueue.sync {
                    _counter
                }
            }

            set {
                serialQueue.sync {
                _counter = newValue

                }
            }
        }
        
        static func run() {
            firstQueue.async {
                for i in 0...10 {
                    counter = i
                }
            }

            secondQueue.async {
                for i in 0...10 {
                    counter = i
                }
            }
        }
    }
}
