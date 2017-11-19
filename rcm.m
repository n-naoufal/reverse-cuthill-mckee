function [ mask, perm, num_node_ls ] = rcm ( root, num_adj, xadj, adj, ...
  mask, num_node )

%  Make sure num_node is legal.
%
  if ( num_node < 1 )
    fprintf ( 1, '\n' );
    fprintf ( 1, 'RCM - Fatal error!\n' );
    fprintf ( 1, '  Illegal input value of num_node = %d\n', num_node );
    fprintf ( 1, '  Acceptable values must be positive.\n' );
    error ( 'RCM - Fatal error!' );
  end
%
%  Make sure ROOT is legal.
%
  if ( root < 1 || num_node < root )
    fprintf ( 1, '\n' );
    fprintf ( 1, 'RCM - Fatal error!\n' );
    fprintf ( 1, '  Illegal input value of ROOT = %d\n', root );
    fprintf ( 1, '  Acceptable values are between 1 and %d\n', num_node );
    error ( 'RCM - Fatal error!' );
  end
%
%  Find the degrees of the nodes in the component specified by MASK and ROOT.
%
  [ deg, num_node_ls, perm ] = degree ( root, num_adj, xadj, adj, mask, ...
    num_node );

  mask(root) = 0;

  if ( num_node_ls < 1 )
    fprintf ( 1, '\n' );
    fprintf ( 1, 'RCM - Fatal error!\n' );
    fprintf ( 1, '  Inexplicable component size num_node_ls = %d\n', num_node_ls );
    error ( 'RCM - Fatal error!' );
  end
%
%  If the connected component is a singleton, there is no reordering to do.
%
  if ( num_node_ls == 1 )
    return
  end
%
%  Carry out the reordering procedure.
%
%  LBEGIN and LVLEND point to the beginning and
%  the end of the current ls respectively.
%
  lvlend = 0;
  lnbr = 1;

  while ( lvlend < lnbr )

    lbegin = lvlend + 1;
    lvlend = lnbr;

    for i = lbegin : lvlend
%
%  For each node in the current ls...
%
      node = perm(i);
      jstrt = xadj(node);
      jstop = xadj(node+1) - 1;
%
%  Find the unnumbered neighbors of NODE.
%
%  FNBR and LNBR point to the first and last neighbors
%  of the current node in PERM.
%
      fnbr = lnbr + 1;

      for j = jstrt : jstop

        nbr = adj(j);

        if ( mask(nbr) ~= 0 )
          lnbr = lnbr + 1;
          mask(nbr) = 0;
          perm(lnbr) = nbr;
        end

      end
%
%  If no neighbors, skip to next node in this ls.
%
      if ( lnbr <= fnbr )
        continue
      end
%
%  Sort the neighbors of NODE in increasing order by degree.
%  Linear insertion is used.
%
      k = fnbr;

      while ( k < lnbr )

        l = k;
        k = k + 1;
        nbr = perm(k);

        while ( fnbr < l )

          lperm = perm(l);

          if ( deg(lperm) <= deg(nbr) )
            break
          end

          perm(l+1) = lperm;
          l = l-1;

        end

        perm(l+1) = nbr;

      end

    end

  end
%
%  We now have the Cuthill-McKee ordering.  
%  Reverse it to get the Reverse Cuthill-McKee ordering.
%
  b(1:num_node_ls) = perm(num_node_ls:-1:1);
  perm(1:num_node_ls) = b(1:num_node_ls);
  return
end
