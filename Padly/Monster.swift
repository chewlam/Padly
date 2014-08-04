//
//  Monster.swift
//  Padly
//
//  Created by Chew Lam on 7/17/14.
//  Copyright (c) 2014 null. All rights reserved.
//
import UIKit


class Monster {
    var id: Int?
    var name: String?
    var type: String?
    var type_sub: String?
    var element: String?
    var element_sub: String?
    var max_level: Int?
    var img40_url: String?
    var img60_url: String?
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
    
    init() {
        
    }

    func load(obj: NSDictionary) {
        self.id = obj["id"] as? Int
        self.name = obj["name"] as? String
        self.max_level = obj["max_level"] as? Int
        self.img40_url = obj["image40_href"] as? String
        self.img60_url = obj["image60_href"] as? String
        self.rarity = obj["rarity"] as? Int
        self.hp_min = obj["hp_min"] as? Int
        self.hp_max = obj["hp_max"] as? Int
        self.hp_scale = obj["hp_scale"] as? Float
        self.rcv_min = obj["rcv_min"] as? Int
        self.rcv_max = obj["rcv_max"] as? Int
        self.rcv_scale = obj["rcv_scale"] as? Float
        self.atk_min = obj["atk_min"] as? Int
        self.atk_max = obj["atk_max"] as? Int
        self.atk_scale = obj["atk_scale"] as? Float
        self.cost = obj["team_cost"] as? Int
        self.feed_xp = obj["feed_xp"] as? Int
        self.xp_curve = obj["xp_curve"] as? Int
        self.active_skill = obj["active_skill"] as? String
        self.leader_skill = obj["leader_skill"] as? String
        self.jp_only = obj["jp_only"] as? Bool
        
        if let x1 = obj["type"] as? Int {
            self.type = self.types[x1];
        }
        
        if let x2 = obj["type2"] as? Int {
            self.type_sub = self.types[x2];
        }

        if let x3 = obj["element"] as? Int {
            self.element = self.elements[x3];
        }

        if let x4 = obj["element2"] as? Int {
            self.element_sub = self.elements[x4];
        }
    }

    func showFormattedRarity() -> String {
        let v = String(count: self.rarity!, repeatedValue: Character("\u2605"))        

        return v
    }
    
    
    func calc(curr_level: Int, max_level: Int, min_val: Int, max_val: Int, scale: Float) -> Int {
        var r = Float(curr_level-1)/Float(max_level-1)
        var v = min_val + Int(Float(max_val - min_val) * Float(pow(r, scale)))
        return v;
    }
}
