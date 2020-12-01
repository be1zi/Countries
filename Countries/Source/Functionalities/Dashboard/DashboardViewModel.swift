//
//  DashboardViewModel.swift
//  Countries
//
//  Created by Konrad Belzowski on 30/11/2020.
//

import RxSwift
import RxCocoa

public class DashboardViewModel {
    
    //
    // MARK: - Properties
    //
    
    public let cellName = String(describing: DashboardTableViewCell.self)
    public let countriesSubject = BehaviorRelay<[CountryModel]>(value: [])
    public let isUpdating = PublishSubject<Bool>()
    private var disposeBag = DisposeBag()
    
    //
    // MARK: - Init
    //
    
    public init() {
        getAllCountries()
    }
    
    //
    // MARK: - Methods
    //
    
    public func getAllCountries() {
        
        disposeBag = DisposeBag()
        isUpdating.onNext(true)
        
        CountryRepository.shared.getCountries().subscribe(onNext: { [weak self] countries in
            self?.isUpdating.onNext(false)
            self?.countriesSubject.accept(countries)
        }).disposed(by: disposeBag)
    }
}
