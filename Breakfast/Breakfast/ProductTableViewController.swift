//
//  ProductTableViewController.swift
//  Breakfast
//
//  Created by 卢键 on 2017/6/8.
//  Copyright © 2017年 卢键. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ProductTableViewController: UITableViewController {
    
    var placeId:Int? = 1
    let number = 10
    var foodList:Array<Food> = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: "下拉刷新")
        self.refreshControl?.addTarget(self, action: #selector(ProductTableViewController.beginRefresh), for: .valueChanged)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        //        getProductList()
        refreshControl?.beginRefreshing()
        beginRefresh()
        
        
    }
    
    func beginRefresh(){
        let indicatorView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        indicatorView.center = self.view.center
        indicatorView.backgroundColor = UIColor.lightGray
        indicatorView.startAnimating()
        self.view.addSubview(indicatorView)
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false, block: { timer in
            self.getProductList()
            self.refreshControl?.endRefreshing()
            indicatorView.stopAnimating()
        })
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return foodList.count
    }
    
    func getProductList() {
     
        let params:Parameters =  ["placeId":placeId!,"number":number,"flag":0]
        Alamofire.request("http://192.168.2.1:5000/food/allFood", method: .post, parameters: params, encoding: JSONEncoding.default).responseString(completionHandler: {response in
            switch response.result{
            case .success:
                if let res = BaseResponseModel<Array<Food>>.deserialize(from: response.result.value) {
                    print(res.code!)
                    print(res.data!.description)
//                    NSLog(res., <#T##args: CVarArg...##CVarArg#>)
                    self.foodList.removeAll()
                    if let datas = res.data{
                        datas.forEach({ food in
                        self.foodList.append(food)
                        })
                    }
                    
                }
                self.tableView.reloadData()
                //                let resultJson = JSON(response.result.value!)
                //                NSLog(resultJson.description)
                
                
            case .failure(let error):
                print(error)
            }
//            indicatorView.stopAnimating()
        })
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCellIdentifier",for: indexPath) as! ProductCell
        let item = foodList[indexPath.row]
        //        cell.imageView?.image = UIImage(named: item.image)
        Alamofire.request("http://192.168.2.1:5000/static/image/"+item.image!+".jpg").responseData(completionHandler: { data in
            cell.imageView?.image = UIImage(data: data.result.value!)
        })
        cell.name.text = item.name
        cell.price.text = "\(item.price!)"
        cell.time.text = item.createTs ?? ""
        cell.saleNum.text = "\(item.sales!)"
        return cell
        
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
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
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
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
