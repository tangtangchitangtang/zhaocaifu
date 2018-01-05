

//
//  dinDanXaingQingViewController.m
//  qmzk
//
//  Created by tangtangchitangtang on 2017/6/27.
//  Copyright © 2017年 www.fuyuan.qmzk. All rights reserved.
//

#import "dinDanXaingQingViewController.h"
#import "dinDanXaingQingView.h"

@interface dinDanXaingQingViewController ()
@property(nonatomic,strong)dinDanXaingQingView *aView;

@end

@implementation dinDanXaingQingViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title=@"订单详情";
    
    _aView=[dinDanXaingQingView new];
    [self.view addSubview:_aView];
    [_aView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.left.right.mas_equalTo(0);
    }];

    _aView.viewController=self;
    [self logingView];
}
-(void)logingView{
    
    NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:_order_id,@"order_id", nil];
    [ZQTools AFNPostDataUrl:@"app/orderDetail" Dict:dic andTableView:nil andView:self.view andSuccessBlock:^(id responseObject) {
        _aView.tableDic=responseObject;
        [_aView creatView1];
    } anderrorBlock:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
