/*
segmentare
età e professione utenti utilizzatori
numero e genere richieste prestiti libri cartacei
*/
DROP FUNCTION k_nnClassifier();

CREATE OR REPLACE FUNCTION k_nnClassifier ()
    RETURNS TABLE (professione VARCHAR(40))
AS $$
    import pandas as pd
    import numpy as np
    from sklearn.model_selection import train_test_split
    from sklearn.cluster import KMeans

    dict_utilizzatore = {}

    # data extraction from db

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

    # cursor to dictionary to dataFrame

    for r in rv:
        dict_utilizzatore.update({ r['emailutilizzatore'] : ( r['professione'],
                                                              r['datadinascita'],
                                                              r['generi'],
                                                              r['prenotazioni'])})

    df = pd.DataFrame.from_dict(dict_utilizzatore, orient='index', columns=['professione',
                                                                            'datadinascita',
                                                                            'generi',
                                                                            'prenotazioni'])
    # preprocessing data

    # normalize data
    normalize = lambda v: v / np.linalg.norm(v)

    df['professione'] = normalize(df['professione'].astype('category').cat.codes)
    df['generi'], df['prenotazioni'] = normalize(df['generi']), normalize(df['prenotazioni'])
    df['eta'] = normalize(pd.to_datetime('today').year -  pd.to_datetime(df.datadinascita).dt.year)
    df = df.drop('datadinascita', 1)

    kmeans = KMeans(n_clusters=4, init='k-means++', max_iter=300, n_init=10,
                    random_state=42)

    kmeans.fit(df)
    df["cluster"] = kmeans.labels_

    return ([df['professione']])
$$ LANGUAGE plpython3u;

select k_nnClassifier();

select * from utilizzatore

-- df = df.set_index([df.index, pd.Series(kmeans.labels_).values])
