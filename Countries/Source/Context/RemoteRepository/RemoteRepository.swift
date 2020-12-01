//
//  RemoteRepository.swift
//  Countries
//
//  Created by Konrad Belzowski on 30/11/2020.
//

import Alamofire
import RxAlamofire
import RxSwift

public class RemoteRepository {
    
    //
    // MARK: - Properties
    //
    
    private let serverAddress: String?
    private let serverKey: String?
    private let session: Session

    //
    // MARK: - Init
    //
    
    public init() {
        
        self.session = Session.default
        self.serverAddress = ConfigurationManager.shared.property(forKey: "serverAddress")
        self.serverKey = ConfigurationManager.shared.property(forKey: "serverKey")
    }
    
    //
    // MARK: - Methods
    //
    
    public func requestBuilder(_ urlString: String, method: HTTPMethod, parameters: [String: Any]? = nil) -> Single<DataResponse<Any, AFError>> {
        
        guard let serverURL = serverAddress, let key = serverKey else {
            let error = NSError(domain: "RemoteRepository", code: 0, userInfo: ["message" : "Cant load server address from configuration file"])
            return Single.error(error)
        }
     
        let finalURL = serverURL + urlString
        let encoding = JSONEncoding.default
        let headers = HTTPHeaders.init(["Content-Type": "application/json", "x-rapidapi-key" : key])
        
        return session.rx.request(method, finalURL, parameters: parameters, encoding: encoding, headers: headers)
            .responseJSON()
            .observeOn(MainScheduler.instance)
            .asSingle()
    }
}
