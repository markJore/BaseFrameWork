//
//  ELHomePageViewController.m
//  BaseFrameWork
//
//  Created by Eleven on 2017/12/18.
//  Copyright © 2017年 Eleven. All rights reserved.
//

#import "ELHomePageViewController.h"
#import "APIProxy.h"
#import "YYModel.h"
#import "JokeModel.h"
@interface ELHomePageViewController ()

@end

@implementation ELHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[APIProxy shareInstance] getRequestWithUrl:@"http://japi.juhe.cn/joke/content/list.from" params:@{@"key":@"c2aadbc93141e2527d8bd613a32ad8f2",@"sort":@"asc",@"time":@"1318745237"} responseBlock:^(NSDictionary *resonseDic, URLResponseStatus status) {
        JokeModel *model = [JokeModel yy_modelWithDictionary:resonseDic];
        NSLog(@"mmmmm %@ rrrr %@", model.result, model.reason);

    }];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
