//
//  SimpleFactoryCell.m
//  iOS_interView
//
//  Created by 神州第一坑 on 2022/2/23.
//

#import "SimpleFactoryCell.h"
@interface SimpleLabelCell : SimpleFactoryCell

@end

@implementation SimpleLabelCell

- (void)setData:(id)data{
    
    [super setData:data];
    self.textLabel.font=[UIFont systemFontOfSize:100];
    self.textLabel.text =data;
}
@end

@interface SimpleImageCell : SimpleFactoryCell

@end

@implementation SimpleImageCell

- (void)setData:(id)data{
    
    [super setData:data];
    self.imageView.image =[UIImage imageNamed:data];
}

@end

@implementation SimpleFactoryCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier type:(NSInteger)type{
    
    if (type==1) {
        
        return [[SimpleLabelCell alloc]initWithStyle:style reuseIdentifier:[reuseIdentifier stringByAppendingString:@"1"]];
    }else if (type==2){
        
        return [[SimpleImageCell alloc]initWithStyle:style reuseIdentifier:[reuseIdentifier stringByAppendingString:@"2"]];
    }
    return nil;
}

@end
