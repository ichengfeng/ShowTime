//
//  XCNavigationBar.h
//  xingxuan
//
//  Created by xz on 2020/3/23.
//  Copyright © 2020 辛橙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XCNavigationBaseBar : UIView
@property (nonatomic,strong)UIButton *backBtn;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UIView *bottomLineView;
@property (nonatomic,strong)UIButton *rightButton;
@end

NS_ASSUME_NONNULL_END
