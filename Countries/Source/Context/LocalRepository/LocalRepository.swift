//
//  LocalRepository.swift
//  Countries
//
//  Created by Konrad Belzowski on 30/11/2020.
//

import RealmSwift
import RxRealm
import RxSwift

public class LocalRepository {
    
    //
    // MARK: - Properties
    //
    
    var realm: Realm? {
        get {
            do {
                let realm = try Realm()
                realm.refresh()
                return realm
            } catch {
                print(error.localizedDescription)
                return nil
            }
        }
    }
    
    //
    // MARK: - Add
    //
    
    private func arrayAdd<T>(array: [T]) throws {
        
        guard let realm = self.realm else {
            throw NSError(domain: "Realm", code: 0, userInfo: ["message" : "Cant create realm object"])
        }
        
        guard let realmArray = array as? [Object] else {
            throw NSError(domain: "Realm", code: 0, userInfo: ["message" : "Not realm object"])
        }
        
        try realm.safeWrite {
            realm.add(realmArray, update: .all)
        }
    }
    
    public func add<T>(object: T) throws {
        
        do {
            try arrayAdd(array: [object])
        } catch {
            throw error
        }
    }
    
    public func add<T>(array: [T]) throws {
        
        do {
            try arrayAdd(array: array)
        } catch {
            throw error
        }
    }
    
    //
    // MARK: - Get
    //
    
    private func objects<T>(of type: T.Type, predicate: NSPredicate? = nil) throws -> Results<Object> {

        guard let objectType = T.self as? Object.Type else {
            throw NSError(domain: "Realm", code: 0, userInfo: ["message" : "Not realm object"])
        }
        
        guard let realm = self.realm else {
            throw NSError(domain: "Realm", code: 0, userInfo: ["message" : "Cant create realm object"])
        }
        
        var results = realm.objects(objectType)
        
        if let predicate = predicate {
            results = results.filter(predicate)
        }
        
        return results
    }
    
    public func getArrayObservable<T>(of type: T.Type, predicate: NSPredicate? = nil) -> Observable<[T]> {
        
        do {
            let result = try objects(of: type, predicate: predicate)
                        
            return Observable.collection(from: result).map {
                $0.toArray() as! [T]
            }
        } catch {
            return Observable.error(error)
        }
    }
}

private extension Realm {
    
    func safeWrite(_ block: (() throws -> Void)) throws {
        
        if self.isInWriteTransaction {
            try block()
        } else {
            try self.write(block)
        }
    }
}
