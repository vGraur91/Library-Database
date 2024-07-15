CREATE OR REPLACE FUNCTION f_CheckForNullVarChar(
        p_Value VARCHAR2
) RETURN BOOLEAN AS
BEGIN
    if p_Value IS NULL THEN
        return TRUE;
    end if;

    RETURN FALSE;

EXCEPTION
    when OTHERS then
        dbms_output.put_line('Value Error : ' || SQLERRM);
        RETURN TRUE;
END;
/