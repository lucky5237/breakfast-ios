//
//  HomeViewController.swift
//  Breakfast
//
//  Created by 卢键 on 2017/6/7.
//  Copyright © 2017年 卢键. All rights reserved.
//

import UIKit
import TabPageViewController
import Alamofire
import SwiftyJSON

class HomeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    //    @IBOutlet weak var scrollView: UIScrollView!
    var placeId:Int = 1
    let number = 10
    var foodList:Array<Food>  = []
    var viewList:Array<UIView> = []
    @IBAction func placeChanged(_ sender: UISegmentedControl) {
        //        NSLog("当前选择了\(sender.selectedSegmentIndex)" + sender.titleForSegment(at: sender.selectedSegmentIndex)!)
        //∫        switch sender.selectedSegmentIndex {
        //        case 0:
        //            scrollView.setContentOffset(CGPoint(x: <#T##CGFloat#>, y: <#T##CGFloat#>), animated: <#T##Bool#>)
        //        case 1:
        //            view.backgroundColor = .blue
        //        case 2:
        //            view.backgroundColor = .green
        //        default:
        //            view.backgroundColor = .white
        //        }
        //        scrollView.setContentOffset(CGPoint(x:viewList[sender.selectedSegmentIndex].frame.origin.x, y: 0), animated: false)
        tableview.isHidden = true
        placeId = sender.selectedSegmentIndex + 1
        beginRefresh()
         tableview.isHidden = false
    }
    func beginRefresh(){
        tableview.refreshControl?.beginRefreshing()
        let indicatorView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        indicatorView.center = self.view.center
        indicatorView.backgroundColor = UIColor.lightGray
        indicatorView.startAnimating()
        self.view.addSubview(indicatorView)
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { timer in
            self.getProductList()
            self.tableview.refreshControl?.endRefreshing()
            indicatorView.stopAnimating()
        })
        
    }
    
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        self.tableview.refreshControl = UIRefreshControl()
        self.tableview.refreshControl?.attributedTitle = NSAttributedString(string: "下拉刷新")
        self.tableview.refreshControl?.addTarget(self, action: #selector(ProductTableViewController.beginRefresh), for: .valueChanged)
        //         self.tableview.refreshControl?.beginRefreshing()
        beginRefresh()
        
        //        segmentedControl.addTarget(self, action: Selector("action:"), for: .valueChanged);
        
        // Do any additional setup after loading the view.
        //        scrollView.delegate = self
        //        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width * 3, height: scrollView.bounds.height)
        //        let firstView  = UIView(frame: CGRect(x: 0, y: 0, width: scrollView.frame.size.width, height: scrollView.frame.size.height))
        //        firstView.backgroundColor = .red
        //
        //        let secondView  = UIView(frame: CGRect(x: scrollView.frame.size.width, y: 0, width: scrollView.frame.size.width, height: scrollView.frame.size.height))
        //        secondView.backgroundColor = .blue
        //
        //        let thirdView  = UIView(frame: CGRect(x: scrollView.frame.size.width * 2, y: 0, width: scrollView.frame.size.width, height: scrollView.frame.size.height))
        //        thirdView.backgroundColor = .green
        //
        //        let viewcontroller1 =  self.storyboard?.instantiateViewController(withIdentifier: "homeFoodListController") as! ProductTableViewController
        //        viewcontroller1.placeId = 1
        //        viewcontroller1.view.backgroundColor = .red
        //        let viewcontroller2 =  self.storyboard?.instantiateViewController(withIdentifier: "homeFoodListController") as! ProductTableViewController
        //        viewcontroller2.placeId = 2
        //         viewcontroller2.view.backgroundColor = .blue
        //        let viewcontroller3 =  self.storyboard?.instantiateViewController(withIdentifier: "homeFoodListController") as! ProductTableViewController
        //        viewcontroller3.placeId = 3
        //        viewcontroller3.view.backgroundColor = .green
        //        viewcontroller1.view.frame = CGRect(x: 0, y: 0, width: scrollView.frame.size.width, height: scrollView.frame.size.height)
        //        viewcontroller2.view.frame = CGRect(x: scrollView.frame.size.width, y: 0, width: scrollView.frame.size.width, height: scrollView.frame.size.height)
        //
        //        viewcontroller3.view.frame = CGRect(x: scrollView.frame.size.width * 2, y: 0, width: scrollView.frame.size.width, height: scrollView.frame.size.height)
        //
        //        ////        scrollView.
        //
        //        //        let tableView:HomeFoodTableView = HomeFoodTableView(frame: CGRect(x: 0, y: 0, width: scrollView.frame.size.width, height: scrollView.frame.size.height), style: .plain)
        //        //        tableView.dele
        //        //        tableView.refreshControl = UIRefreshControl()
        //        //        tableView.refreshControl?.attributedTitle = NSAttributedString("正在刷")
        //
        //        viewList.append(viewcontroller1.view)
        //        viewList.append(viewcontroller2.view)
        //        viewList.append(viewcontroller3.view)
        //        //
        //        scrollView.addSubview(viewcontroller1.view)
        //        scrollView.addSubview(viewcontroller2.view)
        //        scrollView.addSubview(viewcontroller3.view)
        //
        //        scrollView.isScrollEnabled  = true
        
        //        let tabPageViewController = TabPageViewController.create()
        //        var tableview = UITableView()
        
        
        
        //        tabPageViewController.tabItems = [(viewcontroller1, "垃圾街"), (viewcontroller2, "养贤府"),(viewcontroller3, "家和堂")]
        ////        TabPageOption.currentColor = UIColor.redColor()
        //        scrollView.addSubview(tabPageViewController.view)
        
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCellIdentifier",for: indexPath) as! ProductCell
        let item = foodList[indexPath.row]
//        cell.photo?.image = UIImage(named: item.image)
        Alamofire.request("http://192.168.2.1:5000/static/image/"+item.image!+".jpg").responseData(completionHandler: { data in
            cell.photo?.image = UIImage(data: data.result.value!)
        })
        cell.name.text = item.name ?? ""
        cell.place.text = "\(item.place!.name!)"
        cell.time.text = item.createTs ?? ""
        cell.saleNum.text = "\(item.sales!)"
        return cell
        
    }
    
    func getProductList() {
        
        let params:Parameters =  ["placeId":placeId,"number":number,"flag":0]
        Alamofire.request("http://192.168.2.1:5000/food/allFood", method: .post, parameters: params, encoding: JSONEncoding.default).responseString(completionHandler: {response in
            switch response.result{
            case .success:
                if let res = BaseResponseModel<Array<Food>>.deserialize(from: response.result.value) {
                    self.foodList.removeAll()
                    if let datas = res.data{
                        datas.forEach({ food in
                            self.foodList.append(food)
                        })
                    }
                }
                self.tableview.reloadData()
            case .failure(let error):
                print(error)
            }
            
        })
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodList.count
    }
    
    
    
    
}
