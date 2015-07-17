//
//  StepperView.m
//  CustomStepper
//
//  Created by Soumalya Banerjee on 16/07/15.
//  Copyright (c) 2015 Soumalya Banerjee. All rights reserved.
//

#import "StepperView.h"
#import <QuartzCore/QuartzCore.h>

@implementation StepperView {
    UIView *_stepperPipeBG;
    UIView *_stepperPipeFront;
    
    UILabel *_stepperMark;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)drawStepperInView:(UIView *)containerView {
    
    if (_numberCurrent <= 0) {
        
        _numberCompleted = 0;
        _numberCurrent = 1;
        
    } else if (_numberCurrent > _numberTotalStep) {
        
        _numberCompleted = _numberTotalStep - 1;
        _numberCurrent = _numberTotalStep + 1;
        
    } else {
        _numberCompleted = _numberCurrent - 1;
    }
    
    CGFloat _startPointX = ([UIScreen mainScreen].bounds.size.width - STEPPER_WIDTH) / 2;
    if (_startX) {
        _startPointX = _startX;
    }
    
    CGFloat _startPointY = 100.0f;
    if (_startY) {
        _startPointY = _startY;
    }
    
    _stepperPipeBG = [[UIView alloc] initWithFrame:CGRectMake(_startPointX, _startPointY, STEPPER_WIDTH, STEPPER_HEIGHT)];
    _stepperPipeBG.backgroundColor = [UIColor colorWithRed:(225.0f/256.0f) green:(225.0f/256.0f) blue:(225.0f/256.0f) alpha:1.0f];
    [containerView addSubview:_stepperPipeBG];
    
    
    CGFloat _stepperPipeFrontWidth = ((STEPPER_WIDTH / (_numberTotalStep - 1)) * _numberCompleted);
    _stepperPipeFront = [[UIView alloc] initWithFrame:CGRectMake(10.0f, 4.0f, _stepperPipeFrontWidth, (STEPPER_HEIGHT - 8.0f))];
    _stepperPipeFront.backgroundColor = COMPLETED_COLOR;
    _stepperPipeFront.layer.borderWidth = 1.5f;
    _stepperPipeFront.layer.borderColor = COMPLETED_BORDER_COLOR.CGColor;
    [_stepperPipeBG addSubview:_stepperPipeFront];
    
    for (int i=1; i<=_numberTotalStep; i++) {
        int status = MARK_UNTOUCHED;
        if (i < _numberCurrent) {
            status = MARK_COMPLETED;
        } else if (i == _numberCurrent) {
            status = MARK_CURRENT;
        } else {
            status = MARK_UNTOUCHED;
        }
        [self drawStepperMarkInView:_stepperPipeBG withNumber:i withStatus:status];
    }
}

- (void)setStepWithNumber:(int)step {
    
    if (step <= 0) {
        
        _numberCompleted = 0;
        step = 1;
        
    } else if (step > _numberTotalStep) {
        
        _numberCompleted = _numberTotalStep - 1;
        _numberCurrent = _numberTotalStep + 1;
        
    } else {
        _numberCompleted = step - 1;
        _numberCurrent = step;
    }
    
    CGFloat _stepperPipeFrontWidth = ((STEPPER_WIDTH / (_numberTotalStep - 1)) * _numberCompleted);
    if (_stepperPipeFront) {
        _stepperPipeFront.frame = CGRectMake(10.0f, 4.0f, _stepperPipeFrontWidth, (STEPPER_HEIGHT - 8.0f));
    }
    for (int i=1; i<=_numberTotalStep; i++) {
        int status = MARK_UNTOUCHED;
        if (i < _numberCurrent) {
            status = MARK_COMPLETED;
        } else if (i == _numberCurrent) {
            status = MARK_CURRENT;
        } else {
            status = MARK_UNTOUCHED;
        }
        [self drawStepperMarkInView:_stepperPipeBG withNumber:i withStatus:status];
    }
}

- (void)drawStepperMarkInView:(UIView *)containerView withNumber:(NSInteger)markDigit withStatus:(NSInteger)markStatus {
    
    CGFloat markStartX = 0;
    if (markDigit == 1) {
        markStartX = 0.0f - (STEPPER_MARK_HEIGHT_WIDTH / 2);
    } else if (markDigit == _numberTotalStep) {
        markStartX = STEPPER_WIDTH - (STEPPER_MARK_HEIGHT_WIDTH / 2);
    } else {
        markStartX = ((STEPPER_WIDTH / (_numberTotalStep - 1)) * (markDigit - 1)) - (STEPPER_MARK_HEIGHT_WIDTH / 2);
    }
    
    UIColor *backgroundColor = [UIColor clearColor];
    UIColor *borderColor = [UIColor clearColor];
    switch (markStatus) {
        case MARK_UNTOUCHED:
            backgroundColor = [UIColor clearColor];
            borderColor = [UIColor clearColor];
            break;
            
        case MARK_CURRENT:
            backgroundColor = CURRENT_COLOR;
            borderColor = CURRENT_BORDER_COLOR;
            break;
            
        case MARK_COMPLETED:
            backgroundColor = COMPLETED_COLOR;
            borderColor = COMPLETED_BORDER_COLOR;
            break;
            
        default:
            break;
    }
    
    UIView *_stepperMarkBG = [[UIView alloc] initWithFrame:CGRectMake(markStartX, ((STEPPER_HEIGHT - STEPPER_MARK_HEIGHT_WIDTH) / 2), STEPPER_MARK_HEIGHT_WIDTH, STEPPER_MARK_HEIGHT_WIDTH)];
    _stepperMarkBG.tag = (int)markDigit;
    _stepperMarkBG.backgroundColor = [UIColor colorWithRed:(225.0f/256.0f) green:(225.0f/256.0f) blue:(225.0f/256.0f) alpha:1.0f];
    _stepperMarkBG.layer.cornerRadius = STEPPER_MARK_HEIGHT_WIDTH / 2;
    [_stepperMarkBG clipsToBounds];
    _stepperMarkBG.clipsToBounds = YES;
    [containerView addSubview:_stepperMarkBG];
    [containerView bringSubviewToFront:_stepperMarkBG];
    
    CGFloat heightWidth = STEPPER_MARK_HEIGHT_WIDTH - 6;
    CGFloat labelStart = (STEPPER_MARK_HEIGHT_WIDTH - heightWidth) / 2;
    CGFloat fontSize = heightWidth - 5.0f;
    
    _stepperMark = [[UILabel alloc] initWithFrame:CGRectMake(labelStart, labelStart, heightWidth, heightWidth)];
    _stepperMark.tag = (int)markDigit;
    _stepperMark.backgroundColor = backgroundColor;
    _stepperMark.textAlignment = NSTextAlignmentCenter;
    _stepperMark.font = [UIFont systemFontOfSize:fontSize];
    _stepperMark.text = [NSString stringWithFormat:@"%d", (int)markDigit];
    _stepperMark.layer.cornerRadius = _stepperMark.frame.size.width / 2;
    _stepperMark.layer.borderWidth = 1.5f;
    _stepperMark.layer.borderColor = borderColor.CGColor;
    [_stepperMark clipsToBounds];
    _stepperMark.clipsToBounds = YES;
    [_stepperMarkBG addSubview:_stepperMark];
    [_stepperMarkBG bringSubviewToFront:_stepperMark];
}

@end
