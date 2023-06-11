Configuration password_policy{

    # Import the module that contains the File resource.
    Import-DSCResource -ModuleName 'PSDesiredStateConfiguration'
    Import-DSCResource -ModuleName 'AuditPolicyDSC'
    Import-DSCResource -ModuleName 'SecurityPolicyDSC' 

    # The Node statement specifies which targets to compile MOF files for, when
    # this configuration is executed.
    Node 'localhost' {

        AccountPolicy "1.1.1 - (L1) Ensure Enforce password history is set to 24 or more password(s)" {
            Enforce_password_history = 24
            Name = 'Enforce_password_history'
        }

   	AccountPolicy "1.1.2 - (L1) Ensure Maximum password age is set to 365 or fewer days but not 0" {
            Maximum_Password_Age = 365
            Name = 'Maximum_Password_Age'
        }

 	AccountPolicy "1.1.3 - (L1) Ensure Minimum password age is set to 1 or more day(s)" {
            Minimum_Password_Age = 1
            Name = 'Minimum_Password_Age'
        }
	
	AccountPolicy "1.1.4 - (L1) Ensure Minimum password length is set to 14 or more character(s)" {
            Minimum_Password_Length = 14
            Name = 'Minimum_Password_Length'
        }
        AccountPolicy "1.1.5 - (L1) Ensure Password must meet complexity requirements is set to Enabled" {
            Name = 'Password_must_meet_complexity_requirements'
            Password_must_meet_complexity_requirements = 'Enabled'
        }
        Registry "1.1.6 - (L1) Ensure Relax minimum password length limits is set to Enabled" {
            Key = 'HKLM:\System\CurrentControlSet\Control\SAM'
            ValueData = 1
            ValueName = 'RelaxMinimumPasswordLengthLimits'
            ValueType = 'Dword'
        }
        AccountPolicy "1.1.7 - (L1) Ensure Store passwords using reversible encryption is set to Disabled" {
            Name = 'Store_passwords_using_reversible_encryption'
            Store_passwords_using_reversible_encryption = 'Disabled'
        }
    }
}
password_policy
Start-DscConfiguration -Path '.\password_policy'-Verbose -Wait -Force