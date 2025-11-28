pageextension 50105 "Purchase Order Ext" extends "Purchase Order"
{
    layout
    {
        addlast(factboxes)
        {
            part(ExternalDocsPart; "External Document ListPart")
            {
                Caption = 'External Documents';
                SubPageLink = TableID = const(DATABASE::"Purchase Header"), DocumentNo = field("No.");
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
                        Clear(ExtDoc); // ensure we don't reuse any existing record
                        ExtDoc.Init();
                        ExtDoc.TableID := DATABASE::"Purchase Header";
                        ExtDoc.DocumentNo := Rec."No.";

                        ExtDoc.Insert(true);

                        COMMIT;
                        // No INSERT here – to avoid the write transaction error
                        PAGE.RunModal(PAGE::"External Document Card", ExtDoc);
                        // Each time you call this, the user is working on a fresh record.
                    end;
                }
            }
        }
    }

}