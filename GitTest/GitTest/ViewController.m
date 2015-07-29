//
//  ViewController.m
//  GitTest
//
//  Created by rimi on 15/7/29.
//  Copyright (c) 2015年 rimi. All rights reserved.
//

#import "ViewController.h"
#import "StockData.h"
@interface ViewController ()
{
    UILabel *myLabel;
}
@property (nonatomic, strong) StockData *stockForKVO;
@end



@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    NSLog(@"weige");
    _stockForKVO = [[StockData alloc] init];
    [_stockForKVO addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    
    myLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 100, 100, 30 )];
    myLabel.backgroundColor = [UIColor grayColor];
    myLabel.textColor = [UIColor redColor];
    [self.view addSubview:myLabel];
    
    
    UIButton * b = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    b.frame = CGRectMake(20, 50, 100, 30);
    b.backgroundColor = [UIColor cyanColor];
    [b addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:b];
    
}

-(void) buttonAction
{

    [_stockForKVO dataFromNetWorking];
   
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{

    NSLog(@"keypath : %@", keyPath);
    NSLog(@"object : %@", object);
    NSLog(@"change : %@", change);
    if ([keyPath isEqualToString:@"age"]) {
        myLabel.text = [NSString stringWithFormat:@"%@",[_stockForKVO valueForKey:@"age"]];
//        myLabel.text = [NSString stringWithFormat:@"%@",change[@"new"]];
        NSLog(@"%@",change[@"new"]);
    }
}

- (void)dealloc{

    [_stockForKVO removeObserver:self forKeyPath:@"age"];
}
@end
