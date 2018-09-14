//
//  MainController.m
//  iOS-UITableView
//
//  Created by Ezreal on 2018/6/14.
//  Copyright © 2018年 liuyiming. All rights reserved.
//

#import "MainController.h"
#import "PersonalCenterController.h"

#import "MainCell.h"

@interface MainController () <UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) NSArray *titles;
@property(nonatomic, strong) UITableView *tableView;

@end

@implementation MainController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    _titles = @[@"透视图伸拉效果"];
    
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titles.count;
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
    PersonalCenterController *controller = [[PersonalCenterController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
