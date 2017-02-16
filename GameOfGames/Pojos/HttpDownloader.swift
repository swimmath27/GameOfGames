//
//  HttpDownloader.swift
//  GameOfGames
//
//  Created by Michael Lombardo on 6/3/16.
//  Copyright © 2016 Michael Lombardo. All rights reserved.
//
//from: http://stackoverflow.com/questions/28219848/download-file-in-swift

import Foundation

class HttpDownloader {
  
  class func loadFileSync(_ url: URL, completion:(_ path:String, _ error:Error?) -> Void) {
    let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first! as URL
    let destinationUrl = documentsUrl.appendingPathComponent(url.lastPathComponent)
    

    if let dataFromURL = try? Data(contentsOf: url) {
      if (try? dataFromURL.write(to: destinationUrl, options: [.atomic])) != nil {
        print("file saved [\(destinationUrl.path)]")
        completion(destinationUrl.path, nil)
      }
      else {
        print("error saving file")
        let error = NSError(domain:"Error saving file", code:1001, userInfo:nil)
        completion(destinationUrl.path, error)
      }
    }
    else {
      let error = NSError(domain:"Error downloading file", code:1002, userInfo:nil)
      completion(destinationUrl.path, error)
    }
  }
  
  class func loadFileAsync(_ url: URL, completion:@escaping (_ path:String, _ error:Error?) -> Void) {
    let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first! as URL
    let destinationUrl = documentsUrl.appendingPathComponent(url.lastPathComponent)

    let sessionConfig = URLSessionConfiguration.default
    let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
    let task = session.dataTask(with: url,
                         completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
        if (error == nil) {
          if let response = response as? HTTPURLResponse {
            print("response=\(response)")
            if response.statusCode == 200 {
              if (try? data!.write(to: destinationUrl, options: [.atomic])) != nil {
                print("file saved [\(destinationUrl.path)]")
                completion(destinationUrl.path, error)
              }
              else {
                print("error saving file")
                let error = NSError(domain:"Error saving file", code:1001, userInfo:nil)
                completion(destinationUrl.path, error)
              }
            }
            else {
              print("error downloading file")
              let error = NSError(domain:"Error downloading file", code:1001, userInfo:nil)
              completion("", error)
            }
          }
        }
        else {
          print("Failure: \(error!.localizedDescription)");
          completion(destinationUrl.path, error)
        }
    })
    task.resume()
    
  }
  
  class func loadFileSyncNoOverwrite(_ url: URL, completion:(_ path:String, _ error:NSError?) -> Void) {
    let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first! as URL
    let destinationUrl = documentsUrl.appendingPathComponent(url.lastPathComponent)
    
    if FileManager().fileExists(atPath: destinationUrl.path) {
      print("file already exists [\(destinationUrl.path)]")
      completion(destinationUrl.path, nil)
    }
    else if let dataFromURL = try? Data(contentsOf: url) {
      if (try? dataFromURL.write(to: destinationUrl, options: [.atomic])) != nil {
        print("file saved [\(destinationUrl.path)]")
        completion(destinationUrl.path, nil)
      }
      else {
        print("error saving file")
        let error = NSError(domain:"Error saving file", code:1001, userInfo:nil)
        completion(destinationUrl.path, error)
      }
    }
    else {
      let error = NSError(domain:"Error downloading file", code:1002, userInfo:nil)
      completion(destinationUrl.path, error)
    }
  }
  
  class func loadFileAsyncNoOverwrite(_ url: URL, completion:@escaping (_ path:String, _ error:Error?) -> Void) {
    let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first! as URL
    let destinationUrl = documentsUrl.appendingPathComponent(url.lastPathComponent)
    if FileManager().fileExists(atPath: destinationUrl.path) {
      print("file already exists [\(destinationUrl.path)]")
      completion(destinationUrl.path, nil)
    }
    else {
      let sessionConfig = URLSessionConfiguration.default
      let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
      let task = session.dataTask(with: url,
                           completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
          if (error == nil) {
            if let response = response as? HTTPURLResponse {
              print("response=\(response)")
              if response.statusCode == 200 {
                if (try? data!.write(to: destinationUrl, options: [.atomic])) != nil {
                  print("file saved [\(destinationUrl.path)]")
                  completion(destinationUrl.path, error)
                }
                else {
                  print("error saving file")
                  let error = NSError(domain:"Error saving file", code:1001, userInfo:nil)
                  completion(destinationUrl.path, error)
                }
              }
              else {
                print("error downloading file")
                let error = NSError(domain:"Error downloading file", code:1001, userInfo:nil)
                completion("", error)
              }
            }
          }
          else {
            print("Failure: \(error!.localizedDescription)");
            completion(destinationUrl.path, error)
          }
      })
      task.resume()
    }
  }
}

/*
 usage:
  let url = NSURL(string: "http://www.mywebsite.com/myfile.pdf")
  HttpDownloader.loadFileAsync(url,
    completion: { (path:String, error:NSError!) in
      println("pdf downloaded to: \(path)")
    })
*/
