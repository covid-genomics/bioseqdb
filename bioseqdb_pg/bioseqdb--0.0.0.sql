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
    storage = EXTENDED,
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
    ref_id INTEGER,
    query_id INTEGER,
    is_primary BOOLEAN,
    is_secondary BOOLEAN,
    dummy_nuclseq NUCLSEQ
);

CREATE FUNCTION nuclseq_search_bwa(NUCLSEQ, CSTRING, CSTRING, CSTRING, BOOLEAN)
    RETURNS SETOF bwa_result
    AS 'MODULE_PATHNAME'
    LANGUAGE C STABLE STRICT;

CREATE FUNCTION nuclseq_multi_search_bwa(CSTRING,  CSTRING, CSTRING, CSTRING, CSTRING, CSTRING, BOOLEAN)
    RETURNS SETOF bwa_result
    AS 'MODULE_PATHNAME'
    LANGUAGE C STABLE STRICT;
