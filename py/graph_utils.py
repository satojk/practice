class graph(object):

    def __init__(self, edges):
        #edges is a list of 2-uples of the form (node1, node2)
        self.edges = {}
        self.build_graph(edges)

    def build_graph(self, edges):
        for edge in edges:
            try:
                if edge[1] not in self.edges[edge[0]]:
                    self.edges[edge[0]].append(edge[1])
            except KeyError:
                self.edges[edge[0]] = [edge[1]]
            try:
                if edge[0] not in self.edges[edge[1]]:
                    self.edges[edge[1]].append(edge[0])
            except KeyError:
                self.edges[edge[1]] = [edge[0]]
        for node in self.edges.keys():
            self.edges[node].sort()

    def bfs(self, start_node, end_node, path, search_queue):
        path.append(start_node)
        print(path)
        if start_node == end_node:
            return path
        for next_node in self.edges[start_node]:
            if next_node not in path:
                search_queue = [path+[next_node]] + search_queue
        next_search = search_queue.pop()
	return self.bfs(next_search[-1], end_node, next_search[:-1], search_queue) 

    def dfs(self, start_node, end_node, path, search_queue):
        path.append(start_node)
        print(path)
        if start_node == end_node:
            return path
        for next_node in self.edges[start_node]:
            if next_node not in path:
                search_queue.append(path+[next_node])
        next_search = search_queue.pop()
	return self.dfs(next_search[-1], end_node, next_search[:-1], search_queue) 

example = graph([('a', 'b'), ('c', 'a'), ('b', 'd'), ('d', 'h'), ('a', 'e'), ('e', 'c'), ('e', 'f'), ('c', 'g'), ('f', 'g'), ('c', 'd')])
print(example.dfs('a', 'h', [], []))
