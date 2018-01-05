
#import <UIKit/UIKit.h>
//#import "QZTopTextView.h"

@interface BaseViewController : UIViewController

@property (nonatomic,strong)UISearchBar* searchBar;    //搜索框

@property (nonatomic,assign)int index; //数据页数


- (void)popVc;//返回上一页
@end
