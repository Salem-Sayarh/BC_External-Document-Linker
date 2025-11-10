table 50100 "External Document Link"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; EntryNo; Integer)
        {
            AutoIncrement = true;
            Caption = 'Entry No.';

        }
        field(2; TableID; Integer)
        {
            Caption = 'Table ID';
        }
        field(3; DocumentNo; code[20])
        {

        }
        field(4; Url; Text[250])
        {
            Caption = 'URL';
        }
        field(5; Type; Enum "External Link Type")
        {
            Caption = 'Type';
        }
        field(6; Description; Text[150])
        {
            Caption = 'Description';
        }
        field(7; CreatedBy; Guid)
        {
            Caption = 'Created By';
        }
        field(8; CreatedAt; DateTime)
        {
            Caption = 'Created At';
        }
    }

    keys
    {
        key(PK; EntryNo) { }
        Key(TableDoc; TableID, DocumentNo) { }
    }


}