//
//  AttractionViewController.swift
//  TouristApp
//
//  Created by Nevil Sheta on 03/04/21.
//

import UIKit

class AttractionViewController: UIViewController,  UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var attractionListTableView: UITableView!
    var records: [AttractionList] = []
    let defaults = UserDefaults.standard
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "attractionListCell") as? AttractionTableViewCell
        
        if (cell == nil) {
            cell = AttractionTableViewCell(
                style: UITableViewCell.CellStyle.default, reuseIdentifier: "attractionListCell"
            )
        }
        
        // here is where you tell the table what the content in the row should be:
        let record = records[indexPath.row]
        cell?.attractionNameLabel.text = record.name
        cell?.addressLabel.text = record.address
        cell?.imageOutlet.image = UIImage(named: record.photos[0])
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rowSelected = indexPath.row
        
        let attraction = records[rowSelected]
        guard let pass = storyboard?.instantiateViewController(identifier: "attractionDetails") as? AttractionDetailsViewController else {
            print("Cannot find the pass view controller")
            return
        }
        pass.attraction = attraction
        show(pass, sender: self)    }
    
    //------------------------
    //MARK: Default Functions
    //------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Attractions"
        //self.title = "Places To See"
        
        let logButton : UIBarButtonItem = UIBarButtonItem(title: "Logout", style: UIBarButtonItem.Style.plain, target: self, action: #selector(gotSettingPage))
        self.navigationItem.rightBarButtonItem = logButton
        
        let backButton : UIBarButtonItem = UIBarButtonItem(title: "Back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(goBackToLoginPage))
        self.navigationItem.leftBarButtonItem = backButton
        
        
        //attach the data source and delegate to the outlet
        attractionListTableView.dataSource = self
        attractionListTableView.delegate = self
        
        self.attractionListTableView.rowHeight = 150
        
        if let filepath = Bundle.main.path(forResource:"touristAttraction", ofType:"json") {
            do {
                // 2. Get the file contents as a string
                let contents = try String(contentsOfFile: filepath)
                print(contents)
                
                // 3. You must convert it to a "JSON" data type //in java its called JSONObject and in swift it is called codable
                // 4. You can parse that data type
                let jsonData = contents.data(using: .utf8)!
                records = try! JSONDecoder().decode([AttractionList].self, from:jsonData)
                print("The number of records in file is \(records.count)")
                // output everones name, hourly wage and if they have pet or not
                
                
            } catch {
                // error trying to convert file to a string
                // or other related issues
                print("Cannot load file")
            } // end do
        } else {
            print("File not found")
        } // end if
    }
    
    
    @objc func gotSettingPage(){
        defaults.setValue(false, forKey: "rememberMeState")
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "loginPage") as? LoginViewController
        navigationController?.setNavigationBarHidden(true, animated: true)
        tabBarController?.tabBar.isHidden = true
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    @objc func goBackToLoginPage()
    {
        defaults.setValue(false, forKey: "rememberMeState")
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "loginPage") as? LoginViewController
        navigationController?.setNavigationBarHidden(true, animated: true)
        tabBarController?.tabBar.isHidden = true
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
}

