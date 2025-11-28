page 50103 "External Document Card"
{
    PageType = Card;
    ApplicationArea = All;
    SourceTable = "External Document Link";
    Editable = true;
    InsertAllowed = true;
    ModifyAllowed = true;
    DeleteAllowed = true;

    Permissions = tabledata "External Document Link" = RIMD; // ONLY FOR TEST

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Type"; Rec.Type) { }
                field("Description"; Rec.Description) { }
                field("URL"; Rec.Url) { }
            }
            group(Info)
            {
                field("Created By"; Rec.CreatedBy) { Editable = false; }
                field("Created At"; Rec.CreatedAt) { Editable = false; }
            }
        }
    }

    actions
    {
        // area(Processing)
        // {
        //     action(Save)
        //     {
        //         ApplicationArea = All;
        //         Caption = 'Save';

        //         trigger OnAction()
        //         begin
        //             CurrPage.Update(false);
        //             // saving handled by client when record modified
        //         end;
        //     }
        // }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.CreatedBy := UserId;
        Rec.CreatedAt := CurrentDateTime;
    end;
}