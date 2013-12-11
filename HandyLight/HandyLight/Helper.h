//
//  Helper.h
//  Knob
//
//  Created by Krutarth Majithiya on 2/06/12.
//  Copyright (c) 2012 All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Helper : NSObject

+ (CGFloat) distanceBetweenPointOne:(CGPoint) p1 andPointTwo: (CGPoint) p2;
+ (CGFloat) angleBetweenLineA:(CGPoint) aBegin aEnd:(CGPoint) aEnd LineB:(CGPoint) bBegin bEnd:(CGPoint) bEnd;

@end
