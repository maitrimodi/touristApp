//
//  AttractionViewController.swift
//  TouristApp
//
//  Created by Nevil Sheta on 03/04/21.
//

import UIKit

class AttractionViewController: UIViewController,  UITableViewDelegate, UITableViewDataSource {
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
//       let attractions:[AttractionList] = try! JSONDecoder().decode([AttractionList].self, from:jsonData)
//        for a in attractions {
//            cell?.attractionNameLabel.text = record.name
//            cell?.addressLabel.text = record.address
//            print("")
//        }
        cell?.attractionNameLabel.text = record.name
        cell?.addressLabel.text = record.address
        cell?.imageOutlet.image = UIImage(named: record.photos[0])
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let sectionSelected = indexPath.section
                let rowSelected = indexPath.row
        //        print("You clicked: Section: \(sectionSelected), Row\(rowSelected)")
        //
        //        if(sectionSelected == 0 ){
        //            resultsLabel.text = actionMovies[rowSelected]
        //        }
        //        else if (sectionSelected == 1){
        //            resultsLabel.text = fictionMovies[rowSelected]
        //        }
        //        else if (sectionSelected == 2){
        //            resultsLabel.text = romanceMovies[rowSelected]
        //        }
        //        else if (sectionSelected == 3){
        //            resultsLabel.text = disneyMovies[rowSelected]
        //        }
        //        else if (sectionSelected == 4){
        //            resultsLabel.text = oscarMovies[rowSelected]
        //        }
        
        let attraction = records[rowSelected]
        guard let pass = storyboard?.instantiateViewController(identifier: "attractionDetails") as? AttractionDetailsViewController else {
                        print("Cannot find the pass view controller")
                        return
                    }
                    pass.attraction = attraction
                    show(pass, sender: self)    }
    
    //-----------------
    //MARK: Outlets
    //-----------------
    
    @IBOutlet weak var attractionListTableView: UITableView!
    var records: [AttractionList] = []
    
    let defaults = UserDefaults.standard

    //------------------------
    //MARK: Default Functions
    //------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "ATTRACTIONS"
        let logButton : UIBarButtonItem = UIBarButtonItem(title: "Logout", style: UIBarButtonItem.Style.plain, target: self, action: #selector(gotSettingPage))
        
        self.navigationItem.rightBarButtonItem = logButton
        
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
//                        let name = defaults.string(forKey: "name")
//                    let address = defaults.string(forKey: "address")
//                    let website = defaults.string(forKey: "website")
//                    let description = defaults.string(forKey: "description")
//                    let pricing = defaults.double(forKey: "pricing")
//                    if(name != 0 && address != 0) {
//                        let att = Game(tigers: tigers, werewolves: werewolves)
//                        records.append(game)
//                    }
//                    let x = AttractionList(name: name!, address: address!, website: website!, description: description!, pricing: pricing)
//                    records.append(x)
                        // output the person's name, hourlyWage, pet
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
        self.navigationController?.popViewController(animated: true)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        defaults.setValue(false, forKey: "rememberMeState")
    }
}

