permissionset 50106 "External Docs Mgt"
{
    Caption = 'External Documents Management';
    Assignable = true;

    Permissions =
        tabledata "External Document Link" = RIMD,  // Read, Insert, Modify, Delete data
        table "External Document Link" = X,
        page "External Document Card" = X,
        page "External Document ListPart" = X;
}