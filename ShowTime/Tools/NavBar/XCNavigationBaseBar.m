//
//  XCNavigationBar.m
//  xingxuan
//
//  Created by xz on 2020/3/23.
//  Copyright © 2020 辛橙. All rights reserved.
//

#import "XCNavigationBaseBar.h"

@interface XCNavigationBaseBar()
//@property(nonatomic,strong)UIButton *backBtn;
@property(nonatomic, strong)UIImageView *bgImg;

@end

@implementation XCNavigationBaseBar
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.bgImg.hidden = NO;
        self.backBtn.hidden = NO;
        self.titleLabel.hidden = NO;
        self.backgroundColor = [UIColor whiteColor];
        self.bottomLineView.hidden = NO;
    }
    return self;
}

- (UIImageView *)bgImg {
    if (!_bgImg) {
        _bgImg = [[UIImageView alloc]init];
        _bgImg.image = [UIImage imageNamed:@"nav"];
        [self addSubview:_bgImg];
        [_bgImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    return _bgImg;
}

- (UIButton *)backBtn {
    if (_backBtn == nil) {
        _backBtn = [[UIButton alloc] init];
        [_backBtn setImage:[UIImage imageNamed:@"nav_white"] forState:UIControlStateNormal];
        [self addSubview:_backBtn];
        [_backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(16);
            make.width.height.mas_equalTo(22);
            make.top.mas_equalTo(Screen.statusBarHeight+11);
        }];
        [_backBtn addTarget:self action:@selector(backBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

- (void)backBtnAction {
    [[UIViewController topMost].navigationController popViewControllerAnimated:true];
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:18];
        _titleLabel.textColor = [UIColor whiteColor];
        [self addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.mas_equalTo(Screen.statusBarHeight+11);
            make.height.mas_equalTo(22);
        }];
    }
    return _titleLabel;
}

- (UIButton *)rightButton {
    if (!_rightButton) {
        _rightButton = [[UIButton alloc] init];
        [_rightButton setImage:[UIImage imageNamed:@"icon_msgcenter_customer"] forState:UIControlStateNormal];
        [self addSubview:_rightButton];
        [_rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-16);
            make.width.height.mas_equalTo(22);
            make.top.mas_equalTo(Screen.statusBarHeight+11);
        }];
        [_rightButton addTarget:self action:@selector(rightButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}

- (void)rightButtonAction {
    //联系客服
//    [JumpManager dialHotLine];
}

- (UIView *)bottomLineView {
    if (_bottomLineView == nil) {
        _bottomLineView = [[UIView alloc] init];
        _bottomLineView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0.08 alpha:0.08];
        [self addSubview:_bottomLineView];
        [_bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
            make.height.mas_equalTo(1/UIScreen.mainScreen.scale);
        }];
    }
    return _bottomLineView;
}
@end
