//
//  MZViewController.m
//  MZGoogleStyleButton
//
//  Created by monzy613 on 05/12/2016.
//  Copyright (c) 2016 monzy613. All rights reserved.
//

#import "MZViewController.h"
#import "MZGoogleStyleButton.h"

@interface MZViewController ()

@end

@implementation MZViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    MZGoogleStyleButton *button = [[MZGoogleStyleButton alloc] init];
    button.frame = CGRectMake(0, 0, 200, 50);
    button.center = self.view.center;
    button.layer.cornerRadius = 5;
    button.backgroundColor = [UIColor redColor];
    button.layerOpaque = 0.5;
    button.duration = 0.4;
    button.layer.shadowOpacity = 1.0;
    [self.view addSubview:button];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
