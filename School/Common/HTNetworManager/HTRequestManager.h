//
//  HTRequestManager.h
//  GMat
//
//  Created by hublot on 2017/5/3.
//  Copyright © 2017年 thinku. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTNetworkManager.h"
#import "HTRequestDomain.h"


#import "HTBroadCastModel.h"

#import "HTLoginTextFieldGroupView.h"

#import "HTCommunityLayoutModel.h"

#import "HTOrganizationModel.h"

#import "HTAnswerModel.h"

#import "HTGossIPItemModel.h"

#define HTPlaceholderString(string, placeholder) string && [NSString stringWithFormat:@"%@", string].length ? [NSString stringWithFormat:@"%@", string] : (placeholder && [NSString stringWithFormat:@"%@", placeholder].length ? [NSString stringWithFormat:@"%@", placeholder] : @"")

@interface HTRequestManager : NSObject


/**
 获取广告
 
 */
+ (void)requestBroadcastComplete:(HTUserTaskCompleteBlock)complete;


/**
 获取备考八卦列表
 
 @param pageSize 每页返回个数
 @param currentPage 当前页
 */
+ (void)requestGossipListWithNetworkModel:(HTNetworkModel *)networkModel pageSize:(NSString *)pageSize currentPage:(NSString *)currentPage catIdString:(NSString *)catIdString complete:(HTUserTaskCompleteBlock)complete;


/**
 获取某一个八卦的详情
 
 @param gossipIdString 要获取的八卦的 id
 */
+ (void)requestGossipDetailWithNetworkModel:(HTNetworkModel *)networkModel gossipIdString:(NSString *)gossipIdString complete:(HTUserTaskCompleteBlock)complete;


/**
 回复帖子
 
 @param replyContent 要回复的内容
 @param communityLayoutModel 打包的八卦的模型
 */
+ (void)requestGossipReplyGossipOwnerWithNetworkModel:(HTNetworkModel *)networkModel replyContent:(NSString *)replyContent communityLayoutModel:(HTCommunityLayoutModel *)communityLayoutModel complete:(HTUserTaskCompleteBlock)complete;


/**
 回复楼层
 
 @param replyContent 要回复的内容
 @param communityLayoutModel 打包的八卦的模型
 @param beingReplyModel 打包的要回复的楼层的模型
 */
+ (void)requestGossipReplyGossipLoopReplyWithNetworkModel:(HTNetworkModel *)networkModel replyContent:(NSString *)replyContent communityLayoutModel:(HTCommunityLayoutModel *)communityLayoutModel beingReplyModel:(HTCommunityReplyLayoutModel *)beingReplyModel complete:(HTUserTaskCompleteBlock)complete;


/**
 八卦点赞或取消点赞
 
 @param gossipIdString 要点赞或要取消点赞的八卦 id
 */
+ (void)requestGossipGoodGossipWithNetworkModel:(HTNetworkModel *)networkModel gossipIdString:(NSString *)gossipIdString complete:(HTUserTaskCompleteBlock)complete;


/**
 上传图片到服务器, 图片用来发表备考八卦, 图片数据放在 networkModel
 
 */
+ (void)requestGossipUploadGossipImageWithNetworkModel:(HTNetworkModel *)networkModel complete:(HTUserTaskCompleteBlock)complete;

/**
 发表一个新的备考八卦
 
 @param gossipTitleString 发表标题
 @param gossipDetailString 发表内容
 @param imageSourceArray 发表的图片地址数组
 */
+ (void)requestGossipSendGossipWithNetworkModel:(HTNetworkModel *)networkModel gossipTitleString:(NSString *)gossipTitleString gossipDetailString:(NSString *)gossipDetailString imageSourceArray:(NSArray <NSString *> *)imageSourceArray complete:(HTUserTaskCompleteBlock)complete;


/**
 获取自己的备考八卦的未读消息
 
 */
+ (void)requestGossipMessageWithNetworkModel:(HTNetworkModel *)networkModel complete:(HTUserTaskCompleteBlock)complete;


/**
 获取首页列表

 */
+ (void)requestIndexListWithNetworkModel:(HTNetworkModel *)networkModel complete:(HTUserTaskCompleteBlock)complete;


/**
 获取筛选学校的参数列表

 */
+ (void)requestSchoolFilterParameterWithNetworkModel:(HTNetworkModel *)networkModel complete:(HTUserTaskCompleteBlock)complete;


/**
 获取测评的国家列表和专业列表

 */
+ (void)requestSchoolMatriculateCountryListAndMajorListWithNetworkModel:(HTNetworkModel *)networkModel complete:(HTUserTaskCompleteBlock)complete;

/**
 上传智能选校参数

 @param parameter 表单
 */
+ (void)requestSendSchoolMatriculateWithNetworkModel:(HTNetworkModel *)networkModel parameter:(NSDictionary *)parameter complete:(HTUserTaskCompleteBlock)complete;


/**
 获取单个学校的几率测评

 @param parameter 表单
 */
+ (void)requestSchoolSingleMatriculateResultWithNetworkModel:(HTNetworkModel *)networkModel parameter:(NSDictionary *)parameter complete:(HTUserTaskCompleteBlock)complete;


/**
 获取学校详情

 @param schoolId 学校 id
 */
+ (void)requestSchoolDetailWithNetworkModel:(HTNetworkModel *)networkModel schoolId:(NSString *)schoolId complete:(HTUserTaskCompleteBlock)complete;


/**
 获取专业详情

 @param professionalId 专业 id
 */
+ (void)requestProfessionalWithNetworkModel:(HTNetworkModel *)networkModel professionalId:(NSString *)professionalId complete:(HTUserTaskCompleteBlock)complete;



/**
 获取热门学校列表

 @param currentPage 当前页码
 @param pageSize 每一页的数量
 */
+ (void)requestHotSchoolListWithNetworkModel:(HTNetworkModel *)networkModel currentPage:(NSString *)currentPage pageSize:(NSString *)pageSize complete:(HTUserTaskCompleteBlock)complete;


/**
 获取大学排名类别的列表

 @param currentPage 当前页码
 @param pageSize 每一页的数量
 */
+ (void)requestRankClassListWithNetworkModel:(HTNetworkModel *)networkModel currentPage:(NSString *)currentPage pageSize:(NSString *)pageSize complete:(HTUserTaskCompleteBlock)complete;


/**
 获取大学排名学校的列表

 @param classIdString 大学排名类别的 id
 @param yearIdString 大学排名年份的 type
 @param currentPage 当前页码
 @param pageSize 每一页的数量
 */
+ (void)requestRankSchoolListWithNetworkModel:(HTNetworkModel *)networkModel classIdString:(NSString *)classIdString yearIdString:(NSString *)yearIdString currentPage:(NSString *)currentPage pageSize:(NSString *)pageSize complete:(HTUserTaskCompleteBlock)complete;


/**
 请求学校筛选出来的列表

 @param countryIdString 国家的 id
 @param rankIdString 排名的 id
 @param professionalIdString 专业的 id
 @param currentPage 当前页码
 @param pageSize 每一页的数量
 */
+ (void)requestSchoolFilterListWithNetworkModel:(HTNetworkModel *)networkModel countryIdString:(NSString *)countryIdString rankIdString:(NSString *)rankIdString professionalIdString:(NSString *)professionalIdString currentPage:(NSString *)currentPage pageSize:(NSString *)pageSize complete:(HTUserTaskCompleteBlock)complete;



/**
 获取留学资讯的详情

 @param contentIdString 内容的 id
 */
+ (void)requestActivityDetailWithNetworkModel:(HTNetworkModel *)networkModel contentIdString:(NSString *)contentIdString complete:(HTUserTaskCompleteBlock)complete;



/**
 筛选学校

 @param countryIdString 国家 id
 @param rangkIdString 排名 id
 @param professionalIdString 专业 id
 @param currentPage 当前页码
 @param pageSize 每一页的数量
 */
+ (void)requestFilterSchoolListWithNetworkModel:(HTNetworkModel *)networkModel countryIdString:(NSString *)countryIdString rangkIdString:(NSString *)rangkIdString professionalIdString:(NSString *)professionalIdString pageSize:(NSString *)pageSize currentPage:(NSString *)currentPage complete:(HTUserTaskCompleteBlock)complete;


/**
 获取知识库

 */
+ (void)requestLibrarayListWithNetworkModel:(HTNetworkModel *)networkModel complete:(HTUserTaskCompleteBlock)complete;


/**
 获取案例的类别列表

 */
+ (void)requestExampleItemWithNetworkModel:(HTNetworkModel *)networkModel complete:(HTUserTaskCompleteBlock)complete;


/**
 获取案例的内容列表

 @param catIdString 案例的类别 id
 @param currentPage 当前页码
 @param pageSize 每一页的数量
 */
+ (void)requestExampleListWithNetworkModel:(HTNetworkModel *)networkModel catIdString:(NSString *)catIdString pageSize:(NSString *)pageSize currentPage:(NSString *)currentPage complete:(HTUserTaskCompleteBlock)complete;



/**
 获取问答标签列表

 */
+ (void)requestAnswerTagListWithNetworkModel:(HTNetworkModel *)networkModel complete:(HTUserTaskCompleteBlock)complete;


/**
 获取问答列表

 @param answerTagString 问答标签 id
 @param currentPage 当前页码
 @param pageSize 每一页的数量
 */
+ (void)requestAnswerListWithNetworkModel:(HTNetworkModel *)networkModel answerTagString:(NSString *)answerTagString pageSize:(NSString *)pageSize currentPage:(NSString *)currentPage complete:(HTUserTaskCompleteBlock)complete;


/**
 发表一个新的问答

 @param tagIdArray 标签 ID 的数组
 @param answerTitle 问答的标题
 @param answerContent 问答的详情
 */
+ (void)requestCreateAnswerWithNetworkModel:(HTNetworkModel *)networkModel tagIdArray:(NSArray *)tagIdArray answerTitle:(NSString *)answerTitle answerContent:(NSString *)answerContent complete:(HTUserTaskCompleteBlock)complete;


/**
 发表一个新的回答

 @param contentString 要回答的内容
 @param anwerModel 要回答的问题模型
 */
+ (void)requestCreateAnswerSolutionWithNetworkModel:(HTNetworkModel *)networkModel contentString:(NSString *)contentString answerModel:(HTAnswerModel *)anwerModel complete:(HTUserTaskCompleteBlock)complete;


/**
 发表一个新的评论

 @param contentString 要评论的内容
 @param solutionModel 要评论的解答模型
 @param answerReplyModel 要评论的评论模型
 */
+ (void)requestCreateAnswerReplyWithNetworkModel:(HTNetworkModel *)networkModel contentString:(NSString *)contentString answerSolutionModel:(HTAnswerSolutionModel *)solutionModel answerReplyModel:(HTAnswerReplyModel *)answerReplyModel complete:(HTUserTaskCompleteBlock)complete;


/**
 获取找实习的列表

 */
+ (void)requestWorkListWithNetworkModel:(HTNetworkModel *)networkModel complete:(HTUserTaskCompleteBlock)complete;



/**
 获取留学活动的头条 banner

 */
+ (void)requestActivityBannerWithNetworkModel:(HTNetworkModel *)networkModel complete:(HTUserTaskCompleteBlock)complete;


/**
 获取留学活动列表

 @param currentPage 当前页码
 @param pageSize 每一页的数量
 */
+ (void)requestActivityListWithNetworkModel:(HTNetworkModel *)networkModel pageSize:(NSString *)pageSize currentPage:(NSString *)currentPage complete:(HTUserTaskCompleteBlock)complete;


/**
 获取知识库详情
 
 @param contentIdString 内容 id
 @param catIdString 分类 id
 */
+ (void)requestLibrarayDetailWithNetworkModel:(HTNetworkModel *)networkModel contentIdString:(NSString *)contentIdString catIdString:(NSString *)catIdString complete:(HTUserTaskCompleteBlock)complete;


/**
 获取实习的详情

 @param contentIdString 内容的 id
 @param catIdString 分类的 id
 */
+ (void)requestWorkDetailWithNetworkModel:(HTNetworkModel *)networkModel contentIdString:(NSString *)contentIdString catIdString:(NSString *)catIdString complete:(HTUserTaskCompleteBlock)complete;


/**
 获取案例的详情
 
 @param contentIdString 内容的 id
 @param catIdString 分类的 id
 */
+ (void)requestExampleDetailWithNetworkModel:(HTNetworkModel *)networkModel contentIdString:(NSString *)contentIdString catIdString:(NSString *)catIdString complete:(HTUserTaskCompleteBlock)complete;


/**
 获取商品详情, 比如文书服务, 知识库的视频

 @param storeIdString 商品 id
 */
+ (void)requestStoreDetailWithNetworkModel:(HTNetworkModel *)networkModel storeIdString:(NSString *)storeIdString complete:(HTUserTaskCompleteBlock)complete;


/**
 获取机构的列表
 
 @param organizationListType 列表按什么方式排序
 @param currentPage 当前页码
 @param pageSize 每一页的数量

 */
+ (void)requestOrganizationListWithNetworkModel:(HTNetworkModel *)networkModel organizationListType:(HTOrganizationListType)organizationListType pageSize:(NSString *)pageSize currentPage:(NSString *)currentPage complete:(HTUserTaskCompleteBlock)complete;


/**
 获取机构的详情

 @param organizationId 机构 id
 */
+ (void)requestOrganizationDetailWithNetworkModel:(HTNetworkModel *)networkModel organizationId:(NSString *)organizationId complete:(HTUserTaskCompleteBlock)complete;


/**
 获取问答的详情

 @param answerIdString 问的的 id
 */
+ (void)requestAnswerDetailWithNetworkModel:(HTNetworkModel *)networkModel answerIdString:(NSString *)answerIdString complete:(HTUserTaskCompleteBlock)complete;














/**
 重置密码

 @param phoneOrEmailString 电话或者邮箱
 @param resetPassword 重新设置的密码
 @param messageCode 验证码
 */
+ (void)requestResetPasswordWithNetworkModel:(HTNetworkModel *)networkModel phoneOrEmailString:(NSString *)phoneOrEmailString resetPassword:(NSString *)resetPassword messageCode:(NSString *)messageCode complete:(HTUserTaskCompleteBlock)complete;


/**
 短信验证码确认人为发送
 */
+ (void)requestMessageCodeSurePersonWithNetworkModel:(HTNetworkModel *)networkModel complete:(HTUserTaskCompleteBlock)complete;



/**
 注册, 重置密码, 修改用户信息时发送验证码

 @param phoneOrEmailString 电话或者邮箱
 @param requestMessageCodeStyle 获取验证码用来做什么
 */
+ (void)requestRegisterOrForgetPasswordOrUpdataUserMessageCodeWithNetworkModel:(HTNetworkModel *)networkModel phoneOrEmailString:(NSString *)phoneOrEmailString requestMessageCodeStyle:(HTLoginTextFieldGroupType)requestMessageCodeStyle complete:(HTUserTaskCompleteBlock)complete;


/**
 获取中国区 appStore 最高版本

 */
+ (void)requestAppStoreMaxVersionWithNetworkModel:(HTNetworkModel *)networkModel complete:(HTUserTaskCompleteBlock)complete;

/**
 打开 appStore
 */
+ (void)requestOpenAppStore;


/**
 注册

 @param phoneOrEmailString 电话或邮箱
 @param registerPassword 注册密码
 @param messageCode 注册的验证码
 @param usernameString 注册的用户名
 */
+ (void)requestRegisterWithNetworkModel:(HTNetworkModel *)networkModel phoneOrEmailString:(NSString *)phoneOrEmailString registerPassword:(NSString *)registerPassword messageCode:(NSString *)messageCode usernameString:(NSString *)usernameString complete:(HTUserTaskCompleteBlock)complete;

/**
 正常登陆

 @param usernameString 用户名, 电话, 邮箱
 @param passwordString 密码
 */
+ (void)requestNormalLoginWithNetworkModel:(HTNetworkModel *)networkModel usernameString:(NSString *)usernameString passwordString:(NSString *)passwordString complete:(HTUserTaskCompleteBlock)complete;


/**
 三方登录

 @param openIdString 三方授权拿到的 openid
 @param nicknameString 三方授权拿到的昵称
 @param thirdIconSource 三方授权拿到的头像
 */
+ (void)requestThirdLoginWithNetworkModel:(HTNetworkModel *)networkModel openIdString:(NSString *)openIdString nicknameString:(NSString *)nicknameString thirdIconSource:(NSString *)thirdIconSource complete:(HTUserTaskCompleteBlock)complete;


/**
 登录后要进行重置 session

 @param requestParameterDictionary 包含用户名和密码的字典
 @param responseParameterDictionary 包含 uid, 用户名, 密码, 邮箱, 电话的字典
 */
+ (void)requestResetLoginSessionWithNetworkModel:(HTNetworkModel *)networkModel requestParameterDictionary:(NSDictionary *)requestParameterDictionary responseParameterDictionary:(NSDictionary *)responseParameterDictionary complete:(HTUserTaskCompleteBlock)complete;



/**
 获取用户详细信息
 
 */
+ (void)requestUserModelWithNetworkModel:(HTNetworkModel *)networkModel complete:(HTUserTaskCompleteBlock)complete;

/**
 修改用户头像

 */
+ (void)requestUploadUserHeadImageWithNetworkModel:(HTNetworkModel *)networkModel complete:(HTUserTaskCompleteBlock)complete;


/**
 修改用户昵称

 @param changeNickname 新昵称
 */
+ (void)requestUpdateUserNicknameWithNetworkModel:(HTNetworkModel *)networkModel changeNickname:(NSString *)changeNickname complete:(HTUserTaskCompleteBlock)complete;


/**
 修改用户电话

 @param changePhone 新电话
 */
+ (void)requestUpdateUserPhoneWithNetworkModel:(HTNetworkModel *)networkModel changePhone:(NSString *)changePhone messageCode:(NSString *)messageCode complete:(HTUserTaskCompleteBlock)complete;


/**
 修改用户邮箱

 @param changeEmail 新邮箱
 */
+ (void)requestUpdateUserEmailWithNetworkModel:(HTNetworkModel *)networkModel changeEmail:(NSString *)changeEmail messageCode:(NSString *)messageCode complete:(HTUserTaskCompleteBlock)complete;


/**
 修改用户密码

 @param originPassword 原密码
 @param changePassword 新密码
 */
+ (void)requestUpdateUserPasswordWithNetworkModel:(HTNetworkModel *)networkModel originPassword:(NSString *)originPassword changePassword:(NSString *)changePassword complete:(HTUserTaskCompleteBlock)complete;


/**
 发送用户反馈, 会同时传到 bmob

 @param suggestionMessage 用户建议
 @param userContactWay 联系方式
 */
+ (void)requestSendApplicationIssueWithNetworkModel:(HTNetworkModel *)networkModel suggestionMessage:(NSString *)suggestionMessage userContactWay:(NSString *)userContactWay complete:(HTUserTaskCompleteBlock)complete;


/**
 获取意见反馈列表

 */
+ (void)requestApplicationIssueListWithNetworkModel:(HTNetworkModel *)networkModel complete:(HTUserTaskCompleteBlock)complete;


/**
 背景测评

 */
+ (void)requestBackgroundResultWithNetworkModel:(HTNetworkModel *)networkModel parameter:(NSDictionary *)parameter complete:(HTUserTaskCompleteBlock)complete;


/**
 搜索学校和专业接口

 @param parameter 参数
 @param pageSize 每页返回个数
 @param currentPage 当前页
 */
+ (void)requestSearchSchoolOrMajorListWithNetworkModel:(HTNetworkModel *)networkModel parameter:(NSDictionary *)parameter pageSize:(NSString *)pageSize currentPage:(NSString *)currentPage complete:(HTUserTaskCompleteBlock)complete;


/**
 搜索问答, 活动, 或者知识库

 @param parameter 参数
 @param pageSize 每页返回个数
 @param currentPage 当前页
 */
+ (void)requestSearchAnswerOrActivityOrLibraryWithNetworkModel:(HTNetworkModel *)networkModel parameter:(NSDictionary *)parameter pageSize:(NSString *)pageSize currentPage:(NSString *)currentPage complete:(HTUserTaskCompleteBlock)complete;

/**
 获取顾问的分类列表

 */
+ (void)requestAdvisorCateListWithNetworkModel:(HTNetworkModel *)networkModel complete:(HTUserTaskCompleteBlock)complete;


/**
 获取顾问的列表

 @param catIdString 顾问的分类 id
 @param pageSize 每页返回个数
 @param currentPage 当前页
 */
+ (void)requestAdvisorListWithNetworkModel:(HTNetworkModel *)networkModel catIdString:(NSString *)catIdString pageSize:(NSString *)pageSize currentPage:(NSString *)currentPage complete:(HTUserTaskCompleteBlock)complete;


/**
 获取顾问详情

 @param advisorIdString 顾问 id
 */
+ (void)requestAdvisorDetailWithNetworkModel:(HTNetworkModel *)networkModel advisorIdString:(NSString *)advisorIdString complete:(HTUserTaskCompleteBlock)complete;


/**
 获取用户回答的问题列表

 @param uidString 用户的 uid
 @param pageSize 每页返回个数
 @param currentPage 当前页
 */
+ (void)requestUserSolutionListWithNetworkModel:(HTNetworkModel *)networkModel uidString:(NSString *)uidString pageSize:(NSString *)pageSize currentPage:(NSString *)currentPage complete:(HTUserTaskCompleteBlock)complete;


/**
 获取用户创建的问题列表

 @param uidString 用户的 uid
 @param pageSize 每页返回个数
 @param currentPage 当前页
 */
+ (void)requestUserAnswerListWithNetworkModel:(HTNetworkModel *)networkModel uidString:(NSString *)uidString pageSize:(NSString *)pageSize currentPage:(NSString *)currentPage complete:(HTUserTaskCompleteBlock)complete;


/**
 获取用户的粉丝列表

 @param uidString 用户的 uid
 @param pageSize 每页返回个数
 @param currentPage 当前页
 */
+ (void)requestUserFansListWithNetworkModel:(HTNetworkModel *)networkModel uidString:(NSString *)uidString pageSize:(NSString *)pageSize currentPage:(NSString *)currentPage complete:(HTUserTaskCompleteBlock)complete;


/**
 获取用户的关注列表

 @param uidString 用户的 uid
 @param pageSize 每页返回个数
 @param currentPage 当前页
 */
+ (void)requestUserAttentionListWithNetworkModel:(HTNetworkModel *)networkModel uidString:(NSString *)uidString pageSize:(NSString *)pageSize currentPage:(NSString *)currentPage complete:(HTUserTaskCompleteBlock)complete;


/**
 关注用户

 @param toUidString 谁被关注 的 uid
 */
+ (void)requestAttentionUserWithNetworkModel:(HTNetworkModel *)networkModel toUidString:(NSString *)toUidString complete:(HTUserTaskCompleteBlock)complete;


/**
 取消关注

 @param toUidString 取消关注
 */
+ (void)requestCancelAttentionUserWithNetworkModel:(HTNetworkModel *)networkModel toUidString:(NSString *)toUidString complete:(HTUserTaskCompleteBlock)complete;

/**
 获取其他用户的信息

 @param uidString 用户的 uid
 */
+ (void)requestUserInfomationWithNetworkModel:(HTNetworkModel *)networkModel uidString:(NSString *)uidString complete:(HTUserTaskCompleteBlock)complete;


/**
 获取测评记录

 */
+ (void)requestMatriculateRecordWithNetworkModel:(HTNetworkModel *)networkModel complete:(HTUserTaskCompleteBlock)complete;


/**
 获取文书详情
 @param pageSize 每页返回个数
 @param currentPage 当前页

 */
+ (void)requestBookListWithNetworkModel:(HTNetworkModel *)networkModel pageSize:(NSString *)pageSize currentPage:(NSString *)currentPage complete:(HTUserTaskCompleteBlock)complete;


/**
 问答答案点赞

 @param solutionIdString 答案 id
 */
+ (void)requestAnswerSolutionLikeWithNetworkModel:(HTNetworkModel *)networkModel solutionIdString:(NSString *)solutionIdString complete:(HTUserTaskCompleteBlock)complete;


/**
 问答答案取消点赞

 @param solutionIdString 答案 id
 */
+ (void)requestAnswerSolutionCancelLikeWithNetworkModel:(HTNetworkModel *)networkModel solutionIdString:(NSString *)solutionIdString complete:(HTUserTaskCompleteBlock)complete;

/**
 获取选校结果
 @param resultIdString 结果 id 可为空

 */
+ (void)requestSchoolMatriculateAllResultListWithNetworkModel:(HTNetworkModel *)networkModel resultIdString:(NSString *)resultIdString complete:(HTUserTaskCompleteBlock)complete;


/**
 获取录取测评结果
 
 @param resultIdString 结果 id 可为空
 */
+ (void)requestSchoolMatriculateSingleResultListWithNetworkModel:(HTNetworkModel *)networkModel resultIdString:(NSString *)resultIdString complete:(HTUserTaskCompleteBlock)complete;


/**
 获取专业解析的分类列表

 */
+ (void)requestMajorCatListWithNetworkModel:(HTNetworkModel *)networkModel complete:(HTUserTaskCompleteBlock)complete;

/**
 获取专业解析的列表
 
 @param catIdString 专业解析的分类 id
 @param pageSize 每页返回个数
 @param currentPage 当前页
 */
+ (void)requestMajorListWithNetworkModel:(HTNetworkModel *)networkModel catIdString:(NSString *)catIdString pageSize:(NSString *)pageSize currentPage:(NSString *)currentPage complete:(HTUserTaskCompleteBlock)complete;


/**
 获取专业解析的详情

 @param majorParseId 专业解析的 id
 */
+ (void)requestMajorDetailWithNetworkModel:(HTNetworkModel *)networkModel majorParseId:(NSString *)majorParseId complete:(HTUserTaskCompleteBlock)complete;


/**
 专业点赞

 @param majorIdString 专业 id
 */
+ (void)requestMajorGoodWithNetworkModel:(HTNetworkModel *)networkModel majorIdString:(NSString *)majorIdString complete:(HTUserTaskCompleteBlock)complete;


/**
 案例首页

 */
+ (void)requestExampleIndexWithNetworkModel:(HTNetworkModel *)networkModel singleSectionItemCount:(NSInteger)singleSectionItemCount complete:(HTUserTaskCompleteBlock)complete;



/**
 获取论坛列表

 @param catIdString 分类 id
 @param pageSize 每页返回个数
 @param currentPage 当前页
 */
+ (void)requestDiscoverListWithNetworkModel:(HTNetworkModel *)networkModel catIdString:(NSString *)catIdString pageSize:(NSString *)pageSize currentPage:(NSString *)currentPage complete:(HTUserTaskCompleteBlock)complete;


/**
 获取论坛帖子详细内容

 @param discoverId 帖子 id
 */
+ (void)requestDiscoverItemDetailWithNetworkModel:(HTNetworkModel *)networkModel discoverId:(NSString *)discoverId complete:(HTUserTaskCompleteBlock)complete;



/**
 发表一个新的帖子到论坛

 @param titleString 标题
 @param contentString 内容
 @param catIdString 分类 id
 */
+ (void)requestDiscoverIssueWithNetworkModel:(HTNetworkModel *)networkModel titleString:(NSString *)titleString contentString:(NSString *)contentString catIdString:(NSString *)catIdString complete:(HTUserTaskCompleteBlock)complete;


/**
 获取新的论坛帖子

 @param discoverId 要回复的内容 id
 @param contentString 内容
 */
+ (void)requestDiscoverReplyWithNetworkModel:(HTNetworkModel *)networkModel discoverId:(NSString *)discoverId contentString:(NSString *)contentString complete:(HTUserTaskCompleteBlock)complete;

@end
