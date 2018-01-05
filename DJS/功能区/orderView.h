//
//  orderView.h
//  DJS
//
//  Created by mac on 2017/12/27.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "BaseView.h"

@interface orderView : BaseView<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property(nonatomic,strong)UILabel *allBtn,*pingJiaBtn;
@property(nonatomic,strong)UIView *allLabel,*pingJiaLabel;
@property(nonatomic,strong)BaseTableView *allTabelView,*pingJiaTableView;
@property(nonatomic,strong) UIScrollView *scrollView;
@property(nonatomic,assign)int abc;
@property(nonatomic,strong)NSMutableArray *tableArr1,*tableArr2;

@end
