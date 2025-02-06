//
//  APIConfiguration.swift
//  WallaMarvel
//
//  Created by Norhan Boghdadi on 06/02/2025.
//

import Foundation


struct APIConfiguration {
    static let baseURL = "https://gateway.marvel.com:443"
    static let privateKey = "188f9a5aa76846d907c41cbea6506e4cc455293f"
    static let publicKey = "d575c26d5c746f623518e753921ac847"
    
    static func authenticationQueryItems() -> [URLQueryItem] {
        let ts = String(Int(Date().timeIntervalSince1970))
        let hash = "\(ts)\(privateKey)\(publicKey)".md5
        
        return [
            URLQueryItem(name: "apikey", value: publicKey),
            URLQueryItem(name: "ts", value: ts),
            URLQueryItem(name: "hash", value: hash)
        ]
    }
}
