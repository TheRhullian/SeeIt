//  
//  ShowDetailsPresenter.swift
//  SeeIt
//
//  Created by Rhullian Damião on 02/02/22.
//

import Foundation

protocol ShowDetailsPresenterDelegate: AnyObject {
}

class ShowDetailsPresenter {
    
    weak var delegate: ShowDetailsPresenterDelegate?
    
    init(delegate: ShowDetailsPresenterDelegate) {
        
        self.delegate = delegate
    }
    
    func didLoad() {
    }
    
    func willAppear() {
    }
    
    func didAppear() {
    }
}
