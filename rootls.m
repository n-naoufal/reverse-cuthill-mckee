function [ mask, num_ls, xls, ls ] = rootls ( root, num_adj, ...
  xadj, adj, mask, num_node )

  mask(root) = 0;
  ls(1) = root;
  num_ls = 0;
  l_end = 0;
  num_node_ls = 1;
%
% l_begin is the pointer to the beginning of the current level, and
% l_end points to the end of this level.
%
  while ( 1 )
      
   l_begin =l_end + 1;
   l_end = num_node_ls;
   num_ls = num_ls + 1;
   xls(num_ls) = l_begin;
%
%  Generate the next level by finding all the masked neighbors of nodes
%  in the current level.
%
    for i = l_begin :l_end

      node = ls(i);
      jstrt = xadj(node);
      jstop = xadj(node+1)-1;

      for j = jstrt : jstop

        voisin = adj(j);

        if ( mask(voisin) ~= 0 )
          num_node_ls = num_node_ls + 1;
          ls(num_node_ls) = voisin;
          mask(voisin) = 0;
        end

      end

    end
%
%  Compute the current level width (the number of nodes encountered.)
%  If it is positive, generate the next level.
%
    l_size = num_node_ls -l_end;

    if ( l_size <= 0 )
      break
    end

  end

  xls(num_ls+1) =l_end + 1;
%
%  Reset MASK to 1 for the nodes in the level structure.
%
  mask(ls(1:num_node_ls)) = 1;

  return
end
