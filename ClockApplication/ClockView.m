//
//  ClockView.m
//  ClockApplication
//
//  Created by Kumaraswamy D R on 26/07/16.
//  Copyright © 2016 TechLeraner. All rights reserved.
//

#import "ClockView.h"

#define SEC_HAND_LENGTH 0.8
//in pixels
#define HOURS_HAND_WIDTH 10
#define MIN_HAND_WIDTH 8
#define SEC_HAND_WIDTH 4
float Degrees2Radians(float degrees) { return degrees * M_PI / 180; }

@interface ClockView()
@property(nonatomic,strong) UIImageView *backgroundImageView;
@property(nonatomic,strong) UIBezierPath *path1;
@property(nonatomic,strong) UIImageView *minuteLineView,*hoursLineView,*seccondsLineView;
@property(nonatomic) long hour,minute,seconds;
@property(nonatomic) BOOL isFirstTime;
@property(nonatomic,strong) NSString *am_OR_pm;


@property(nonatomic,strong)   CALayer *secHand;;


@end
@implementation ClockView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _backgroundImageView = [[UIImageView alloc]initWithFrame:frame];
        [_backgroundImageView setImage:[UIImage imageNamed:@"clock-background.png"]];
        [self addSubview:_backgroundImageView];
         [self performSelector:@selector(currentTime) withObject:nil afterDelay:1.0f];
        
        _isFirstTime=YES;
        
        
        _seccondsLineView = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width/2, self.frame.size.width/2, 1, 60)];
        _seccondsLineView.center = CGPointMake(_backgroundImageView.center.x, _backgroundImageView.center.y);
        _seccondsLineView.layer.anchorPoint = CGPointMake(0, 0);
        _seccondsLineView.image = [UIImage imageNamed:@"clock-sec-background.png"];
        _seccondsLineView.backgroundColor = [UIColor blackColor];
        [self addSubview:_seccondsLineView];

        
        
        
    }
    return self;
}
-(void)layoutSubviews
{
    
}
-(void)currentTime
{
    //Get current time
    NSDate* now = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *dateComponents = [gregorian components:(NSCalendarUnitHour  | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:now];
    NSInteger hour = [dateComponents hour];
    NSString *am_OR_pm=@"AM";
    
    
        if (hour>12)
    {
        hour=hour%12;
        
        am_OR_pm = @"PM";
    }
    
    NSInteger minute = [dateComponents minute];
    NSInteger second = [dateComponents second];
   
    NSLog(@"Current Time  %@",[NSString stringWithFormat:@"%02ld:%02ld:%02ld %@", (long)hour, (long)minute, (long)second,am_OR_pm]);
    
    _hour=hour;  
    _minute= minute;
    _seconds=second;
    _am_OR_pm=am_OR_pm;
    
    [UIView animateWithDuration:0.5
                          delay:0
         usingSpringWithDamping:.2
          initialSpringVelocity:.4
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         
                         _seccondsLineView.transform = CGAffineTransformMakeRotation(_seconds * (6*M_PI)/180);
                     }
                     completion:^(BOOL finished) {
                         
                     }];
    
    [self performSelector:@selector(currentTime) withObject:nil afterDelay:0.5f];

}
@end
