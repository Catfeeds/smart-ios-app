
#define AppendString(domain, detail) [NSString stringWithFormat:@"%@%@", domain, detail]

// 商城域名拼接
#define SmartApplyApi(detail) AppendString(DomainShopNormal, detail)

// 商城文件资源域名拼接
#define SmartApplyResourse(detail) AppendString(DomainSmartApplyResourceNormal, detail)

// 留学文件资源域名拼接
#define SchoolResourse(detail) AppendString(DomainSchoolResourceNormal, detail)

// 八卦域名拼接
#define GossIpApi(detail) AppendString(DomainGossipNormal, detail)

// 用户系统域名拼接
#define LoginApi(detail) AppendString(DomainLoginNormal, detail)


#define DomainSmartApplyNormal @"http://www.smartapply.cn/cn/"
#define DomainSmartApplyResourceNormal @"http://www.smartapply.cn/"


#define DomainSchoolNormal @"http://schools.smartapply.cn/cn/"
#define DomainSchoolResourceNormal @"http://schools.smartapply.cn/"


#define DomainGossipNormal @"http://bbs.viplgw.cn/cn/app-api"

#define DomainLoginNormal @"http://login.gmatonline.cn/cn/app-api"
