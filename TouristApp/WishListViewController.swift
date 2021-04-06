//
//  WishListViewController.swift
//  TouristApp
//
//  Created by Nevil Sheta on 06/04/21.
//

import UIKit

class WishlistViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let defaults = UserDefaults.standard
    
    var objData:[AttractionList] = []
    var wishList:[AttractionList] = []
    var wishPlace:AttractionList?
    
    @IBOutlet weak var wishTable: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        wishTable.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let username = defaults.string(forKey: "userName")!
        let getData = defaults.array(forKey: "\(username)_wishids") as? [Int]
        if(getData?.count == nil){
            return 1
        }else{
            return getData!.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "wishTableCell") as! WishTableViewCell
        if(cell == nil){
            cell = WishTableViewCell()
        }
        var records: [AttractionList] = []
        //Fetch wishlisted items and display in table cell respectively
        let username = defaults.string(forKey: "userName")!
        let getData = defaults.array(forKey: "\(username)_wishids") as? [Int]
        if(getData != nil)
        {
            for item in objData{
                for session in getData!{
                    print("\(item.id) + \(item.name) + \(session)")
                    if(item.id == session){
                        records.append(item)
                    }
                }
            }
            let place = records[indexPath.row]
            cell.wishName.text = place.name
            cell.wishPhone.text = place.phoneNo
            cell.wishAddress.text = place.address
        }
        return cell
    }
    
    override func viewDidLoad() {
        self.loadData(fileName: "touristAttraction")
        super.viewDidLoad()
        wishTable.dataSource = self
        wishTable.delegate = self
        wishTable.rowHeight = 100
    }
    
    //getFile Data
    func loadData(fileName:String){
        if let filepath = Bundle.main.path(forResource:fileName, ofType:"json") {
            do {
                let contents = try String(contentsOfFile: filepath)
                let jsonData = contents.data(using: .utf8)!
                objData = try! JSONDecoder().decode([AttractionList].self, from:jsonData)
                let email = defaults.string(forKey: "userName")!
                let getData = defaults.array(forKey: "\(email)_wishids") as? [Int]
                if(getData?.count == nil){
                    print("No Wishlist")
                }else{
                    for data in objData{
                        if(getData!.contains(data.id)){
                            wishList.append(data)
                        }
                    }
                }
                print("Total items \(objData.count)")
            } catch {
                print("Cannot load file")
            }
        }
    }
}
