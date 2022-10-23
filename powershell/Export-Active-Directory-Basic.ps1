([ADSISearcher]@{
    SizeLimit    = 2147483647;
    Asynchronous = $true;
    Tombstone    = $true;
}).FindAll() | ConvertTo-Json -Depth 100 > "ad.json";