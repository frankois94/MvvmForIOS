//
//  SecondView.m
//  Sample
//
//  Created by Dabonot Francois on 20/01/2018.
//  Copyright © 2018 Dabonot Francois. All rights reserved.
//

#import "SecondView.h"

@interface SecondView ()

@end

@implementation SecondView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)closeView:(id)sender {
    [[self viewModel] closeViewModel];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
