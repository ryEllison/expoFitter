��    a      $  �   ,      8  �   9  7   �     �     	  '   -	  3   U	      �	  2   �	  9   �	  1   
  ?   I
  5   �
  ?   �
  $   �
  M   $  &   r     �  )   �     �  C   �  @   7  $   x  <   �  ;   �  !         8  8   Y  J   �  -   �  �     4   �  V   �  >   U  <   �     �  L   Q  2   �  .   �  +      2   ,  ;   _  6   �  ?   �  B     T   U  G   �  E   �  K   8  2   �  >   �  v   �  /   m  ,   �  ;   �  1        8  4   T  8   �  7   �  0   �  8   +  -   d  5   �  )   �  M   �  6   @  0   w     �     �  $   �                /     F     `     y  %   �  B   �  "   �  &   "  7   I      �     �  /   �  1   �  \     5   n  F   �  #   �  2     :   B     }  )   �  '   �     �  !   �  G    �   a  @   �  $   8  $   ]  4   �  I   �        >   "  E   a  J   �  G   �  4   :   K   o   )   �   c   �   (   I!     r!  -   �!      �!  C   �!  B   "  )   \"  K   �"  Q   �"  +   $#  '   P#  X   x#  m   �#  M   ?$    �$  I   �%  p   �%  X   Q&  B   �&  �   �&  c   s'  R   �'  O   *(  H   z(  V   �(  Y   )  K   t)  X   �)  Y   *  e   s*  `   �*  R   :+  e   �+  <   �+  E   0,  �   v,  O   -  3   W-  7   �-  B   �-     .  ;   &.  9   b.  E   �.  R   �.  K   5/  L   �/  :   �/  /   	0  `   90  ;   �0  7   �0  +   1     :1  ,   P1     }1     �1     �1  !   �1  "   �1  "   2  1   02  M   b2  E   �2  5   �2  H   ,3  #   u3     �3  @   �3  D   �3  w   54  D   �4  U   �4  )   H5  =   r5  R   �5  #   6  J   '6  J   r6     �6  @   �6         =   [            S   0   N       Y          R   7       ^       /      <               H       @          1             I      B   2   ,                   W   L   5             ]   !   ;   G   *          %   T       6      A   _           9       +   U          \   Q                         
   Z   (           E   	   O   `          K          4          #   V      &   X   J          )   :   a   D      .   3   P   >       ?   "   $       -       C           F         8   '       M    %d observation (%s) has *only* NAs --> omit them for clustering! %d observations (%s ...) have *only* NAs --> omit them for clustering! %s has constant columns %s; these are standardized to 0 %s has invalid column names %s must be in 1:ncol(x) %s must contain column names or numbers 'A' must be p x p  cov-matrix defining an ellipsoid 'B' has to be a positive integer 'col.clus' should have length 4 when color is TRUE 'dmatrix' is not a dissimilarity matrix compatible to 'x' 'full' must be FALSE, TRUE, or a number in [0, 1] 'iniMem.p' must be a nonnegative n * k matrix with rowSums == 1 'k' (number of clusters) must be in {1,2, .., n/2 -1} 'm', a membership matrix, must be nonnegative with rowSums == 1 'maxit' must be non-negative integer 'medoids' must be NULL or vector of %d distinct indices in {1,2, .., n}, n=%d 'memb.exp' must be a finite number > 1 'n' must be >= 2 'par.method' must be of length 1, 3, or 4 'samples' should be at least 1 'sampsize' = %d should not be larger than the number of objects, %d 'sampsize' should be at least %d = max(2, 1+ number of clusters) 'weights' must be of length p (or 1) 'x' is a "dist" object, but should be a data matrix or frame 'x' is not and cannot be converted to class "dissimilarity" 'x' must be numeric  n x p matrix 'x' must only have integer codes >>>>> funny case in clusplot.default() -- please report! All variables must be binary (e.g., a factor with 2 levels, both present). Cannot keep data when 'x' is a dissimilarity! Distance computations with NAs: using correct instead of pre-2016 wrong formula.
Use  'correct.d=FALSE'  to get previous results or set 'correct.d=TRUE' explicitly
to suppress this warning. Distances must be result of dist or a square matrix. Each of the random samples contains objects between which no distance can be computed. Error in C routine for the spanning ellipsoid,
 rank problem?? FANNY algorithm has not converged in 'maxit' = %d iterations For each of the %d samples, at least one object was found which could not be assigned to a cluster (because of missing values). Missing values were displaced by the median of the corresponding variable(s) NA values in the dissimilarity matrix not allowed. NA-values are not allowed in clustering vector NA-values are not allowed in dist-like 'x'. NA-values in the dissimilarity matrix not allowed. Need either a dissimilarity 'dist' or diss.matrix 'dmatrix' No clustering performed, NA's in dissimilarity matrix. No clustering performed, NA-values in the dissimilarity matrix. No clustering performed, NAs in the computed dissimilarity matrix. No clustering performed, a variable was found with all non missing values identical. No clustering performed, all variables have at least one missing value. No clustering performed, an object was found with all values missing. No clustering performed, found variable with more than half values missing. No valid silhouette information (#{clusters} =? 1) Number of clusters 'k' must be in {1,2, .., n-1}; hence n >= 2 Observation %s has *only* NAs --> omit it for clustering Observations %s have *only* NAs --> omit them for clustering! Set either 'variant' or 'pamonce', but not both The clustering vector is of incorrect length The number of cluster should be at least 1 and at most n-1. algorithm possibly not converged in %d iterations ambiguous clustering method at least one binary variable has more than 2 levels. at least one binary variable has not 2 different levels. at least one binary variable has values not in {0,1,NA} binary variable(s) %s treated as interval scaled clustering 'x' and dissimilarity 'dist' are incompatible computed some negative or all 0 probabilities ellipsoidPoints() not yet implemented for p >= 3 dim. error from .C(cl_pam, *): invalid medID's full silhouette is only available for results of 'clara(*, keep.data = TRUE)' have %d observations, but not more than %d are allowed index has to be a function or a list of function invalid %s; must be named list invalid 'correct.d' invalid 'jstop' from .C(cl_clara,.): invalid 'silhouette' object invalid 'spaceH0': invalid 'twins' object invalid clustering method invalid partition object invalid silhouette structure invalid type %s for column numbers %s mona() needs at least p >= 2 variables (in current implementation) need at least 2 objects to cluster no diss nor data found for clusplot()' no diss nor data found, nor the original argument of %s no points without missing values omitting NAs one or more objects contain only missing values one or more variables contain only missing values setting 'logical' variable %s to type 'asymm' setting 'logical' variables %s to type 'asymm' specified both 'full' and 'subset'; will use 'subset' the memberships are all very close to 1/k. Maybe decrease 'memb.exp' ? the square matrix is not symmetric. when 'medoids.x' is FALSE, 'keep.data' must be too with mixed variables, metric "gower" is used automatically x is not a data matrix x is not a dataframe or a numeric matrix. x is not a numeric dataframe or matrix. x is not numeric x must be a matrix or data frame. Project-Id-Version: cluster 1.14.5
PO-Revision-Date: 2021-04-12 18:49+0200
Last-Translator: Philippe Grosjean <phgrosjean@sciviews.org>
Language-Team: none
Language: fr
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Generator: Poedit 2.4.2
Plural-Forms: nplurals=2; plural=(n > 1);
 %d observation (%s) n'a *que* des NAs --> ignorée pour le regroupement! %d observations (%s) n'ont *que* des NAs --> ignorées pour le regroupement! %s a des colonnes constantes %s ; elles sont standardisées à 0 %s a des noms de colonnes incorrects %s doit être compris dans 1:ncol(x) %s doit contenir des noms de colonnes ou des nombres 'A doit être une matrice de covariance p x p définissant un ellipsoïde 'B' doit être un entier positif 'col.clus' doit avoir une longueur de 4 lorsque color est TRUE 'dmatrix' n'est pas une matrice de dissimilarité compatible avec 'x' 'full' doit être parmi FALSE, TRUE, ou un nombre de l’intervalle [0, 1] 'iniMem.p' doit être une matrice n * k non négative avec rowSums == 1 'k' (nombre de groupes) doit être {1,2,…, n/2 -1} 'm', une matrice d'appartenance, doit être non négative avec rowSums == 1 'maxit' doit être un entier non négatif 'medoids' doit être NULL ou un vecteur de %d valeurs d'indices distincts dans {1, 2, …, n}, n=%d 'memb.exp' doit être un nombre fini > 1 'n' doit être >= 2 'par.method' doit être de longueur 1, 3 ou 4 'samples' doit valoir au moins 1 'sampsize' = %d ne peut être plus grand que le nombre d'objets, %d 'sampsize' doit être au minimum %d = max(2, 1+ nombre de groupes) 'weights' doit être de longueur p (ou 1) 'x' est un objet "dist", mais il faut une matrice ou un tableau de données 'x' n'est pas et ne peux pas être converti en un objet de classe "dissimilarity" 'x' doit être une matrice numérique n x p 'x' ne doit avoir que des codes entiers >>>>> cas pathologique dans clusplot.default() -- veuillez envoyer un rapport de bogue ! Toutes les variables doivent être booléennes (c'est-à-dire, des variables facteur à 2 niveaux présents). Impossible de conserver les données lorsque 'x' est un objet dissimilarity ! Calcul de distances avec NAs : utilisation de la formule corrigée à la place de celle d’avant 2016 qui était erronnée.
Utilisez 'correct.d=FALSE' pour obtenir les résultats d'avant, ou indiquez 'correct.d=TRUE' de manière explicite
pour éliminer cet avis. Les distances doivent résulter d'un objet dist ou d'une matrice carrée. Chacun des échantillons aléatoires contient des objets entre lesquels aucune distance ne peut être calculée. Erreur dans la routine C pour obtenir l'ellipsoïde de dispersion,
 problème de rang ?? L’algorithme FANNY n'a pas convergé en 'maxit' = %d itérations Dans chacun des %d échantillons, au moins un objet ne peut être assigné à un groupe (parce qu'il contient des valeurs manquantes) Les valeurs manquantes ont été remplacées par la médiane de la ou des variables correspondantes Les valeurs manquantes (NA) ne sont pas admises dans la matrice de dissimilarité. Les valeurs manquantes NA ne sont pas autorisées dans le vecteur d'agrégation Les valeurs manquantes NA ne sont pas autorisées dans 'x' de type dist. Les valeurs manquantes (NA) ne sont pas autorisées dans la matrice de dissimilarité. Il faut soit un objet 'dist' de dissimilarité ou une matrice de dissimilarité 'dmatrix' Aucune agrégation n'est réalisée, NAs dans la matrice de dissimilarité. Aucune agrégation n'est réalisée, présence de NAs dans la matrice de dissimilarité. Aucune agrégation n'a été effectuée, NAs dans la matrice de dissimilarité calculée. Aucune agrégation n'a été effectuée, une variable a toutes ses valeurs non manquantes identiques. Aucune agrégation n'a été effectuée, toutes les variables ont au moins une valeur manquante. Aucune agrégation n'a été effectuée, un objet a toutes ses valeurs manquantes. Aucune agrégation n'a été effectuée, une variable a plus de la moitié de ses valeurs manquantes. Aucune valeur de silhouette n'est correcte (#{groupes} =? 1) Le nombre de groupes 'k' doit être dans {1,2, …, n-1} ; où n >= 2 L'observation %s n'a *que* des NAs --> ignorée pour le regroupement Les observations %s n'ont *que* des NAs --> ignorées pour le regroupement! Spécifiez soit 'variant’, soit 'pamonce’, mais pas les deux en même temps Le vecteur d'agrégation est de longueur incorrecte Le nombre de groupes doit être entre 1 et n-1 compris. l'algorithme n'a vraisemblablement pas convergé en %d itérations méthode d'agrégation ambigüe une des variables binaires au moins a plus de deux niveaux. une des variables binaires au moins n'a pas deux niveaux. une des variables binaires au moins a des valeurs autres que {0,1,NA} la ou les variables binaires %s sont traitées comme des intervalles standardisés l'agrégation 'x' et la matrice de dissimilarité 'dist' sont incompatibles des probabilités négatives ou toutes égales à zéro ont été calculées ellipsoidPoints() pas encore implémenté pour p >= 3 dim. erreur depuis .C(cl_pam, *) : medIDs incorrects la silhouette complète n'est disponible que pour les résultats de 'clara(*, keep.data = TRUE)' il y a %d observations, mais pas plus de %d sont acceptées index doit être une fonction ou une liste de fonctions %s incorrect ; doit être une liste nommée 'correct.d' incorrect 'jstop' incorrect obtenu de .C(cl_clara,.) : objet 'silhouette' incorrect 'spaceH0' incorrect : objet 'twins' incorrect méthode d'agrégation incorrecte objet de partitionnement incorrect structure de silhouette incorrecte type invalide %s pour les numéros de colonnes %s mona() a besoin d'au moins p >= 2 variables (dans l'implémentation actuelle) au moins deux objets sont nécessaires pour effectuer une agrégation pas de diss ni de données trouvées pour clusplot()' pas de diss ni de données trouvées, ni même l'argument original de %s aucun point sans valeurs manquantes valeurs NAs ignorées un ou plusieurs objets ne contiennent que des valeurs manquantes une ou plusieurs variables ne contiennent que des valeurs manquantes la variable 'logical' %s est transformée en type 'asymm' les variables 'logical' %s sont transformées en type 'asymm' 'full' et 'subset' tous deux spécifiés ; utilisation de 'subset’ les appartenances sont toutes très proches de 1/k. Essayez en diminuant 'memb.exp' ? la matrice carrée n'est pas symétrique. lorsque 'medoids.x' est FALSE, 'keep.data' doit l'être aussi avec des variables mélangées, la métrique "gower" est utilisée automatiquement x n'est pas une matrice de données x n'est pas un tableau de données (data frame) ni une matrice numérique. x n'est pas un tableau de données (data frame) ou une matrice numérique. x n'est pas numérique x doit être une matrice ou un tableau de données (data frame). 