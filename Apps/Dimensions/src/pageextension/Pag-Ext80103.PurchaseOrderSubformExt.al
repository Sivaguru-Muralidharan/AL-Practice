namespace CIT.Dimensions;

using Microsoft.Purchases.Document;
using Microsoft.Finance.Dimension;
using Microsoft.Finance.GeneralLedger.Setup;

pageextension 80103 "Purchase Order Subform Ext" extends "Purchase Order Subform"
{
    layout
    {
        addafter("ShortcutDimCode8")
        {
            field(ShortcutDimCode9; ShortcutDimCode[1])
            {
                ApplicationArea = Dimensions;
                CaptionClass = '1' + DimCaption9;
                TableRelation = "Dimension Value".Code where("Global Dimension No." = const(9),
                                                                  "Dimension Value Type" = const(Standard),
                                                                  Blocked = const(false));
                Visible = DimVisible9;

                trigger OnValidate()
                begin
                    Rec.ValidateShortcutDimCode(9, ShortcutDimCode[9]);
                end;
            }
        }
    }
    local procedure GetDimensionProperties()
    var
        GLSetup: Record "General Ledger Setup";
    begin
        if not GLSetup.Get() then
            exit;
        GetDimensionVisibility(GLSetup);
        GetDimensionCaption(GLSetup);
    end;

    local procedure GetDimensionVisibility(var GLSetup: Record "General Ledger Setup")
    begin
        if GLSetup."Shortcut Dimension 9 Code" <> '' then
            DimVisible9 := true;
    end;

    local procedure GetDimensionCaption(var GLSetup: Record "General Ledger Setup")
    var
        DimensionRec: Record "Dimension";
    begin
        if not DimVisible9 then
            exit;
        DimCaption9 := DimensionRec."Code Caption";
    end;

    local procedure GetShortcutDimValue()
    var
        DimensionManagement: Codeunit DimensionManagement;
        DimensionSetEntry: Record "Dimension Set Entry" temporary;
    begin
        DimensionManagement.GetDimensionSet(DimensionSetEntry, Rec."Dimension Set ID");
        if DimensionSetEntry.FindSet() then
            repeat
                case DimensionSetEntry."Global Dimension No." of
                    9:
                        ShortcutDimCode[1] := DimensionSetEntry."Dimension Value Code";
                end;
            until DimensionSetEntry.Next() = 0;
    end;


    trigger OnAfterGetCurrRecord()
    begin
        GetShortcutDimValue();
    end;

    trigger OnOpenPage()
    begin
        GetDimensionProperties();
    end;

    var
        DimVisible9: Boolean;
        DimCaption9: Text;
        ShortcutDimCode: array[1] of Code[20];
}
