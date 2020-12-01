//
//  CountryRemoteRepository.swift
//  Countries
//
//  Created by Konrad Belzowski on 30/11/2020.
//

import RxSwift
import Alamofire

public class CountryRemoteRepository: RemoteRepository {
    
    //
    // MARK: - Singleton
    //
    
    public static let shared = CountryRemoteRepository()
    
    //
    // MARK: - Methods
    //
    
    public func fetchAllCountries() -> Single<Data?> {
        return requestBuilder("/all", method: .get, parameters: nil).map { $0.data }
    }
}
