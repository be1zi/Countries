//
//  DashboardTableViewCellViewModel.swift
//  Countries
//
//  Created by Konrad Belzowski on 01/12/2020.
//

import Foundation

public class DashboardTableViewCellViewModel {
    
    //
    // MARK: - Properties
    //
    
    public let countryModel: CountryModel
    
    //
    // MARK: - Init
    //
    
    public init(model: CountryModel) {
        self.countryModel = model
    }
}
