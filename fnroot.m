function [ root, num_ls, xls, ls ] = fnroot( root, ...
  num_adj, xadj, adj, mask, num_node )

%  Determine the ls structure rooted at ROOT.
%
  [ mask, num_ls, xls, ls ] = rootls ( root, num_adj, ...
    xadj, adj, mask, num_node );
%
%  Count the number of nodes in this level structure.
%
  num_node_ls = xls(num_ls+1) - 1;
%
%  Extreme case:
%    A complete graph has a level set of only a single level.
%    Every node is equally good (or bad).
%
  if ( num_ls == 1 )
    return
  end
%
%  Extreme case:
%    A "line graph" 0--0--0--0--0 has every node in its only ls.
%    By chance, we've stumbled on the ideal root.
%
  if ( num_ls == num_node_ls )
    return
  end
%
%  Pick any node from the last level that has minimum degree
%  as the starting point to generate a new level set.
%
  while ( 1 )

    mindeg = num_node_ls;

    jstrt = xls(num_ls);
    root = ls(jstrt);

    if ( jstrt < num_node_ls )

      for j = jstrt : num_node_ls

        node = ls(j);
        ndeg = 0;
        kstrt = xadj(node);
        kstop = xadj(node+1)-1;

        for k = kstrt : kstop
          voisin = adj(k);
          if ( 0 < mask(voisin) )
            ndeg = ndeg+1;
          end
        end

        if ( ndeg < mindeg )
          root = node;
          mindeg = ndeg;
        end

      end

    end
%
%  Generate th
%  Determine the ls structure rooted at ROOT.
%
  [ mask, num_ls, xls, ls ] = rootls ( root, num_adj, ...
    xadj, adj, mask, num_node );
%
%  Count the number of nodes in this level structure.
%
  num_node_ls = xls(num_ls+1) - 1;
%
%  Extreme case:
%    A complete graph has a level set of only a single level.
%    Every node is equally good (or bad).
%
  if ( num_ls == 1 )
    return
  end
%
%  Extreme case:
%    A "line graph" 0--0--0--0--0 has every node in its only ls.
%    By chance, we've stumbled on the ideal root.
%
  if ( num_ls == num_node_ls )
    return
  end
%
%  Pick any node from the last level that has minimum degree
%  as the starting point to generate a new level set.
%
  while ( 1 )

    mindeg = num_node_ls;

    jstrt = xls(num_ls);
    root = ls(jstrt);

    if ( jstrt < num_node_ls )

      for j = jstrt : num_node_ls

        node = ls(j);
        ndeg = 0;
        kstrt = xadj(node);
        kstop = xadj(node+1)-1;

        for k = kstrt : kstop
          voisin = adj(k);
          if ( 0 < mask(voisin) )
            ndeg = ndeg+1;
          end
        end

        if ( ndeg < mindeg )
          root = node;
          mindeg = ndeg;
        end

      end

    end
%
%  Generate the rooted ls structure associated with this node.
%
    [ mask, num_level_2, xls, ls ] = rootls ( root, num_adj, ...
      xadj, adj, mask, num_node );
%
%  If the number of levels did not increase, accept the new ROOT.
%
    if ( num_level_2 <= num_ls )
      break
    end

    num_ls = num_level_2;
%
%  In the unlikely case that ROOT is one endpoint of a line graph,
%  we can exit now.
%
    if ( num_node_ls <= num_ls )
      break
    end

  end

%  return rooted ls structure associated with this node.
%
    [ mask, num_level_2, xls, ls ] = rootls ( root, num_adj, ...
      xadj, adj, mask, num_node );
%
%  If the number of levels did not increase, accept the new ROOT.
%
    if ( num_level_2 <= num_ls )
      break
    end

    num_ls = num_level_2;
%
%  In the unlikely case that ROOT is one endpoint of a line graph,
%  we can exit now.
%
    if ( num_node_ls <= num_ls )
      break
    end

  end

  return
end
