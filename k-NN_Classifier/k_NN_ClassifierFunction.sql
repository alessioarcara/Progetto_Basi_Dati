/*
segmentare
età e professione utenti utilizzatori
numero e genere richieste prestiti libri cartacei
*/
DROP FUNCTION pymax()

CREATE OR REPLACE FUNCTION pymax ()
    RETURNS JSON
AS $$
    import pandas as pd
    import numpy as np
    from sklearn import datasets

    dict_utilizzatore = {}

    etichetta_utilizzatore = plpy.execute("""SELECT utilizzatore.emailutilizzatore, professione, datadinascita, CountPrenotazioni
                                         FROM utilizzatore
                                         JOIN utente ON emailutente = utilizzatore.emailutilizzatore
                                         JOIN (SELECT count(*) AS CountPrenotazioni, prenotazione.emailutilizzatore
                                               FROM prenotazione
                                               GROUP BY prenotazione.emailutilizzatore) AS A
                                               ON utilizzatore.emailutilizzatore = A.emailutilizzatore
                                         """)

    for r in etichetta_utilizzatore:
        dict_utilizzatore[r["emailutilizzatore"]] = [r["professione"], r["datadinascita"], r["countprenotazioni"]]

    df = pd.DataFrame(dict_utilizzatore,
                      columns=['professione', 'datadinascita', 'CountPrenotazioni'],
                      index=dict_utilizzatore.keys())




    return df.to_json()
$$ LANGUAGE plpython3u;

select pymax()

SELECT count(*) AS CountPrenotazioni, emailutilizzatore
FROM prenotazione
GROUP BY emailutilizzatore