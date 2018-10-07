//
//  ViewController.swift
//  Intron
//
//  Created by Tamas Bara on 07.10.18.
//  Copyright © 2018 Tamas Bara. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageHeight: NSLayoutConstraint!
    @IBOutlet weak var imageWidth: NSLayoutConstraint!
    @IBOutlet weak var imageArco: UIImageView!
    
    private var initialHeight: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let originalWidth = imageArco.frame.width
        initialHeight = imageArco.frame.height
        let newWidth = UIScreen.main.bounds.width
        let ratio = newWidth / originalWidth
        initialHeight *= ratio
        initialHeight += 1
        imageHeight.constant = initialHeight
        imageWidth.constant = newWidth
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        
        guard indexPath.section == 0 else {
            cell.textLabel?.text = "Zoom Demo"
            return cell
        }
        
        cell.backgroundColor = .clear
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard indexPath.section == 0 else {
            return UITableView.automaticDimension
        }
        
        return initialHeight
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = -scrollView.contentOffset.y - 20
        if y >= 0 {
            imageHeight.constant = initialHeight + y
            imageArco.alpha = 1
        } else {
            imageArco.alpha = max(0.1, (initialHeight+y)/initialHeight)
        }
    }
}

