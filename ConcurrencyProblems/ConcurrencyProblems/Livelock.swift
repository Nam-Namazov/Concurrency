//
//  Livelock.swift
//  ConcurrencyProblems
//
//  Created by Намик on 11/6/22.
//

import Foundation

final class Livelock {
    private static let semaphore1 = DispatchSemaphore(value: 1)
    private static let semaphore2 = DispatchSemaphore(value: 1)

    static func run() {
        let concurrentQueue = DispatchQueue(label: "test.Deadlock", attributes: .concurrent)

        concurrentQueue.async {
            print("First queue")
            semaphore1.wait()
            sleep(2)
            semaphore2.wait()
            sleep(2)
            semaphore2.signal()
            semaphore1.signal()
            print("first complete") // вечно будет запрашивать этот ресурс, пока мы не добавим signal, будет livelock
        }

        concurrentQueue.async {
            print("Second queue")
            semaphore2.wait()
            sleep(2)
            semaphore1.wait()
            sleep(2)
            semaphore1.signal()
            semaphore2.signal()
            print("second complete") // вечно будет запрашивать этот ресурс, пока мы не добавим signal, будет livelock
        }
    }
    
    final class Solution {
        static func run() {
            let serialQueue = DispatchQueue(label: "Livelock")

            serialQueue.sync {
                print("First queue")
                semaphore1.wait()
                sleep(2)
                semaphore2.wait()
                sleep(2)
                semaphore2.signal()
                semaphore1.signal()
                print("first complete")
            }

            serialQueue.sync {
                print("Second queue")
                semaphore2.wait()
                sleep(2)
                semaphore1.wait()
                sleep(2)
                semaphore1.signal()
                semaphore2.signal()
                print("second complete")
            }
        }

    }
}

