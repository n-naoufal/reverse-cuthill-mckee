function [ root, ls_num, xls, level ] = root_find ( root, ...
  adj_num, adj_row, adj, mask, node_num )

%  Determine the level structure rooted at ROOT.
%
  [ mask, ls_num, xls, level ] = level_set ( root, adj_num, ...
    adj_row, adj, mask, node_num );
%
%  Count the number of nodes in this level structure.
%
  iccsze = xls(ls_num+1) - 1;
%
%  Extreme case:
%    A complete graph has a level set of only a single level.
%    Every node is equally good (or bad).
%
  if ( ls_num == 1 )
    return
  end
%
%  Extreme case:
%    A "line graph" 0--0--0--0--0 has every node in its only level.
%    By chance, we've stumbled on the ideal root.
%
  if ( ls_num == iccsze )
    return
  end
%
%  Pick any node from the last level that has minimum degree
%  as the starting point to generate a new level set.
%
  while ( 1 )

    mindeg = iccsze;

    jstrt = xls(ls_num);
    root = level(jstrt);

    if ( jstrt < iccsze )

      for j = jstrt : iccsze

        node = level(j);
        ndeg = 0;
        kstrt = adj_row(node);
        kstop = adj_row(node+1)-1;

        for k = kstrt : kstop
          nabor = adj(k);
          if ( 0 < mask(nabor) )
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
%  Generate the rooted level structure associated with this node.
%
    [ mask, level_num2, xls, level ] = level_set ( root, adj_num, ...
      adj_row, adj, mask, node_num );
%
%  If the number of levels did not increase, accept the new ROOT.
%
    if ( level_num2 <= ls_num )
      break
    end

    ls_num = level_num2;
%
%  In the unlikely case that ROOT is one endpoint of a line graph,
%  we can exit now.
%
    if ( iccsze <= ls_num )
      break
    end

  end

  return
end
