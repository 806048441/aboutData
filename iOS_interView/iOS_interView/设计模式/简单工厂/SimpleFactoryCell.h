//
//  SimpleFactoryCell.h
//  iOS_interView
//
//  Created by 神州第一坑 on 2022/2/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SimpleFactoryCell : UITableViewCell

@property (strong,nonatomic)id data;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier type:(NSInteger)type;
@end

NS_ASSUME_NONNULL_END
