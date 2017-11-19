function perm = genrcm (A)
  [num_adj, num_node, xadj, adj] =Matrice_adjacence(A);
  mask(1:num_node) = 1;

  num = 1;

  for i = 1 : num_node
%
%  For each masked connected component...
%
    if ( mask(i) ~= 0 )

      root = i;
%
%  Find a pseudo-peripheral node ROOT.  The level structure found by
%  ROOT_FIND is stored starting at PERM(NUM).
%
      [ root, num_ls, xls, ls ] = fnroot ( root, ...
        num_adj, xadj, adj, mask, num_node );
%
%  RCM orders the component using ROOT as the starting node.
%
      [ mask, ls, num_node_ls ] = rcm ( root, num_adj, xadj, adj, mask, ...
        num_node );

      perm(num:num+num_node_ls-1) = ls(1:num_node_ls);

      num = num + num_node_ls;
%
%  We can stop once every node is in one of the connected components.
%
      if ( num_node < num )
        return
      end

    end

  end

  return
end
