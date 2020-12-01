//
//  ConfigurationManager.swift
//  Countries
//
//  Created by Konrad Belzowski on 30/11/2020.
//

import Foundation

public class ConfigurationManager {
    
    //
    // MARK: - Properties
    //
    
    private var properties = NSDictionary()
    
    //
    // MARK: - Singleton
    //
    
    public static let shared = ConfigurationManager()
    
    //
    // MARK: - Init
    //
    
    private init() {
        loadConfiguration()
    }
    
    //
    // MARK: - Helpers
    //
    
    private func loadConfiguration() {
        
        if let path = Bundle.main.path(forResource: "config", ofType: "plist"),
           let dictionary = NSDictionary(contentsOfFile: path) {
            properties = dictionary
        }
    }
    
    public func property<T>(forKey key: String) -> T? {
        if let value = properties[key] as? T {
            return value
        }
        
        return nil
    }
}
