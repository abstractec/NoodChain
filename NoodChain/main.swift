//
//  main.swift
//  NoodChain
//
//  Created by Haseldon, John on 6/28/18.
//  Copyright © 2018 Chain. All rights reserved.
//

import Foundation

var chain = Chain()
let difficulty = 5

var genesisBlock = Block(data: "I am the first block", previousHash: "0")
chain.add(genesisBlock)
genesisBlock.mine(difficulty: difficulty)

var secondBlock = Block(data: "I am the second block", previousHash: genesisBlock.currentHash!)
chain.add(secondBlock)
secondBlock.mine(difficulty: difficulty)

var thirdBlock = Block(data: "I am the third block", previousHash: secondBlock.currentHash!)
chain.add(thirdBlock)
thirdBlock.mine(difficulty: difficulty)

let encoder = JSONEncoder()
encoder.outputFormatting = .prettyPrinted

let data = try encoder.encode(chain)
if let output = String(data: data, encoding: .utf8) {
    print ("\(output)")
}

print ("is chain valid? \(chain.valid())")
