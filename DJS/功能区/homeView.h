//
//  homeView.h
//  DJS
//
//  Created by mac on 2017/12/27.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "BaseView.h"

@interface homeView : BaseView<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSArray *tableArr;
@property(nonatomic,strong)NSArray *bannerArr;
@property(nonatomic,strong)BaseTableView *tableView;
@property(nonatomic,strong)UIView *headView;
@property(nonatomic,strong)NSMutableArray<UIButton *> *btnArr;
@property(nonatomic,strong)NSMutableArray *btnNameArr;

@end
