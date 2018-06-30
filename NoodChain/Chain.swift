//
//  Chain.swift
//  NoodChain
//
//  Created by Haseldon, John on 6/28/18.
//  Copyright © 2018 Chain. All rights reserved.
//

import Cocoa

class Chain: NSObject, Encodable {
    var chain: [Block] = []

    func add(_ block: Block) {
        chain.append(block)
    }

    func valid() -> ChainStatus {
        var currentBlock: Block?
        var previousBlock: Block?

        for idx in 1..<chain.count {
            currentBlock = chain[idx]
            previousBlock = chain[idx - 1]

            guard let current = currentBlock, let previous = previousBlock, let currentHash = current.currentHash else {
                print ("could not get all values")
                return .internalError
            }

            if currentHash != current.calculatedHash() {
                print ("Current Hashes not equal")
                return .currentHashInequality
            }

            if previous.currentHash != current.previousHash {
                print ("Previous hashes not equal")
                return .previousHashInequality
            }
        }

        return .valid
    }
}

enum ChainStatus {
    case valid
    case internalError
    case currentHashInequality
    case previousHashInequality
}
