//
//  Player.swift
//  GameOfGames
//
//  Created by Michael Lombardo on 2/15/17.
//  Copyright © 2017 Michael Lombardo. All rights reserved.
//

import Foundation


class Player {

  fileprivate(set) var name:String = "";

  init (_ name:String) {
    self.name = name;
  }

  func setName(_ name:String) {
    self.name = name;
  }
}
