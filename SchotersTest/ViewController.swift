//
//  ViewController.swift
//  SchotersTest
//
//  Created by nurpariz on 10/01/19.
//  Copyright © 2019 nurpariz. All rights reserved.
//

import UIKit
import Alamofire
class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collection: UICollectionView!
    
    var category = [DataCategory]()
    var selectedString = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collection.collectionViewLayout = FlowLayout()
        collection.allowsMultipleSelection = true
        getJsonAPI()
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goList"{
            let vc = segue.destination as! ListSchotersTableViewController
            vc.selectedData = selectedString
        }
    }

    func getJsonAPI() {
        let url = "https://private-90552-schoterspersonal.apiary-mock.com/categories"
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.httpBody, headers: nil).responseJSON { (response) in
            
            if let result = response.result.value {
                let json = result as! [[String:Any]]
                
                for dict in json {
                    let item = DataCategory(json: dict)
                    self.category.append(item)
                }
            }
            self.collection.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return category.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellCategory", for: indexPath) as! CellLabel
        cell.cellLabel.text = category[indexPath.item].name
        
        return cell
    }
    
    @IBAction func actionDone(_ sender: UIButton) {
        
    }
    
    func addData(index: Int){
        let selectedCategories = category[index].name
        selectedString.append(selectedCategories)
    }
    
    func removeData(index: Int){
        let selectedCategories = category[index].name
        for i in 0...selectedString.count - 1 {
            if selectedString[i] == selectedCategories {
                selectedString.remove(at: i)
                return
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        addData(index: indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        removeData(index: indexPath.item)
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let interestString = self.category[indexPath.row].name
        let widthCell = interestString.widthString(withConstrainedHeight: 20.0, font: UIFont.systemFont(ofSize: 15))
        return CGSize(width: widthCell + 15, height: 40)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
    
}

extension String {
    func widthString(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        return ceil(boundingBox.width)
    }
}
