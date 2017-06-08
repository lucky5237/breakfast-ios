//
//  HomeViewController.swift
//  Breakfast
//
//  Created by 卢键 on 2017/6/7.
//  Copyright © 2017年 卢键. All rights reserved.
//

import UIKit
import TabPageViewController

class HomeViewController: UIViewController,UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    var viewList:Array<UIView> = []
    @IBAction func placeChanged(_ sender: UISegmentedControl) {
//        NSLog("当前选择了\(sender.selectedSegmentIndex)" + sender.titleForSegment(at: sender.selectedSegmentIndex)!)
//        switch sender.selectedSegmentIndex {
//        case 0:
//            scrollView.setContentOffset(CGPoint(x: <#T##CGFloat#>, y: <#T##CGFloat#>), animated: <#T##Bool#>)
//        case 1:
//            view.backgroundColor = .blue
//        case 2:
//            view.backgroundColor = .green
//        default:
//            view.backgroundColor = .white
//        }
          scrollView.setContentOffset(CGPoint(x:viewList[sender.selectedSegmentIndex].frame.origin.x, y: 0), animated: false)
    }
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
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
        let viewcontroller1 =  self.storyboard?.instantiateViewController(withIdentifier: "homeFoodListController") as! ProductTableViewController
        viewcontroller1.placeId = 1
        let viewcontroller2 =  self.storyboard?.instantiateViewController(withIdentifier: "homeFoodListController") as! ProductTableViewController
        viewcontroller2.placeId = 2

        let viewcontroller3 =  self.storyboard?.instantiateViewController(withIdentifier: "homeFoodListController") as! ProductTableViewController
        viewcontroller3.placeId = 3
      //        viewcontroller.view.frame = CGRect(x: 0, y: 0, width: scrollView.frame.size.width, height: scrollView.frame.size.height)
////        scrollView.
//        viewList.append(viewcontroller.view)
//        viewList.append(secondView)
//        viewList.append(thirdView)
//        
//        scrollView.addSubview(viewcontroller.view)
//        scrollView.addSubview(secondView)
//        scrollView.addSubview(thirdView)

        let tabPageViewController = TabPageViewController.create()
//        var tableview = UITableView()
        
        
        
        tabPageViewController.tabItems = [(viewcontroller1, "垃圾街"), (viewcontroller2, "养贤府"),(viewcontroller3, "家和堂")]
//        TabPageOption.currentColor = UIColor.redColor()
        scrollView.addSubview(tabPageViewController.view)

        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        NSLog("scrollViewDidEndDecelerating is called")
//        NSLog("\(scrollView.contentOffset.x)");
        segmentedControl.selectedSegmentIndex = Int(scrollView.contentOffset.x / scrollView.bounds.width)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
