
CREATE OR REPLACE FUNCTION is_valid_name(p_name IN VARCHAR2) RETURN BOOLEAN IS
BEGIN
    RETURN REGEXP_LIKE(p_name, '^[A-Za-z0-9\s\.\-\'' ]{1,100}$');
END;