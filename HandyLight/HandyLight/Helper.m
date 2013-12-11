//
//  Helper.m
//  Knob
//
//  Created by Krutarth Majithiya on 2/06/12.
//  Copyright (c) 2012 All rights reserved.
//

#import "Helper.h"

@implementation Helper

+ (CGFloat) distanceBetweenPointOne:(CGPoint)p1 andPointTwo:(CGPoint)p2 {
    CGFloat dx = p1.x - p2.x;
    CGFloat dy = p1.y - p2.y;
    return sqrt(dx*dx + dy*dy);
}

+ (CGFloat) angleBetweenLineA:(CGPoint)aBegin aEnd:(CGPoint)aEnd LineB:(CGPoint)bBegin bEnd:(CGPoint)bEnd{
    
    CGFloat a = aEnd.x - aBegin.x;
    CGFloat b = aEnd.y - aBegin.y;
    CGFloat c = bEnd.x - bBegin.x;
    CGFloat d = bEnd.y - bBegin.y;
    
    CGFloat atanA = atan2(a, b);
    CGFloat atanB = atan2(c, d);
    
    // convert radiants to degrees
    return (atanA - atanB) * 180 / M_PI;
    
}

@end
