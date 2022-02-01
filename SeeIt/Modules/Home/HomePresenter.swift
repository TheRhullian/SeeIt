//  
//  HomePresenter.swift
//  SeeIt
//
//  Created by Rhullian Damião on 30/01/22.
//

import Foundation

protocol HomePresenterDelegate: AnyObject {
}

class HomePresenter {
    
    weak var delegate: HomePresenterDelegate?
    
    init(delegate: HomePresenterDelegate) {
        
        self.delegate = delegate
    }
    
    func didLoad() {
    }
    
    func willAppear() {
    }
    
    func didAppear() {
    }
}
