@isTest
private class MoodleAuthHandlerTest {
    static String STUDENT_USER_PROFILE_NAME = 'Chatter Free User'; 
    static String CUSTOMER_COMMUNITY_PROFILE_NAME = 'Custom External Apps'; 
    static User googleUser = null;
    static User azureUser = null;
    static User communityUser = null;
    static Auth.UserData userDataA = null; //Azure User
    static Auth.UserData userDataS = null; //Google User
    static Auth.UserData userDataC = null;

    @isTest static void createUserTest() {
        setupData();

        Test.startTest();
            MoodleAndLearningCommunityAuthHandler mah = new MoodleAndLearningCommunityAuthHandler();
            //Test Chatter Free User login using Google
            User u = mah.createUser(null, userDataS);
            System.assertEquals(u.Id, googleUser.Id);

            //Test Chatter Free User login using Azure
            u = mah.createUser(null, userDataA);
            System.assertEquals(u.Id, azureUser.Id);

            //Test Community user login
            u = mah.createUser('0DBp00000008RMo', userDataC);
            System.assertEquals(u.Id, communityUser.Id);

            //Update user just for coverage completeness
            mah.updateUser(communityUser.Id, '0DBp00000008RMo', userDataC);
        Test.stopTest();
    }

    static void setupData() {
        Long currentTime = System.currentTimeMillis();
        //Insert a couple of Student Users with Chatter Free profile - 1 with Google login & another with Azure login
        //Google Login
        googleUser = new User(
            ProfileId = [SELECT Id FROM Profile WHERE Name = :STUDENT_USER_PROFILE_NAME].Id,
            LastName = 'last',
            Email = 'suser@hfs.com',
            Username = 'suser@hfs.com.' + currentTime,
            CompanyName = 'TEST',
            Title = 'title',
            Alias = 'alias',
            TimeZoneSidKey = 'Asia/Kolkata',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US'
        );
        insert (googleUser);
        
        //Azure Login
        azureUser = new User(
            ProfileId = [SELECT Id FROM Profile WHERE Name = :STUDENT_USER_PROFILE_NAME].Id,
            LastName = 'last',
            Email = 'auser@hfs.com',
            Username = 'auser@hfs.com.' + currentTime,
            CompanyName = 'TEST',
            Title = 'title',
            Alias = 'alias',
            TimeZoneSidKey = 'Asia/Kolkata',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US'
        );
        insert (azureUser);

        //Insert community user
        Account a = new Account(name='test account');
        insert (a);
        Contact c = new Contact(firstName='Contact fname', lastName = 'Contact lName', AccountId = a.Id);
        insert (c);
        communityUser = new User(
            ProfileId = [SELECT Id FROM Profile WHERE Name = :CUSTOMER_COMMUNITY_PROFILE_NAME].Id,
            LastName = 'last',
            Email = 'cuser@hfs.com',
            Username = 'cuser@hfs.com.' + currentTime,
            CompanyName = 'TEST',
            Title = 'title',
            Alias = 'alias',
            TimeZoneSidKey = 'Asia/Kolkata',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US', 
            ContactId = c.Id
        );
        insert (communityUser);

        userDataA = new Auth.UserData('userIdentifierAtAuth', 'first', 'last',
                                        'first last', null, null, 'auser@hfs.com' + '.' + currentTime, 'en_US', 'Open ID Connect',
                                        null, new Map<String, String>{'language' => 'en_US', 'unique_name' => 'auser@hfs.com'});
        userDataS = new Auth.UserData('userIdentifierAtAuth', 'first', 'last',
                                        'first last', 'suser@hfs.com', null, 'suser@hfs.com' + '.' + currentTime, 'en_US', 'Google',
                                        null, new Map<String, String>{'language' => 'en_US'});
        userDataC = new Auth.UserData('userIdentifierAtAuth', 'first', 'last',
                                        'first last', 'cuser@hfs.com', null, 'cuser@hfs.com' + '.' + currentTime, 'en_US', 'Google',
                                        null, new Map<String, String>{'language' => 'en_US', 'sfdc_networkid' => '0DBp00000008RMo'});
    }
}