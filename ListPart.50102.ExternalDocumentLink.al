page 50102 "External Document ListPart"
{
    PageType = ListPart;
    SourceTable = "External Document Link";
    ApplicationArea = All;
    Caption = 'External Document Links';
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Type; Rec.Type)
                {
                    Caption = 'Type';
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(Url; Rec.Url)
                {
                    Caption = 'Link';
                    ExtendedDatatype = URL;
                }
                field(CreatedAt; Rec.CreatedAt)
                {
                    Caption = 'Created at';
                }
                field(CreatedBy; Rec.CreatedBy)
                {
                    Caption = 'User';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(OpenDocument)
            {
                Caption = 'Open';
                Image = Open;
                ApplicationArea = All;
                Scope = Repeater; // 👈 show in line menu

                trigger OnAction()
                begin
                    if Rec.Url = '' then begin
                        Message('No URL defined for this link.');
                        exit;
                    end;

                    Hyperlink(Rec.Url);
                end;
            }

            action(EditLink)
            {
                Caption = 'Edit';
                Image = EditLines;
                ApplicationArea = All;
                Scope = Repeater; // 👈 line menu

                trigger OnAction()
                var
                    LinkRec: Record "External Document Link";
                begin
                    LinkRec := Rec;
                    if LinkRec.IsEmpty() then
                        exit;

                    PAGE.RunModal(PAGE::"External Document Card", LinkRec);
                    CurrPage.Update(false);
                end;
            }

            action(DeleteLink)
            {
                Caption = 'Delete';
                Image = Delete;
                ApplicationArea = All;
                Scope = Repeater; // 👈 line menu

                trigger OnAction()
                begin
                    if Confirm('Delete selected external link?') then
                        Rec.Delete(true);
                end;
            }
        }
    }
}
