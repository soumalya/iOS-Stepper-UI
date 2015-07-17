//
//  ViewController.m
//  CustomStepper
//
//  Created by Soumalya Banerjee on 16/07/15.
//  Copyright (c) 2015 Soumalya Banerjee. All rights reserved.
//

#import "ViewController.h"
#import "StepperView.h"

@interface ViewController () {
    StepperView *stepper;
    int _currentStep;
    int _totalStep;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _currentStep = 2;
    _totalStep = 4;
    
    stepper = [[StepperView alloc] init];
    
    stepper.startX = 30.0f; // Optional
    stepper.startY = 300.0f; // Optional
    
    stepper.numberTotalStep = _totalStep;
    
    //number greater than total means all completed
    //number less than 0 or is equal to 0 means just started
    stepper.numberCurrent = _currentStep;
    
    [stepper drawStepperInView:self.view];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goPrevious:(id)sender {
    --_currentStep;
    if (_currentStep <= 0) {
        _currentStep = 1;
    }
    [stepper setStepWithNumber:_currentStep];
}

- (IBAction)goNext:(id)sender {
    ++_currentStep;
    if (_currentStep > _totalStep) {
        _currentStep = _totalStep + 1;
    }
    [stepper setStepWithNumber:_currentStep];
}
@end
