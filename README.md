# Export-Active-Directory
Scripts to export active directory objects.


## Powershell

### Global Exportation

```powershell
$Searcher = New-Object System.DirectoryServices.DirectorySearcher; # Initialize the Directory Searcher object

$Searcher.SizeLimit = 2147483647; # Define the number of objects that we want
# "2147483" can be replaced with any number, it is the maximum value for a System.Int32 variable
$Searcher.Tombstone = $true; # Enable the search for deleted objects
$Searcher.Asynchronous = $true; # Enable asynchronous search to reduce search time
$Searcher.PageSize = 10000; # Enable the paged search to extend the maximum number of objects

$Results = $Searcher.FindAll(); # Find all the results based on our filter

$Json = ConvertTo-Json $Results; # Convert the $Results powershell object to json
# It is possible to change the Depth of the json conversion, the base depth value is 3
# The only objects not correctly represented with a depth of 3 are bytes and are not very 

Set-Content "ad.json" $Json; # Save the json results in a file
```
#### Compact version
```powershell
([ADSISearcher]@{
    SizeLimit    = 2147483647;
    Asynchronous = $true;
    Tombstone    = $true;
    PageSize     = 10000;
}).FindAll() | ConvertTo-Json > "ad.json";
```

> The json conversion depth can be changed with `-Depth` (by default 3)

> The scripts must be executed on a computer connected to the domain


### Filtered Exportation
```powershell
$Searcher = New-Object System.DirectoryServices.DirectorySearcher; # Initialize the Directory Searcher object

$Searcher.Filter = "LDAP filter" # Define the searcher LDAP filter
$Searcher.SizeLimit = 2147483647; # Define the number of objects that we want
# "2147483" can be replaced with any number, it is the maximum value for a System.Int32 variable
$Searcher.Tombstone = $true; # Enable the search for deleted objects
$Searcher.Asynchronous = $true; # Enable asynchronous search to reduce search time
$Searcher.PageSize = 10000; # Enable the paged search to extend the maximum number of objects


$Results = $Searcher.FindAll(); # Find all the results based on our filter

$Json = ConvertTo-Json $Results; # Convert the $Results powershell object to json
# It is possible to change the Depth of the json conversion, the base depth value is 3
# The only objects not correctly represented with a depth of 3 are bytes and are not very 

Set-Content "ad.json" $Json; # Save the json results in a file
```
#### Compact version
```powershell
([ADSISearcher]@{
    Filter       = "LDAP filter"
    SizeLimit    = 2147483647;
    Asynchronous = $true;
    Tombstone    = $true;
    PageSize     = 10000;
}).FindAll() | ConvertTo-Json > "ad.json";
```


> See [Users Exportation](https://github.com/Telegicloetrocongelateur/Export-Active-Directory/blob/8c786001af6d20ccaef8348a9c3d4a81a53ba17e/powershell/Export-Active-Directory-Users.ps1)


### Extern Exportation

```powershell

$Root = New-Object System.DirectoryServices.DirectoryEntry; # Initialize the Directory Entry, the Search Root

$Root.Path = "LDAP://domain.controller.ip/dc=controller,dc=ip" # Define Directory Entry LDAP path 
$Root.Username = "username" # Define the username of the user used to login into the Active Directory
$Root.Password = "password" # Define Active Directory user password

$Searcher = New-Object System.DirectoryServices.DirectorySearcher; # Initialize the Directory Searcher object

$Searcher.SizeLimit = 2147483647; # Define the number of objects that we want
# "2147483" can be replaced with any number, it is the maximum value for a System.Int32 variable
$Searcher.Tombstone = $true; # Enable the search for deleted objects
$Searcher.Asynchronous = $true; # Enable asynchronous search to reduce search time
$Searcher.PageSize = 10000; # Enable the paged search to extend the maximum number of objects

$Results = $Searcher.FindAll(); # Find all the results based on our filter

$Json = ConvertTo-Json $Results; # Convert the $Results powershell object to json
# It is possible to change the Depth of the json conversion, the base depth value is 3
# The only objects not correctly represented with a depth of 3 are bytes and are not very 

Set-Content "ad.json" $Json; # Save the json results in a file
```

#### Compact version

```powershell
([ADSISearcher]@{
    SearchRoot   = [ADSI]::new("LDAP://domain.controller.ip/dc=controller,dc=ip", "username", "password");
    Filter       = "LDAP filter"
    SizeLimit    = 2147483647;
    Asynchronous = $true;
    Tombstone    = $true;
    PageSize     = 10000;
}).FindAll() | ConvertTo-Json > "ad.json";
```
