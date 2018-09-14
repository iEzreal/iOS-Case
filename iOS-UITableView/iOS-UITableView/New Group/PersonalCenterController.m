//
//  PersonalCenterController.m
//  iOS-UITableView
//
//  Created by Ezreal on 2018/6/14.
//  Copyright © 2018年 liuyiming. All rights reserved.
//

#import "PersonalCenterController.h"

#import "MainCell.h"

@interface PersonalCenterController () <UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView;

@end

@implementation PersonalCenterController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"个人中心";
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 12;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"MainCell";
    MainCell *mainCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!mainCell) {
        mainCell = [[MainCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return mainCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}


@end
