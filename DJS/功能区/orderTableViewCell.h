//
//  orderTableViewCell.h
//  DJS
//
//  Created by 浪尖渝力 on 2018/1/3.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface orderTableViewCell : BaseTableViewCell
@property(nonatomic,strong)NSDictionary *dic;
-(void)creatView;
@end
