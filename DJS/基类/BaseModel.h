//
//  BaseModel.h
//  jiedian
//
//  Created by 美街美店 on 16/5/5.
//  Copyright © 2016年 com.jiedian.www. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface BaseModel : NSObject

#pragma mark——————————后台返回字段 
@property (nonatomic,strong)NSString *errCode; //结果：0，失败；1 .成功
//@property (nonatomic,strong)NSString *alert; //失败说明
@property (nonatomic,strong)id data; //返回的数据
@property(nonatomic,strong)NSString *errMsg;//提示信息


@end
