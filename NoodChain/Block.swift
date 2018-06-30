//
//  Block.swift
//  NoodChain
//
//  Created by Haseldon, John on 6/28/18.
//  Copyright © 2018 Chain. All rights reserved.
//

import Cocoa

class Block: NSObject, Codable {
    var currentHash: String?
    var previousHash: String
    private var data: String
    private var timestamp: Double
    private var nonce = 0

    init(data: String, previousHash: String) {
        self.data = data
        self.previousHash = previousHash
        self.timestamp = Date().timeIntervalSince1970

        super.init()

        self.currentHash = calculatedHash()
    }

    func calculatedHash() -> String {
        return String.sha256(input: "\(previousHash)\(timestamp)\(nonce)\(data)")
    }

    func mine(difficulty: Int) {
        let target = randomString(length: difficulty).replacingOccurrences(of: "\0", with: "0")
        var found = false

        while !found {
            nonce = nonce + 1
            currentHash = calculatedHash()

            if (currentHash?.starts(with: target))! {
                found = true
            }
        }
    }

    func randomString(length: Int) -> String {

        let letters : NSString = "abcdef0123456789"
        let len = UInt32(letters.length)

        var randomString = ""

        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }

        return randomString
    }
}

