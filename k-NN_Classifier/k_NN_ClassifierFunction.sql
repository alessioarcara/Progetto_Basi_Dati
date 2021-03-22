/*
segmentare
età e professione utenti utilizzatori
numero e genere richieste prestiti libri cartacei
*/
DROP FUNCTION k_nnClassifier();

CREATE OR REPLACE FUNCTION k_nnClassifier ()
    RETURNS TEXT
AS $$
    import pandas as pd
    import numpy as np
    from sklearn.model_selection import train_test_split
    from sklearn.neighbors import KNeighborsClassifier

    dict_utilizzatore = {}

    rv = plpy.execute("""WITH richiestelibri AS (
                         SELECT emailutilizzatore, count(distinct (genere)) AS generi, count(*) AS prenotazioni
                         FROM prenotazione
                         JOIN libro ON codicelibrocartaceo = codicelibro
                         GROUP BY emailutilizzatore
                         )
                        SELECT utilizzatore.emailutilizzatore, professione, datadinascita, generi, prenotazioni
                        FROM utilizzatore
                                 JOIN utente ON emailutente = utilizzatore.emailutilizzatore
                                 JOIN richiestelibri ON utilizzatore.emailutilizzatore = richiestelibri.emailutilizzatore
                      """)

    for r in rv:
        dict_utilizzatore.update({ r['emailutilizzatore'] : ( r['professione'],
                                                              r['datadinascita'],
                                                              r['generi'],
                                                              r['prenotazioni'])})

    df = pd.DataFrame.from_dict(dict_utilizzatore, orient='index', columns=['professione',
                                                                            'datadinascita',
                                                                            'generi',
                                                                            'prenotazioni'])

    #normalizzazione dataframe
    normalize = lambda v: v / np.linalg.norm(v)
    df['professione'] = normalize(df['professione'].astype('category').cat.codes)
    df['generi'] = normalize(df['generi'])
    df['eta'] = normalize(pd.to_datetime('today').year -  pd.to_datetime(df.datadinascita).dt.year)
    df = df.drop('datadinascita', 1)
    df['prenotazioni'] = normalize(df['prenotazioni'])

    return df
$$ LANGUAGE plpython3u;

select k_nnClassifier();