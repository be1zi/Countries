//
//  CountryRepository.swift
//  Countries
//
//  Created by Konrad Belzowski on 30/11/2020.
//

import RxSwift

public class CountryRepository {
    
    //
    // MARK: - Properties
    //
    
    private let localRepository: CountryLocalRepository
    private let remoteRepository: CountryRemoteRepository
    private var disposeBag = DisposeBag()
    
    //
    // MARK: - Singleton
    //
    
    public static let shared = CountryRepository()
    
    //
    // MARK: - Init
    //
    
    public init() {
        self.localRepository = CountryLocalRepository.shared
        self.remoteRepository = CountryRemoteRepository.shared
    }
    
    public func getCountries() -> Observable<[CountryModel]> {
        
        disposeBag = DisposeBag()
        
        remoteRepository.fetchAllCountries().subscribe(onSuccess: { [weak self] responseData in
            
            if let data = responseData {
                let decoder = JSONDecoder.init()
                
                do {
                    let models = try decoder.decode([CountryModel].self, from: data)
                    try self?.localRepository.add(array: models)
                } catch {
                    print(error)
                }
            }
        }) { error in
            print(error)
        }.disposed(by: disposeBag)
        
        return localRepository.getCountries()
    }
}
