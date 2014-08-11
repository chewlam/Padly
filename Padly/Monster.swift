//
//  Monster.swift
//  Padly
//
//  Created by Chew Lam on 7/17/14.
//  Copyright (c) 2014 null. All rights reserved.
//
import UIKit


class Monster {
    let padlyServeUrl = "http://127.0.0.1:9000/assets/images/"
    
    var id: Int?
    var name: String?
    var type: String?
    var type_sub: String?
    var element: String?
    var element_sub: String?
    var max_level: Int?
    var img40: String?
    var img60: String?
    var img_full: String?
    var rarity: Int?
    var hp_min: Int?
    var hp_max: Int?
    var hp_scale: Float?
    var rcv_min: Int?
    var rcv_max: Int?
    var rcv_scale: Float?
    var atk_min: Int?
    var atk_max: Int?
    var atk_scale: Float?
    var cost: Int?
    var feed_xp: Int?
    var active_skill: String?
    var leader_skill: String?
    var xp_curve: Int?
    var jp_only: Bool?

    var curr_level: Int?
    
    let elements: [Int: String] = [0: "Fire", 1: "Water", 2: "Wood", 3: "Light", 4: "Dark"]
    let types: [Int: String] = [0: "Evo Material", 1: "Balanced", 2: "Physical", 3: "Healer", 4: "Dragon", 5: "God", 6: "Attacker", 7: "Devil", 12: "Awoken Skill Material", 13: "Protected", 14: "Enhance Material"]
    
    
    init() {
        
    }

    func load(obj: NSDictionary) {
        /*
        {
        "id": 1218,
        "name": "Kirin of the Sacred Gleam, Sakuya",
        "max_level": 99,
        "image40_href": "/static/img/monsters/40x40/1218.76370c1d5499.png",
        "image40_size": 4739,
        "image60_href": "/static/img/monsters/60x60/1218.6e2e6f6dfb70.png",
        "image60_size": 9444,
        "rarity": 7,
        "hp_min": 1271,
        "hp_max": 3528,
        "hp_scale": 1.0,
        "rcv_min": 256,
        "rcv_max": 384,
        "rcv_scale": 1.0,
        "atk_min": 913,
        "atk_max": 1370,
        "atk_scale": 1.0,
        "team_cost": 35,
        "xp_curve": 4000000,
        "active_skill": "Boisterous Dance",
        "leader_skill": "Dance of the Four Origins",
        "feed_xp": 1575.0,
        "awoken_skills": [17, 12, 11, 28, 17, 21, 19],
        "jp_only": false
        "type": 5,
        "type2": 2,
        "element": 3,
        "element2": 3,
        }
        */

        id = (obj["id"] as Int)
        name = (obj["name"] as String)
        max_level = (obj["max_level"] as Int)
        img40 = padlyServeUrl + "\(id!).40x40.png"
        img60 = padlyServeUrl + "\(id!).60x60.png"
        img_full = padlyServeUrl + "\(id!).full.jpg"
        rarity = obj["rarity"] as? Int
        hp_min = obj["hp_min"] as? Int
        hp_max = obj["hp_max"] as? Int
        hp_scale = obj["hp_scale"] as? Float
        rcv_min = obj["rcv_min"] as? Int
        rcv_max = obj["rcv_max"] as? Int
        rcv_scale = obj["rcv_scale"] as? Float
        atk_min = obj["atk_min"] as? Int
        atk_max = obj["atk_max"] as? Int
        atk_scale = obj["atk_scale"] as? Float
        cost = obj["team_cost"] as? Int
        feed_xp = obj["feed_xp"] as? Int
        xp_curve = obj["xp_curve"] as? Int
        active_skill = obj["active_skill"] as? String
        leader_skill = obj["leader_skill"] as? String
        jp_only = obj["jp_only"] as? Bool
        
        if let x1 = obj["type"] as? Int {
            type = self.types[x1];
        }
        
        if let x2 = obj["type2"] as? Int {
            type_sub = self.types[x2];
        }

        if let x3 = obj["element"] as? Int {
            element = self.elements[x3];
        }

        if let x4 = obj["element2"] as? Int {
            element_sub = self.elements[x4];
        }
    }

    func showFormattedRarity() -> String {
        let v = String(count: self.rarity!, repeatedValue: Character("\u{2605}"))

        return v
    }
    
    
    func calc(curr_level: Int, max_level: Int, min_val: Int, max_val: Int, scale: Float) -> Int {
        var r = Float(curr_level-1)/Float(max_level-1)
        var v = min_val + Int(Float(max_val - min_val) * Float(pow(r, scale)))
        return v;
    }
}
