//
//  KnobViewSensor.h
//  Knob
//
//  Created by Krutarth Majithiya on 2/06/12.
//  Copyright (c) 2012. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIGestureRecognizerSubclass.h>

//Set the minium and Maximum rotation
#define MIN_ANGLE -65.0
#define MAX_ANGLE 255.0
#define CURTAIN_OPEN_OFFSET 1.0

@protocol KnobViewSensorDelegate <UIGestureRecognizerDelegate>
@optional
- (void) rotation: (CGFloat) angle;
@end

@interface KnobViewSensor : UIGestureRecognizer {
    CGPoint midPoint;
    CGFloat innerRadius;
    CGFloat outerRadius;
    CGFloat cumulatedAngle;
    id <KnobViewSensorDelegate> target;
}

- (id) initWithMidPoint: (CGPoint) midPoint innerRadius: (CGFloat) innerRadius outerRadius: (CGFloat) outerRadius target: (id) target;

- (void)reset;
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event;


@end
