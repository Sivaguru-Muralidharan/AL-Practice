namespace CIT.Dimensions;

using Microsoft.Finance.Dimension;
using Microsoft.Finance.GeneralLedger.Setup;

tableextension 80100 "GL Setup Ext" extends "General Ledger Setup"
{
    fields
    {
        field(80100; "Shortcut Dimension 9 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 9 Code';
            TableRelation = Dimension;
            ToolTip = 'Specifies the Shortcut Dimension 9 Code.';
            trigger OnValidate()
            begin
                Rec.UpdateDimValueGlobalDimNo(xRec."Shortcut Dimension 9 Code", "Shortcut Dimension 9 Code", 9);
            end;
        }
        field(80101; "Shortcut Dimension 10 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 10 Code';
            TableRelation = Dimension;
            ToolTip = 'Specifies the Shortcut Dimension 10 Code.';
            trigger OnValidate()
            begin
                Rec.UpdateDimValueGlobalDimNo(xRec."Shortcut Dimension 10 Code", "Shortcut Dimension 10 Code", 10);
            end;
        }
    }

}