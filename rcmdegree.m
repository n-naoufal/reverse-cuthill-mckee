function [ Deg, num_node_ls, ls ] = rcmdegree ( root, adj_num, adj_row, adj, mask,node_num )

% Le signe de adj_row (A) est utilisé pour indiquer si le noeud A est déjà
% pris en compte
  ls(1) = root;  % ls pour level_structure 
  adj_row(root) = -adj_row(root);
  
%  LBEGIN pointe au début de la structure à niveaux actuelle ls
%  LVLEND pointe la fin de la structure à niveaux actuelle ls
  lvlend = 0; 
  num_node_ls = 1; % nombre de noeuds dans la structure à niveaux
  lvsize = num_node_ls - lvlend; % la largeur de la structure

  while ( lvsize > 0 )
    lbegin = lvlend + 1;
    lvlend = num_node_ls;

%  Déterminer le degrés des noeuds dans la structure à niveaux actuelle
%  En même temps, générer la structure à niveaux suivante.
    for i = lbegin : lvlend

      node = ls(i);
      jstart = -adj_row(node);
      jstop = abs ( adj_row(node+1) ) - 1;
      ideg = 0;

      if (jstop >= jstart)
          
      for j = jstart : jstop

        nbr = adj(j);

        if ( mask(nbr) ~= 0 )

          ideg = ideg + 1;

          if ( 0 <= adj_row(nbr) )
            adj_row(nbr) = -adj_row(nbr);
            num_node_ls = num_node_ls + 1;
            ls(num_node_ls) = nbr;
          end

        end

      end
      end
      Deg(node) = ideg;

    end

%  recalculer la largeur de la structure à niveaux actuelle 
    lvsize = num_node_ls - lvlend;
%  Si la largeur de la structure actuelle est non nulle, générer la
%  structure suivante
  end

  
%  Remettre le signe de adj_row à son origine.

  for i = 1 : num_node_ls
    node = ls(i);
    adj_row(node) = -adj_row(node);
  end

  return
end
