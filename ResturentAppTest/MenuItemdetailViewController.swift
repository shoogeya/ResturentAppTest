//
//  MenuItemdetailViewController.swift
//  ResturentAppTest
//
//  Created by mac on 03/02/2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class MenuItemdetailViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var titleText: UILabel!
    @IBOutlet var priceLabal: UILabel!
    @IBOutlet var detailTextLabal: UILabel!
    @IBOutlet var addToOrderButton: UIButton!
    var menuItem: MenuItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addToOrderButton.layer.cornerRadius = 0.5
        updateUI()
        // Do any additional setup after loading the view.
        
    }
    func updateUI(){
        titleText.text = menuItem.name
        priceLabal.text = String(format: "$%.2f", menuItem.price)
        detailTextLabal.text = menuItem.detailText
        MenuController.shard.fetchImage(url: menuItem.imageURL) { (image) in
            guard let image = image else{return}
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
    }
    
    @IBAction func orderButtonTapped(_ sender: Any) {
        UIView.animate(withDuration: 0.3){
        self.addToOrderButton.transform = CGAffineTransform(scaleX: 3.0, y: 3.0)
          self.addToOrderButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
    }
        MenuController.shard.order.menuItems.append(menuItem)
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
