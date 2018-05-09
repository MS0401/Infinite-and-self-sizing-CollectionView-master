//
//  ViewController.swift
//  InfiniteCollectionView
//
//  Created by Satinder Singh on 11/11/17.
//  Copyright © 2017 Satinder. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var colorCollectionView: UICollectionView!
    let infiniteSize = 10000
    var stringItem : [String] = {
        let infiniteSize = 10000
        var string = ["asdfadsf ","asd fds f","asd fasd","asdf","sadf","asdfasdfds","a","asdfasd"]
        var strings = [String]()
        for i in 0..<infiniteSize {
            strings.append(string[i % string.count])
        }
        return strings
        }()
    
    lazy var colorList: [UIColor] = {
        var colors = [UIColor]()
        for hue in stride(from: 0, to: 1.0, by: 0.25) {
            let color = UIColor(hue: CGFloat(hue), saturation: 1, brightness: 1, alpha: 1)
            colors.append(color)
        }
        return colors
    }()

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let midIndexPath = IndexPath(row: infiniteSize / 2, section: 0)
        colorCollectionView.scrollToItem(at: midIndexPath, at: .centeredHorizontally, animated: false)
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorCell", for: indexPath) as! TextCollectionViewCell
        cell.text.text = stringItem[indexPath.row]
        //cell.backgroundColor = colorList[indexPath.row % colorList.count]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return infiniteSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = stringItem[indexPath.row].SizeOf_String(font: UIFont.systemFont(ofSize: 17)).width
        return CGSize(width: width+10, height: 80)
    }
    
    
    
}


extension String {
    func SizeOf_String( font: UIFont) -> CGSize {
        let fontAttribute = [NSAttributedStringKey.font: font]
        let size = self.size(withAttributes: fontAttribute)  // for Single Line
        return size
    }
}
