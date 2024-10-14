// Welcome to your new AL extension.
// Remember that object names and IDs should be unique across all extensions.
// AL snippets start with t*, like tpageext - give them a try and happy coding!

namespace CIT.Dimensions;

using Microsoft.Sales.Customer;
using Microsoft.Purchases.Document;
using Microsoft.Finance.Dimension;
using Microsoft.Sales.Document;

pageextension 80101 SalesOrderDimensionExt extends "Sales Order"
{
    actions
    {
        addlast(processing)
        {
            action("AddDimensions")
            {
                ApplicationArea = All;
                Image = Dimensions;
                Caption = 'Add Dimensions';
                ToolTip = 'Add Dimensions. This is a test.';
                trigger OnAction()
                var
                    TempDimSetRec: Record "Dimension Set Entry" temporary;
                    CITDimensionModifier: Codeunit "CIT Dimension Modifier";
                    RecRef: RecordRef;
                begin

                    TempDimSetRec.Init();
                    TempDimSetRec.Validate("Dimension Code", 'DEPARTMENT');
                    TempDimSetRec.Validate("Dimension Value Code", 'PROD');
                    TempDimSetRec.Insert(true);
                    TempDimSetRec.Init();
                    TempDimSetRec.Validate("Dimension Code", 'PROJECT');
                    TempDimSetRec.Validate("Dimension Value Code", 'VW');
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