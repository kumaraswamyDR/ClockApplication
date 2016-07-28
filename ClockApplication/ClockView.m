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
@property(nonatomic) long hour,hourCopy,minute,minuteCopy,seconds;
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
        
        self.backgroundColor = [UIColor clearColor];
        _backgroundImageView = [[UIImageView alloc]initWithFrame:frame];
      
        _backgroundImageView.backgroundColor = [UIColor clearColor];
        [_backgroundImageView setImage:[UIImage imageNamed:@"clock-background.png"]];
        [self addSubview:_backgroundImageView];
        _backgroundImageView.layer.cornerRadius = self.frame.size.width/2;
         [self performSelector:@selector(currentTime) withObject:nil afterDelay:1.0f];
        
        _isFirstTime=YES;
        
        _seccondsLineView = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width/2, self.frame.size.width/2, 5, 60)];
        _seccondsLineView.center = CGPointMake(_backgroundImageView.center.x, _backgroundImageView.center.y);
        
        _seccondsLineView.layer.anchorPoint = CGPointMake(0.5, 0);
        _seccondsLineView.image = [UIImage imageNamed:@"clock-sec-background.png"];
        _seccondsLineView.image = [_seccondsLineView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [_seccondsLineView setTintColor:[UIColor redColor]];
        [self addSubview:_seccondsLineView];
        
        
        _minuteLineView = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width/2, self.frame.size.width/2, 5, 50)];
        _minuteLineView.center = CGPointMake(_backgroundImageView.center.x, _backgroundImageView.center.y);
        _minuteLineView.layer.anchorPoint = CGPointMake(0.5, 0);
        _minuteLineView.image = [UIImage imageNamed:@"clock-sec-background.png"];
        _minuteLineView.image = [_seccondsLineView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [_minuteLineView setTintColor:[UIColor greenColor]];
        _minuteLineView.backgroundColor = [UIColor blackColor];
        [self addSubview:_minuteLineView];
        
        _hoursLineView = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width/2, self.frame.size.width/2, 5, 40)];
        _hoursLineView.center = CGPointMake(_backgroundImageView.center.x, _backgroundImageView.center.y);
        _hoursLineView.layer.anchorPoint = CGPointMake(0.5, 0);
        _hoursLineView.image = [UIImage imageNamed:@"clock-sec-background.png"];
        _hoursLineView.backgroundColor = [UIColor blackColor];
        [self addSubview:_hoursLineView];
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
                         
                         _seccondsLineView.transform = CGAffineTransformMakeRotation ((_seconds * (6*M_PI)/180)-(90*(M_PI/2)));
                         if(minute != _minuteCopy || _isFirstTime)
                         {
                         _minuteLineView.transform = CGAffineTransformMakeRotation((_minute * (6*M_PI)/180)-(90*(M_PI/2)));
                         _hoursLineView.transform = CGAffineTransformMakeRotation((hour*30*(M_PI/180))+(minute*0.5*(M_PI/180))-(90*(M_PI/2)));
                             _minuteCopy= _minute;
                             _isFirstTime= NO;
                         }
                     }
                     completion:^(BOOL finished) {
                     }];
    [self performSelector:@selector(currentTime) withObject:nil afterDelay:0.5f];

}
@end
