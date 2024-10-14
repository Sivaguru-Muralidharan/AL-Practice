// Welcome to your new AL extension.
// Remember that object names and IDs should be unique across all extensions.
// AL snippets start with t*, like tpageext - give them a try and happy coding!

namespace CIT.Dimensions;

using Microsoft.Sales.Customer;
using Microsoft.Purchases.Document;
using Microsoft.Finance.Dimension;

pageextension 80100 PurchaseOrderDimensionExt extends "Purchase Order"
{
    layout
    {
        addafter("Shortcut Dimension 2 Code")
        {
            field(ShortcutDimCode10; Rec."Shortcut Dimension 10 Code")
            {
                ApplicationArea = All;
                TableRelation = "Dimension Value".Code where("Global Dimension No." = const(10),
                                                                  "Dimension Value Type" = const(Standard),
                                                                  Blocked = const(false));
            }
        }
    }
    actions
    {
        addlast(processing)
        {
            action("AddDimensions")
            {
                ApplicationArea = All;
                Image = Dimensions;
                Caption = 'Add Dimensions';
                ToolTip = 'Add Dimensions.';
                trigger OnAction()
                var
                    TempDimSetRec: Record "Dimension Set Entry" temporary;
                    CITDimensionModifier: Codeunit "CIT Dimension Modifier";
                    RecRef: RecordRef;
                begin
                    TempDimSetRec.Init();
                    TempDimSetRec.Validate("Dimension Code", 'AREA');
                    TempDimSetRec.Validate("Dimension Value Code", '30');
                    TempDimSetRec.Insert(true);
                    TempDimSetRec.Init();
                    TempDimSetRec.Validate("Dimension Code", 'BUSINESSGROUP');
                    TempDimSetRec.Validate("Dimension Value Code", 'HOME');
                    TempDimSetRec.Insert(true);
                    TempDimSetRec.Init();
                    TempDimSetRec.Validate("Dimension Code", 'CUSTOMERGROUP');
                    TempDimSetRec.Validate("Dimension Value Code", 'INSTITUTION');
                    TempDimSetRec.Insert(true);
                    TempDimSetRec.Init();
                    TempDimSetRec.Validate("Dimension Code", 'DEPARTMENT');
                    TempDimSetRec.Validate("Dimension Value Code", 'ADM');
                    TempDimSetRec.Insert(true);
                    TempDimSetRec.Init();
                    TempDimSetRec.Validate("Dimension Code", 'EMPLOYEE');
                    TempDimSetRec.Validate("Dimension Value Code", 'EMP1');
                    TempDimSetRec.Insert(true);
                    TempDimSetRec.Init();
                    TempDimSetRec.Validate("Dimension Code", 'PROJECT');
                    TempDimSetRec.Validate("Dimension Value Code", 'MERCEDES');
                    TempDimSetRec.Insert(true);
                    TempDimSetRec.Init();
                    TempDimSetRec.Validate("Dimension Code", 'PURCHASER');
                    TempDimSetRec.Validate("Dimension Value Code", 'MH');
                    TempDimSetRec.Insert(true);
                    TempDimSetRec.Init();
                    TempDimSetRec.Validate("Dimension Code", 'SALESCAMPAIGN');
                    TempDimSetRec.Validate("Dimension Value Code", 'SUMMER');
                    TempDimSetRec.Insert(true);

                    RecRef.GetTable(Rec);
                    RecRef.Get(Rec.RecordId());
                    CITDimensionModifier.ConfigureRecord(Rec.FieldNo("Dimension Set ID"), Rec.FieldNo("Shortcut Dimension 1 Code"), Rec.FieldNo("Shortcut Dimension 2 Code"));
                    CITDimensionModifier.UpdateDimensionCode(TempDimSetRec, RecRef);
                end;
            }
        }
    }

}