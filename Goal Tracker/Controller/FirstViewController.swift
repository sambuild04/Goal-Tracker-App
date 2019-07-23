//
//  FirstViewController.swift
//  Goal Tracker
//
//  Created by Sam  on 5/27/19.
//  Copyright © 2019 Sam. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let images: [UIImage] = [UIImage(named:"image1")!, UIImage(named:"image2")!, UIImage(named:"image3")!]
    
//    var postImage = [Image]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}


//extension FirstViewController: UICollectionViewDelegateFlowLayout{
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let numberOfColumns:CGFloat = 2
//        let width = collectionView.frame.size.width
//        let xInset: CGFloat = 10
//        let cellSpacing: CGFloat = 5
//        return CGSize(width: (width / numberOfColumns) - (xInset + cellSpacing), height: (width: (width / numberOfColumns) - (xInset + cellSpacing)))
//    }
//}

extension FirstViewController: UICollectionViewDataSource, UICollectionViewDelegate  {
    
    
    //Mark: - CollectionView Data Source Method
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
//        let post = postImage[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! CollectionViewCell
        let image = images[indexPath.item]
        cell.imageView.image = image
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }

}



