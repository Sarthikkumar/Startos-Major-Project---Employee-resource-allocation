//This authentication handler is used for managing student access to Moodle and also
//customer access to community. 
global class MoodleAndLearningCommunityAuthHandler implements Auth.RegistrationHandler {
    class RegHandlerException extends Exception {}
    
    String STUDENT_USER_PROFILE_NAME = 'Chatter Free User'; 
    String[] CUSTOMER_COMMUNITY_PROFILE_NAMES = new String[]{'Custom External Apps', 'Custom External Apps Login User'}; 
    
    //This has to return true for authentication flow to proceed
    global boolean canCreateUser(Auth.UserData data) {
        return true;
    }
    
    global User createUser(Id portalId, Auth.UserData data){
        if(!canCreateUser(data)) {
            //Returning null or throwing an exception fails the SSO flow
            return null;
        }
        String email = getEmail(data);
        System.debug('>>> In createUser. portalId: ' + portalId);
        System.debug('>>> Auth.UserData: ' + data + '<<<');
        System.debug('>>> Email: ' + email + '<<<');
        if (data.attributeMap.containsKey('sfdc_networkid')) {
            List<User> users = 
                     [SELECT Id 
                        FROM User 
                       WHERE email = :email 
                         and ProfileId in (select id from Profile where name in :CUSTOMER_COMMUNITY_PROFILE_NAMES )];
            if (!users.isEmpty()) {
                return (users[0]);
            } else {
                throw new RegHandlerException('Cannot find your user id. Please contact your administrator.');
            }
        } else {
            List<User> users =
                     [SELECT Id 
                        FROM User 
                       WHERE email = :email and ProfileId in  (select id from Profile where name = :STUDENT_USER_PROFILE_NAME )];
            if (!users.isEmpty()) {
                return (users[0]);
            } else {
                throw new RegHandlerException('Cannot find your user id. Please contact your administrator.');
            }
        }
    }
    
    //Google provider returns email in the email field within data
    //Azure AD provider returns email in attributeMap.unique_name 
    private String getEmail(Auth.UserData data) {
        String email = null;
        
        if (data.email != null) {
            email = data.email;
        } else if (data.attributeMap.containsKey('unique_name')) {
            email = data.attributeMap.get('unique_name');
        } 
        
        return (email);
    }
    
    global void updateUser(Id userId, Id portalId, Auth.UserData data){
        System.debug('>>> In updateUser. portalId: ' + portalId);
        System.debug('>>> Auth.UserData: ' + data + '<<<');
    }
}