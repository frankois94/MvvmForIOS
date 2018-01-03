//
//  ViewController.m
//  Sample
//
//  Created by Dabonot Francois on 03/01/2018.
//  Copyright © 2018 Dabonot Francois. All rights reserved.
//

#import "MainView.h"

@interface MainView ()
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation MainView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self bindProperty:@"helloWorld" onUpdate:^(NSString  * _Nonnull value) {
        NSLog(@"update helloWorld %@", value);
        [_label setText:value];
    }];
}

- (IBAction)textfieldChange:(UITextField *)sender
{
    [[self viewModel] setHelloWorld:[sender text]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
