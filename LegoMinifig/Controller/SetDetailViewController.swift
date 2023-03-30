//
//  SetDetailViewController.swift
//  LegoMinifig
//
//  Created by Nicola Rigoni on 24/03/23.
//

import UIKit

class SetDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var tableView: UITableView!
    
    var selectedSet: String?
    var listID: Int?
    let detailSetManager: SetDetailManager = SetDetailManager()
    
    var setDetail: [SetPropertyModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(DetailTitleMinifigureCell.nib(), forCellReuseIdentifier: DetailTitleMinifigureCell.identifier)
        tableView.register(DetailComponentsMinifigureCell.nib(), forCellReuseIdentifier: DetailComponentsMinifigureCell.identifier)
        
        

        Task { @MainActor in
            setDetail = try await detailSetManager.fetchCompletedDetail(setNum: selectedSet)
            self.tableView.reloadData() 
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return setDetail.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let titleCell = tableView.dequeueReusableCell(withIdentifier: DetailTitleMinifigureCell.identifier) as! DetailTitleMinifigureCell
        
        let componentsCell = tableView.dequeueReusableCell(withIdentifier: DetailComponentsMinifigureCell.identifier) as! DetailComponentsMinifigureCell
        
        
        
        if indexPath.row == 0 {
            
            titleCell.selectionStyle = .none
            titleCell.configure(setProperty: setDetail[indexPath.row])
            
            return titleCell
        } else {
            componentsCell.selectionStyle = .none
            componentsCell.configure(setProperty: setDetail[indexPath.row])
            
            return componentsCell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
        if indexPath.row == 0 {
            return 200
        }
        return 100
        
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        selectedSet = sets[indexPath.row].results[0].propertySet.setNum
//        selectedSetListID = sets[indexPath.row].results[0].listID
//        tableView.deselectRow(at: indexPath, animated: true)
//        self.performSegue(withIdentifier: "toSetDetail", sender: self)
//
//    }

    

}
