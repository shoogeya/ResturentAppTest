//
//  OrderTableViewController.swift
//  ResturentAppTest
//
//  Created by mac on 03/02/2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
class OrderTableViewController: UITableViewController {
    
var orderMinutus = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
        
        NotificationCenter.default.addObserver(tableView, selector: #selector(tableView.reloadData), name: MenuController.orderUpdateNotofication, object: nil)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
     
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return MenuController.shard.order.menuItems.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identfiers.OrderCellIdentifier, for: indexPath)

        // Configure the cell...
        configure(cell, forItemAt: indexPath)

        return cell
    }
    func configure(_ cell: UITableViewCell,forItemAt indexPath: IndexPath){
        let orderItem = MenuController.shard.order.menuItems[indexPath.row]
        cell.textLabel?.text = orderItem.name
        cell.detailTextLabel?.text = String(format: "$%.2f", orderItem.price)
        
        MenuController.shard.fetchImage(url: orderItem.imageURL) { (image) in
            guard let image = image else { return }
            DispatchQueue.main.async {
                if let currentIndex = self.tableView.indexPath(for: cell), currentIndex != indexPath {
                    return
                }
                cell.imageView?.image = image
                cell.setNeedsLayout()
            }
        }
    }
 
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            MenuController.shard.order.menuItems.remove(at: indexPath.row)
        }
    }
    
    @IBAction func submitTapped(_ sender: Any) {
        let orderTotal = MenuController.shard.order.menuItems.reduce(0.0) { (result, menuItem) -> Double in
            return result + menuItem.price
        }
        let formattedOrder = String(format: "$%.2f", orderTotal)
        let alert = UIAlertController(title: "ConfirmOrder", message: "You are about to submit your order with a total of \(formattedOrder) ",preferredStyle: .alert )
        alert.addAction(UIAlertAction(title: "Submit", style: .default, handler: { action in
            self.upLoadOrder()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    
        present(alert, animated: true, completion: nil)
            
    
    }
    func upLoadOrder(){
        let menuIDs = MenuController.shard.order.menuItems.map{
            $0.id
        }
        MenuController.shard.submitOrder(forMenuIDs: menuIDs) { (minuts) in
            DispatchQueue.main.async {
                if let minutus = minuts {
                    self.orderMinutus = minutus
                    self.performSegue(withIdentifier: Identfiers.ConformationSegue, sender: nil)
                }

            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Identfiers.ConformationSegue {
            let orderConformationVC = segue.destination as! OrderConformationVC
            orderConformationVC.minits = orderMinutus
        }
    }
    
    
    
    
    
   @IBAction func unwindToOrderList(segu: UIStoryboardSegue){
    if segu.identifier == "DismissConformation" {
        MenuController.shard.order.menuItems.removeAll()
    }
        
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
