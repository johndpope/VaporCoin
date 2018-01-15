//
//  ClientSignature.swift
//  VaporCoin
//
//  Created by Valtteri Koskivuori on 12/09/2017.
//

import Foundation

//This will contain key loading, signing, funcs to check balance...

class Wallet {
	
	var pubKey: Data? = nil
	var privKey: Data? = nil
	
	//TODO: Make this a calculated value, ripemd160 of pubkey?
	var address: Data {
		return Data()
	}
	
	init(pub: Data, priv: Data) {
		self.pubKey = pub
		self.privKey = priv
	}
	
	init() {
		self.pubKey = nil
		self.privKey = nil
	}
	
	func signTransaction(txn: Transaction, priv: Wallet) -> Data {
		return Data()
	}
	
	//TODO
	func signMessage(msg: Data, priv: Wallet) -> Data {
		//let megaRandomBytes = [0x1a, 0x2b, 0x3c, 0x4d, 0x5e, 0x6f]
		//let ecdsaSHA512Sig = try Signature.sign(message: msg, with: priv.privKey, using: .sha512)
		//let ecdsaPrivateKey = try! CryptoKey(path: "/path/to/ecdsa_privateKey.pem", component: .privateKey(passphrase: nil))
		//let ecdsaSHA512Sig = try Signature.sign(message: megaRandomBytes, with: ecdsaPrivateKey, using: .sha512)
		//let newSignatureee = try Signature.si
		return Data()
	}
	
	//TODO
	func checkSignature(msg: Data, sign: Wallet) -> Bool {
		//'Decrypt' the signature, and then see if hash matches data
		return false
	}
}
