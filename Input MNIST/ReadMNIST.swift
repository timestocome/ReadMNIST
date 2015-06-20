//
//  ReadMNIST.swift
//  HopfieldNetwork
//
//  Created by Linda Cobb on 5/27/15.
//  Copyright (c) 2015 TimesToCome Mobile. All rights reserved.
//

import Foundation


class ReadMNIST
{
    
    var labelData:[UInt8] = []
    var imageData:[UInt8] = []
    
    
    // images
    // 32 bit int   magic number        0x00000803 (2051)
    // 32 bit int   number of images    60000
    // 32 bit int   number of rows      28
    // 32 bit int   number of columns   28
    // pixels unsigned bytes            0-255
    func loadFileImageFile(){
    
        
        // inputStreamWithURL ?

        
        // find and open file
        let URL = NSBundle.mainBundle().URLForResource("train-images-idx3-ubyte", withExtension: "data")
        let data = NSData(contentsOfURL: URL!)
        
        
        // put file data into an array
        let length = data?.length       // number of bytes in data
        imageData = Array(count: length!, repeatedValue: 0)
        data?.getBytes(&imageData, length: length!)
        
        
        
        
        // get information about the data
        var infoBytes:[UInt8] = [0, 0, 0, 0]
        let size = sizeof(UInt32)
        
        // magic number
        var range = NSRange(location: 0, length: size)
        data?.getBytes(&infoBytes, range: range)
        infoBytes = Array(infoBytes.reverse())  //big endian little endian
        let magicNumber = UnsafePointer<UInt32>(infoBytes).memory
        print("magicNumber \(magicNumber)")
        
        // number of images
        range.location = size
        data?.getBytes(&infoBytes, range: range)
        infoBytes = Array(infoBytes.reverse())
        let numberOfLabels = UnsafePointer<UInt32>(infoBytes).memory
        print("number of labels \(numberOfLabels)")
        
        
        // number of rows
        range.location += size
        data?.getBytes(&infoBytes, range: range)
        infoBytes = Array(infoBytes.reverse())
        let numberOfRows = UnsafePointer<UInt32>(infoBytes).memory
        print("numberOfRows \(numberOfRows)")
        
        
        // number of columns
        range.location += size
        data?.getBytes(&infoBytes, range: range)
        infoBytes = Array(infoBytes.reverse())
        let numberOfColumns = UnsafePointer<UInt32>(infoBytes).memory
        print("numberOfColumms \(numberOfColumns)")
        
        
        // remove first  bits that contain info data from array
        imageData.removeRange(0..<16)
       // println("data? (0-255) \n\n \(imageData)"  )
        
        // print one just to see if it looks okay
        for i in 0..<28 {
            print("")
            for j in 0..<28 {
                print( NSString(format: "%04d", imageData[i*28 + j]), appendNewline: false)
            }
        }


    }
    
    
    
    // labels
    // 32 bit int   magic number        0x00000801 (2049)
    // 32 bit int   number of labels    60000
    // labels unsigned bytes  range is  0-9
    func loadLabelFile(){
        
        
        // find and open file
        let URL = NSBundle.mainBundle().URLForResource("train-labels-idx1-ubyte", withExtension: "data")
        let data = NSData(contentsOfURL: URL!)

        
        
        // put file data into an array
        let length = data?.length       // number of bytes in data
        labelData = Array(count: length!, repeatedValue: 0)
        data?.getBytes(&labelData, length: length!)
        
        
        
        // get information about the data
        var infoBytes:[UInt8] = [0, 0, 0, 0]
        let size = sizeof(UInt32)
        var range = NSRange(location: 0, length: size)
        data?.getBytes(&infoBytes, range: range)
        infoBytes = Array(infoBytes.reverse())  //big endian little endian
        let magicNumber = UnsafePointer<UInt32>(infoBytes).memory
        print("magicNumber \(magicNumber)")
        
        
        range.location = size
        data?.getBytes(&infoBytes, range: range)
        infoBytes = Array(infoBytes.reverse())
        let numberOfLabels = UnsafePointer<UInt32>(infoBytes).memory
        print("number of labels \(numberOfLabels)")
        
        
        
        // remove first 8 bits that contain file data from our labels array
        labelData.removeRange(0..<8)
        print("data? (0-9) \n\n \(labelData)"  )
        
    }
    
    
   
    
    
}