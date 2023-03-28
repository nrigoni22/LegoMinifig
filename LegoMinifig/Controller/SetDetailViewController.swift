//
//  SetDetailViewController.swift
//  LegoMinifig
//
//  Created by Nicola Rigoni on 24/03/23.
//

import UIKit

class SetDetailViewController: UIViewController {

    var selectedSet: String? 
    
    let detailSetManager: SetDetailManager = SetDetailManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Task {
            try await detailSetManager.fetchSetAndComponents(setNum: selectedSet)
        }
        
    }
    

    

}
