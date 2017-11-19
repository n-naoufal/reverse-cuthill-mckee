function [ mask, ls_num, ls_row, ls ] = rcmrooted_L_S ( root, adj_num,adj_row, adj, mask, node_num )

  mask(root) = 0;
  ls(1) = root; % racine initiale de la structure à niveaux
  ls_num = 0; % nombre de niveaux
  l_end = 0;
  num_node_ls = 1; % nombre de noeuds dans la structure à niveaux
  l_size = num_node_ls -l_end; % Largeur de la structure à niveaux

%  L_BEGIN pointe au début de la structure à niveaux actuelle ls
%  L_END pointe la fin de la structure à niveaux actuelle ls
  while ( l_size > 0 )
      
   l_begin =l_end + 1;
   l_end = num_node_ls;
   ls_num = ls_num + 1;
   ls_row(ls_num) = l_begin;
   
% Générer le niveau suivant en trouvant les voisins "maskés" des noeuds de
% la structure actuelle
    for i = l_begin :l_end
      node = ls(i);
      jstart = adj_row(node);
      jstop = adj_row(node+1)-1;

      if (jstop >= jstart) 
          for j = jstart : jstop
              nbr = adj(j);
              if ( mask(nbr) ~= 0 )
                  num_node_ls = num_node_ls + 1;
                  ls(num_node_ls) = nbr;
                  mask(nbr) = 0;
              end
          end
      end
      
    end

%  Calculer la largeur du niveau actuel. Si non nulle, générer le niveau suivant 
    l_size = num_node_ls -l_end;
  end

  ls_row(ls_num+1) =l_end + 1;

  % remettre mask à 1 pour tous les noeuds de la structure à niveaux
  mask(ls(1:num_node_ls)) = 1;

  return
end
