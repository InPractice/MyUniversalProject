//
//  AlreadyInputCell.m
//  Universal
//
//  Created by julius on 14/12/5.
//  Copyright (c) 2014年 mycompany. All rights reserved.
//

#import "AlreadyInputCell.h"
#import "AlreadyInputModel.h"

@interface AlreadyInputCell ()
{
    UILabel *_bedroomNumsLabel;
    UILabel *_bbdNameLabel;
    UILabel *_addrLabel;
    UILabel *_houseTitleLabel;
    UILabel *_houseUnitPrice;;
}
@end


@implementation AlreadyInputCell



- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) {
        return nil;
    }
    
//    self.textLabel.adjustsFontSizeToFitWidth = YES;
//    self.textLabel.textColor = [UIColor darkGrayColor];
//    self.detailTextLabel.font = [UIFont systemFontOfSize:12.0f];
//    self.detailTextLabel.numberOfLines = 0;
//    self.selectionStyle = UITableViewCellSelectionStyleGray;
    
    _bedroomNumsLabel = [[UILabel alloc]init];
    _bedroomNumsLabel.textColor = [UIColor redColor];
    _bbdNameLabel = [[UILabel alloc]init];
    _bbdNameLabel.textColor = [UIColor yellowColor];
    _addrLabel = [[UILabel alloc]init];
    _addrLabel.textColor = [UIColor greenColor];
    _houseTitleLabel = [[UILabel alloc]init];
    _houseTitleLabel.textColor = [UIColor blackColor];
    _houseUnitPrice = [[UILabel alloc]init];
    _houseUnitPrice.textColor = [UIColor purpleColor];
    [self addSubview:_bedroomNumsLabel];
    [self addSubview:_bbdNameLabel];
    [self addSubview:_addrLabel];
    [self addSubview:_houseTitleLabel];
    [self addSubview:_houseUnitPrice];
    
    return self;
}

- (void)setPost:(AlreadyInputModel *)model {
    _model = model;
//    
//    self.textLabel.text = _post.user.username;
//    self.detailTextLabel.text = _post.text;
//    [self.imageView setImageWithURL:_post.user.avatarImageURL placeholderImage:[UIImage imageNamed:@"profile-image-placeholder"]];
    
    _bedroomNumsLabel.text = _model.bedroomNums;
    _bbdNameLabel.text = _model.bbdName;
    _addrLabel.text = _model.addr;
    _houseTitleLabel.text = _model.houseTitle;
    _houseUnitPrice.text = _model.houseUnitPrice;

    
    
    [self setNeedsLayout];
}

+ (CGFloat)heightForCellWithAlreadyInputModel:(AlreadyInputModel *)model {
    return (CGFloat)fmaxf(70.0f, (float)[self detailTextHeight:model.houseTitle] + 45.0f);
}

+ (CGFloat)detailTextHeight:(NSString *)text {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    CGSize sizeToFit = [text sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake(240.0f, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
#pragma clang diagnostic pop
    return sizeToFit.height;
}

#pragma mark - UIView

- (void)layoutSubviews {
    [super layoutSubviews];
    
    
    
    
    
    
//    self.imageView.frame = CGRectMake(10.0f, 10.0f, 50.0f, 50.0f);
//    self.textLabel.frame = CGRectMake(70.0f, 6.0f, 240.0f, 20.0f);
//    
//    CGRect detailTextLabelFrame = CGRectOffset(self.textLabel.frame, 0.0f, 25.0f);
//    CGFloat calculatedHeight = [[self class] detailTextHeight:self.model.houseTitle];
//    detailTextLabelFrame.size.height = calculatedHeight;
//    self.detailTextLabel.frame = detailTextLabelFrame;
}








//
//
//
//- (void)awakeFromNib {
//    // Initialization code
//    _bedroomNumsLabel = [[UILabel alloc]init];
//    _bbdNameLabel = [[UILabel alloc]init];
//    _addrLabel = [[UILabel alloc]init];
//    _houseTitleLabel = [[UILabel alloc]init];
//    _houseUnitPrice = [[UILabel alloc]init];
//    
//    [self addSubview:_bedroomNumsLabel];
//    [self addSubview:_bbdNameLabel];
//    [self addSubview:_addrLabel];
//    [self addSubview:_houseTitleLabel];
//    [self addSubview:_houseUnitPrice];
//    
//}
//
//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}
//
//- (void)drawRect:(CGRect)rect
//{
//    
//    
//}
//
//- (void)setModel:(AlreadyInputModel *)model
//{
//    
//}

@end
