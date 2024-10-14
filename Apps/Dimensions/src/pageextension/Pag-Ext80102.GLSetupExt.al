namespace CIT.Dimensions;

using Microsoft.Finance.GeneralLedger.Setup;

pageextension 80102 "GL Setup Ext" extends "General Ledger Setup"
{
    layout
    {
        addafter("Shortcut Dimension 8 Code")
        {
            field("Shortcut Dimension 9 Code"; Rec."Shortcut Dimension 9 Code")
            {
                ApplicationArea = All;
                Caption = 'Shortcut Dimension 9 Code';
            }
            field("Shortcut Dimension 10 Code"; Rec."Shortcut Dimension 10 Code")
            {
                ApplicationArea = All;
                Caption = 'Shortcut Dimension 10 Code';
            }
        }
    }
}