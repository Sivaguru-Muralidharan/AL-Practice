namespace CIT.Dimensions;

using Microsoft.Finance.Dimension;

codeunit 80100 "CIT Dimension Modifier"
{
    procedure UpdateDimensionCode(var UpdatedDimSetRec: Record "Dimension Set Entry" temporary)
    var
        TempExistingDimSet: Record "Dimension Set Entry" temporary;
        DimensionManagement: Codeunit DimensionManagement;
        DimensionSetIDFieldRef: FieldRef;
        Dimension1FieldRef: FieldRef;
        Dimension2FieldRef: FieldRef;
        NewDimensionSetID: Integer;
        NewDimension1Code: Code[20];
        NewDimension2Code: Code[20];
    begin
        DimensionSetIDFieldRef := GlobalRecordRef.Field(GlobalDimensionSetIDFieldNo);
        Dimension1FieldRef := GlobalRecordRef.Field(GlobalDimension1FieldNo);
        Dimension2FieldRef := GlobalRecordRef.Field(GlobalDimension2FieldNo);
        //Added to Get the List of Existing Dimensions in the Dimension Set!
        DimensionManagement.GetDimensionSet(TempExistingDimSet, DimensionSetIDFieldRef.Value);
        if UpdatedDimSetRec.FindSet() then
            repeat
                //Added to Update the Dimensions in the Dimension Set if the Dimension Value Code is already present in the Dimension Set!
                if TempExistingDimSet.Get(DimensionSetIDFieldRef.Value(), UpdatedDimSetRec."Dimension Code") then begin
                    TempExistingDimSet.Validate("Dimension Value Code", UpdatedDimSetRec."Dimension Value Code");
                    TempExistingDimSet.Modify(true);
                end
                //Added to Insert the Dimensions in the Dimension Set if the Dimension Value Code is not present in the Dimension Set!
                else begin
                    TempExistingDimSet.Init();
                    TempExistingDimSet := UpdatedDimSetRec;
                    TempExistingDimSet."Dimension Set ID" := DimensionSetIDFieldRef.Value;
                    TempExistingDimSet.Insert(true);
                end;
            until UpdatedDimSetRec.Next() = 0;

        //Added to Get the List of Dimensions in the Dimension Set!
        NewDimensionSetID := DimensionManagement.GetDimensionSetID(TempExistingDimSet);

        //To Update the Global Dimensions in the Main Table if we are changing a Global Dimension using Code!
        //This is added because we don't want a scenario where the Global Dimensions are updated in the Dimension Set but not in the Main Table!
        //MUST ADD!!!!!!
        DimensionManagement.UpdateGlobalDimFromDimSetID(NewDimensionSetID, NewDimension1Code, NewDimension2Code);
        DimensionSetIDFieldRef.Validate(NewDimensionSetID);
        Dimension1FieldRef.Validate(NewDimension1Code);
        Dimension2FieldRef.Validate(NewDimension2Code);
        GlobalRecordRef.Modify(true);
    end;

    procedure ConfigureRecord(RecRef: RecordRef; DimensionSetIDFieldNo: Integer; Dimension1FieldNo: Integer; Dimension2FieldNo: Integer)
    begin
        GlobalRecordRef := RecRef;
        GlobalDimensionSetIDFieldNo := DimensionSetIDFieldNo;
        GlobalDimension1FieldNo := Dimension1FieldNo;
        GlobalDimension2FieldNo := Dimension2FieldNo;
    end;

    var
        GlobalRecordRef: RecordRef;
        GlobalDimensionSetIDFieldNo: Integer;
        GlobalDimension1FieldNo: Integer;
        GlobalDimension2FieldNo: Integer;
}
