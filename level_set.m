function [ mask, level_num, xls, level ] = level_set ( root, adj_num, ...
  adj_row, adj, mask, node_num )

  mask(root) = 0;
  level(1) = root;
  level_num = 0;
  lvlend = 0;
  iccsze = 1;
%
%  LBEGIN is the pointer to the beginning of the current level, and
%  LVLEND points to the end of this level.
%
  while ( 1 )

    lbegin = lvlend + 1;
    lvlend = iccsze;
    level_num = level_num + 1;
    xls(level_num) = lbegin;
%
%  Generate the next level by finding all the masked neighbors of nodes
%  in the current level.
%
    for i = lbegin : lvlend

      node = level(i);
      jstrt = adj_row(node);
      jstop = adj_row(node+1)-1;

      for j = jstrt : jstop

        nbr = adj(j);

        if ( mask(nbr) ~= 0 )
          iccsze = iccsze + 1;
          level(iccsze) = nbr;
          mask(nbr) = 0;
        end

      end

    end
%
%  Compute the current level width (the number of nodes encountered.)
%  If it is positive, generate the next level.
%
    lvsize = iccsze - lvlend;

    if ( lvsize <= 0 )
      break
    end

  end

  xls(level_num+1) = lvlend + 1;
%
%  Reset MASK to 1 for the nodes in the level structure.
%
  mask(level(1:iccsze)) = 1;

  return
end
