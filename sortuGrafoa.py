
def sortu_grafoa():

    # Datuak irakurri
    # BETE HEMEN 8 lerro
    connect = sqlite3.connect('/content/drive/MyDrive/Colab Notebooks/BH/Proiektua/database.sqlite')
    query = """
    SELECT pa.paper_id, pa.author_id, a.name
    FROM paper_authors AS pa JOIN papers AS p ON pa.paper_id = p.id
    JOIN authors as a ON pa.author_id = a.id
    WHERE p.Year BETWEEN '2014' AND '2015'
    """
    df = pd.read_sql(query, connect)

    
    # Sortu grafoa
    # BETE HEMEN 7-10 lerro
    G = nx.Graph()

    for p, a in df.groupby('paper_id')['name']: 
        for u, v in itertools.combinations(a, 2):
            if G.has_edge(u, v):
                G[u][v]['weight'] +=1
            else:
                G.add_edge(u, v, weight=1)
    return G