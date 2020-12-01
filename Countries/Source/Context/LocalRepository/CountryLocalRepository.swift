//
//  CountryLocalRepository.swift
//  Countries
//
//  Created by Konrad Belzowski on 30/11/2020.
//

import RxSwift

public class CountryLocalRepository: LocalRepository {
 
    //
    // MARK: - Singleton
    //
    
    public static let shared = CountryLocalRepository()
    
    //
    // MARK: - Methods
    //
    
    public func getCountries() -> Observable<[CountryModel]> {
        let sorted = Sorted(key: "name")
        return getArrayObservable(of: CountryModel.self, sorted: sorted)
    }
}
