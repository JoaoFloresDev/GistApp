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

class DependencieContainer: AllDependencies {
    lazy var coreApi: ApiFactoring = ApiFactory()
}
