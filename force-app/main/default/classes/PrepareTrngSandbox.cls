global class PrepareTrngSandbox implements SandboxPostCopy {
    List<User> users = new List<User>();
    List<User> allUsers = new List<User>();
    global void runApexClass(SandboxContext context) {
        List<User> sysAdmins = [select email, username from User where Profile.Name = 'System Administrator'];
        List<User> usersToUpdate = new List<User>();
        for (User u : sysAdmins) {
            if (u.email.endsWith('.invalid')) {
                Integer invalidPos = u.email.indexOf('.invalid');
                u.email = u.email.substring(0, invalidPos);
                
                usersToUpdate.add(u);
            }
        }
        if (usersToUpdate.size() > 0) {
            update (usersToUpdate);
        }

        createSysAdminUsers(context.sandboxName());
    }

    private void createSysAdminUsers(String sbName) {
        Id sysAdminProfileId = [select id from Profile where name = 'System Administrator' Limit 1].Id;
        addAllUsers();
        addUsers(sbName);
        // Populate other fields
        for (User u : users) {
            u.ProfileId = sysAdminProfileId;
            u.CommunityNickname = u.FirstName + '.StratosTraining';
            u.EmailEncodingKey = 'ISO-8859-1';
            u.LanguageLocaleKey = 'en_US';
            u.LocaleSidKey = 'en_US';
            u.TimeZoneSidKey = 'Asia/Kolkata';
            u.Username = u.Alias + '@stratos.' + sbName;
        }

        //We have only 8 Salesforce user licenses so limit user creation to this 
        if (users.size() <= 8) {
            insert users;
        }

        //Reset passwords so that they are sent an email to set their password
        for (User u : users) {
            System.resetPassword(u.Id, true);
        }
    }

    private void addAllUsers() {
        allUsers.add(new User(Alias='150468', FirstName='Abdul Malik', LastName='Arshath',Email='abdul.malik@stratos.studio', Department='C6T3'));
        allUsers.add(new User(Alias='150473', FirstName='Amruta', LastName='Waghmare',Email='amruta.waghmare@stratos.studio', Department='C6T2'));
        allUsers.add(new User(Alias='150476', FirstName='Chiranjeevi Gopi Krishna', LastName='Dasari',Email='chiranjeevi@stratos.studio', Department='C6T4'));
        allUsers.add(new User(Alias='150457', FirstName='Deepak', LastName='Lodhi',Email='deepak.lodhi@stratos.studio', Department='C6T2'));
        allUsers.add(new User(Alias='150459', FirstName='Grishma', LastName='Misal',Email='grishma.misal@stratos.studio', Department='C6T2'));
        allUsers.add(new User(Alias='150464', FirstName='Joydeep', LastName='Das',Email='joydeep.das@stratos.studio', Department='C6T1'));
        allUsers.add(new User(Alias='150474', FirstName='Mayur', LastName='Godbole',Email='mayur.godbole@stratos.studio', Department='C6T4'));
        allUsers.add(new User(Alias='150469', FirstName='Milan', LastName='Oli',Email='milan.oli@stratos.studio', Department='C6T3'));
        allUsers.add(new User(Alias='150465', FirstName='Mukesh Varma', LastName='Pothabathula',Email='mukesh.varma@stratos.studio', Department='C6T1'));
        allUsers.add(new User(Alias='150466', FirstName='Padmapriya', LastName='Ariga',Email='padmapriya.ariga@stratos.studio', Department='C6T1'));
        allUsers.add(new User(Alias='150461', FirstName='Pranav', LastName='Kulkarni',Email='pranav.kulkarni@stratos.studio', Department='C6T1'));
        allUsers.add(new User(Alias='150463', FirstName='Priyadharsini', LastName='K',Email='priyadharsini.k@stratos.studio', Department='C6T4'));
        allUsers.add(new User(Alias='150467', FirstName='Rajat', LastName='Pandey',Email='rajat.pandey@stratos.studio', Department='C6T1'));
        allUsers.add(new User(Alias='150470', FirstName='Sarthik Kumar', LastName='Sirigada',Email='sarthikkumar@stratos.studio', Department='C6T4'));
        allUsers.add(new User(Alias='150462', FirstName='Sheeba', LastName='Ramola',Email='sheeba.ramola@stratos.studio', Department='C6T4'));
        allUsers.add(new User(Alias='150477', FirstName='Snehal', LastName='Raut',Email='snehal.raut@stratos.studio', Department='C6T2'));
        allUsers.add(new User(Alias='150458', FirstName='Srikanth', LastName='Padakanti',Email='srikanth.padakanti@stratos.studio', Department='C6T2'));
        allUsers.add(new User(Alias='150475', FirstName='Sumithra', LastName='Selvam',Email='sumithra.b@stratos.studio', Department='C6T3'));
        allUsers.add(new User(Alias='150472', FirstName='Vivek', LastName='Erukulla',Email='vivek.erukulla@stratos.studio', Department='C6T3'));
    }

    private void addUsers(String sbName) {
        for (User u : allUsers) {
            if (u.Department == sbName) {
                users.add(u);
            }
        }
    }
}