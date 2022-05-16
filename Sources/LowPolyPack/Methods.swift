//
//  Methods.swift
//  
//
//  Created by Marina Roshchupkina on 28.04.2022.
//  Copyright © 2022 Marina Roshchupkina. All rights reserved.
//
import UIKit
func lowPolyfy(sourceImage: UIImage, ratio: Int) -> UIImage{
    
    let image = sourceImage
       
    guard let imageModel = Image.load(image: image) else {
        return UIImage()
    }
    defer {
        imageModel.deallocate()
    }
    
    /* detect edges, get all points of edges*/
    let points = Sobel().edgePoints(imageModel)
    
    /* pick out some points from the point set */
    var selectedPoints = [Point]()
    let selectRatio: Int = ratio
    let selectCount = points.count / selectRatio
    for i in 0..<selectCount {
        let point = points[i * selectRatio]
        let vertex = Point(x: point.x, y: point.y)
        selectedPoints.append(vertex)
    }
    
    /* add some randomly generated points into it */
    let possionPoints = Poisson().discSample(Double(imageModel.width), height: Double(imageModel.height), minDistance: Double(imageModel.width) / Double(selectRatio), newPointsCount: 30)
    selectedPoints.append(contentsOf: possionPoints)
    
    /* output triangles with Delaunay Triangulation  */
    let triangles = Delaunay().triangulate(selectedPoints)
    
    
    /* draw image */
    UIGraphicsBeginImageContextWithOptions(CGSize(width: (image.cgImage?.width)!, height: (image.cgImage?.height)!), true, UIScreen.main.scale)
    defer {
        UIGraphicsEndImageContext()
    }
    guard let context = UIGraphicsGetCurrentContext() else {
        return UIImage()
    }
    context.setAllowsAntialiasing(false)
    context.setStrokeColor(UIColor.clear.cgColor)
    context.setLineWidth(0.5)
    for (_, triangle) in triangles.enumerated()  {
        let centroid = triangle.centroid()
        guard let fillColor = imageModel.getPixelColor(x: Int(centroid.x), y: Int(centroid.y))?.cgColor else {
            return UIImage()
        }
        context.setFillColor(fillColor)
        context.setStrokeColor(UIColor.yellow.cgColor)
        context.setLineWidth(0.5)
        context.move(to: triangle.p0.cgPoint())
        context.addLine(to: triangle.p1.cgPoint())
        context.addLine(to: triangle.p2.cgPoint())
        context.addLine(to: triangle.p0.cgPoint())
        context.closePath()
        context.fillPath()
    }
    guard let outputImage = UIGraphicsGetImageFromCurrentImageContext() else {
        return UIImage()
    }
    return outputImage
}
