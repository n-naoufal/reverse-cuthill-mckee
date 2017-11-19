function perm = genrcm (A)

  [adj_num, node_num, adj_row, adj] =Matrice_adjacence(A);
  mask(1:node_num) = 1;
  num = 1;
  for i = 1 : node_num
%  Pour toute composante connectée masquée

    if ( mask(i) ~= 0 )
      root = i;
      
%  On cherche un noeud racine qui est pseudo-peripherique.  
%  La structure à niveaux (rooted level structure) trouvée par rcmrooted_L_S est stockée en perm
      [ root, ls_num, ls_row, ls ] = rcmfind_root ( root, ...
        adj_num, adj_row, adj, mask, node_num );

%  RCM ordonne les composantes en prenant root comme noeud de départ.

      [ mask, ls, num_node_ls ] = rcm ( root, adj_num, adj_row, adj, mask, node_num );

      perm(num:num+num_node_ls-1) = ls(1:num_node_ls);

      num = num + num_node_ls;

%  On stop si tout les noeuds sont numérotés.
      if ( node_num < num )
        return
      end

    end

  end

  return
end
