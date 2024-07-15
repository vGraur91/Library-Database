
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
        dbms_output.put_line('f_CheckForNullVarChar: Value Error : ' || SQLERRM);
        RETURN TRUE;
END;
/



CREATE OR REPLACE PROCEDURE p_ValidationForVarchar2(
    p_value VARCHAR2,
    p_Message VARCHAR2,
    p_error_code INT,
    p_isNotNull BOOLEAN
) AS
    v_value varchar(100);
BEGIN
    v_value := DBMS_ASSERT.SIMPLE_SQL_NAME(p_value);

    if p_isNotNull THEN
        IF f_CheckForNullVarChar(v_value) THEN
            RAISE_APPLICATION_ERROR(p_error_code, p_Message);
        END IF;
    end if;
    
EXCEPTION
    when value_error THEN
        DBMS_OUTPUT.PUT_LINE('f_ValidationForVarchar2: There is a problem with input value : ' || SQLERRM);
        
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('f_ValidationForVarchar2: An error occured : ' || SQLERRM);
        
END;
/