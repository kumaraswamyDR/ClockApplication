//
//  ViewController.m
//  ClockApplication
//
//  Created by Kumaraswamy D R on 26/07/16.
//  Copyright © 2016 TechLeraner. All rights reserved.
//

#import "ViewController.h"
#import "ClockView.h"

@interface ViewController ()
@property(nonatomic,strong) ClockView *clockView;
@property(nonatomic,strong) UIImageView *backGroundImageView;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _backGroundImageView = [[UIImageView alloc]init];
    _backGroundImageView.image = [UIImage imageNamed:@"clockbackground.jpg"];
    [self.view addSubview:_backGroundImageView];
    
    _clockView = [[ClockView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width*0.8, self.view.frame.size.width*0.8)];
    [self.view addSubview:_clockView];
    
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)viewWillLayoutSubviews
{
     _backGroundImageView.frame = self.view.frame;
    _clockView.frame = CGRectMake(self.view.frame.size.width*0.1, self.view.frame.size.width*0.2, self.view.frame.size.width*0.8, self.view.frame.size.height*0.6);
   
   
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
