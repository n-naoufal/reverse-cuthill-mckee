function [ root, ls_num, ls_row, ls ] = rcmfind_root( root,adj_num, adj_row, adj, mask, node_num )

%  Déterminer la structure à niveaux ls enracinée en root
[ mask, ls_num, ls_row, ls ] = rcmrooted_L_S ( root, adj_num,adj_row, adj, mask, node_num );

%  Calculer le nombre de noeuds dans la structure
num_node_ls = ls_row(ls_num+1) - 1;

% Deux cas extrêmes 

%  Cas extrême numéro 1 
%  Le graphe a un seul niveau 
%  Chaque noeud peut être bon ou pas
if ( ls_num == 1 )
    return
end
  
%  Cas extrême numéro 2
%  Le graphe est une "ligne". Chaque noeud est dans son propre niveau.
%  On est tombé par chance sur le noeud racine idéal
if ( ls_num == num_node_ls )
    return
end

% Prendre n'importe quel noeud de degré minimum dans le dernier niveau
% comme le noeud de départ afin de générer le nouveau niveau

while (num_node_ls > ls_num)
    jstart = ls_row(ls_num);
    mindeg = num_node_ls;
    root = ls(jstart);

    if ( jstart ~= num_node_ls )

      for j = jstart : num_node_ls

        node = ls(j);
        ndeg = 0;
        kstart = adj_row(node);
        kstop = adj_row(node+1)-1;

        for k = kstart : kstop
          nbr = adj(k);
          if ( 0 < mask(nbr) )
            ndeg = ndeg+1;
          end
        end

        if ( ndeg < mindeg )
          root = node;
          mindeg = ndeg;
        end

      end

    end

% Générer la structure à niveaux ls associée à ce noeud
[ mask, num_level_2, ls_row, ls ] = rcmrooted_L_S ( root, adj_num,adj_row, adj, mask, node_num );

% Si le nombre de niveaux stagne, on accepte le nouveau noeud racine "root"

   
   if ( num_level_2 <= ls_num )
      return
   end
   
   ls_num = num_level_2;
% Si on tombe dans le cas tel que la racine root est le dernier point d'un
% graphe ligne, on sort de la boucle
end

return
end
