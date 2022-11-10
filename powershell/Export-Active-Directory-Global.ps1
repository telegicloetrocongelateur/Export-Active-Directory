([ADSISearcher]@{
    SizeLimit    = 2147483647;
    Asynchronous = $true;
    Tombstone    = $true;
    PageSize     = 10000;
}).FindAll() | ConvertTo-Json -Depth 100 > "ad.json";
