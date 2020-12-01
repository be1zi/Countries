//
//  CountryModel.swift
//  Countries
//
//  Created by Konrad Belzowski on 30/11/2020.
//

import RealmSwift

public class CountryModel: Object, Codable {
    
    //
    // MARK: - Properties
    //
    
    @objc dynamic public var name: String = ""
    @objc dynamic public var capital: String?
    @objc dynamic public var region: String?
    
    public override class func primaryKey() -> String? {
        return "name"
    }
    
    private enum CodingKeys: String, CodingKey {
        case name
        case capital
        case region
    }
    
    //
    // MARK: - Init
    //
    
    public convenience required init(from decoder: Decoder) throws {
        self.init()
        
        try self.decode(from: decoder)
    }
    
    //
    // MARK: - Methods
    //
    
    public func decode(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        capital = try container.decodeIfPresent(String.self, forKey: .capital)
        region = try container.decodeIfPresent(String.self, forKey: .region)
    }
}
