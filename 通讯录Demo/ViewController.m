//
//  ViewController.m
//  通讯录Demo
//
//  Created by 陈竹青 on 2021/8/16.
//

#import "ViewController.h"
/// iOS 9前的框架
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
/// iOS 9的新框架
#import <ContactsUI/ContactsUI.h>
#define Is_up_Ios_9 ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0)
@interface ViewController ()<CNContactPickerDelegate,ABPeoplePickerNavigationControllerDelegate>

@end

@implementation ViewController
- (IBAction)btn:(id)sender {
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 100, 100, 40)];
    btn.backgroundColor = UIColor.redColor;
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(gotoContactVC:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)gotoContactVC:(id) sender{
    [self JudgeAddressBookPower];
    
    [self getmyAddressbook];
}

#pragma mark ---- 调用系统通讯录
- (void)JudgeAddressBookPower {
    ///获取通讯录权限，调用系统通讯录
    [self CheckAddressBookAuthorization:^(bool isAuthorized , bool isUp_ios_9) {
        if (isAuthorized) {
            [self callAddressBook:isUp_ios_9];
        }else {
            NSLog(@"请到设置>隐私>通讯录打开本应用的权限设置");
        }
    }];
}
      
- (void)CheckAddressBookAuthorization:(void (^)(bool isAuthorized , bool isUp_ios_9))block {
    if (Is_up_Ios_9) {
        CNContactStore * contactStore = [[CNContactStore alloc]init];
        if ([CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts] == CNAuthorizationStatusNotDetermined) {
            [contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * __nullable error) {
                if (error){
                    NSLog(@"Error: %@", error);
                }
                else if (!granted){
                    block(NO,YES);
                }
                else{
                    block(YES,YES);
                }
            }];
        }
        else if ([CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts] == CNAuthorizationStatusAuthorized){
            block(YES,YES);
        }
        else {
            NSLog(@"请到设置>隐私>通讯录打开本应用的权限设置");
        }
    }
    else {
        ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
        ABAuthorizationStatus authStatus = ABAddressBookGetAuthorizationStatus();
        if (authStatus == kABAuthorizationStatusNotDetermined){
            ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (error){
                        NSLog(@"Error: %@", (__bridge NSError *)error);
                    }
                    else if (!granted){
                        block(NO,NO);
                    }
                    else{
                        block(YES,NO);
                    }
                });
            });
        }else if (authStatus == kABAuthorizationStatusAuthorized)
        {
            block(YES,NO);
        }else {
            NSLog(@"请到设置>隐私>通讯录打开本应用的权限设置");
        }
    }
}
      
- (void)callAddressBook:(BOOL)isUp_ios_9 {
    if (isUp_ios_9) {
        CNContactPickerViewController *contactPicker = [[CNContactPickerViewController alloc] init];
        contactPicker.delegate = self;
        contactPicker.displayedPropertyKeys = @[CNContactPhoneNumbersKey];
        [self presentViewController:contactPicker animated:YES completion:nil];
    }else {
        ABPeoplePickerNavigationController *peoplePicker = [[ABPeoplePickerNavigationController alloc] init];
        peoplePicker.peoplePickerDelegate = self;
        [self presentViewController:peoplePicker animated:YES completion:nil];

    }
}

- (void)getmyAddressbook {
    CNAuthorizationStatus authorizationStatus = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    if (authorizationStatus == CNAuthorizationStatusAuthorized) {
        NSLog(@"没有授权...");
    }
    NSMutableDictionary * myDict = [[NSMutableDictionary alloc]init];
    // 获取指定的字段,并不是要获取所有字段，需要指定具体的字段
    NSArray *keysToFetch = @[CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey];
    CNContactFetchRequest *fetchRequest = [[CNContactFetchRequest alloc] initWithKeysToFetch:keysToFetch];
    CNContactStore *contactStore = [[CNContactStore alloc] init];
    [contactStore enumerateContactsWithFetchRequest:fetchRequest error:nil usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
        NSLog(@"-------------------------------------------------------");
        NSString *givenName = contact.givenName;
        NSString *familyName = contact.familyName;
        NSLog(@"givenName=%@, familyName=%@", givenName, familyName);
        NSString *nameStr = [NSString stringWithFormat:@"%@%@",contact.familyName,contact.givenName];
        NSArray *phoneNumbers = contact.phoneNumbers;
        CNPhoneNumber *phoneNumber;
        for (CNLabeledValue *labelValue in phoneNumbers) {
            NSString *label = labelValue.label;
            phoneNumber = labelValue.value;
            NSLog(@"label=%@, phone=%@", label, phoneNumber.stringValue);
        }
        [myDict setObject:phoneNumber.stringValue forKey:nameStr];
        //    *stop = YES; // 停止循环，相当于break；
    }];
    NSLog(@"mydict is ==== %@",myDict);
}
  
#pragma mark -- CNContactPickerDelegate
- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContactProperty:(CNContactProperty *)contactProperty {
    CNPhoneNumber *phoneNumber = (CNPhoneNumber *)contactProperty.value;
    NSString *text1 = [NSString stringWithFormat:@"%@%@",contactProperty.contact.familyName,contactProperty.contact.givenName];
    /// 电话
    NSString *text2 = phoneNumber.stringValue;
    NSLog(@"联系人：%@, 电话：%@",text1,text2);
//    [self dismissViewControllerAnimated:YES completion:^{
//        /// 联系人
//        NSString *text1 = [NSString stringWithFormat:@"%@%@",contactProperty.contact.familyName,contactProperty.contact.givenName];
//        /// 电话
//        NSString *text2 = phoneNumber.stringValue;
////        text2 = [text2 stringByReplacingOccurrencesOfString:@"-" withString:@""];
//        NSLog(@"联系人：%@, 电话：%@",text1,text2);
//    }];
}
//- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContacts:(NSArray<CNContact*> *)contacts{
//
//    for (CNContact * contact in contacts) {
//        NSString *text1 = [NSString stringWithFormat:@"%@%@",contact.familyName,contact.givenName];
//        NSArray *phoneNumbers = contact.phoneNumbers;
//        for (CNLabeledValue *labelValue in phoneNumbers) {
//            CNPhoneNumber * phoneNumber = labelValue.value;
//            NSLog(@"name=%@,phone=%@",text1,phoneNumber.stringValue);
//        }
//    }
//}
  
//#pragma mark -- ABPeoplePickerNavigationControllerDelegate
- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController*)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier {

    ABMultiValueRef valuesRef = ABRecordCopyValue(person, kABPersonPhoneProperty);
    CFIndex index = ABMultiValueGetIndexForIdentifier(valuesRef,identifier);
    CFStringRef value = ABMultiValueCopyValueAtIndex(valuesRef,index);
    CFStringRef anFullName = ABRecordCopyCompositeName(person);

    [self dismissViewControllerAnimated:YES completion:^{
        /// 联系人
        NSString *text1 = [NSString stringWithFormat:@"%@",anFullName];
        /// 电话
        NSString *text2 = (__bridge NSString*)value;
//        text2 = [text2 stringByReplacingOccurrencesOfString:@"-" withString:@""];
        NSLog(@"联系人：%@, 电话：%@",text1,text2);
    }];
}


@end
