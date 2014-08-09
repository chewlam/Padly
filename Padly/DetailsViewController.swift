//
//  DetailsViewController.swift
//  Padly
//
//  Created by Chew Lam on 7/18/14.
//  Copyright (c) 2014 null. All rights reserved.
//


import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet var image: UIImageView
    @IBOutlet var bigImage: UIImageView
    @IBOutlet var nameLabel: UILabel
    @IBOutlet var typeLabel: UILabel
    @IBOutlet var idLabel: UILabel
    @IBOutlet var costLabel: UILabel
    @IBOutlet var elementLabel: UILabel
    @IBOutlet var statTable: UITableView
    @IBOutlet var rarityLabel: UILabel

    var monster: Monster?
    
    init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = self.monster?.name
        var scale: CGFloat = 2.0;
        
        image.image = UIImage(data: NSData(contentsOfURL: NSURL(string: self.monster?.img60)))
        bigImage.image = UIImage(data: NSData(contentsOfURL: NSURL(string: monster?.img_full)), scale: scale)

        var _text = "\(self.monster?.type)"

        if let _subtype = self.monster?.type_sub  {
            _text += " / \(_subtype)"
        }
        typeLabel.text = _text
        
        _text = "\(self.monster?.element)"
        if let _subelement = self.monster?.element_sub  {
            _text += " / \(_subelement)"
        }
        elementLabel.text = _text

        if let _cost = self.monster?.cost as? Int {
            costLabel.text = "Cost \(String(_cost))"
        }
        
        rarityLabel.text = "\(self.monster?.showFormattedRarity())"
        
        if let _id = self.monster?.id as? Int {
            idLabel.text = "No. " + String(_id)
        }
        
        idLabel.textColor = self.getColor()
        nameLabel.textColor = self.getColor()
        idLabel.backgroundColor = self.getBackgroundColor()
        nameLabel.backgroundColor = self.getBackgroundColor()
        
    }
    
    func getColor() -> UIColor{
        switch self.monster!.element! {
            case "Water", "Fire", "Wood", "Dark":
                return UIColor.whiteColor()
            case "Light":
                return UIColor.darkGrayColor()
            default:
                return UIColor.blackColor()
        }
    }
    
    func getBackgroundColor() -> UIColor {
        switch self.monster!.element! {
            case "Water":
                return UIColor.blueColor()
            case "Fire":
                return UIColor.redColor()
            case "Wood":
                return UIColor(red: CGFloat(102/255.0), green: CGFloat(204/255.0), blue: CGFloat(0.0), alpha: CGFloat(1.0))
            case "Dark":
                return UIColor.purpleColor()
            case "Light":
                return UIColor.yellowColor()
            default:
                return UIColor.blackColor()
        }
        
    }
    
}

