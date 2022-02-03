//  
//  EpisodeDetailsPresenter.swift
//  SeeIt
//
//  Created by Rhullian Damião on 03/02/22.
//

import Foundation

protocol EpisodeDetailsPresenterDelegate: AnyObject {
}

class EpisodeDetailsPresenter {
    
    weak var delegate: EpisodeDetailsPresenterDelegate?
    
    init(delegate: EpisodeDetailsPresenterDelegate) {
        
        self.delegate = delegate
    }
    
    func didLoad() {
    }
    
    func willAppear() {
    }
    
    func didAppear() {
    }
}
