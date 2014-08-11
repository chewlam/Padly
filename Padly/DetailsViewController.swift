//
//  DetailsViewController.swift
//  Padly
//
//  Created by Chew Lam on 7/18/14.
//  Copyright (c) 2014 null. All rights reserved.
//


import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var bigImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var elementLabel: UILabel!
    @IBOutlet weak var statTable: UITableView!
    @IBOutlet weak var rarityLabel: UILabel!

    @IBOutlet weak var minRCVLabel: UILabel!
    @IBOutlet weak var minHPLabel: UILabel!
    @IBOutlet weak var minLevelLabel: UILabel!
    @IBOutlet weak var minATKLabel: UILabel!
    
    @IBOutlet weak var maxHPLabel: UILabel!
    @IBOutlet weak var maxLevelLabel: UILabel!
    @IBOutlet weak var maxATKLabel: UILabel!
    @IBOutlet weak var maxRCVLabel: UILabel!
    
    @IBOutlet weak var currLevelLabel: UILabel!
    @IBOutlet weak var currHPLabel: UILabel!
    @IBOutlet weak var currRCVLabel: UILabel!
    @IBOutlet weak var currATKLabel: UILabel!

    var monster: Monster?
    
    required init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = monster!.name
        var scale: CGFloat = 2.0;
        
        image.image = UIImage(data: NSData(contentsOfURL: NSURL(string: monster!.img60!)))
        bigImage.image = UIImage(data: NSData(contentsOfURL: NSURL(string: monster!.img_full!)))
        
        var _text = monster!.type

        if let _subtype = monster?.type_sub  {
            _text = _text! + " / \(_subtype)"
        }
        typeLabel.text = _text
        
        _text = monster!.element
        if let _subelement = monster?.element_sub  {
            _text = _text! + " / \(_subelement)"
        }
        elementLabel.text = _text
        
        costLabel.text = "Cost \(monster!.cost!)"
        rarityLabel.text = "\(self.monster!.showFormattedRarity())"
        idLabel.text = "No. \(monster!.id!)"
            
        idLabel.textColor = self.getColor()
        nameLabel.textColor = self.getColor()
        idLabel.backgroundColor = self.getBackgroundColor()
        nameLabel.backgroundColor = self.getBackgroundColor()
        
        minLevelLabel.text = String(1)
        minHPLabel.text = String(monster!.hp_min!)
        minATKLabel.text = String(monster!.hp_min!)
        minRCVLabel.text = String(monster!.rcv_min!)
        
        maxLevelLabel.text = String(monster!.max_level!)
        maxHPLabel.text = String(monster!.hp_max!)
        maxATKLabel.text = String(monster!.hp_max!)
        maxRCVLabel.text = String(monster!.rcv_max!)

        
        
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

