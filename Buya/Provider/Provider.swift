//
//  Provider.swift
//  Buya
//
//  Created by Eric Basargin on 02/03/2019.
//  Copyright © 2019 Three-man army. All rights reserved.
//

import Foundation
import RxSwift

public protocol ProviderProtocol: class {
    associatedtype Endpoint: EndpointType
    
    func request(_ endpoint: Endpoint) -> Single<Data>
}

public class Provider<Endpoint: EndpointType>: ProviderProtocol {
    private let networkWorker: NetworkWorkerProtocol
    private let jsonEncoder: JSONEncoder
    private let plugins: [PluginType]
    
    let addressManager: AddressManagerProtocol
    
    init(addressManager: AddressManagerProtocol,
         plugins: [PluginType] = [],
         networkWorker: NetworkWorkerProtocol = NetworkWorker(),
         jsonEncoder: JSONEncoder = JSONEncoder()) {
        self.addressManager = addressManager
        self.plugins = plugins
        self.networkWorker = networkWorker
        self.jsonEncoder = jsonEncoder
    }
    
    public func request(_ endpoint: Endpoint) -> Single<Data> {
        return self.createURLRequest(endpoint).flatMap { (urlRequest) -> Single<Data> in
            var urlRequest = urlRequest
            
            for plugin in self.plugins {
                urlRequest = plugin.prepare(urlRequest, endpoint: endpoint)
            }
            
            var result = self.networkWorker.performRequest(urlRequest)
            
            for plugin in self.plugins {
                result = plugin.process(result, endpoint: endpoint)
            }
            
            return result
        }
    }
}