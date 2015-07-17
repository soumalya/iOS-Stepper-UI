//
//  StepperView.h
//  CustomStepper
//
//  Created by Soumalya Banerjee on 16/07/15.
//  Copyright (c) 2015 Soumalya Banerjee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StepperConstants.h"

@interface StepperView : UIView

@property (nonatomic) NSInteger numberTotalStep;
@property (nonatomic) NSInteger numberCompleted;
@property (nonatomic) NSInteger numberCurrent;
@property (nonatomic) CGFloat startX;
@property (nonatomic) CGFloat startY;

- (void)drawStepperInView:(UIView *)containerView;
- (void)drawStepperMarkInView:(UIView *)containerView withNumber:(NSInteger)markDigit withStatus:(NSInteger)markStatus;
- (void)setStepWithNumber:(int)step;

@end
