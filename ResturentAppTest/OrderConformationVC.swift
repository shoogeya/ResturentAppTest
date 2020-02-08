//
//  OrderConformationVC.swift
//  ResturentAppTest
//
//  Created by mac on 06/02/2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class OrderConformationVC: UIViewController {

    @IBOutlet var timeRmeningLabal: UILabel!
    var minits: Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        timeRmeningLabal.text = "Thank you for order! your wait Time is approxmatly\(minits!) minutus"
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
