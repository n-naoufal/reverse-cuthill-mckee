function [ deg, num_node_ls, ls ] = degree ( root, num_adj, xadj, adj, mask, ...
  num_node )

%  The sign of xadj(I) is used to indicate if node I has been considered.
%
  ls(1) = root;
  xadj(root) = -xadj(root);
  lvlend = 0;
  num_node_ls = 1;
%
%  LBEGIN is the pointer to the beginning of the current ls, and
%  LVLEND points to the end of this ls.
%
  while ( 1 )

    lbegin = lvlend + 1;
    lvlend = num_node_ls;
%
%  Find the degrees of nodes in the current ls,
%  and at the same time, generate the next ls.
%
    for i = lbegin : lvlend

      node = ls(i);
      jstrt = -xadj(node);
      jstop = abs ( xadj(node+1) ) - 1;
      ideg = 0;

      for j = jstrt : jstop

        nbr = adj(j);

        if ( mask(nbr) ~= 0 )

          ideg = ideg + 1;

          if ( 0 <= xadj(nbr) )
            xadj(nbr) = -xadj(nbr);
            num_node_ls = num_node_ls + 1;
            ls(num_node_ls) = nbr;
          end

        end

      end

      deg(node) = ideg;

    end
%
%  Compute the current ls width.
%
    lvsize = num_node_ls - lvlend;
%
%  If the current ls width is nonzero, generate another ls.
%
    if ( lvsize == 0 )
      break
    end

  end
%
%  Reset xadj to its correct sign and return.
%
  for i = 1 : num_node_ls
    node = ls(i);
    xadj(node) = -xadj(node);
  end

  return
end
