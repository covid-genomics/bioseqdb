CREATE TYPE NUCLSEQ;

CREATE FUNCTION nuclseq_in(CSTRING)
    RETURNS NUCLSEQ
    AS 'MODULE_PATHNAME'
    LANGUAGE C IMMUTABLE STRICT;

CREATE FUNCTION nuclseq_out(NUCLSEQ)
    RETURNS CSTRING
    AS 'MODULE_PATHNAME'
    LANGUAGE C IMMUTABLE STRICT;

CREATE TYPE nuclseq (
    internallength = VARIABLE,
    input = nuclseq_in,
    output = nuclseq_out
);

CREATE FUNCTION nuclseq_len(NUCLSEQ)
    RETURNS INTEGER
    AS 'MODULE_PATHNAME'
    LANGUAGE C IMMUTABLE STRICT;

CREATE FUNCTION nuclseq_content(NUCLSEQ, CSTRING)
    RETURNS DOUBLE PRECISION
    AS 'MODULE_PATHNAME'
    LANGUAGE C IMMUTABLE STRICT;

CREATE FUNCTION nuclseq_complement(NUCLSEQ)
    RETURNS NUCLSEQ
    AS 'MODULE_PATHNAME'
    LANGUAGE C IMMUTABLE STRICT;

CREATE TYPE bwa_result AS (
    id INTEGER,
    target_start INTEGER,
    target_end INTEGER,
    target_len INTEGER,
    target_aligned NUCLSEQ,
    result TEXT,
    error TEXT
);

CREATE FUNCTION nuclseq_search_bwa(NUCLSEQ, CSTRING, CSTRING, INTEGER, INTEGER, CSTRING, BOOLEAN, DOUBLE PRECISION, INTEGER)
    RETURNS SETOF bwa_result
    AS 'MODULE_PATHNAME'
    LANGUAGE C IMMUTABLE STRICT;