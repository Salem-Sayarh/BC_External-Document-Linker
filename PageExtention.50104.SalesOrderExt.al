pageextension 50104 "Sales Order Ext" extends "Sales Order"
{
    layout
    {

        // NEW: add a FastTab with "link lines" in the content area
        addlast(General) // or another existing FastTab you prefer
        {
            group("External Documents")
            {
                Caption = 'External Documents';
                ShowCaption = false;

                part(ExternalDocsLines; "External Document ListPart")
                {
                    ApplicationArea = All;
                    SubPageLink =
                        TableID = const(DATABASE::"Sales Header"),
                        DocumentNo = field("No.");
                }
            }
        }
    }

    actions
    {
        addlast(processing)
        {
            group(ExternalDocs)
            {
                action(AddExternalDoc)
                {
                    ApplicationArea = All;
                    Caption = 'Add External Document';
                    Image = Add;
                    trigger OnAction()
                    var
                        ExtDoc: Record "External Document Link";
                    begin
                        Clear(ExtDoc);
                        ExtDoc.Init();
                        ExtDoc.TableID := DATABASE::"Sales Header";
                        ExtDoc.DocumentNo := Rec."No.";

                        ExtDoc.Insert(true);

                        COMMIT;

                        // No INSERT here → let the card handle it, or:
                        PAGE.RunModal(PAGE::"External Document Card", ExtDoc);
                    end;
                }
            }
        }
    }
}
