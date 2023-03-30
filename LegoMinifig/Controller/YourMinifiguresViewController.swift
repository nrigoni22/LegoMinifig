//
//  YourMinifiguresViewController.swift
//  LegoMinifig
//
//  Created by Nicola Rigoni on 24/03/23.
//

import UIKit

class YourMinifiguresViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var sets: SetModel? = nil
    
    let userMinifigureManager: MinifiguresSetManager = MinifiguresSetManager()
    
    var selectedSet: String? = nil
    var selectedSetListID: Int? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        navigationItem.hidesBackButton = true
        navigationItem.title = "Your minifigures"
        // Do any additional setup after loading the view.
        tableView.register(MinifiguresBannerCell.nib(), forCellReuseIdentifier: MinifiguresBannerCell.identifier)
        fetchUserMinifigureSet()
        
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
    }
    
    @IBAction func LogoutButton(_ sender: UIBarButtonItem) {
        print("logout pressed")
        UserDefaults.standard.set(nil, forKey: "user_token")
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func didPullToRefresh(){
        print("refreshing")
//        Task { @MainActor in
//            guard let sets = try await userMinifigureManager.fetchUserSets() else { return }
//            self.sets = sets
//            self.tableView.reloadData()
//            self.tableView.refreshControl?.endRefreshing()
//        }
    }
    
    private func fetchUserMinifigureSet() {
        Task { @MainActor in
            guard let userSet = try await userMinifigureManager.fetchUserSets() else { return }
            self.sets = userSet
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sets else { return  0 }
        
        return sets.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MinifiguresBannerCell.identifier, for: indexPath) as! MinifiguresBannerCell
        if let sets {
            cell.selectionStyle = .none
            cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
            cell.configure(setProperty: sets.results[indexPath.row].propertySet)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let sets {
            selectedSet = sets.results[indexPath.row].propertySet.setNum
            selectedSetListID = sets.results[indexPath.row].listID
            tableView.deselectRow(at: indexPath, animated: true)
            self.performSegue(withIdentifier: "toSetDetail", sender: self)
        }
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let setDetailVC = segue.destination as! SetDetailViewController
        setDetailVC.selectedSet = selectedSet!
        setDetailVC.listID = selectedSetListID
    }
   

}
