//
//  DCTableViewController.h
//  PurangFinanceVillage
//
//  Created by daichen on 2017/4/27.
//  Copyright © 2017年 ___PURANG___. All rights reserved.
//

#import "DCViewController.h"
#import "UIScrollView+EmptyDataSet.h"

@interface DCTableViewController : DCViewController<UITableViewDelegate, UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

- (instancetype)initWithStyle:(UITableViewStyle)style;

/**
 *  显示大量数据的控件
 */
@property (nonatomic, strong) UITableView *tableView;

/**
 *  数据源
 */
@property (nonatomic, strong) NSMutableArray *dataSource;

- (void)refreshTableViewHeader;
- (void)refreshTableViewFooter;

@end
