//
//  dinDanXaingQingView.h
//  qmzk
//
//  Created by tangtangchitangtang on 2017/6/27.
//  Copyright © 2017年 www.fuyuan.qmzk. All rights reserved.
//

#import "BaseView.h"

@interface dinDanXaingQingView : BaseView<UITextViewDelegate>
@property(nonatomic,strong)NSDictionary *tableDic;
@property(nonatomic,strong)UITextView *textView;
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)NSMutableArray *btnArr;
@property(nonatomic,strong)UILabel *scorLabel;
@property(nonatomic,strong)NSNumber *scorl;
-(void)creatView1;




@end
