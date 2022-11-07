//
//  Deadlock.swift
//  ConcurrencyProblems
//
//  Created by Намик on 11/6/22.
//

import Foundation

final class Deadlock {
    
    static func run() {
        let queue = DispatchQueue(label: "label")

        queue.async {
            queue.sync {
                // outer block is waiting for this inner block to complete,
                // inner block won't start before outer block finishes
                // => deadlock
            }
            // this will never be reached
        }
    }
    
    final class Solution {
        static func run() {
            let queue = DispatchQueue(label: "label")

            queue.async {
                print("123")
            }

            queue.sync {
                print("123")
            }
        }
    }
}
