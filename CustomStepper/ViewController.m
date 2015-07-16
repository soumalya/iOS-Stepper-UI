//
//  ViewController.m
//  CustomStepper
//
//  Created by Soumalya Banerjee on 16/07/15.
//  Copyright (c) 2015 Soumalya Banerjee. All rights reserved.
//

#import "ViewController.h"
#import "StepperView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    StepperView *stepper = [[StepperView alloc] init];
    
    stepper.startX = 30.0f; // Optional
    stepper.startY = 400.0f; // Optional
    
    stepper.numberTotalStep = 4;
    
    //number greater than total means all completed
    //number less than 0 or is equal to 0 means just started
    stepper.numberCurrent = 3;
    
    [stepper drawStepperInView:self.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
