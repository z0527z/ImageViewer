//
//  ViewController.m
//  ImageViewer
//
//  Created by dingql on 14-1-1.
//  Copyright (c) 2014年 dingql. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic, strong) NSArray * desList;
@end

@implementation ViewController

- (id)init
{
    if (self = [super init]) {
        NSString * path = [[NSBundle mainBundle] pathForResource:@"res" ofType:@"plist"];
        self.desList = [NSArray arrayWithContentsOfFile:path];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.tag = 9;
    button.frame = CGRectMake(10, 10, 50, 20);
    [button setTitle:@"设置" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(Setting:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UILabel * number = [[UILabel alloc] initWithFrame:CGRectMake(135, 10, 50, 20)];
    number.tag = 10;
    number.text = [NSString stringWithFormat:@"1/%d", _desList.count];
    [self.view addSubview:number];
    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40, 320, 320)];
    imageView.tag = 11;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [imageView setImage:[UIImage imageNamed:@"0"]];
    [self.view addSubview:imageView];
    
    UILabel * describle = [[UILabel alloc] initWithFrame:CGRectMake(20, 380, 280, 40)];
    describle.tag = 12;
    describle.numberOfLines = 0;
    describle.text = [_desList objectAtIndex:0];
    describle.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:describle];
    
    UISlider * slider = [[UISlider alloc] initWithFrame:CGRectMake(20, 420, 280, 34)];
    slider.maximumValue = 15;
    slider.minimumValue = 0;
    slider.value = 0;
    [slider addTarget:self action:@selector(showPhoto:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider];
    
}

- (void) showPhoto: (id) sender
{
    UILabel * number = (UILabel *)[self.view viewWithTag:10];
    number.text = [NSString stringWithFormat:@"%d/%d", (int)((UISlider *)sender).value + 1, _desList.count];
    
    UIImageView * imageView = (UIImageView *)[self.view viewWithTag:11];
    [imageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d", (int)((UISlider *)sender).value]]];
    
    UILabel * describle = (UILabel *)[self.view viewWithTag:12];
    describle.text = [_desList objectAtIndex:(int)((UISlider *)sender).value];
}

- (void) Setting: (id) sender
{
    UIButton * button = (UIButton *)[self.view viewWithTag:9];
    
    // 以下弹出框做成属性，效果会好些
    if (!((UIButton *)sender).isSelected) {
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 460, self.view.frame.size.width, 90)];
        view.backgroundColor = [UIColor darkGrayColor];
        view.tag = 13;
        
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 70, 20)];
        label.backgroundColor = view.backgroundColor;
        label.text = @"夜间模式";
        [view addSubview:label];
        
        UISwitch * state = [[UISwitch alloc] initWithFrame:CGRectMake(100, 15, 0, 0)];
        state.on = NO;
        [state addTarget:self action:@selector(SwitchIsOn:) forControlEvents:UIControlEventValueChanged];
        [view addSubview:state];
        
        UILabel * judgement = [[UILabel alloc] initWithFrame:CGRectMake(10, 60, 70, 20)];
        judgement.backgroundColor = view.backgroundColor;
        judgement.text = @"图片大小";
        [view addSubview:judgement];
        
        UISlider * slider = [[UISlider alloc] initWithFrame:CGRectMake(100, 53, 200, 34)];
        slider.maximumValue = 1;
        slider.minimumValue = 0.3;
        slider.value = 1;
        [slider addTarget:self action:@selector(changeImage:) forControlEvents:UIControlEventValueChanged];
        [view addSubview:slider];
        
        [self.view addSubview:view];
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        
        CGRect tmp = view.frame;
        tmp.origin.y -= view.frame.size.height;
        view.frame = tmp;
        [UIView commitAnimations];
        
        button.selected = YES;
    }
    else{
        UIView * view = [self.view viewWithTag:13];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        
        CGRect tmp = view.frame;
        tmp.origin.y += view.frame.size.width;
        view.frame = tmp;
        [UIView commitAnimations];
        
        [view removeFromSuperview];
        button.selected = NO;
    }
}

- (void) SwitchIsOn: (id) sender
{
    UISwitch * state = (UISwitch *) sender;
    
    if (state.on) {
        self.view.backgroundColor = [UIColor grayColor];
    }
    else{
        self.view.backgroundColor = [UIColor whiteColor];
    }
    
    [self.view viewWithTag:10].backgroundColor = self.view.backgroundColor;
    [self.view viewWithTag:12].backgroundColor = self.view.backgroundColor;
}

- (void) changeImage: (id) sender
{
    UISlider * slider = (UISlider *)sender;
    
    [(UIImageView *)[self.view viewWithTag:11] setTransform:CGAffineTransformMakeScale(slider.value, slider.value)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
