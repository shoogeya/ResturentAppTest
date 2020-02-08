//
//  MenuController.swift
//  ResturentAppTest
//
//  Created by mac on 03/02/2020.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import UIKit

class MenuController {
    static let shard = MenuController()
    var order = Order(){
        didSet{
            NotificationCenter.default.post(name: MenuController.orderUpdateNotofication, object: nil)
        }
}
    let baseURL = URL(string: "http://localhost:8090/")!
    static let orderUpdateNotofication = Notification.Name("MenuController.orderUpdated")
    
    func fetchCategories(complition: @escaping ([String?]) -> Void){
        let categoryURL = baseURL.appendingPathComponent("categories")
        let task = URLSession.shared.dataTask(with: categoryURL) { (data, response, error) in
            if let data = data,let jsonDictionary = try? JSONSerialization.jsonObject(with: data) as? [String:Any],let categories = jsonDictionary["categories"] as? [String?]{
                complition(categories)
            }else{
                complition([nil])
            }
        }
        task.resume()
        
    }
    func fetchMenuItems(forCategory categoryName: String, complition: @escaping ([MenuItem?]) -> Void){
        let initialMenuURL = baseURL.appendingPathComponent("menu")
        var components = URLComponents(url: initialMenuURL, resolvingAgainstBaseURL: true)
        components?.queryItems = [URLQueryItem(name: "category", value: categoryName)]
        let menuURL = components?.url!
        let task = URLSession.shared.dataTask(with: menuURL!) { (data, response, error) in
            let jsonDecode = JSONDecoder()
            if let data = data,let menuItems = try? jsonDecode.decode(MenuItems.self, from: data){
                complition(menuItems.items)
            }else{
                complition([nil])
            }
        }
    task.resume()
        
        
    }
    func submitOrder(forMenuIDs menuIDs: [Int],complition: @escaping(Int?) -> Void){
        let orderURL = baseURL.appendingPathComponent("order")
        var request = URLRequest(url: orderURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let data: [String:[Int]] = ["menuIds":menuIDs]
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(data)
        request.httpBody = jsonData
        let task = URLSession.shared.dataTask(with: request) { (data, response, reeor) in
            let jsonDecode = JSONDecoder()
            if let data = data,let preperationTime = try? jsonDecode.decode(PreperationTime.self, from: data){
                complition(preperationTime.prepTime)
            }else{
                complition(nil)
            }
        }
        
        task.resume()
    }
    
    func fetchImage(url: URL, complition: @escaping (UIImage?) -> Void){
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                let image = UIImage(data: data)
                complition(image)
            }else{
                complition(nil)
            }
        }
        task.resume()
    }
}
