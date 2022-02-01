//
//  ViewController.swift
//  SeeIt
//
//  Created by Rhullian Damião on 28/01/22.
//

import UIKit

class InitialViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupNavigationController()
        let vc = HomeViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        
        self.navigationController?.navigationBar.backgroundColor = UIColor(red: 00/255, green: 04/255, blue: 15/255, alpha: 1)
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 00/255, green: 04/255, blue: 15/255, alpha: 1)
        self.navigationController?.setViewControllers([vc], animated: true)
    }
    
    private func setupNavigationController() {
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationItem.leftBarButtonItem?.setTitleTextAttributes([.foregroundColor: UIColor.clear], for: .normal)
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
}

