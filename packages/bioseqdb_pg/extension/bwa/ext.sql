CREATE TYPE bwa_options AS (
	min_seed_len INTEGER,
	max_occ INTEGER,
	match_score INTEGER,
	mismatch_penalty INTEGER,
	pen_clip3 INTEGER,
	pen_clip5 INTEGER,
	zdrop INTEGER,
	bandwidth INTEGER,
	o_del INTEGER,
	e_del INTEGER,
	o_ins INTEGER,
	e_ins INTEGER
);

CREATE FUNCTION bwa_opts(
	min_seed_len INTEGER DEFAULT 19,
	max_occ INTEGER DEFAULT NULL,
	match_score INTEGER DEFAULT 1,
	mismatch_penalty INTEGER DEFAULT 4,
	pen_clip3 INTEGER DEFAULT 5,
	pen_clip5 INTEGER DEFAULT 5,
	zdrop INTEGER DEFAULT 100,
	bandwidth INTEGER DEFAULT 100,
	o_del INTEGER DEFAULT 6,
	o_ins INTEGER DEFAULT 6,
	e_del INTEGER DEFAULT 1,
	e_ins INTEGER DEFAULT 1
) RETURNS bwa_options AS $$ 
	SELECT ROW(
		min_seed_len, max_occ, match_score, mismatch_penalty,
		pen_clip3, pen_clip5, zdrop, bandwidth,
		o_del, o_ins, e_del, e_ins
	) as opts
$$ LANGUAGE SQL IMMUTABLE;

CREATE TYPE bwa_result AS (
    ref_id BIGINT,
    ref_subseq nucl_seq,
    ref_match_start INTEGER,
    ref_match_end INTEGER,
    ref_match_len INTEGER,
    query_id BIGINT,
    query_subseq nucl_seq,
    query_match_start INTEGER,
    query_match_end INTEGER,
    query_match_len INTEGER,
    is_primary BOOLEAN,
    is_secondary BOOLEAN,
    is_reverse BOOLEAN,
    cigar TEXT,
    score INTEGER
);

CREATE OR REPLACE FUNCTION nuclseq_search_bwa(nucl_seq, cstring, bwa_options DEFAULT bwa_opts())
    RETURNS SETOF bwa_result
    AS 'MODULE_PATHNAME', 'nuclseq_search_bwa' LANGUAGE C STABLE STRICT;


CREATE OR REPLACE FUNCTION nuclseq_multi_search_bwa(cstring, cstring, bwa_options DEFAULT bwa_opts())
    RETURNS SETOF bwa_result
    AS 'MODULE_PATHNAME', 'nuclseq_multi_search_bwa' LANGUAGE C STABLE STRICT;