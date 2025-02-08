//
//  APIConfiguration.swift
//  WallaMarvel
//
//  Created by Norhan Boghdadi on 06/02/2025.
//

import Foundation


struct APIConfiguration {
    static let baseURL = "https://gateway.marvel.com:443"
    private static var privateKey: String {
        return Bundle.main.infoDictionary?["MARVEL_PRIVATE_KEY"] as? String ?? ""
    }

    private static var publicKey: String {
        return Bundle.main.infoDictionary?["MARVEL_PUBLIC_KEY"] as? String ?? ""
    }

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
