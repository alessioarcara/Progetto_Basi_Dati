DROP FUNCTION pymax()

CREATE OR REPLACE FUNCTION pymax ()
    RETURNS TABLE (like utilizzatore)
AS $$
    rv = plpy.execute("SELECT * FROM utilizzatore")
    return rv
$$ LANGUAGE plpython3u;

select pymax()