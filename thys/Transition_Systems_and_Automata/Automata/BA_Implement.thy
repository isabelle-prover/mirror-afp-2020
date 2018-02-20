section {* Implementation of Büchi Automata *}

theory BA_Implement
imports
  "BA_Refine"
  "../Basic/Implement"
begin

  record ('label, 'state) bai =
    alphabeti :: "'label list"
    initiali :: "'state list"
    succi :: "'label \<Rightarrow> 'state \<Rightarrow> 'state list"
    acceptingi :: "'state \<Rightarrow> bool"

  definition bai_rel :: "('label\<^sub>1 \<times> 'label\<^sub>2) set \<Rightarrow> ('state\<^sub>1 \<times> 'state\<^sub>2) set \<Rightarrow> ('more\<^sub>1 \<times> 'more\<^sub>2) set \<Rightarrow>
    (('label\<^sub>1, 'state\<^sub>1, 'more\<^sub>1) bai_scheme \<times> ('label\<^sub>2, 'state\<^sub>2, 'more\<^sub>2) bai_scheme) set" where
    [to_relAPP]: "bai_rel L S M \<equiv> {(A\<^sub>1, A\<^sub>2).
      (alphabeti A\<^sub>1, alphabeti A\<^sub>2) \<in> \<langle>L\<rangle> list_rel \<and>
      (initiali A\<^sub>1, initiali A\<^sub>2) \<in> \<langle>S\<rangle> list_rel \<and>
      (succi A\<^sub>1, succi A\<^sub>2) \<in> L \<rightarrow> S \<rightarrow> \<langle>S\<rangle> list_rel \<and>
      (acceptingi A\<^sub>1, acceptingi A\<^sub>2) \<in> S \<rightarrow> bool_rel \<and>
      (bai.more A\<^sub>1, bai.more A\<^sub>2) \<in> M}"

  lemma bai_param[param]:
    "(bai_ext, bai_ext) \<in> \<langle>L\<rangle> list_rel \<rightarrow> \<langle>S\<rangle> list_rel \<rightarrow> (L \<rightarrow> S \<rightarrow> \<langle>S\<rangle> list_rel) \<rightarrow>
      (S \<rightarrow> bool_rel) \<rightarrow> M \<rightarrow> \<langle>L, S, M\<rangle> bai_rel"
    "(alphabeti, alphabeti) \<in> \<langle>L, S, M\<rangle> bai_rel \<rightarrow> \<langle>L\<rangle> list_rel"
    "(initiali, initiali) \<in> \<langle>L, S, M\<rangle> bai_rel \<rightarrow> \<langle>S\<rangle> list_rel"
    "(succi, succi) \<in> \<langle>L, S, M\<rangle> bai_rel \<rightarrow> L \<rightarrow> S \<rightarrow> \<langle>S\<rangle> list_rel"
    "(acceptingi, acceptingi) \<in> \<langle>L, S, M\<rangle> bai_rel \<rightarrow> (S \<rightarrow> bool_rel)"
    "(bai.more, bai.more) \<in> \<langle>L, S, M\<rangle> bai_rel \<rightarrow> M"
    unfolding bai_rel_def fun_rel_def by auto

  definition bai_ba_rel :: "('label\<^sub>1 \<times> 'label\<^sub>2) set \<Rightarrow> ('state\<^sub>1 \<times> 'state\<^sub>2) set \<Rightarrow> ('more\<^sub>1 \<times> 'more\<^sub>2) set \<Rightarrow>
    (('label\<^sub>1, 'state\<^sub>1, 'more\<^sub>1) bai_scheme \<times> ('label\<^sub>2, 'state\<^sub>2, 'more\<^sub>2) ba_scheme) set" where
    [to_relAPP]: "bai_ba_rel L S M \<equiv> {(A\<^sub>1, A\<^sub>2).
      (alphabeti A\<^sub>1, alphabet A\<^sub>2) \<in> \<langle>L\<rangle> list_set_rel \<and>
      (initiali A\<^sub>1, initial A\<^sub>2) \<in> \<langle>S\<rangle> list_set_rel \<and>
      (succi A\<^sub>1, succ A\<^sub>2) \<in> L \<rightarrow> S \<rightarrow> \<langle>S\<rangle> list_set_rel \<and>
      (acceptingi A\<^sub>1, accepting A\<^sub>2) \<in> S \<rightarrow> bool_rel \<and>
      (bai.more A\<^sub>1, ba.more A\<^sub>2) \<in> M}"

  lemma bai_ba_param[param]:
    "(bai_ext, ba_ext) \<in> \<langle>L\<rangle> list_set_rel \<rightarrow> \<langle>S\<rangle> list_set_rel \<rightarrow> (L \<rightarrow> S \<rightarrow> \<langle>S\<rangle> list_set_rel) \<rightarrow>
      (S \<rightarrow> bool_rel) \<rightarrow> M \<rightarrow> \<langle>L, S, M\<rangle> bai_ba_rel"
    "(alphabeti, alphabet) \<in> \<langle>L, S, M\<rangle> bai_ba_rel \<rightarrow> \<langle>L\<rangle> list_set_rel"
    "(initiali, initial) \<in> \<langle>L, S, M\<rangle> bai_ba_rel \<rightarrow> \<langle>S\<rangle> list_set_rel"
    "(succi, succ) \<in> \<langle>L, S, M\<rangle> bai_ba_rel \<rightarrow> L \<rightarrow> S \<rightarrow> \<langle>S\<rangle> list_set_rel"
    "(acceptingi, accepting) \<in> \<langle>L, S, M\<rangle> bai_ba_rel \<rightarrow> S \<rightarrow> bool_rel"
    "(bai.more, ba.more) \<in> \<langle>L, S, M\<rangle> bai_ba_rel \<rightarrow> M"
    unfolding bai_ba_rel_def fun_rel_def by auto

  definition ba :: "('label, 'state, 'more) bai_scheme \<Rightarrow> ('label, 'state, 'more) ba_scheme" where
    "ba A \<equiv> \<lparr> alphabet = set (alphabeti A), initial = set (initiali A),
      succ = \<lambda> a p. set (succi A a p), accepting = acceptingi A, \<dots> = bai.more A \<rparr>"
  definition bai :: "('label, 'state, 'more) bai_scheme \<Rightarrow> bool" where
    "bai A \<equiv> distinct (alphabeti A) \<and> distinct (initiali A) \<and> (\<forall> a p. distinct (succi A a p))"

  lemma bai_ba_br: "\<langle>Id, Id, Id\<rangle> bai_ba_rel = br ba bai"
    unfolding bai_ba_rel_def ba_def bai_def
    by (fastforce intro!: ba.equality simp: fun_rel_def in_br_conv list_set_rel_def)

  lemma ba_id_param[param]: "(ba, id) \<in> \<langle>L, S, M\<rangle> bai_ba_rel \<rightarrow> \<langle>L, S, M\<rangle> ba_rel"
  proof
    fix Ai A
    assume 1: "(Ai, A) \<in> \<langle>L, S, M\<rangle> bai_ba_rel"
    have 2: "ba Ai = \<lparr> alphabet = set (alphabeti Ai), initial = set (initiali Ai),
      succ = \<lambda> a p. set (succi Ai a p), accepting = acceptingi Ai, \<dots> = bai.more Ai \<rparr>"
      unfolding ba_def by rule
    have 3: "id A = \<lparr> alphabet = id (alphabet A), initial = id (initial A),
      succ = \<lambda> a p. id (succ A a p), accepting = accepting A, \<dots> = ba.more A \<rparr>" by simp
    show "(ba Ai, id A) \<in> \<langle>L, S, M\<rangle> ba_rel" unfolding 2 3 using 1 by parametricity
  qed

  (* TODO: take a look at Digraph_Impl setup to make synthesizing whole bai/bae possible *)
  lemmas [autoref_rules] = bai_ba_param(2-6)

end