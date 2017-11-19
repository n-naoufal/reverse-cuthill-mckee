function [ mask, perm, num_node_ls ] = rcm ( root, adj_num, adj_row, adj,mask, node_num )


%  S'assurer du bon choix de root.
if ( root < 1 || node_num < root )
    error ( 'RCM - Fatal error!' );
end

% Trouver le degré des noeuds spécifiés par mask et root
[ Deg, num_node_ls, perm ] = rcmdegree ( root, adj_num, adj_row, adj, mask,node_num );

mask(root) = 0;

% Le composant connecté n'existe pas
if ( num_node_ls < 1 )
    return
end
% Si le composant connecté du graphe est un singleton. aucun réordonnement
% n'est appliqué.
if ( num_node_ls == 1 )
    return
end

%  Commencer le réordonnement

%  LBEGIN et LVLEND pointent le début et la fin du niveau de structure actuelle 
lvlend = 0;
lnbr = 1;
  
while ( lvlend < lnbr )
    
    lbegin = lvlend + 1;
    lvlend = lnbr;

    for i = lbegin : lvlend
        
%  Pour chaque noeud dans le niveau actuel
      node = perm(i);
      jstart = adj_row(node);
      jstop = adj_row(node+1) - 1;
      
%  Trouver les voisins non-numérotés de "node"
%  FNBR et LNBR pointent au premier et dernier voisin du noeud actuel dans perm
      fnbr = lnbr + 1;
      
      for j = jstart : jstop
        nbr = adj(j);
        if ( mask(nbr) ~= 0 )
          lnbr = lnbr + 1;
          mask(nbr) = 0;
          perm(lnbr) = nbr;
        end
      end
      
%  Pas de voisins ! on passe au noeud suivant dans la structure
      if ( lnbr <= fnbr )
        continue
      end

% Ordonner en degré croissant les voisins de "node"
      k = fnbr;
      while ( k < lnbr )
        l = k;
        k = k + 1;
        nbr = perm(k);
        
        while ( fnbr <= l )
          lperm = perm(l);
          if ( Deg(lperm) <= Deg(nbr) )
            break
          end
          perm(l+1) = lperm;
          l = l-1;
        end
        
        perm(l+1) = nbr;
      end

    end

  end

%  On a finalement l'ordre de Cuthill-McKee 
%  Inversons cet ordre pour avoir le RCM
%  b(1:num_node_ls) = perm(num_node_ls:-1:1);
%  perm(1:num_node_ls) = b(1:num_node_ls);
  
  return
end
