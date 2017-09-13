//
//  Block.swift
//  VaporCoin
//
//  Created by Valtteri Koskivuori on 11/09/2017.
//

import Crypto
import Vapor
import Foundation

final class Block: NSObject, NSCoding {
	//Block header
	var prevHash: Data
	var merkleRoot: MerkleRoot
	var timestamp: Double //Unix Tstamp
	var target: Float
	var nonce: Int64 //256 bit hash
	
	var depth: Int
	var txns: [Transaction]
	
	var blockHash: Data {
		return self.encoded().sha256
	}
	
	override init() {
		self.prevHash = Data()
		self.merkleRoot = MerkleRoot()
		self.timestamp = Date().timeIntervalSince1970
		self.target = 1
		self.nonce = 0
		
		self.depth = 0
		self.txns = []
		
	}
	
	init(prevHash: Data, merkleRoot: MerkleRoot, depth: Int, txns: [Transaction], timestamp: Double, difficulty: Float, nonce: Int64) {
		self.prevHash = prevHash
		self.merkleRoot = merkleRoot
		self.depth = depth
		self.txns = txns
		self.timestamp = timestamp
		self.target = difficulty
		self.nonce = nonce
	}
	
	func encoded() -> Data {
		return NSKeyedArchiver.archivedData(withRootObject: self)
	}
	
	func verify() -> Bool {
		//Verify the validity of a block
		
		//Verify the hash
		//Check that the reported hash matches
		let testHash = self.encoded().sha256
		if self.blockHash != testHash {
			print("Block hash doesn't match")
			return false
		}
		//Check that hash is valid
		
		
		//Check timestamp
		
		return true
	}
	
	//MARK: Swift encoding logic
	public convenience required init?(coder aDecoder: NSCoder) {
		let prevHash = aDecoder.decodeObject(forKey: "prevHash") as! Data
		let merkleRoot = aDecoder.decodeObject(forKey: "merkleTree") as! MerkleRoot
		let depth = aDecoder.decodeInteger(forKey: "depth")
		let txns = aDecoder.decodeObject(forKey: "txns") as! [Transaction]
		let timestamp = aDecoder.decodeDouble(forKey: "timestamp")
		let difficulty = aDecoder.decodeFloat(forKey: "difficulty")
		let nonce = aDecoder.decodeInt64(forKey: "nonce")
		
		self.init(prevHash: prevHash, merkleRoot: merkleRoot, depth: depth, txns: txns, timestamp: timestamp, difficulty: difficulty, nonce: nonce)
	}
	
	func encode(with aCoder: NSCoder) {
		aCoder.encode(prevHash, forKey: "prevHash")
		aCoder.encode(merkleRoot, forKey: "merkleRoot")
		aCoder.encode(timestamp, forKey: "timestamp")
		aCoder.encode(target, forKey: "target")
		aCoder.encode(nonce, forKey: "nonce")
		
		/*aCoder.encode(depth, forKey: "depth")
		aCoder.encode(txns, forKey: "txns")*/
	}
}

func genesisBlock() -> Block {
	let genesis = Block(prevHash: Data(), merkleRoot: MerkleRoot(), depth: 0, txns: [], timestamp: 1505278315, difficulty: 1.0, nonce: 0)
	return genesis
}
