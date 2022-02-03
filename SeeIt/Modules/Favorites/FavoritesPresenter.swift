//  
//  FavoritesPresenter.swift
//  SeeIt
//
//  Created by Rhullian Damião on 03/02/22.
//

import Foundation

protocol FavoritesPresenterDelegate: AnyObject {
}

class FavoritesPresenter {
    
    weak var delegate: FavoritesPresenterDelegate?
    
    init(delegate: FavoritesPresenterDelegate) {
        
        self.delegate = delegate
    }
    
    func didLoad() {
    }
    
    func willAppear() {
    }
    
    func didAppear() {
    }
}
