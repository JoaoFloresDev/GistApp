//
//  DependencieManager.swift
//  GistApp
//
//  Created by Joao Victor Flores da Costa on 24/05/24.
//

import Foundation
import CoreApiInterface
import CoreApi

typealias AllDependencies = CoreApiDependence

public class BaseDependencieInjector: AllDependencies {
    public var coreApi: ApiFactoring

    public init(coreApi: ApiFactoring) {
        self.coreApi = coreApi
    }
}

class DependencieContainer: AllDependencies {
    lazy var coreApi: CoreApiInterface.ApiFactoring = ApiFactory()
}
