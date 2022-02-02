//  
//  HomePresenter.swift
//  SeeIt
//
//  Created by Rhullian Damião on 30/01/22.
//

import Foundation

protocol HomePresenterDelegate: AnyObject {
    func homePresenter(didGetResults movies: [Show])
}

class HomePresenter {
    
    weak var delegate: HomePresenterDelegate?
    
    var movieResults: [Show] = [] {
        didSet {
            self.delegate?.homePresenter(didGetResults: self.movieResults)
        }
    }
    
    init(delegate: HomePresenterDelegate) {
        
        self.delegate = delegate
    }
    
    func didLoad() {
        searchMovie(movie: "Marvel")
    }
    
    func willAppear() {
    }
    
    func didAppear() {
    }
    
    func searchMovie(movie: String) {
        let task = URLSession(configuration: .default).showTask(movie: movie) { result, response, error in
            if let err = error {
                print(err)
                return
            }
            
            guard let res = result else { return }
            self.movieResults = res
        }
        task?.resume()
    }
}
