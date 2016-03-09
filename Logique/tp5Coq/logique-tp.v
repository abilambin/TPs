(* Voir l'enonce a la page suivante: https://staff.aist.go.jp/reynald.affeldt/coq/.
   Il s'agit essentiellement de remplacer les "Abort" par les scripts
   "Proof. [tactiques] Qed." adequats. *)

(* partie 1 *)

Lemma hilbertS (A B C : Prop) :
  (A -> B -> C) -> (A -> B) -> A -> C.
Proof.
intros abc ab a.
apply abc.
- exact a.
- apply ab.
exact a.
Qed.

(* partie 2.1 *)

Lemma exo1 (P Q : Prop) : P -> (Q -> P).
Proof.
intros p _.
exact p.
Qed.

Lemma exo2 (P Q : Prop) : P -> ( ~ P -> Q).
Proof.
intros p np.
destruct np.
exact p.
Qed.

Lemma exo3 (P Q R : Prop) : (P -> Q) -> ((Q -> R) -> (P -> R)).
intros pq qr p.
Inductive False : Prop := .
apply qr.
apply pq.
exact p.
Qed.

Lemma exo4 (P Q : Prop) : (P -> Q) -> ( ~ Q -> ~ P).
intros pq nq.
intros p.
apply nq.
destruct nq.
apply pq.
exact p.
Qed.

Require Import Classical.

Lemma bottom_c (A : Prop) : ((~A) -> False) -> A.
intros naf.
apply NNPP.
intros na.
destruct naf.
exact na.
Qed.

Lemma exo5 (P Q : Prop) : ( ~ Q -> ~ P) -> (P -> Q).
intros nqnp p.
apply bottom_c.
intro nq.
destruct nqnp.
exact nq.
exact p.
Qed.

Lemma exo6 (P : Prop) : ~ ~ P -> P.
intro nnp.
apply bottom_c.
intro np.
destruct nnp.
exact np.
Qed.

Lemma exo7 (P : Prop) : P -> ~ ~ P.
intro p.
intro np.
apply np.
exact p.
Qed.

Lemma exo8 (P Q R : Prop) : (P -> (Q -> R)) -> (P /\ Q -> R).
intros pqr pOq.
apply pqr.
apply pOq.
apply pOq.
Qed.

Lemma exo9 (P Q R : Prop) : (P /\ Q -> R) -> (P -> (Q -> R)).
intros pqr p q.
apply pqr.
split.
apply p.
exact q.
Qed.

Lemma exo10 (P : Prop) : P /\ ~ P -> False.
intro pEnp.
destruct pEnp.
destruct H0.
exact H.
Qed.

Lemma exo11 (P : Prop) : False -> P /\ ~ P.
intro f.
destruct f.
Qed.

(* partie 2.2 *)
Lemma or_elim ( A B C : Prop ) :
( A -> C ) -> ( B -> C ) -> A \/ B -> C .
intros ac bc aOb.
destruct aOb as [ a | b ].
apply ac .
exact a .
apply bc .
exact b .
Qed .


Lemma exo12 (P Q : Prop) : P \/ Q <-> ~ ( ~ P /\ ~ Q).
split.
intro pOq.
intro npEnq.
destruct pOq.
destruct npEnq.
apply H0.
apply H.
destruct npEnq.
apply H1.
apply H.

intro NnpEnq.
apply bottom_c.
intro Npoq.
destruct NnpEnq.
apply and_not_or.
split.
destruct Npoq.

apply np.
intro q.
Abort.

Lemma exo13 (P : Prop) : ~ P <-> (P -> False).
split.
intros np p.
destruct np.
apply p.

intro pf.
intro p.
apply exo11.
apply pf.
apply p.
Qed.

Lemma exo14 (P Q : Prop) : (P <-> Q) <-> (P -> Q) /\ (Q -> P).
split.
intro pEQq.
split.
destruct pEQq as [pIMq qIMp].
apply pIMq.
destruct pEQq as [pIMq qIMp].
apply qIMp.

intro pIMqETqIMp.
split.
destruct pIMqETqIMp as [pIMq qIMp].
apply pIMq.
destruct pIMqETqIMp as [pIMq qIMp].
exact qIMp.
Qed.

(* partie 3 *)

Lemma exemple134 (A B C : Prop) : (A /\ B -> C) <-> (A -> B -> C).
split.
intros aEbIMc a b.
apply aEbIMc.
split.
apply a.
apply b.

intros aIMbIMc aEb.
destruct aEb as [a b].
apply aIMbIMc.
apply a.
apply b.
Qed.

Lemma exemple135 (A B C : Prop) : (C -> A) \/ (C -> B) -> (C -> A \/ B).
intros caOcb c.
destruct caOcb.
left.
apply H.
apply c.
right.
apply H.
apply c.
Qed.

Lemma exemple_136 (X : Type) (A B : X -> Prop) :
  ((forall x, A x) \/ (forall x, B x)) -> forall x, A x \/ B x.
intro test.
destruct test.
left.
apply H.
right.
apply H.
Qed.

Lemma exemple_137 (X : Type) (A B : X -> Prop) :
  (exists x, A x /\ B x) -> ((exists x, A x) /\ (exists x, B x)).
intro test.
destruct test as [x abx].
destruct abx as [ax bx].
split.
exists x.
apply ax.
exists x.
apply bx.
Qed.

Lemma exemple_138 (A B : Prop) : ~ (A /\ B) -> ( ~ A \/ ~ B).
apply exo12.
intro Naeb.
left.
intro a.
destruct Naeb.
split.
apply a.


Lemma exemple_138' (A B : Prop) : ~ (A /\ B) -> ( ~ A \/ ~ B).
Abort.

Lemma exemple_139 (X : Type) : forall (x1 x2 : X), x1 = x2 -> x2 = x1.
Abort.

Lemma exemple_140 (X : Type) : forall (x1 x2 x3 : X), x1 = x2 /\ x2 = x3 -> x1 = x3.
Abort.

(* partie 4 *)

Definition FALSE : Prop := forall (P : Prop), P.

Lemma FALSE_False : FALSE <-> False.
Abort.

Definition AND (A B : Prop) := forall (P : Prop), (A -> B -> P) -> P.

Definition OR (A B : Prop) := forall (P : Prop), ((A -> P) -> (B -> P) -> P).

Definition EX (A : Type) (P : A -> Prop) := forall (Q : Prop), (forall a, P a -> Q) -> Q.

Definition EQ (A : Type) (a a' : A) := forall (P : A -> Prop), P a -> P a'.

Lemma SPLIT (A B : Prop) : A -> B -> AND A B.
Abort.

Lemma PROJ1 (A B : Prop) : AND A B -> A.
Abort.

Lemma PROJ2 (A B : Prop) : AND A B -> B.
Abort.

Lemma ORINTROL (A B : Prop) : A -> OR A B.
Abort.

Lemma ORINTROR (A B : Prop) : B -> OR A B.
Abort.

Lemma AND_and (A B : Prop) : AND A B <-> A /\ B.
Abort.

Lemma OR_or (A B : Prop) : OR A B <-> A \/ B.
Abort.

Lemma EX_exists (A : Type) (P : A -> Prop) : EX A P <-> exists a, P a.
Abort.

Lemma EQ_eq (A : Type) (a a' : A) : EQ _ a a' <-> a = a'.
Abort.
