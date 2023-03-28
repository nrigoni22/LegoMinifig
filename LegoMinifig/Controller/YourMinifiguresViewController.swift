//
//  YourMinifiguresViewController.swift
//  LegoMinifig
//
//  Created by Nicola Rigoni on 24/03/23.
//

import UIKit

class YourMinifiguresViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var sets: [SetModel] = []
    
    let userMinifigureManager: MinifiguresSetManager = MinifiguresSetManager()
    
    var selectedSet: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        navigationItem.hidesBackButton = true
        navigationItem.title = "Your minifigures"
        // Do any additional setup after loading the view.
        tableView.register(MinifiguresBannerCell.nib(), forCellReuseIdentifier: MinifiguresBannerCell.identifier)
        fetchUserMinifigureSet()
    }
    
    @IBAction func LogoutButton(_ sender: UIBarButtonItem) {
        print("logout pressed")
        UserDefaults.standard.set(nil, forKey: "user_token")
        navigationController?.popToRootViewController(animated: true)
    }
    private func fetchUserMinifigureSet() {
        Task { @MainActor in
            guard let sets = try await userMinifigureManager.fetchUserSets() else { return }
            self.sets = sets
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return sets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MinifiguresBannerCell.identifier, for: indexPath) as! MinifiguresBannerCell
        cell.selectionStyle = .none
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        if let imageData = sets[indexPath.row].results[0].propertySet.coverImage, let image = UIImage(data: imageData) {
            cell.configure(title: sets[indexPath.row].results[0].propertySet.name, image: image)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedSet = sets[indexPath.row].results[0].propertySet.setNum
        tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: "toSetDetail", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let setDetailVC = segue.destination as! SetDetailViewController
        setDetailVC.selectedSet = selectedSet!
    }
   

}
