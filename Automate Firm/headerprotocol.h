//
//  headerprotocol.h
//  Automate Firm
//
//  Created by leonine on 19/10/15.
//  Copyright © 2015 leonine. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol headerprotocol <NSObject>
@optional
-(void)loginResponse:(NSString *)responseMessage;
-(void)officeListingResponse:(NSMutableDictionary *)officeListDict;
-(void)settingsSavedresponse:(NSMutableArray *)Savedarrayresponse;

-(void)initiallyruleviewresponse:(NSMutableArray *)viewrulearray;
-(void)initiallyShiftRuleViewResponse:(NSMutableArray *)shiftRulesArray;
-(void)initiallyRoundupRuleViewResponse:(NSMutableArray *)roundupRulesArray;
-(void)initiallyLeaveRuleViewResponse:(NSMutableArray *)leavesArray;

-(void)updateruleviewresponse:(NSMutableArray *)updateruleArray;
-(void)showalerviewcontroller:(NSString *)errorMessage;
-(void)designationsGotresponse:(NSMutableArray *)designationsarray;
-(void)passingarraydesignation:(NSString *)responsestring;

-(void)deleteSettingsRuleResponse:(NSString *)deleteRule;
-(void)allBankViewResponse:(NSMutableArray *)bankList;
-(void)ShowExistingAlert;
-(void)individualOfficeView:(NSMutableDictionary *)officelist :(UIImage *)logoimg ;
-(void)allcountryresponse:(id)countrylist;
-(void)allstateresponse:(id )statelist;
-(void)allcityresponse:(id)Citylist;
-(void)serviceGotResponse : (id)responseData;

-(void)updateofficeResponse:(NSString *)updatedmessage;
-(void)updateStoreResponse:(id)updatedmessage;
-(void)storeviewresponse:(id )storelist;
-(void)StoreDetailsViewResponse:(id )storelist;
-(void)AddNewEmployeeIntitalResponse:(NSMutableDictionary *)responseData;
-(void)addNewEmployeeSaveResponse:(NSString *)saveResponse;
-(void)weekruleresponse:(NSString *)responsemsg;
-(void)individualWeekruleViewResponse:(NSMutableArray *)weekRuleList;
-(void)individualweekruleDetailsViewResponse:(NSMutableArray *)weekRuleList;

-(void)holidayWorkingPremiseGotResponse : (id)responseData;
-(void)holidayDepartmentresponse:(id)responseData;
-(void)holidayCategoryresponse:(id)responseData;
-(void)individualDisplayResponse:(id)responseData;
-(void)firstsavingResponsegetRuleIdResponse:(NSString *)holidayruleid;

-(void)officeDesignationResponse:(NSMutableDictionary *)myofficeDesignationDict;

-(void)viewAllFineResponse:(id)responseList;

-(void)leaveAbbrivationlist:(NSMutableArray *)responseList;

-(void)response:(NSMutableArray *)responseList;


-(void)created_loanresponse:(NSString *)loanresponsestring;

-(void)donesavedGotresponse:(NSString *)responsestring;

-(void)viewAllLoanResponse:(id)responseList;

-(void)deleteloantileid:(NSMutableDictionary *)responsedata;

-(void)updationofloanResponse:(NSMutableDictionary *)updatedloanresponse;

-(void)deleteloanrules:(NSString *)deletedresponse;

-(void)indiviualLoanServiceresponse:(NSMutableArray *)responsedata;

-(void)viewAllAdvanceResponse:(id)responseList;
-(void)viewIndividualResponse:(id)responseList;

-(void)createResponse:(id)Response;
-(void)deleteResponse:(id)response;
//pay
-(void)viewAllPayResponse:(id)responseList;

-(void)viewIndividualPayResponse:(id)responseList;

//documents
-(void)viewAllDateResponse:(id)responseList;
-(void)viewAllResponse:(id)responseList;
-(void)deleteExixtDoc:(id)responseMesg;

//Earnings
-(void)allearningsResponse:(id)response;
-(void)createEarningResponse:(id)reponse;
-(void)conditionDetailsResponse:(id)responseData;
-(void)createdIncometax:(NSString *)dictreponse;
-(void)displayincometaxResponse:(NSMutableDictionary *)displayresponsedict;
-(void)deleteAllTileResponse:(id)response flag:(NSString *)delFlag;
//deduction
-(void)viewalldedctionResponse:(id)responseDta;
-(void)createDeductResponse:(id)response;
-(void)alldeductionResponse:(id)response;
//employeelistingstaffing
-(void)employeelistingService:(NSMutableDictionary *)listingResponse;
-(void)allEmployeeFilterResponse:(NSMutableDictionary *)responsedict;
-(void)filterigemployeelistingService:(NSMutableDictionary *)filterlistingResponse;
-(void)employeeidcardlisting:(NSMutableDictionary *)idresponsedict;
//employeeindividualscreen
-(void)employeeindividualGotreponsedata:(NSMutableDictionary *)idresponsedict;
-(void)documentationFrontscreenlistingService:(NSMutableDictionary *)listingdocuments;
-(void)newDocumentationFolderaddedresponse:(NSString *)responsestring;
-(void)deletedDocumentsResponse:(NSString *)deletedresponse;
//Registartion details
-(void)registrationDetailResponse:(id)details;
-(void)registraionCmpleteResponse:(id)response;
//documentationemployeefiltering
-(void)documentationemployeefilteringdocumentResponse:(NSMutableDictionary *)filteringemployeedocumentsresponsedict;

//signupservice..........

-(void)signupmodulesectorResponse:(id)details;
-(void)signupmoduleagentResponse:(id)details;
-(void)signupAdminmoduleResponse:(id)details;
@end
