/*
segmentare
età e professione utenti utilizzatori
numero e genere richieste prestiti libri cartacei
*/
DROP FUNCTION k_nnClassifier();

CREATE OR REPLACE FUNCTION k_nnClassifier ()
    RETURNS JSON
AS $$
    import pandas as pd
    import numpy as np
    from sklearn import datasets

    dict_utilizzatore = {}

    rv = plpy.execute("""WITH richiestelibri AS (
                             SELECT emailutilizzatore, genere, count(*) AS countprenotazioni
                             FROM prenotazione
                             JOIN libro ON codicelibrocartaceo = codicelibro
                             GROUP BY emailutilizzatore, genere
                         )
                         SELECT utilizzatore.emailutilizzatore, professione, datadinascita, genere, countprenotazioni
                         FROM utilizzatore
                         JOIN utente ON emailutente = utilizzatore.emailutilizzatore
                         JOIN richiestelibri ON utilizzatore.emailutilizzatore = richiestelibri.emailutilizzatore
                      """)

    for r in rv:
        dict_utilizzatore.update({ r['emailutilizzatore'] : ( r['professione'], r['datadinascita'], r['genere'], r['countprenotazioni'] ) })

    df = pd.DataFrame(dict_utilizzatore)

    return df.to_json()
$$ LANGUAGE plpython3u;

select k_nnClassifier();

--            columns=['professione', 'datadinascita', 'countprenotazioni, genere'
--            index=dict_utilizzatore.keys()
