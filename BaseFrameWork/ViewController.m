//
//  ViewController.m
//  BaseFrameWork
//
//  Created by Eleven on 2017/12/11.
//  Copyright © 2017年 Eleven. All rights reserved.
//

#import "ViewController.h"
#import "APIProxy.h"
#import "YYModel.h"
#import "JokeModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    [[APIProxy shareInstance] postRequestWithUrl:@"http://japi.juhe.cn/joke/content/list.from?key=c2aadbc93141e2527d8bd613a32ad8f2&sort=asc&time=1418745237" params:nil serversigns:NO responseBlock:^(NSDictionary *resonseDic, URLResponseStatus status) {
//
//    }];
//    [[APIProxy shareInstance] postRequestWithUrl:@"http://japi.juhe.cn/joke/content/list.from" params:@{@"key":@"c2aadbc93141e2527d8bd613a32ad8f2",@"sort":@"asc",@"time":@"1418745237"} serversigns:NO responseBlock:^(NSDictionary *resonseDic, URLResponseStatus status) {
//
//    }];
    [[APIProxy shareInstance] getRequestWithUrl:@"http://japi.juhe.cn/joke/content/list.from" params:@{@"key":@"c2aadbc93141e2527d8bd613a32ad8f2",@"sort":@"asc",@"time":@"1318745237"} responseBlock:^(NSDictionary *resonseDic, URLResponseStatus status) {
        JokeModel *model = [JokeModel yy_modelWithDictionary:resonseDic];
        NSLog(@"mmmmm %@ rrrr %@", model.result, model.reason);
        
    }];

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)run1{
    CGFloat height  = 10;
    CGFloat width = 8;
    for (size_t y = 0; y < height; ++y) {
        for (size_t x = 0; x < width; ++x) {
            NSLog(@"path 111 ");
        }
    }
}

- (void)run2{
    CGFloat height  = 10;
    CGFloat width = 8;
    dispatch_apply(height, dispatch_get_global_queue(0, 0), ^(size_t y) {
        for (size_t x = 0; x < width; x += 2) {
            NSLog(@"path 222");
        }
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
