//
//  LearningMaterialCell.m
//  iOS_interView
//
//  Created by 神州第一坑 on 2021/10/16.
//

#import "LearningMaterialCell.h"
#import "Masonry.h"
@implementation LearningMaterialCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.label =[[UILabel alloc]init];
        self.label.numberOfLines =0;
        self.label.font =[UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.label];
        
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.top.mas_equalTo(10);
            make.right.bottom.mas_equalTo(-10);
        }];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
