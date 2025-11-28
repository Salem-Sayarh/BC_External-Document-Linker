page 50103 "External Document Card"
{
    // Card page to create/edit a single external document link
    PageType = Card;
    ApplicationArea = All;
    SourceTable = "External Document Link";

    // Full edit capabilities on this record
    Editable = true;
    InsertAllowed = true;
    ModifyAllowed = true;
    DeleteAllowed = true;

    // Temporary elevation so this page can read/write the link table (for sandbox/testing)
    Permissions = tabledata "External Document Link" = RIMD; // ONLY FOR TEST

    layout
    {
        area(Content)
        {
            group(General)
            {
                // Main link metadata
                field("Type"; Rec.Type) { }
                field("Description"; Rec.Description) { }
                field("URL"; Rec.Url) { }
            }
            group(Info)
            {
                // Audit fields are shown but not editable by the user
                field("Created By"; Rec.CreatedBy) { Editable = false; }
                field("Created At"; Rec.CreatedAt) { Editable = false; }
            }
        }
    }

    // Initialize audit fields when a new record is created from this page
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.CreatedBy := UserId;
        Rec.CreatedAt := CurrentDateTime;
    end;
}
