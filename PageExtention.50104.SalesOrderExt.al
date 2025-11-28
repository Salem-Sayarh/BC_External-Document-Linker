pageextension 50104 "Sales Order Ext" extends "Sales Order"
{
    layout
    {
        // Add a new FastTab to show all external links related to this sales order
        addlast(General)
        {
            group("External Documents")
            {
                // Hide the group caption so only the subpage content is visible
                Caption = 'External Documents';
                ShowCaption = false;

                // Subpage that lists all external links for the current Sales Header
                part(ExternalDocsLines; "External Document ListPart")
                {
                    ApplicationArea = All;
                    SubPageLink =
                        TableID = const(DATABASE::"Sales Header"),
                        DocumentNo = field("No."); // link on Sales Order No.
                }
            }
        }
    }

    actions
    {
        // Add a processing group to manage external documents from the Sales Order
        addlast(processing)
        {
            group(ExternalDocs)
            {
                // Creates a new external link record for the current sales order
                action(AddExternalDoc)
                {
                    ApplicationArea = All;
                    Caption = 'Add External Document';
                    Image = Add;

                    trigger OnAction()
                    var
                        ExtDoc: Record "External Document Link";
                    begin
                        // Prepare a fresh record pre-linked to this Sales Header
                        Clear(ExtDoc);
                        ExtDoc.Init();
                        ExtDoc.TableID := DATABASE::"Sales Header";
                        ExtDoc.DocumentNo := Rec."No.";

                        // Insert and commit so the record exists before opening the card
                        ExtDoc.Insert(true);
                        COMMIT;

                        // Let the user edit the new link on the card page
                        PAGE.RunModal(PAGE::"External Document Card", ExtDoc);
                    end;
                }
            }
        }
    }
}
