//
//  newsPageProtocol.swift
//  AppWeatherVIPER
//
//  Created by Aleph-AHV2D on 28/10/24.
//

import Foundation

protocol newsPageViewProtocol: AnyObject {
    var presenterToView: newsPagePreProtocol? {get set}
    
    func loadNewsData()
}

protocol newsPagePreProtocol: AnyObject{
    var view: newsPageViewProtocol? {get set}
    var router: newsPageRouterProtocol? {get set}
    var interactor: newsPageInteractorProtocol? {get set}
    
    func getDataNews() -> [Item]?
}

protocol newsPageRouterProtocol: AnyObject {
    
}

protocol newsPageInteractorProtocol:AnyObject{
    func getDataJSON() -> [Item]? 
}
