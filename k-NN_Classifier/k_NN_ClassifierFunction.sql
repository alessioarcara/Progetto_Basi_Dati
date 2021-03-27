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

    # normalize data
    normalize = lambda v: v / np.linalg.norm(v)

    # preprocessing data
    df['professione_feat'] = normalize(df['professione'].astype('category').cat.codes)
    df['generi_feat'], df['prenotazioni_feat'] = normalize(df['generi']), normalize(df['prenotazioni'])
    df['eta'] = (pd.to_datetime('today').year -  pd.to_datetime(df.datadinascita).dt.year)
    df['eta_feat'] = normalize(df['eta'].copy())
    df = df.drop('datadinascita', 1)

    # clustering
    # 4 as my model suggested
    kmeans = KMeans(n_clusters=4, init='k-means++', max_iter=300, n_init=10,
                    random_state=42)
    kmeans.fit(df[['professione_feat', 'eta_feat', 'generi_feat', 'prenotazioni_feat']])

    # return table
    df["cluster"] = kmeans.labels_
    df = df.drop(['professione_feat', 'eta_feat', 'generi_feat', 'prenotazioni_feat'], 1)
    return df.T.to_json()
$$ LANGUAGE plpython3u;

select k_nnClassifier();

DROP MATERIALIZED VIEW IF EXISTS ClustersUtilizzatori;

CREATE MATERIALIZED VIEW ClustersUtilizzatori AS
select
       key as email,
       (data.value ->> 'cluster')::numeric AS cluster,
       (data.value ->> 'professione')::text AS professione,
       (data.value ->> 'eta')::numeric AS eta,
       (data.value ->> 'generi')::numeric AS generi,
       (data.value ->> 'prenotazioni')::numeric AS prenotazioni
FROM json_each(k_nnClassifier()) AS data ;