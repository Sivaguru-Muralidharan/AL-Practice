namespace CIT.Dimensions;

using Microsoft.Purchases.Document;
using Microsoft.Finance.Dimension;
using Microsoft.Finance.GeneralLedger.Setup;

tableextension 80101 "Purchase Header Ext." extends "Purchase Header"
{
    fields
    {
        field(80101; "Shortcut Dimension 10 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 10 Code';
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                TempDimSetRec: Record "Dimension Set Entry" temporary;
                CITDimensionModifier: Codeunit "CIT Dimension Modifier";
                RecRef: RecordRef;
                GLSetupRec: Record "General Ledger Setup";
                DimensionSetID: Integer;
                Dimension1Code: Code[20];
                Dimension2Code: Code[20];
            begin
                GLSetupRec.Get();
                TempDimSetRec.Init();
                TempDimSetRec.Validate("Dimension Code", GLSetupRec."Shortcut Dimension 10 Code");
                TempDimSetRec.Validate("Dimension Value Code", Rec."Shortcut Dimension 10 Code");
                TempDimSetRec.Insert();

                RecRef.GetTable(Rec);
                RecRef.Get(Rec.RecordId());
                CITDimensionModifier.ConfigureRecord(Rec.FieldNo("Dimension Set ID"), Rec.FieldNo("Shortcut Dimension 1 Code"), Rec.FieldNo("Shortcut Dimension 2 Code"));
                CITDimensionModifier.UpdateDimensionCode(TempDimSetRec, RecRef);
                CITDimensionModifier.GetDimensions(DimensionSetID, Dimension1Code, Dimension2Code);
                Rec.Validate("Dimension Set ID", DimensionSetID);
                Rec.Validate("Shortcut Dimension 1 Code", Dimension1Code);
                Rec.Validate("Shortcut Dimension 2 Code", Dimension2Code);
            end;
        }
    }
}
