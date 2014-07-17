-module(btree).

-export([new/1,
         insert/2,
         search/2
        ]).

-record(btree, {tree, func}).


new(Func) ->
    #btree{tree=[], func=Func}.


insert(TreeRec, N) ->
    #btree{tree=T1,
           func=F} = TreeRec,

    T2 = insert(T1, N, F),
    TreeRec#btree{tree=T2}.


insert(Tree, N, Func) ->
    case Tree of
        [] ->
            [N, [], []];

        [Root, Left, Right] ->
            case Func(N, Root) of
                0 -> Tree;
                -1 -> [Root, insert(Left, N, Func), Right];
                1 -> [Root, Left, insert(Right, N, Func)]
            end
    end.


search(#btree{tree=T, func=F}, N) ->
    search(T, N, F).


search(Tree, N, Func) ->
    case Tree of
        [] ->
            {error, undefined};

        [Root, Left, Right] ->
            case Func(N, Root) of
                0 -> Root;
                -1 -> search(Left, N, Func);
                1 -> search(Right, N, Func)
            end
    end.
    


