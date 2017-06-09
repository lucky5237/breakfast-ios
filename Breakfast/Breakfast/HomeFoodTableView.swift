//
//  HomeFoodTableView.swift
//  Breakfast
//
//  Created by 卢键 on 2017/6/9.
//  Copyright © 2017年 卢键. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class HomeFoodTableView: UITableView,UITableViewDataSource,UITableViewDelegate{
    
    var placeId:Int? = 1
    let number = 10
    var foodList:Array<Food> = []
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        refreshControl =  UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: "下拉刷新")
        refreshControl?.addTarget(self, action: #selector(ProductTableViewController.beginRefresh), for: .valueChanged)
//        self.register(ProductCell.self, forCellReuseIdentifier: "productCellIdentifier")
        self.delegate = self
        self.dataSource = self

    }
    
    func beginRefresh(){
        let indicatorView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        indicatorView.center = self.center
        indicatorView.backgroundColor = UIColor.lightGray
        indicatorView.startAnimating()
        addSubview(indicatorView)
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false, block: { timer in
            self.getProductList()
            self.refreshControl?.endRefreshing()
            indicatorView.stopAnimating()
        })
        
    }
    
    func getProductList() {
        
        let params:Parameters =  ["placeId":placeId!,"number":number,"flag":0]
        Alamofire.request("http://192.168.2.1:5000/food/allFood", method: .post, parameters: params, encoding: JSONEncoding.default).responseString(completionHandler: {response in
            switch response.result{
            case .success:
                if let res = BaseResponseModel<Array<Food>>.deserialize(from: response.result.value) {
//                    print(res.code!)
//                    print(res.data!.description)
                    self.foodList.removeAll()
                    if let datas = res.data{
                        datas.forEach({ food in
                            self.foodList.append(food)
                        })
                    }
                    
                }
                self.reloadData()
                
            case .failure(let error):
                print(error)
            }
            //            indicatorView.stopAnimating()
        })
    }


    
    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
    }
  
   
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCellIdentifier",for: indexPath)
        let item = foodList[indexPath.row]
        
        let photo = cell.viewWithTag(1) as! UIImageView
        let name = cell.viewWithTag(2) as! UILabel
        let time = cell.viewWithTag(4) as! UILabel
        let saleNum = cell.viewWithTag(5) as! UILabel
        //        var price = cell
        //        cell.imageView?.image = UIImage(named: item.image)
        Alamofire.request("http://192.168.2.1:5000/static/image/"+item.image!+".jpg").responseData(completionHandler: { data in
            photo.image = UIImage(data: data.result.value!)
        })
        name.text = item.name
        //        cell.price.text = "\(item.price!)"
        time.text = item.createTs ?? ""
        saleNum.text = "\(item.sales!)"
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodList.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    
}
