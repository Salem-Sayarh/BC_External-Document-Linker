page 50102 "External Document ListPart"
{
    // ListPart used as a subpage to show external links for a given document
    PageType = ListPart;
    SourceTable = "External Document Link";
    ApplicationArea = All;
    Caption = 'External Document Links';

    // The list itself is read-only – creation/editing happens via actions/card page
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
                // Link type (enum) – e.g. SharePoint, Web URL, etc.
                field(Type; Rec.Type)
                {
                    Caption = 'Type';
                }

                // Short description for the link
                field(Description; Rec.Description)
                {
                    Caption = 'Description';
                }

                // Clickable URL that opens in the browser
                field(Url; Rec.Url)
                {
                    Caption = 'Link';
                    ExtendedDatatype = URL;
                }

                // Audit info – when the link was created
                field(CreatedAt; Rec.CreatedAt)
                {
                    Caption = 'Created at';
                }

                // Audit info – who created the link
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
            // Opens the selected link in the browser
            action(OpenDocument)
            {
                Caption = 'Open';
                Image = Open;
                ApplicationArea = All;

                // Show this action on each row’s context menu
                Scope = Repeater;

                trigger OnAction()
                begin
                    if Rec.Url = '' then begin
                        Message('No URL defined for this link.');
                        exit;
                    end;

                    Hyperlink(Rec.Url);
                end;
            }

            // Opens the card page to edit the selected link
            action(EditLink)
            {
                Caption = 'Edit';
                Image = EditLines;
                ApplicationArea = All;
                Scope = Repeater;

                trigger OnAction()
                var
                    LinkRec: Record "External Document Link";
                begin
                    // Work on a copy of the current record
                    LinkRec := Rec;
                    if LinkRec.IsEmpty() then
                        exit;

                    PAGE.RunModal(PAGE::"External Document Card", LinkRec);

                    // Refresh subpage after edit
                    CurrPage.Update(false);
                end;
            }

            // Deletes the selected link after confirmation
            action(DeleteLink)
            {
                Caption = 'Delete';
                Image = Delete;
                ApplicationArea = All;
                Scope = Repeater;

                trigger OnAction()
                begin
                    if Confirm('Delete selected external link?') then
                        Rec.Delete(true);
                end;
            }
        }
    }
}
