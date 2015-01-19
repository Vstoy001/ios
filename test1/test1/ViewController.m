//
//  ViewController.m
//  test1
//
//  Created by Victor Stoyanov on 1/18/15.
//  Copyright (c) 2015 Victor Stoyanov. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UILabel *myLabel;
@property (strong, nonatomic) IBOutlet UISegmentedControl *mode;

@end

@implementation ViewController


- (IBAction)onClicked:(id)sender
{
    [[self myLabel] setText:@"hellow world"];
    
    [[self mode] setSelectedSegmentIndex:1];
    
}

- (IBAction)segCtrl:(id)sender {
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
