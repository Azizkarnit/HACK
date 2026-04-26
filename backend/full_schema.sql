--
-- PostgreSQL database dump
--

\restrict 0wXmONGXSIED8loJsI3EcWfXRclWmYNsqYd8wSNDrplI750hHbFFtL1wwUiJWnN

-- Dumped from database version 17.6
-- Dumped by pg_dump version 18.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: auth; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA auth;


ALTER SCHEMA auth OWNER TO supabase_admin;

--
-- Name: extensions; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA extensions;


ALTER SCHEMA extensions OWNER TO postgres;

--
-- Name: graphql; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA graphql;


ALTER SCHEMA graphql OWNER TO supabase_admin;

--
-- Name: graphql_public; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA graphql_public;


ALTER SCHEMA graphql_public OWNER TO supabase_admin;

--
-- Name: pgbouncer; Type: SCHEMA; Schema: -; Owner: pgbouncer
--

CREATE SCHEMA pgbouncer;


ALTER SCHEMA pgbouncer OWNER TO pgbouncer;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS '';


--
-- Name: realtime; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA realtime;


ALTER SCHEMA realtime OWNER TO supabase_admin;

--
-- Name: storage; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA storage;


ALTER SCHEMA storage OWNER TO supabase_admin;

--
-- Name: vault; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA vault;


ALTER SCHEMA vault OWNER TO supabase_admin;

--
-- Name: pg_graphql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_graphql WITH SCHEMA graphql;


--
-- Name: EXTENSION pg_graphql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_graphql IS 'pg_graphql: GraphQL support';


--
-- Name: pg_stat_statements; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_stat_statements WITH SCHEMA extensions;


--
-- Name: EXTENSION pg_stat_statements; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_stat_statements IS 'track planning and execution statistics of all SQL statements executed';


--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA extensions;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- Name: supabase_vault; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS supabase_vault WITH SCHEMA vault;


--
-- Name: EXTENSION supabase_vault; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION supabase_vault IS 'Supabase Vault Extension';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA extensions;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- Name: aal_level; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.aal_level AS ENUM (
    'aal1',
    'aal2',
    'aal3'
);


ALTER TYPE auth.aal_level OWNER TO supabase_auth_admin;

--
-- Name: code_challenge_method; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.code_challenge_method AS ENUM (
    's256',
    'plain'
);


ALTER TYPE auth.code_challenge_method OWNER TO supabase_auth_admin;

--
-- Name: factor_status; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.factor_status AS ENUM (
    'unverified',
    'verified'
);


ALTER TYPE auth.factor_status OWNER TO supabase_auth_admin;

--
-- Name: factor_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.factor_type AS ENUM (
    'totp',
    'webauthn',
    'phone'
);


ALTER TYPE auth.factor_type OWNER TO supabase_auth_admin;

--
-- Name: oauth_authorization_status; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.oauth_authorization_status AS ENUM (
    'pending',
    'approved',
    'denied',
    'expired'
);


ALTER TYPE auth.oauth_authorization_status OWNER TO supabase_auth_admin;

--
-- Name: oauth_client_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.oauth_client_type AS ENUM (
    'public',
    'confidential'
);


ALTER TYPE auth.oauth_client_type OWNER TO supabase_auth_admin;

--
-- Name: oauth_registration_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.oauth_registration_type AS ENUM (
    'dynamic',
    'manual'
);


ALTER TYPE auth.oauth_registration_type OWNER TO supabase_auth_admin;

--
-- Name: oauth_response_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.oauth_response_type AS ENUM (
    'code'
);


ALTER TYPE auth.oauth_response_type OWNER TO supabase_auth_admin;

--
-- Name: one_time_token_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.one_time_token_type AS ENUM (
    'confirmation_token',
    'reauthentication_token',
    'recovery_token',
    'email_change_token_new',
    'email_change_token_current',
    'phone_change_token'
);


ALTER TYPE auth.one_time_token_type OWNER TO supabase_auth_admin;

--
-- Name: action; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.action AS ENUM (
    'INSERT',
    'UPDATE',
    'DELETE',
    'TRUNCATE',
    'ERROR'
);


ALTER TYPE realtime.action OWNER TO supabase_admin;

--
-- Name: equality_op; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.equality_op AS ENUM (
    'eq',
    'neq',
    'lt',
    'lte',
    'gt',
    'gte',
    'in'
);


ALTER TYPE realtime.equality_op OWNER TO supabase_admin;

--
-- Name: user_defined_filter; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.user_defined_filter AS (
	column_name text,
	op realtime.equality_op,
	value text
);


ALTER TYPE realtime.user_defined_filter OWNER TO supabase_admin;

--
-- Name: wal_column; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.wal_column AS (
	name text,
	type_name text,
	type_oid oid,
	value jsonb,
	is_pkey boolean,
	is_selectable boolean
);


ALTER TYPE realtime.wal_column OWNER TO supabase_admin;

--
-- Name: wal_rls; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.wal_rls AS (
	wal jsonb,
	is_rls_enabled boolean,
	subscription_ids uuid[],
	errors text[]
);


ALTER TYPE realtime.wal_rls OWNER TO supabase_admin;

--
-- Name: buckettype; Type: TYPE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TYPE storage.buckettype AS ENUM (
    'STANDARD',
    'ANALYTICS',
    'VECTOR'
);


ALTER TYPE storage.buckettype OWNER TO supabase_storage_admin;

--
-- Name: email(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.email() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.email', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'email')
  )::text
$$;


ALTER FUNCTION auth.email() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION email(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.email() IS 'Deprecated. Use auth.jwt() -> ''email'' instead.';


--
-- Name: jwt(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.jwt() RETURNS jsonb
    LANGUAGE sql STABLE
    AS $$
  select 
    coalesce(
        nullif(current_setting('request.jwt.claim', true), ''),
        nullif(current_setting('request.jwt.claims', true), '')
    )::jsonb
$$;


ALTER FUNCTION auth.jwt() OWNER TO supabase_auth_admin;

--
-- Name: role(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.role() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.role', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'role')
  )::text
$$;


ALTER FUNCTION auth.role() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION role(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.role() IS 'Deprecated. Use auth.jwt() -> ''role'' instead.';


--
-- Name: uid(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.uid() RETURNS uuid
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.sub', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'sub')
  )::uuid
$$;


ALTER FUNCTION auth.uid() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION uid(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.uid() IS 'Deprecated. Use auth.jwt() -> ''sub'' instead.';


--
-- Name: grant_pg_cron_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_cron_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_cron'
  )
  THEN
    grant usage on schema cron to postgres with grant option;

    alter default privileges in schema cron grant all on tables to postgres with grant option;
    alter default privileges in schema cron grant all on functions to postgres with grant option;
    alter default privileges in schema cron grant all on sequences to postgres with grant option;

    alter default privileges for user supabase_admin in schema cron grant all
        on sequences to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on tables to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on functions to postgres with grant option;

    grant all privileges on all tables in schema cron to postgres with grant option;
    revoke all on table cron.job from postgres;
    grant select on table cron.job to postgres with grant option;
  END IF;
END;
$$;


ALTER FUNCTION extensions.grant_pg_cron_access() OWNER TO supabase_admin;

--
-- Name: FUNCTION grant_pg_cron_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_cron_access() IS 'Grants access to pg_cron';


--
-- Name: grant_pg_graphql_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_graphql_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
DECLARE
    func_is_graphql_resolve bool;
BEGIN
    func_is_graphql_resolve = (
        SELECT n.proname = 'resolve'
        FROM pg_event_trigger_ddl_commands() AS ev
        LEFT JOIN pg_catalog.pg_proc AS n
        ON ev.objid = n.oid
    );

    IF func_is_graphql_resolve
    THEN
        -- Update public wrapper to pass all arguments through to the pg_graphql resolve func
        DROP FUNCTION IF EXISTS graphql_public.graphql;
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language sql
        as $$
            select graphql.resolve(
                query := query,
                variables := coalesce(variables, '{}'),
                "operationName" := "operationName",
                extensions := extensions
            );
        $$;

        -- This hook executes when `graphql.resolve` is created. That is not necessarily the last
        -- function in the extension so we need to grant permissions on existing entities AND
        -- update default permissions to any others that are created after `graphql.resolve`
        grant usage on schema graphql to postgres, anon, authenticated, service_role;
        grant select on all tables in schema graphql to postgres, anon, authenticated, service_role;
        grant execute on all functions in schema graphql to postgres, anon, authenticated, service_role;
        grant all on all sequences in schema graphql to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on tables to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on functions to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on sequences to postgres, anon, authenticated, service_role;

        -- Allow postgres role to allow granting usage on graphql and graphql_public schemas to custom roles
        grant usage on schema graphql_public to postgres with grant option;
        grant usage on schema graphql to postgres with grant option;
    END IF;

END;
$_$;


ALTER FUNCTION extensions.grant_pg_graphql_access() OWNER TO supabase_admin;

--
-- Name: FUNCTION grant_pg_graphql_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_graphql_access() IS 'Grants access to pg_graphql';


--
-- Name: grant_pg_net_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_net_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT 1
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_net'
  )
  THEN
    IF NOT EXISTS (
      SELECT 1
      FROM pg_roles
      WHERE rolname = 'supabase_functions_admin'
    )
    THEN
      CREATE USER supabase_functions_admin NOINHERIT CREATEROLE LOGIN NOREPLICATION;
    END IF;

    GRANT USAGE ON SCHEMA net TO supabase_functions_admin, postgres, anon, authenticated, service_role;

    IF EXISTS (
      SELECT FROM pg_extension
      WHERE extname = 'pg_net'
      -- all versions in use on existing projects as of 2025-02-20
      -- version 0.12.0 onwards don't need these applied
      AND extversion IN ('0.2', '0.6', '0.7', '0.7.1', '0.8', '0.10.0', '0.11.0')
    ) THEN
      ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;
      ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;

      ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;
      ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;

      REVOKE ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;
      REVOKE ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;

      GRANT EXECUTE ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
      GRANT EXECUTE ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
    END IF;
  END IF;
END;
$$;


ALTER FUNCTION extensions.grant_pg_net_access() OWNER TO supabase_admin;

--
-- Name: FUNCTION grant_pg_net_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_net_access() IS 'Grants access to pg_net';


--
-- Name: pgrst_ddl_watch(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.pgrst_ddl_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  cmd record;
BEGIN
  FOR cmd IN SELECT * FROM pg_event_trigger_ddl_commands()
  LOOP
    IF cmd.command_tag IN (
      'CREATE SCHEMA', 'ALTER SCHEMA'
    , 'CREATE TABLE', 'CREATE TABLE AS', 'SELECT INTO', 'ALTER TABLE'
    , 'CREATE FOREIGN TABLE', 'ALTER FOREIGN TABLE'
    , 'CREATE VIEW', 'ALTER VIEW'
    , 'CREATE MATERIALIZED VIEW', 'ALTER MATERIALIZED VIEW'
    , 'CREATE FUNCTION', 'ALTER FUNCTION'
    , 'CREATE TRIGGER'
    , 'CREATE TYPE', 'ALTER TYPE'
    , 'CREATE RULE'
    , 'COMMENT'
    )
    -- don't notify in case of CREATE TEMP table or other objects created on pg_temp
    AND cmd.schema_name is distinct from 'pg_temp'
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


ALTER FUNCTION extensions.pgrst_ddl_watch() OWNER TO supabase_admin;

--
-- Name: pgrst_drop_watch(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.pgrst_drop_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  obj record;
BEGIN
  FOR obj IN SELECT * FROM pg_event_trigger_dropped_objects()
  LOOP
    IF obj.object_type IN (
      'schema'
    , 'table'
    , 'foreign table'
    , 'view'
    , 'materialized view'
    , 'function'
    , 'trigger'
    , 'type'
    , 'rule'
    )
    AND obj.is_temporary IS false -- no pg_temp objects
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


ALTER FUNCTION extensions.pgrst_drop_watch() OWNER TO supabase_admin;

--
-- Name: set_graphql_placeholder(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.set_graphql_placeholder() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
    DECLARE
    graphql_is_dropped bool;
    BEGIN
    graphql_is_dropped = (
        SELECT ev.schema_name = 'graphql_public'
        FROM pg_event_trigger_dropped_objects() AS ev
        WHERE ev.schema_name = 'graphql_public'
    );

    IF graphql_is_dropped
    THEN
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language plpgsql
        as $$
            DECLARE
                server_version float;
            BEGIN
                server_version = (SELECT (SPLIT_PART((select version()), ' ', 2))::float);

                IF server_version >= 14 THEN
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql extension is not enabled.'
                            )
                        )
                    );
                ELSE
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql is only available on projects running Postgres 14 onwards.'
                            )
                        )
                    );
                END IF;
            END;
        $$;
    END IF;

    END;
$_$;


ALTER FUNCTION extensions.set_graphql_placeholder() OWNER TO supabase_admin;

--
-- Name: FUNCTION set_graphql_placeholder(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.set_graphql_placeholder() IS 'Reintroduces placeholder function for graphql_public.graphql';


--
-- Name: get_auth(text); Type: FUNCTION; Schema: pgbouncer; Owner: supabase_admin
--

CREATE FUNCTION pgbouncer.get_auth(p_usename text) RETURNS TABLE(username text, password text)
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO ''
    AS $_$
  BEGIN
      RAISE DEBUG 'PgBouncer auth request: %', p_usename;

      RETURN QUERY
      SELECT
          rolname::text,
          CASE WHEN rolvaliduntil < now()
              THEN null
              ELSE rolpassword::text
          END
      FROM pg_authid
      WHERE rolname=$1 and rolcanlogin;
  END;
  $_$;


ALTER FUNCTION pgbouncer.get_auth(p_usename text) OWNER TO supabase_admin;

--
-- Name: apply_rls(jsonb, integer); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer DEFAULT (1024 * 1024)) RETURNS SETOF realtime.wal_rls
    LANGUAGE plpgsql
    AS $$
declare
-- Regclass of the table e.g. public.notes
entity_ regclass = (quote_ident(wal ->> 'schema') || '.' || quote_ident(wal ->> 'table'))::regclass;

-- I, U, D, T: insert, update ...
action realtime.action = (
    case wal ->> 'action'
        when 'I' then 'INSERT'
        when 'U' then 'UPDATE'
        when 'D' then 'DELETE'
        else 'ERROR'
    end
);

-- Is row level security enabled for the table
is_rls_enabled bool = relrowsecurity from pg_class where oid = entity_;

subscriptions realtime.subscription[] = array_agg(subs)
    from
        realtime.subscription subs
    where
        subs.entity = entity_
        -- Filter by action early - only get subscriptions interested in this action
        -- action_filter column can be: '*' (all), 'INSERT', 'UPDATE', or 'DELETE'
        and (subs.action_filter = '*' or subs.action_filter = action::text);

-- Subscription vars
roles regrole[] = array_agg(distinct us.claims_role::text)
    from
        unnest(subscriptions) us;

working_role regrole;
claimed_role regrole;
claims jsonb;

subscription_id uuid;
subscription_has_access bool;
visible_to_subscription_ids uuid[] = '{}';

-- structured info for wal's columns
columns realtime.wal_column[];
-- previous identity values for update/delete
old_columns realtime.wal_column[];

error_record_exceeds_max_size boolean = octet_length(wal::text) > max_record_bytes;

-- Primary jsonb output for record
output jsonb;

begin
perform set_config('role', null, true);

columns =
    array_agg(
        (
            x->>'name',
            x->>'type',
            x->>'typeoid',
            realtime.cast(
                (x->'value') #>> '{}',
                coalesce(
                    (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                    (x->>'type')::regtype
                )
            ),
            (pks ->> 'name') is not null,
            true
        )::realtime.wal_column
    )
    from
        jsonb_array_elements(wal -> 'columns') x
        left join jsonb_array_elements(wal -> 'pk') pks
            on (x ->> 'name') = (pks ->> 'name');

old_columns =
    array_agg(
        (
            x->>'name',
            x->>'type',
            x->>'typeoid',
            realtime.cast(
                (x->'value') #>> '{}',
                coalesce(
                    (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                    (x->>'type')::regtype
                )
            ),
            (pks ->> 'name') is not null,
            true
        )::realtime.wal_column
    )
    from
        jsonb_array_elements(wal -> 'identity') x
        left join jsonb_array_elements(wal -> 'pk') pks
            on (x ->> 'name') = (pks ->> 'name');

for working_role in select * from unnest(roles) loop

    -- Update `is_selectable` for columns and old_columns
    columns =
        array_agg(
            (
                c.name,
                c.type_name,
                c.type_oid,
                c.value,
                c.is_pkey,
                pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
            )::realtime.wal_column
        )
        from
            unnest(columns) c;

    old_columns =
            array_agg(
                (
                    c.name,
                    c.type_name,
                    c.type_oid,
                    c.value,
                    c.is_pkey,
                    pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
                )::realtime.wal_column
            )
            from
                unnest(old_columns) c;

    if action <> 'DELETE' and count(1) = 0 from unnest(columns) c where c.is_pkey then
        return next (
            jsonb_build_object(
                'schema', wal ->> 'schema',
                'table', wal ->> 'table',
                'type', action
            ),
            is_rls_enabled,
            -- subscriptions is already filtered by entity
            (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
            array['Error 400: Bad Request, no primary key']
        )::realtime.wal_rls;

    -- The claims role does not have SELECT permission to the primary key of entity
    elsif action <> 'DELETE' and sum(c.is_selectable::int) <> count(1) from unnest(columns) c where c.is_pkey then
        return next (
            jsonb_build_object(
                'schema', wal ->> 'schema',
                'table', wal ->> 'table',
                'type', action
            ),
            is_rls_enabled,
            (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
            array['Error 401: Unauthorized']
        )::realtime.wal_rls;

    else
        output = jsonb_build_object(
            'schema', wal ->> 'schema',
            'table', wal ->> 'table',
            'type', action,
            'commit_timestamp', to_char(
                ((wal ->> 'timestamp')::timestamptz at time zone 'utc'),
                'YYYY-MM-DD"T"HH24:MI:SS.MS"Z"'
            ),
            'columns', (
                select
                    jsonb_agg(
                        jsonb_build_object(
                            'name', pa.attname,
                            'type', pt.typname
                        )
                        order by pa.attnum asc
                    )
                from
                    pg_attribute pa
                    join pg_type pt
                        on pa.atttypid = pt.oid
                where
                    attrelid = entity_
                    and attnum > 0
                    and pg_catalog.has_column_privilege(working_role, entity_, pa.attname, 'SELECT')
            )
        )
        -- Add "record" key for insert and update
        || case
            when action in ('INSERT', 'UPDATE') then
                jsonb_build_object(
                    'record',
                    (
                        select
                            jsonb_object_agg(
                                -- if unchanged toast, get column name and value from old record
                                coalesce((c).name, (oc).name),
                                case
                                    when (c).name is null then (oc).value
                                    else (c).value
                                end
                            )
                        from
                            unnest(columns) c
                            full outer join unnest(old_columns) oc
                                on (c).name = (oc).name
                        where
                            coalesce((c).is_selectable, (oc).is_selectable)
                            and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                    )
                )
            else '{}'::jsonb
        end
        -- Add "old_record" key for update and delete
        || case
            when action = 'UPDATE' then
                jsonb_build_object(
                        'old_record',
                        (
                            select jsonb_object_agg((c).name, (c).value)
                            from unnest(old_columns) c
                            where
                                (c).is_selectable
                                and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                        )
                    )
            when action = 'DELETE' then
                jsonb_build_object(
                    'old_record',
                    (
                        select jsonb_object_agg((c).name, (c).value)
                        from unnest(old_columns) c
                        where
                            (c).is_selectable
                            and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                            and ( not is_rls_enabled or (c).is_pkey ) -- if RLS enabled, we can't secure deletes so filter to pkey
                    )
                )
            else '{}'::jsonb
        end;

        -- Create the prepared statement
        if is_rls_enabled and action <> 'DELETE' then
            if (select 1 from pg_prepared_statements where name = 'walrus_rls_stmt' limit 1) > 0 then
                deallocate walrus_rls_stmt;
            end if;
            execute realtime.build_prepared_statement_sql('walrus_rls_stmt', entity_, columns);
        end if;

        visible_to_subscription_ids = '{}';

        for subscription_id, claims in (
                select
                    subs.subscription_id,
                    subs.claims
                from
                    unnest(subscriptions) subs
                where
                    subs.entity = entity_
                    and subs.claims_role = working_role
                    and (
                        realtime.is_visible_through_filters(columns, subs.filters)
                        or (
                          action = 'DELETE'
                          and realtime.is_visible_through_filters(old_columns, subs.filters)
                        )
                    )
        ) loop

            if not is_rls_enabled or action = 'DELETE' then
                visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
            else
                -- Check if RLS allows the role to see the record
                perform
                    -- Trim leading and trailing quotes from working_role because set_config
                    -- doesn't recognize the role as valid if they are included
                    set_config('role', trim(both '"' from working_role::text), true),
                    set_config('request.jwt.claims', claims::text, true);

                execute 'execute walrus_rls_stmt' into subscription_has_access;

                if subscription_has_access then
                    visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
                end if;
            end if;
        end loop;

        perform set_config('role', null, true);

        return next (
            output,
            is_rls_enabled,
            visible_to_subscription_ids,
            case
                when error_record_exceeds_max_size then array['Error 413: Payload Too Large']
                else '{}'
            end
        )::realtime.wal_rls;

    end if;
end loop;

perform set_config('role', null, true);
end;
$$;


ALTER FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) OWNER TO supabase_admin;

--
-- Name: broadcast_changes(text, text, text, text, text, record, record, text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text DEFAULT 'ROW'::text) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    -- Declare a variable to hold the JSONB representation of the row
    row_data jsonb := '{}'::jsonb;
BEGIN
    IF level = 'STATEMENT' THEN
        RAISE EXCEPTION 'function can only be triggered for each row, not for each statement';
    END IF;
    -- Check the operation type and handle accordingly
    IF operation = 'INSERT' OR operation = 'UPDATE' OR operation = 'DELETE' THEN
        row_data := jsonb_build_object('old_record', OLD, 'record', NEW, 'operation', operation, 'table', table_name, 'schema', table_schema);
        PERFORM realtime.send (row_data, event_name, topic_name);
    ELSE
        RAISE EXCEPTION 'Unexpected operation type: %', operation;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Failed to process the row: %', SQLERRM;
END;

$$;


ALTER FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) OWNER TO supabase_admin;

--
-- Name: build_prepared_statement_sql(text, regclass, realtime.wal_column[]); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) RETURNS text
    LANGUAGE sql
    AS $$
      /*
      Builds a sql string that, if executed, creates a prepared statement to
      tests retrive a row from *entity* by its primary key columns.
      Example
          select realtime.build_prepared_statement_sql('public.notes', '{"id"}'::text[], '{"bigint"}'::text[])
      */
          select
      'prepare ' || prepared_statement_name || ' as
          select
              exists(
                  select
                      1
                  from
                      ' || entity || '
                  where
                      ' || string_agg(quote_ident(pkc.name) || '=' || quote_nullable(pkc.value #>> '{}') , ' and ') || '
              )'
          from
              unnest(columns) pkc
          where
              pkc.is_pkey
          group by
              entity
      $$;


ALTER FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) OWNER TO supabase_admin;

--
-- Name: cast(text, regtype); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime."cast"(val text, type_ regtype) RETURNS jsonb
    LANGUAGE plpgsql IMMUTABLE
    AS $$
declare
  res jsonb;
begin
  if type_::text = 'bytea' then
    return to_jsonb(val);
  end if;
  execute format('select to_jsonb(%L::'|| type_::text || ')', val) into res;
  return res;
end
$$;


ALTER FUNCTION realtime."cast"(val text, type_ regtype) OWNER TO supabase_admin;

--
-- Name: check_equality_op(realtime.equality_op, regtype, text, text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) RETURNS boolean
    LANGUAGE plpgsql IMMUTABLE
    AS $$
      /*
      Casts *val_1* and *val_2* as type *type_* and check the *op* condition for truthiness
      */
      declare
          op_symbol text = (
              case
                  when op = 'eq' then '='
                  when op = 'neq' then '!='
                  when op = 'lt' then '<'
                  when op = 'lte' then '<='
                  when op = 'gt' then '>'
                  when op = 'gte' then '>='
                  when op = 'in' then '= any'
                  else 'UNKNOWN OP'
              end
          );
          res boolean;
      begin
          execute format(
              'select %L::'|| type_::text || ' ' || op_symbol
              || ' ( %L::'
              || (
                  case
                      when op = 'in' then type_::text || '[]'
                      else type_::text end
              )
              || ')', val_1, val_2) into res;
          return res;
      end;
      $$;


ALTER FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) OWNER TO supabase_admin;

--
-- Name: is_visible_through_filters(realtime.wal_column[], realtime.user_defined_filter[]); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$
    /*
    Should the record be visible (true) or filtered out (false) after *filters* are applied
    */
        select
            -- Default to allowed when no filters present
            $2 is null -- no filters. this should not happen because subscriptions has a default
            or array_length($2, 1) is null -- array length of an empty array is null
            or bool_and(
                coalesce(
                    realtime.check_equality_op(
                        op:=f.op,
                        type_:=coalesce(
                            col.type_oid::regtype, -- null when wal2json version <= 2.4
                            col.type_name::regtype
                        ),
                        -- cast jsonb to text
                        val_1:=col.value #>> '{}',
                        val_2:=f.value
                    ),
                    false -- if null, filter does not match
                )
            )
        from
            unnest(filters) f
            join unnest(columns) col
                on f.column_name = col.name;
    $_$;


ALTER FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) OWNER TO supabase_admin;

--
-- Name: list_changes(name, name, integer, integer); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) RETURNS TABLE(wal jsonb, is_rls_enabled boolean, subscription_ids uuid[], errors text[], slot_changes_count bigint)
    LANGUAGE sql
    SET log_min_messages TO 'fatal'
    AS $$
  WITH pub AS (
    SELECT
      concat_ws(
        ',',
        CASE WHEN bool_or(pubinsert) THEN 'insert' ELSE NULL END,
        CASE WHEN bool_or(pubupdate) THEN 'update' ELSE NULL END,
        CASE WHEN bool_or(pubdelete) THEN 'delete' ELSE NULL END
      ) AS w2j_actions,
      coalesce(
        string_agg(
          realtime.quote_wal2json(format('%I.%I', schemaname, tablename)::regclass),
          ','
        ) filter (WHERE ppt.tablename IS NOT NULL AND ppt.tablename NOT LIKE '% %'),
        ''
      ) AS w2j_add_tables
    FROM pg_publication pp
    LEFT JOIN pg_publication_tables ppt ON pp.pubname = ppt.pubname
    WHERE pp.pubname = publication
    GROUP BY pp.pubname
    LIMIT 1
  ),
  -- MATERIALIZED ensures pg_logical_slot_get_changes is called exactly once
  w2j AS MATERIALIZED (
    SELECT x.*, pub.w2j_add_tables
    FROM pub,
         pg_logical_slot_get_changes(
           slot_name, null, max_changes,
           'include-pk', 'true',
           'include-transaction', 'false',
           'include-timestamp', 'true',
           'include-type-oids', 'true',
           'format-version', '2',
           'actions', pub.w2j_actions,
           'add-tables', pub.w2j_add_tables
         ) x
  ),
  -- Count raw slot entries before apply_rls/subscription filter
  slot_count AS (
    SELECT count(*)::bigint AS cnt
    FROM w2j
    WHERE w2j.w2j_add_tables <> ''
  ),
  -- Apply RLS and filter as before
  rls_filtered AS (
    SELECT xyz.wal, xyz.is_rls_enabled, xyz.subscription_ids, xyz.errors
    FROM w2j,
         realtime.apply_rls(
           wal := w2j.data::jsonb,
           max_record_bytes := max_record_bytes
         ) xyz(wal, is_rls_enabled, subscription_ids, errors)
    WHERE w2j.w2j_add_tables <> ''
      AND xyz.subscription_ids[1] IS NOT NULL
  )
  -- Real rows with slot count attached
  SELECT rf.wal, rf.is_rls_enabled, rf.subscription_ids, rf.errors, sc.cnt
  FROM rls_filtered rf, slot_count sc

  UNION ALL

  -- Sentinel row: always returned when no real rows exist so Elixir can
  -- always read slot_changes_count. Identified by wal IS NULL.
  SELECT null, null, null, null, sc.cnt
  FROM slot_count sc
  WHERE NOT EXISTS (SELECT 1 FROM rls_filtered)
$$;


ALTER FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) OWNER TO supabase_admin;

--
-- Name: quote_wal2json(regclass); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.quote_wal2json(entity regclass) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $$
      select
        (
          select string_agg('' || ch,'')
          from unnest(string_to_array(nsp.nspname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
        )
        || '.'
        || (
          select string_agg('' || ch,'')
          from unnest(string_to_array(pc.relname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
          )
      from
        pg_class pc
        join pg_namespace nsp
          on pc.relnamespace = nsp.oid
      where
        pc.oid = entity
    $$;


ALTER FUNCTION realtime.quote_wal2json(entity regclass) OWNER TO supabase_admin;

--
-- Name: send(jsonb, text, text, boolean); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean DEFAULT true) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
  generated_id uuid;
  final_payload jsonb;
BEGIN
  BEGIN
    -- Generate a new UUID for the id
    generated_id := gen_random_uuid();

    -- Check if payload has an 'id' key, if not, add the generated UUID
    IF payload ? 'id' THEN
      final_payload := payload;
    ELSE
      final_payload := jsonb_set(payload, '{id}', to_jsonb(generated_id));
    END IF;

    -- Set the topic configuration
    EXECUTE format('SET LOCAL realtime.topic TO %L', topic);

    -- Attempt to insert the message
    INSERT INTO realtime.messages (id, payload, event, topic, private, extension)
    VALUES (generated_id, final_payload, event, topic, private, 'broadcast');
  EXCEPTION
    WHEN OTHERS THEN
      -- Capture and notify the error
      RAISE WARNING 'ErrorSendingBroadcastMessage: %', SQLERRM;
  END;
END;
$$;


ALTER FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) OWNER TO supabase_admin;

--
-- Name: subscription_check_filters(); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.subscription_check_filters() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    /*
    Validates that the user defined filters for a subscription:
    - refer to valid columns that the claimed role may access
    - values are coercable to the correct column type
    */
    declare
        col_names text[] = coalesce(
                array_agg(c.column_name order by c.ordinal_position),
                '{}'::text[]
            )
            from
                information_schema.columns c
            where
                format('%I.%I', c.table_schema, c.table_name)::regclass = new.entity
                and pg_catalog.has_column_privilege(
                    (new.claims ->> 'role'),
                    format('%I.%I', c.table_schema, c.table_name)::regclass,
                    c.column_name,
                    'SELECT'
                );
        filter realtime.user_defined_filter;
        col_type regtype;

        in_val jsonb;
    begin
        for filter in select * from unnest(new.filters) loop
            -- Filtered column is valid
            if not filter.column_name = any(col_names) then
                raise exception 'invalid column for filter %', filter.column_name;
            end if;

            -- Type is sanitized and safe for string interpolation
            col_type = (
                select atttypid::regtype
                from pg_catalog.pg_attribute
                where attrelid = new.entity
                      and attname = filter.column_name
            );
            if col_type is null then
                raise exception 'failed to lookup type for column %', filter.column_name;
            end if;

            -- Set maximum number of entries for in filter
            if filter.op = 'in'::realtime.equality_op then
                in_val = realtime.cast(filter.value, (col_type::text || '[]')::regtype);
                if coalesce(jsonb_array_length(in_val), 0) > 100 then
                    raise exception 'too many values for `in` filter. Maximum 100';
                end if;
            else
                -- raises an exception if value is not coercable to type
                perform realtime.cast(filter.value, col_type);
            end if;

        end loop;

        -- Apply consistent order to filters so the unique constraint on
        -- (subscription_id, entity, filters) can't be tricked by a different filter order
        new.filters = coalesce(
            array_agg(f order by f.column_name, f.op, f.value),
            '{}'
        ) from unnest(new.filters) f;

        return new;
    end;
    $$;


ALTER FUNCTION realtime.subscription_check_filters() OWNER TO supabase_admin;

--
-- Name: to_regrole(text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.to_regrole(role_name text) RETURNS regrole
    LANGUAGE sql IMMUTABLE
    AS $$ select role_name::regrole $$;


ALTER FUNCTION realtime.to_regrole(role_name text) OWNER TO supabase_admin;

--
-- Name: topic(); Type: FUNCTION; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE FUNCTION realtime.topic() RETURNS text
    LANGUAGE sql STABLE
    AS $$
select nullif(current_setting('realtime.topic', true), '')::text;
$$;


ALTER FUNCTION realtime.topic() OWNER TO supabase_realtime_admin;

--
-- Name: allow_any_operation(text[]); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.allow_any_operation(expected_operations text[]) RETURNS boolean
    LANGUAGE sql STABLE
    AS $$
  WITH current_operation AS (
    SELECT storage.operation() AS raw_operation
  ),
  normalized AS (
    SELECT CASE
      WHEN raw_operation LIKE 'storage.%' THEN substr(raw_operation, 9)
      ELSE raw_operation
    END AS current_operation
    FROM current_operation
  )
  SELECT EXISTS (
    SELECT 1
    FROM normalized n
    CROSS JOIN LATERAL unnest(expected_operations) AS expected_operation
    WHERE expected_operation IS NOT NULL
      AND expected_operation <> ''
      AND n.current_operation = CASE
        WHEN expected_operation LIKE 'storage.%' THEN substr(expected_operation, 9)
        ELSE expected_operation
      END
  );
$$;


ALTER FUNCTION storage.allow_any_operation(expected_operations text[]) OWNER TO supabase_storage_admin;

--
-- Name: allow_only_operation(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.allow_only_operation(expected_operation text) RETURNS boolean
    LANGUAGE sql STABLE
    AS $$
  WITH current_operation AS (
    SELECT storage.operation() AS raw_operation
  ),
  normalized AS (
    SELECT
      CASE
        WHEN raw_operation LIKE 'storage.%' THEN substr(raw_operation, 9)
        ELSE raw_operation
      END AS current_operation,
      CASE
        WHEN expected_operation LIKE 'storage.%' THEN substr(expected_operation, 9)
        ELSE expected_operation
      END AS requested_operation
    FROM current_operation
  )
  SELECT CASE
    WHEN requested_operation IS NULL OR requested_operation = '' THEN FALSE
    ELSE COALESCE(current_operation = requested_operation, FALSE)
  END
  FROM normalized;
$$;


ALTER FUNCTION storage.allow_only_operation(expected_operation text) OWNER TO supabase_storage_admin;

--
-- Name: can_insert_object(text, text, uuid, jsonb); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  INSERT INTO "storage"."objects" ("bucket_id", "name", "owner", "metadata") VALUES (bucketid, name, owner, metadata);
  -- hack to rollback the successful insert
  RAISE sqlstate 'PT200' using
  message = 'ROLLBACK',
  detail = 'rollback successful insert';
END
$$;


ALTER FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) OWNER TO supabase_storage_admin;

--
-- Name: enforce_bucket_name_length(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.enforce_bucket_name_length() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
    if length(new.name) > 100 then
        raise exception 'bucket name "%" is too long (% characters). Max is 100.', new.name, length(new.name);
    end if;
    return new;
end;
$$;


ALTER FUNCTION storage.enforce_bucket_name_length() OWNER TO supabase_storage_admin;

--
-- Name: extension(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.extension(name text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
_filename text;
BEGIN
	select string_to_array(name, '/') into _parts;
	select _parts[array_length(_parts,1)] into _filename;
	-- @todo return the last part instead of 2
	return reverse(split_part(reverse(_filename), '.', 1));
END
$$;


ALTER FUNCTION storage.extension(name text) OWNER TO supabase_storage_admin;

--
-- Name: filename(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.filename(name text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
BEGIN
	select string_to_array(name, '/') into _parts;
	return _parts[array_length(_parts,1)];
END
$$;


ALTER FUNCTION storage.filename(name text) OWNER TO supabase_storage_admin;

--
-- Name: foldername(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.foldername(name text) RETURNS text[]
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
BEGIN
	select string_to_array(name, '/') into _parts;
	return _parts[1:array_length(_parts,1)-1];
END
$$;


ALTER FUNCTION storage.foldername(name text) OWNER TO supabase_storage_admin;

--
-- Name: get_common_prefix(text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_common_prefix(p_key text, p_prefix text, p_delimiter text) RETURNS text
    LANGUAGE sql IMMUTABLE
    AS $$
SELECT CASE
    WHEN position(p_delimiter IN substring(p_key FROM length(p_prefix) + 1)) > 0
    THEN left(p_key, length(p_prefix) + position(p_delimiter IN substring(p_key FROM length(p_prefix) + 1)))
    ELSE NULL
END;
$$;


ALTER FUNCTION storage.get_common_prefix(p_key text, p_prefix text, p_delimiter text) OWNER TO supabase_storage_admin;

--
-- Name: get_size_by_bucket(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_size_by_bucket() RETURNS TABLE(size bigint, bucket_id text)
    LANGUAGE plpgsql
    AS $$
BEGIN
    return query
        select sum((metadata->>'size')::int) as size, obj.bucket_id
        from "storage".objects as obj
        group by obj.bucket_id;
END
$$;


ALTER FUNCTION storage.get_size_by_bucket() OWNER TO supabase_storage_admin;

--
-- Name: list_multipart_uploads_with_delimiter(text, text, text, integer, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, next_key_token text DEFAULT ''::text, next_upload_token text DEFAULT ''::text) RETURNS TABLE(key text, id text, created_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(key COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                        substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1)))
                    ELSE
                        key
                END AS key, id, created_at
            FROM
                storage.s3_multipart_uploads
            WHERE
                bucket_id = $5 AND
                key ILIKE $1 || ''%'' AND
                CASE
                    WHEN $4 != '''' AND $6 = '''' THEN
                        CASE
                            WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                                substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                key COLLATE "C" > $4
                            END
                    ELSE
                        true
                END AND
                CASE
                    WHEN $6 != '''' THEN
                        id COLLATE "C" > $6
                    ELSE
                        true
                    END
            ORDER BY
                key COLLATE "C" ASC, created_at ASC) as e order by key COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_key_token, bucket_id, next_upload_token;
END;
$_$;


ALTER FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, next_key_token text, next_upload_token text) OWNER TO supabase_storage_admin;

--
-- Name: list_objects_with_delimiter(text, text, text, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.list_objects_with_delimiter(_bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, start_after text DEFAULT ''::text, next_token text DEFAULT ''::text, sort_order text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, metadata jsonb, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone)
    LANGUAGE plpgsql STABLE
    AS $_$
DECLARE
    v_peek_name TEXT;
    v_current RECORD;
    v_common_prefix TEXT;

    -- Configuration
    v_is_asc BOOLEAN;
    v_prefix TEXT;
    v_start TEXT;
    v_upper_bound TEXT;
    v_file_batch_size INT;

    -- Seek state
    v_next_seek TEXT;
    v_count INT := 0;

    -- Dynamic SQL for batch query only
    v_batch_query TEXT;

BEGIN
    -- ========================================================================
    -- INITIALIZATION
    -- ========================================================================
    v_is_asc := lower(coalesce(sort_order, 'asc')) = 'asc';
    v_prefix := coalesce(prefix_param, '');
    v_start := CASE WHEN coalesce(next_token, '') <> '' THEN next_token ELSE coalesce(start_after, '') END;
    v_file_batch_size := LEAST(GREATEST(max_keys * 2, 100), 1000);

    -- Calculate upper bound for prefix filtering (bytewise, using COLLATE "C")
    IF v_prefix = '' THEN
        v_upper_bound := NULL;
    ELSIF right(v_prefix, 1) = delimiter_param THEN
        v_upper_bound := left(v_prefix, -1) || chr(ascii(delimiter_param) + 1);
    ELSE
        v_upper_bound := left(v_prefix, -1) || chr(ascii(right(v_prefix, 1)) + 1);
    END IF;

    -- Build batch query (dynamic SQL - called infrequently, amortized over many rows)
    IF v_is_asc THEN
        IF v_upper_bound IS NOT NULL THEN
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND o.name COLLATE "C" >= $2 ' ||
                'AND o.name COLLATE "C" < $3 ORDER BY o.name COLLATE "C" ASC LIMIT $4';
        ELSE
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND o.name COLLATE "C" >= $2 ' ||
                'ORDER BY o.name COLLATE "C" ASC LIMIT $4';
        END IF;
    ELSE
        IF v_upper_bound IS NOT NULL THEN
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND o.name COLLATE "C" < $2 ' ||
                'AND o.name COLLATE "C" >= $3 ORDER BY o.name COLLATE "C" DESC LIMIT $4';
        ELSE
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND o.name COLLATE "C" < $2 ' ||
                'ORDER BY o.name COLLATE "C" DESC LIMIT $4';
        END IF;
    END IF;

    -- ========================================================================
    -- SEEK INITIALIZATION: Determine starting position
    -- ========================================================================
    IF v_start = '' THEN
        IF v_is_asc THEN
            v_next_seek := v_prefix;
        ELSE
            -- DESC without cursor: find the last item in range
            IF v_upper_bound IS NOT NULL THEN
                SELECT o.name INTO v_next_seek FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" >= v_prefix AND o.name COLLATE "C" < v_upper_bound
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            ELSIF v_prefix <> '' THEN
                SELECT o.name INTO v_next_seek FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" >= v_prefix
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            ELSE
                SELECT o.name INTO v_next_seek FROM storage.objects o
                WHERE o.bucket_id = _bucket_id
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            END IF;

            IF v_next_seek IS NOT NULL THEN
                v_next_seek := v_next_seek || delimiter_param;
            ELSE
                RETURN;
            END IF;
        END IF;
    ELSE
        -- Cursor provided: determine if it refers to a folder or leaf
        IF EXISTS (
            SELECT 1 FROM storage.objects o
            WHERE o.bucket_id = _bucket_id
              AND o.name COLLATE "C" LIKE v_start || delimiter_param || '%'
            LIMIT 1
        ) THEN
            -- Cursor refers to a folder
            IF v_is_asc THEN
                v_next_seek := v_start || chr(ascii(delimiter_param) + 1);
            ELSE
                v_next_seek := v_start || delimiter_param;
            END IF;
        ELSE
            -- Cursor refers to a leaf object
            IF v_is_asc THEN
                v_next_seek := v_start || delimiter_param;
            ELSE
                v_next_seek := v_start;
            END IF;
        END IF;
    END IF;

    -- ========================================================================
    -- MAIN LOOP: Hybrid peek-then-batch algorithm
    -- Uses STATIC SQL for peek (hot path) and DYNAMIC SQL for batch
    -- ========================================================================
    LOOP
        EXIT WHEN v_count >= max_keys;

        -- STEP 1: PEEK using STATIC SQL (plan cached, very fast)
        IF v_is_asc THEN
            IF v_upper_bound IS NOT NULL THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" >= v_next_seek AND o.name COLLATE "C" < v_upper_bound
                ORDER BY o.name COLLATE "C" ASC LIMIT 1;
            ELSE
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" >= v_next_seek
                ORDER BY o.name COLLATE "C" ASC LIMIT 1;
            END IF;
        ELSE
            IF v_upper_bound IS NOT NULL THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" < v_next_seek AND o.name COLLATE "C" >= v_prefix
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            ELSIF v_prefix <> '' THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" < v_next_seek AND o.name COLLATE "C" >= v_prefix
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            ELSE
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" < v_next_seek
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            END IF;
        END IF;

        EXIT WHEN v_peek_name IS NULL;

        -- STEP 2: Check if this is a FOLDER or FILE
        v_common_prefix := storage.get_common_prefix(v_peek_name, v_prefix, delimiter_param);

        IF v_common_prefix IS NOT NULL THEN
            -- FOLDER: Emit and skip to next folder (no heap access needed)
            name := rtrim(v_common_prefix, delimiter_param);
            id := NULL;
            updated_at := NULL;
            created_at := NULL;
            last_accessed_at := NULL;
            metadata := NULL;
            RETURN NEXT;
            v_count := v_count + 1;

            -- Advance seek past the folder range
            IF v_is_asc THEN
                v_next_seek := left(v_common_prefix, -1) || chr(ascii(delimiter_param) + 1);
            ELSE
                v_next_seek := v_common_prefix;
            END IF;
        ELSE
            -- FILE: Batch fetch using DYNAMIC SQL (overhead amortized over many rows)
            -- For ASC: upper_bound is the exclusive upper limit (< condition)
            -- For DESC: prefix is the inclusive lower limit (>= condition)
            FOR v_current IN EXECUTE v_batch_query USING _bucket_id, v_next_seek,
                CASE WHEN v_is_asc THEN COALESCE(v_upper_bound, v_prefix) ELSE v_prefix END, v_file_batch_size
            LOOP
                v_common_prefix := storage.get_common_prefix(v_current.name, v_prefix, delimiter_param);

                IF v_common_prefix IS NOT NULL THEN
                    -- Hit a folder: exit batch, let peek handle it
                    v_next_seek := v_current.name;
                    EXIT;
                END IF;

                -- Emit file
                name := v_current.name;
                id := v_current.id;
                updated_at := v_current.updated_at;
                created_at := v_current.created_at;
                last_accessed_at := v_current.last_accessed_at;
                metadata := v_current.metadata;
                RETURN NEXT;
                v_count := v_count + 1;

                -- Advance seek past this file
                IF v_is_asc THEN
                    v_next_seek := v_current.name || delimiter_param;
                ELSE
                    v_next_seek := v_current.name;
                END IF;

                EXIT WHEN v_count >= max_keys;
            END LOOP;
        END IF;
    END LOOP;
END;
$_$;


ALTER FUNCTION storage.list_objects_with_delimiter(_bucket_id text, prefix_param text, delimiter_param text, max_keys integer, start_after text, next_token text, sort_order text) OWNER TO supabase_storage_admin;

--
-- Name: operation(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.operation() RETURNS text
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
    RETURN current_setting('storage.operation', true);
END;
$$;


ALTER FUNCTION storage.operation() OWNER TO supabase_storage_admin;

--
-- Name: protect_delete(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.protect_delete() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Check if storage.allow_delete_query is set to 'true'
    IF COALESCE(current_setting('storage.allow_delete_query', true), 'false') != 'true' THEN
        RAISE EXCEPTION 'Direct deletion from storage tables is not allowed. Use the Storage API instead.'
            USING HINT = 'This prevents accidental data loss from orphaned objects.',
                  ERRCODE = '42501';
    END IF;
    RETURN NULL;
END;
$$;


ALTER FUNCTION storage.protect_delete() OWNER TO supabase_storage_admin;

--
-- Name: search(text, text, integer, integer, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search(prefix text, bucketname text, limits integer DEFAULT 100, levels integer DEFAULT 1, offsets integer DEFAULT 0, search text DEFAULT ''::text, sortcolumn text DEFAULT 'name'::text, sortorder text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
DECLARE
    v_peek_name TEXT;
    v_current RECORD;
    v_common_prefix TEXT;
    v_delimiter CONSTANT TEXT := '/';

    -- Configuration
    v_limit INT;
    v_prefix TEXT;
    v_prefix_lower TEXT;
    v_is_asc BOOLEAN;
    v_order_by TEXT;
    v_sort_order TEXT;
    v_upper_bound TEXT;
    v_file_batch_size INT;

    -- Dynamic SQL for batch query only
    v_batch_query TEXT;

    -- Seek state
    v_next_seek TEXT;
    v_count INT := 0;
    v_skipped INT := 0;
BEGIN
    -- ========================================================================
    -- INITIALIZATION
    -- ========================================================================
    v_limit := LEAST(coalesce(limits, 100), 1500);
    v_prefix := coalesce(prefix, '') || coalesce(search, '');
    v_prefix_lower := lower(v_prefix);
    v_is_asc := lower(coalesce(sortorder, 'asc')) = 'asc';
    v_file_batch_size := LEAST(GREATEST(v_limit * 2, 100), 1000);

    -- Validate sort column
    CASE lower(coalesce(sortcolumn, 'name'))
        WHEN 'name' THEN v_order_by := 'name';
        WHEN 'updated_at' THEN v_order_by := 'updated_at';
        WHEN 'created_at' THEN v_order_by := 'created_at';
        WHEN 'last_accessed_at' THEN v_order_by := 'last_accessed_at';
        ELSE v_order_by := 'name';
    END CASE;

    v_sort_order := CASE WHEN v_is_asc THEN 'asc' ELSE 'desc' END;

    -- ========================================================================
    -- NON-NAME SORTING: Use path_tokens approach (unchanged)
    -- ========================================================================
    IF v_order_by != 'name' THEN
        RETURN QUERY EXECUTE format(
            $sql$
            WITH folders AS (
                SELECT path_tokens[$1] AS folder
                FROM storage.objects
                WHERE objects.name ILIKE $2 || '%%'
                  AND bucket_id = $3
                  AND array_length(objects.path_tokens, 1) <> $1
                GROUP BY folder
                ORDER BY folder %s
            )
            (SELECT folder AS "name",
                   NULL::uuid AS id,
                   NULL::timestamptz AS updated_at,
                   NULL::timestamptz AS created_at,
                   NULL::timestamptz AS last_accessed_at,
                   NULL::jsonb AS metadata FROM folders)
            UNION ALL
            (SELECT path_tokens[$1] AS "name",
                   id, updated_at, created_at, last_accessed_at, metadata
             FROM storage.objects
             WHERE objects.name ILIKE $2 || '%%'
               AND bucket_id = $3
               AND array_length(objects.path_tokens, 1) = $1
             ORDER BY %I %s)
            LIMIT $4 OFFSET $5
            $sql$, v_sort_order, v_order_by, v_sort_order
        ) USING levels, v_prefix, bucketname, v_limit, offsets;
        RETURN;
    END IF;

    -- ========================================================================
    -- NAME SORTING: Hybrid skip-scan with batch optimization
    -- ========================================================================

    -- Calculate upper bound for prefix filtering
    IF v_prefix_lower = '' THEN
        v_upper_bound := NULL;
    ELSIF right(v_prefix_lower, 1) = v_delimiter THEN
        v_upper_bound := left(v_prefix_lower, -1) || chr(ascii(v_delimiter) + 1);
    ELSE
        v_upper_bound := left(v_prefix_lower, -1) || chr(ascii(right(v_prefix_lower, 1)) + 1);
    END IF;

    -- Build batch query (dynamic SQL - called infrequently, amortized over many rows)
    IF v_is_asc THEN
        IF v_upper_bound IS NOT NULL THEN
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND lower(o.name) COLLATE "C" >= $2 ' ||
                'AND lower(o.name) COLLATE "C" < $3 ORDER BY lower(o.name) COLLATE "C" ASC LIMIT $4';
        ELSE
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND lower(o.name) COLLATE "C" >= $2 ' ||
                'ORDER BY lower(o.name) COLLATE "C" ASC LIMIT $4';
        END IF;
    ELSE
        IF v_upper_bound IS NOT NULL THEN
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND lower(o.name) COLLATE "C" < $2 ' ||
                'AND lower(o.name) COLLATE "C" >= $3 ORDER BY lower(o.name) COLLATE "C" DESC LIMIT $4';
        ELSE
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND lower(o.name) COLLATE "C" < $2 ' ||
                'ORDER BY lower(o.name) COLLATE "C" DESC LIMIT $4';
        END IF;
    END IF;

    -- Initialize seek position
    IF v_is_asc THEN
        v_next_seek := v_prefix_lower;
    ELSE
        -- DESC: find the last item in range first (static SQL)
        IF v_upper_bound IS NOT NULL THEN
            SELECT o.name INTO v_peek_name FROM storage.objects o
            WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" >= v_prefix_lower AND lower(o.name) COLLATE "C" < v_upper_bound
            ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
        ELSIF v_prefix_lower <> '' THEN
            SELECT o.name INTO v_peek_name FROM storage.objects o
            WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" >= v_prefix_lower
            ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
        ELSE
            SELECT o.name INTO v_peek_name FROM storage.objects o
            WHERE o.bucket_id = bucketname
            ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
        END IF;

        IF v_peek_name IS NOT NULL THEN
            v_next_seek := lower(v_peek_name) || v_delimiter;
        ELSE
            RETURN;
        END IF;
    END IF;

    -- ========================================================================
    -- MAIN LOOP: Hybrid peek-then-batch algorithm
    -- Uses STATIC SQL for peek (hot path) and DYNAMIC SQL for batch
    -- ========================================================================
    LOOP
        EXIT WHEN v_count >= v_limit;

        -- STEP 1: PEEK using STATIC SQL (plan cached, very fast)
        IF v_is_asc THEN
            IF v_upper_bound IS NOT NULL THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" >= v_next_seek AND lower(o.name) COLLATE "C" < v_upper_bound
                ORDER BY lower(o.name) COLLATE "C" ASC LIMIT 1;
            ELSE
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" >= v_next_seek
                ORDER BY lower(o.name) COLLATE "C" ASC LIMIT 1;
            END IF;
        ELSE
            IF v_upper_bound IS NOT NULL THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" < v_next_seek AND lower(o.name) COLLATE "C" >= v_prefix_lower
                ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
            ELSIF v_prefix_lower <> '' THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" < v_next_seek AND lower(o.name) COLLATE "C" >= v_prefix_lower
                ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
            ELSE
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" < v_next_seek
                ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
            END IF;
        END IF;

        EXIT WHEN v_peek_name IS NULL;

        -- STEP 2: Check if this is a FOLDER or FILE
        v_common_prefix := storage.get_common_prefix(lower(v_peek_name), v_prefix_lower, v_delimiter);

        IF v_common_prefix IS NOT NULL THEN
            -- FOLDER: Handle offset, emit if needed, skip to next folder
            IF v_skipped < offsets THEN
                v_skipped := v_skipped + 1;
            ELSE
                name := split_part(rtrim(storage.get_common_prefix(v_peek_name, v_prefix, v_delimiter), v_delimiter), v_delimiter, levels);
                id := NULL;
                updated_at := NULL;
                created_at := NULL;
                last_accessed_at := NULL;
                metadata := NULL;
                RETURN NEXT;
                v_count := v_count + 1;
            END IF;

            -- Advance seek past the folder range
            IF v_is_asc THEN
                v_next_seek := lower(left(v_common_prefix, -1)) || chr(ascii(v_delimiter) + 1);
            ELSE
                v_next_seek := lower(v_common_prefix);
            END IF;
        ELSE
            -- FILE: Batch fetch using DYNAMIC SQL (overhead amortized over many rows)
            -- For ASC: upper_bound is the exclusive upper limit (< condition)
            -- For DESC: prefix_lower is the inclusive lower limit (>= condition)
            FOR v_current IN EXECUTE v_batch_query
                USING bucketname, v_next_seek,
                    CASE WHEN v_is_asc THEN COALESCE(v_upper_bound, v_prefix_lower) ELSE v_prefix_lower END, v_file_batch_size
            LOOP
                v_common_prefix := storage.get_common_prefix(lower(v_current.name), v_prefix_lower, v_delimiter);

                IF v_common_prefix IS NOT NULL THEN
                    -- Hit a folder: exit batch, let peek handle it
                    v_next_seek := lower(v_current.name);
                    EXIT;
                END IF;

                -- Handle offset skipping
                IF v_skipped < offsets THEN
                    v_skipped := v_skipped + 1;
                ELSE
                    -- Emit file
                    name := split_part(v_current.name, v_delimiter, levels);
                    id := v_current.id;
                    updated_at := v_current.updated_at;
                    created_at := v_current.created_at;
                    last_accessed_at := v_current.last_accessed_at;
                    metadata := v_current.metadata;
                    RETURN NEXT;
                    v_count := v_count + 1;
                END IF;

                -- Advance seek past this file
                IF v_is_asc THEN
                    v_next_seek := lower(v_current.name) || v_delimiter;
                ELSE
                    v_next_seek := lower(v_current.name);
                END IF;

                EXIT WHEN v_count >= v_limit;
            END LOOP;
        END IF;
    END LOOP;
END;
$_$;


ALTER FUNCTION storage.search(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text) OWNER TO supabase_storage_admin;

--
-- Name: search_by_timestamp(text, text, integer, integer, text, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search_by_timestamp(p_prefix text, p_bucket_id text, p_limit integer, p_level integer, p_start_after text, p_sort_order text, p_sort_column text, p_sort_column_after text) RETURNS TABLE(key text, name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
DECLARE
    v_cursor_op text;
    v_query text;
    v_prefix text;
BEGIN
    v_prefix := coalesce(p_prefix, '');

    IF p_sort_order = 'asc' THEN
        v_cursor_op := '>';
    ELSE
        v_cursor_op := '<';
    END IF;

    v_query := format($sql$
        WITH raw_objects AS (
            SELECT
                o.name AS obj_name,
                o.id AS obj_id,
                o.updated_at AS obj_updated_at,
                o.created_at AS obj_created_at,
                o.last_accessed_at AS obj_last_accessed_at,
                o.metadata AS obj_metadata,
                storage.get_common_prefix(o.name, $1, '/') AS common_prefix
            FROM storage.objects o
            WHERE o.bucket_id = $2
              AND o.name COLLATE "C" LIKE $1 || '%%'
        ),
        -- Aggregate common prefixes (folders)
        -- Both created_at and updated_at use MIN(obj_created_at) to match the old prefixes table behavior
        aggregated_prefixes AS (
            SELECT
                rtrim(common_prefix, '/') AS name,
                NULL::uuid AS id,
                MIN(obj_created_at) AS updated_at,
                MIN(obj_created_at) AS created_at,
                NULL::timestamptz AS last_accessed_at,
                NULL::jsonb AS metadata,
                TRUE AS is_prefix
            FROM raw_objects
            WHERE common_prefix IS NOT NULL
            GROUP BY common_prefix
        ),
        leaf_objects AS (
            SELECT
                obj_name AS name,
                obj_id AS id,
                obj_updated_at AS updated_at,
                obj_created_at AS created_at,
                obj_last_accessed_at AS last_accessed_at,
                obj_metadata AS metadata,
                FALSE AS is_prefix
            FROM raw_objects
            WHERE common_prefix IS NULL
        ),
        combined AS (
            SELECT * FROM aggregated_prefixes
            UNION ALL
            SELECT * FROM leaf_objects
        ),
        filtered AS (
            SELECT *
            FROM combined
            WHERE (
                $5 = ''
                OR ROW(
                    date_trunc('milliseconds', %I),
                    name COLLATE "C"
                ) %s ROW(
                    COALESCE(NULLIF($6, '')::timestamptz, 'epoch'::timestamptz),
                    $5
                )
            )
        )
        SELECT
            split_part(name, '/', $3) AS key,
            name,
            id,
            updated_at,
            created_at,
            last_accessed_at,
            metadata
        FROM filtered
        ORDER BY
            COALESCE(date_trunc('milliseconds', %I), 'epoch'::timestamptz) %s,
            name COLLATE "C" %s
        LIMIT $4
    $sql$,
        p_sort_column,
        v_cursor_op,
        p_sort_column,
        p_sort_order,
        p_sort_order
    );

    RETURN QUERY EXECUTE v_query
    USING v_prefix, p_bucket_id, p_level, p_limit, p_start_after, p_sort_column_after;
END;
$_$;


ALTER FUNCTION storage.search_by_timestamp(p_prefix text, p_bucket_id text, p_limit integer, p_level integer, p_start_after text, p_sort_order text, p_sort_column text, p_sort_column_after text) OWNER TO supabase_storage_admin;

--
-- Name: search_v2(text, text, integer, integer, text, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search_v2(prefix text, bucket_name text, limits integer DEFAULT 100, levels integer DEFAULT 1, start_after text DEFAULT ''::text, sort_order text DEFAULT 'asc'::text, sort_column text DEFAULT 'name'::text, sort_column_after text DEFAULT ''::text) RETURNS TABLE(key text, name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $$
DECLARE
    v_sort_col text;
    v_sort_ord text;
    v_limit int;
BEGIN
    -- Cap limit to maximum of 1500 records
    v_limit := LEAST(coalesce(limits, 100), 1500);

    -- Validate and normalize sort_order
    v_sort_ord := lower(coalesce(sort_order, 'asc'));
    IF v_sort_ord NOT IN ('asc', 'desc') THEN
        v_sort_ord := 'asc';
    END IF;

    -- Validate and normalize sort_column
    v_sort_col := lower(coalesce(sort_column, 'name'));
    IF v_sort_col NOT IN ('name', 'updated_at', 'created_at') THEN
        v_sort_col := 'name';
    END IF;

    -- Route to appropriate implementation
    IF v_sort_col = 'name' THEN
        -- Use list_objects_with_delimiter for name sorting (most efficient: O(k * log n))
        RETURN QUERY
        SELECT
            split_part(l.name, '/', levels) AS key,
            l.name AS name,
            l.id,
            l.updated_at,
            l.created_at,
            l.last_accessed_at,
            l.metadata
        FROM storage.list_objects_with_delimiter(
            bucket_name,
            coalesce(prefix, ''),
            '/',
            v_limit,
            start_after,
            '',
            v_sort_ord
        ) l;
    ELSE
        -- Use aggregation approach for timestamp sorting
        -- Not efficient for large datasets but supports correct pagination
        RETURN QUERY SELECT * FROM storage.search_by_timestamp(
            prefix, bucket_name, v_limit, levels, start_after,
            v_sort_ord, v_sort_col, sort_column_after
        );
    END IF;
END;
$$;


ALTER FUNCTION storage.search_v2(prefix text, bucket_name text, limits integer, levels integer, start_after text, sort_order text, sort_column text, sort_column_after text) OWNER TO supabase_storage_admin;

--
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW; 
END;
$$;


ALTER FUNCTION storage.update_updated_at_column() OWNER TO supabase_storage_admin;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: audit_log_entries; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.audit_log_entries (
    instance_id uuid,
    id uuid NOT NULL,
    payload json,
    created_at timestamp with time zone,
    ip_address character varying(64) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE auth.audit_log_entries OWNER TO supabase_auth_admin;

--
-- Name: TABLE audit_log_entries; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.audit_log_entries IS 'Auth: Audit trail for user actions.';


--
-- Name: custom_oauth_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.custom_oauth_providers (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    provider_type text NOT NULL,
    identifier text NOT NULL,
    name text NOT NULL,
    client_id text NOT NULL,
    client_secret text NOT NULL,
    acceptable_client_ids text[] DEFAULT '{}'::text[] NOT NULL,
    scopes text[] DEFAULT '{}'::text[] NOT NULL,
    pkce_enabled boolean DEFAULT true NOT NULL,
    attribute_mapping jsonb DEFAULT '{}'::jsonb NOT NULL,
    authorization_params jsonb DEFAULT '{}'::jsonb NOT NULL,
    enabled boolean DEFAULT true NOT NULL,
    email_optional boolean DEFAULT false NOT NULL,
    issuer text,
    discovery_url text,
    skip_nonce_check boolean DEFAULT false NOT NULL,
    cached_discovery jsonb,
    discovery_cached_at timestamp with time zone,
    authorization_url text,
    token_url text,
    userinfo_url text,
    jwks_uri text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT custom_oauth_providers_authorization_url_https CHECK (((authorization_url IS NULL) OR (authorization_url ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_authorization_url_length CHECK (((authorization_url IS NULL) OR (char_length(authorization_url) <= 2048))),
    CONSTRAINT custom_oauth_providers_client_id_length CHECK (((char_length(client_id) >= 1) AND (char_length(client_id) <= 512))),
    CONSTRAINT custom_oauth_providers_discovery_url_length CHECK (((discovery_url IS NULL) OR (char_length(discovery_url) <= 2048))),
    CONSTRAINT custom_oauth_providers_identifier_format CHECK ((identifier ~ '^[a-z0-9][a-z0-9:-]{0,48}[a-z0-9]$'::text)),
    CONSTRAINT custom_oauth_providers_issuer_length CHECK (((issuer IS NULL) OR ((char_length(issuer) >= 1) AND (char_length(issuer) <= 2048)))),
    CONSTRAINT custom_oauth_providers_jwks_uri_https CHECK (((jwks_uri IS NULL) OR (jwks_uri ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_jwks_uri_length CHECK (((jwks_uri IS NULL) OR (char_length(jwks_uri) <= 2048))),
    CONSTRAINT custom_oauth_providers_name_length CHECK (((char_length(name) >= 1) AND (char_length(name) <= 100))),
    CONSTRAINT custom_oauth_providers_oauth2_requires_endpoints CHECK (((provider_type <> 'oauth2'::text) OR ((authorization_url IS NOT NULL) AND (token_url IS NOT NULL) AND (userinfo_url IS NOT NULL)))),
    CONSTRAINT custom_oauth_providers_oidc_discovery_url_https CHECK (((provider_type <> 'oidc'::text) OR (discovery_url IS NULL) OR (discovery_url ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_oidc_issuer_https CHECK (((provider_type <> 'oidc'::text) OR (issuer IS NULL) OR (issuer ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_oidc_requires_issuer CHECK (((provider_type <> 'oidc'::text) OR (issuer IS NOT NULL))),
    CONSTRAINT custom_oauth_providers_provider_type_check CHECK ((provider_type = ANY (ARRAY['oauth2'::text, 'oidc'::text]))),
    CONSTRAINT custom_oauth_providers_token_url_https CHECK (((token_url IS NULL) OR (token_url ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_token_url_length CHECK (((token_url IS NULL) OR (char_length(token_url) <= 2048))),
    CONSTRAINT custom_oauth_providers_userinfo_url_https CHECK (((userinfo_url IS NULL) OR (userinfo_url ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_userinfo_url_length CHECK (((userinfo_url IS NULL) OR (char_length(userinfo_url) <= 2048)))
);


ALTER TABLE auth.custom_oauth_providers OWNER TO supabase_auth_admin;

--
-- Name: flow_state; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.flow_state (
    id uuid NOT NULL,
    user_id uuid,
    auth_code text,
    code_challenge_method auth.code_challenge_method,
    code_challenge text,
    provider_type text NOT NULL,
    provider_access_token text,
    provider_refresh_token text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    authentication_method text NOT NULL,
    auth_code_issued_at timestamp with time zone,
    invite_token text,
    referrer text,
    oauth_client_state_id uuid,
    linking_target_id uuid,
    email_optional boolean DEFAULT false NOT NULL
);


ALTER TABLE auth.flow_state OWNER TO supabase_auth_admin;

--
-- Name: TABLE flow_state; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.flow_state IS 'Stores metadata for all OAuth/SSO login flows';


--
-- Name: identities; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.identities (
    provider_id text NOT NULL,
    user_id uuid NOT NULL,
    identity_data jsonb NOT NULL,
    provider text NOT NULL,
    last_sign_in_at timestamp with time zone,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    email text GENERATED ALWAYS AS (lower((identity_data ->> 'email'::text))) STORED,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE auth.identities OWNER TO supabase_auth_admin;

--
-- Name: TABLE identities; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.identities IS 'Auth: Stores identities associated to a user.';


--
-- Name: COLUMN identities.email; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.identities.email IS 'Auth: Email is a generated column that references the optional email property in the identity_data';


--
-- Name: instances; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.instances (
    id uuid NOT NULL,
    uuid uuid,
    raw_base_config text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE auth.instances OWNER TO supabase_auth_admin;

--
-- Name: TABLE instances; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.instances IS 'Auth: Manages users across multiple sites.';


--
-- Name: mfa_amr_claims; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_amr_claims (
    session_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    authentication_method text NOT NULL,
    id uuid NOT NULL
);


ALTER TABLE auth.mfa_amr_claims OWNER TO supabase_auth_admin;

--
-- Name: TABLE mfa_amr_claims; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_amr_claims IS 'auth: stores authenticator method reference claims for multi factor authentication';


--
-- Name: mfa_challenges; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_challenges (
    id uuid NOT NULL,
    factor_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    verified_at timestamp with time zone,
    ip_address inet NOT NULL,
    otp_code text,
    web_authn_session_data jsonb
);


ALTER TABLE auth.mfa_challenges OWNER TO supabase_auth_admin;

--
-- Name: TABLE mfa_challenges; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_challenges IS 'auth: stores metadata about challenge requests made';


--
-- Name: mfa_factors; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_factors (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    friendly_name text,
    factor_type auth.factor_type NOT NULL,
    status auth.factor_status NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    secret text,
    phone text,
    last_challenged_at timestamp with time zone,
    web_authn_credential jsonb,
    web_authn_aaguid uuid,
    last_webauthn_challenge_data jsonb
);


ALTER TABLE auth.mfa_factors OWNER TO supabase_auth_admin;

--
-- Name: TABLE mfa_factors; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_factors IS 'auth: stores metadata about factors';


--
-- Name: COLUMN mfa_factors.last_webauthn_challenge_data; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.mfa_factors.last_webauthn_challenge_data IS 'Stores the latest WebAuthn challenge data including attestation/assertion for customer verification';


--
-- Name: oauth_authorizations; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.oauth_authorizations (
    id uuid NOT NULL,
    authorization_id text NOT NULL,
    client_id uuid NOT NULL,
    user_id uuid,
    redirect_uri text NOT NULL,
    scope text NOT NULL,
    state text,
    resource text,
    code_challenge text,
    code_challenge_method auth.code_challenge_method,
    response_type auth.oauth_response_type DEFAULT 'code'::auth.oauth_response_type NOT NULL,
    status auth.oauth_authorization_status DEFAULT 'pending'::auth.oauth_authorization_status NOT NULL,
    authorization_code text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    expires_at timestamp with time zone DEFAULT (now() + '00:03:00'::interval) NOT NULL,
    approved_at timestamp with time zone,
    nonce text,
    CONSTRAINT oauth_authorizations_authorization_code_length CHECK ((char_length(authorization_code) <= 255)),
    CONSTRAINT oauth_authorizations_code_challenge_length CHECK ((char_length(code_challenge) <= 128)),
    CONSTRAINT oauth_authorizations_expires_at_future CHECK ((expires_at > created_at)),
    CONSTRAINT oauth_authorizations_nonce_length CHECK ((char_length(nonce) <= 255)),
    CONSTRAINT oauth_authorizations_redirect_uri_length CHECK ((char_length(redirect_uri) <= 2048)),
    CONSTRAINT oauth_authorizations_resource_length CHECK ((char_length(resource) <= 2048)),
    CONSTRAINT oauth_authorizations_scope_length CHECK ((char_length(scope) <= 4096)),
    CONSTRAINT oauth_authorizations_state_length CHECK ((char_length(state) <= 4096))
);


ALTER TABLE auth.oauth_authorizations OWNER TO supabase_auth_admin;

--
-- Name: oauth_client_states; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.oauth_client_states (
    id uuid NOT NULL,
    provider_type text NOT NULL,
    code_verifier text,
    created_at timestamp with time zone NOT NULL
);


ALTER TABLE auth.oauth_client_states OWNER TO supabase_auth_admin;

--
-- Name: TABLE oauth_client_states; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.oauth_client_states IS 'Stores OAuth states for third-party provider authentication flows where Supabase acts as the OAuth client.';


--
-- Name: oauth_clients; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.oauth_clients (
    id uuid NOT NULL,
    client_secret_hash text,
    registration_type auth.oauth_registration_type NOT NULL,
    redirect_uris text NOT NULL,
    grant_types text NOT NULL,
    client_name text,
    client_uri text,
    logo_uri text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    client_type auth.oauth_client_type DEFAULT 'confidential'::auth.oauth_client_type NOT NULL,
    token_endpoint_auth_method text NOT NULL,
    CONSTRAINT oauth_clients_client_name_length CHECK ((char_length(client_name) <= 1024)),
    CONSTRAINT oauth_clients_client_uri_length CHECK ((char_length(client_uri) <= 2048)),
    CONSTRAINT oauth_clients_logo_uri_length CHECK ((char_length(logo_uri) <= 2048)),
    CONSTRAINT oauth_clients_token_endpoint_auth_method_check CHECK ((token_endpoint_auth_method = ANY (ARRAY['client_secret_basic'::text, 'client_secret_post'::text, 'none'::text])))
);


ALTER TABLE auth.oauth_clients OWNER TO supabase_auth_admin;

--
-- Name: oauth_consents; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.oauth_consents (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    client_id uuid NOT NULL,
    scopes text NOT NULL,
    granted_at timestamp with time zone DEFAULT now() NOT NULL,
    revoked_at timestamp with time zone,
    CONSTRAINT oauth_consents_revoked_after_granted CHECK (((revoked_at IS NULL) OR (revoked_at >= granted_at))),
    CONSTRAINT oauth_consents_scopes_length CHECK ((char_length(scopes) <= 2048)),
    CONSTRAINT oauth_consents_scopes_not_empty CHECK ((char_length(TRIM(BOTH FROM scopes)) > 0))
);


ALTER TABLE auth.oauth_consents OWNER TO supabase_auth_admin;

--
-- Name: one_time_tokens; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.one_time_tokens (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    token_type auth.one_time_token_type NOT NULL,
    token_hash text NOT NULL,
    relates_to text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT one_time_tokens_token_hash_check CHECK ((char_length(token_hash) > 0))
);


ALTER TABLE auth.one_time_tokens OWNER TO supabase_auth_admin;

--
-- Name: refresh_tokens; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.refresh_tokens (
    instance_id uuid,
    id bigint NOT NULL,
    token character varying(255),
    user_id character varying(255),
    revoked boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    parent character varying(255),
    session_id uuid
);


ALTER TABLE auth.refresh_tokens OWNER TO supabase_auth_admin;

--
-- Name: TABLE refresh_tokens; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.refresh_tokens IS 'Auth: Store of tokens used to refresh JWT tokens once they expire.';


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE; Schema: auth; Owner: supabase_auth_admin
--

CREATE SEQUENCE auth.refresh_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE auth.refresh_tokens_id_seq OWNER TO supabase_auth_admin;

--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: auth; Owner: supabase_auth_admin
--

ALTER SEQUENCE auth.refresh_tokens_id_seq OWNED BY auth.refresh_tokens.id;


--
-- Name: saml_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.saml_providers (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    entity_id text NOT NULL,
    metadata_xml text NOT NULL,
    metadata_url text,
    attribute_mapping jsonb,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    name_id_format text,
    CONSTRAINT "entity_id not empty" CHECK ((char_length(entity_id) > 0)),
    CONSTRAINT "metadata_url not empty" CHECK (((metadata_url = NULL::text) OR (char_length(metadata_url) > 0))),
    CONSTRAINT "metadata_xml not empty" CHECK ((char_length(metadata_xml) > 0))
);


ALTER TABLE auth.saml_providers OWNER TO supabase_auth_admin;

--
-- Name: TABLE saml_providers; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.saml_providers IS 'Auth: Manages SAML Identity Provider connections.';


--
-- Name: saml_relay_states; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.saml_relay_states (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    request_id text NOT NULL,
    for_email text,
    redirect_to text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    flow_state_id uuid,
    CONSTRAINT "request_id not empty" CHECK ((char_length(request_id) > 0))
);


ALTER TABLE auth.saml_relay_states OWNER TO supabase_auth_admin;

--
-- Name: TABLE saml_relay_states; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.saml_relay_states IS 'Auth: Contains SAML Relay State information for each Service Provider initiated login.';


--
-- Name: schema_migrations; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.schema_migrations (
    version character varying(255) NOT NULL
);


ALTER TABLE auth.schema_migrations OWNER TO supabase_auth_admin;

--
-- Name: TABLE schema_migrations; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.schema_migrations IS 'Auth: Manages updates to the auth system.';


--
-- Name: sessions; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sessions (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    factor_id uuid,
    aal auth.aal_level,
    not_after timestamp with time zone,
    refreshed_at timestamp without time zone,
    user_agent text,
    ip inet,
    tag text,
    oauth_client_id uuid,
    refresh_token_hmac_key text,
    refresh_token_counter bigint,
    scopes text,
    CONSTRAINT sessions_scopes_length CHECK ((char_length(scopes) <= 4096))
);


ALTER TABLE auth.sessions OWNER TO supabase_auth_admin;

--
-- Name: TABLE sessions; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sessions IS 'Auth: Stores session data associated to a user.';


--
-- Name: COLUMN sessions.not_after; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sessions.not_after IS 'Auth: Not after is a nullable column that contains a timestamp after which the session should be regarded as expired.';


--
-- Name: COLUMN sessions.refresh_token_hmac_key; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sessions.refresh_token_hmac_key IS 'Holds a HMAC-SHA256 key used to sign refresh tokens for this session.';


--
-- Name: COLUMN sessions.refresh_token_counter; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sessions.refresh_token_counter IS 'Holds the ID (counter) of the last issued refresh token.';


--
-- Name: sso_domains; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sso_domains (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    domain text NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    CONSTRAINT "domain not empty" CHECK ((char_length(domain) > 0))
);


ALTER TABLE auth.sso_domains OWNER TO supabase_auth_admin;

--
-- Name: TABLE sso_domains; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sso_domains IS 'Auth: Manages SSO email address domain mapping to an SSO Identity Provider.';


--
-- Name: sso_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sso_providers (
    id uuid NOT NULL,
    resource_id text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    disabled boolean,
    CONSTRAINT "resource_id not empty" CHECK (((resource_id = NULL::text) OR (char_length(resource_id) > 0)))
);


ALTER TABLE auth.sso_providers OWNER TO supabase_auth_admin;

--
-- Name: TABLE sso_providers; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sso_providers IS 'Auth: Manages SSO identity provider information; see saml_providers for SAML.';


--
-- Name: COLUMN sso_providers.resource_id; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sso_providers.resource_id IS 'Auth: Uniquely identifies a SSO provider according to a user-chosen resource ID (case insensitive), useful in infrastructure as code.';


--
-- Name: users; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.users (
    instance_id uuid,
    id uuid NOT NULL,
    aud character varying(255),
    role character varying(255),
    email character varying(255),
    encrypted_password character varying(255),
    email_confirmed_at timestamp with time zone,
    invited_at timestamp with time zone,
    confirmation_token character varying(255),
    confirmation_sent_at timestamp with time zone,
    recovery_token character varying(255),
    recovery_sent_at timestamp with time zone,
    email_change_token_new character varying(255),
    email_change character varying(255),
    email_change_sent_at timestamp with time zone,
    last_sign_in_at timestamp with time zone,
    raw_app_meta_data jsonb,
    raw_user_meta_data jsonb,
    is_super_admin boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    phone text DEFAULT NULL::character varying,
    phone_confirmed_at timestamp with time zone,
    phone_change text DEFAULT ''::character varying,
    phone_change_token character varying(255) DEFAULT ''::character varying,
    phone_change_sent_at timestamp with time zone,
    confirmed_at timestamp with time zone GENERATED ALWAYS AS (LEAST(email_confirmed_at, phone_confirmed_at)) STORED,
    email_change_token_current character varying(255) DEFAULT ''::character varying,
    email_change_confirm_status smallint DEFAULT 0,
    banned_until timestamp with time zone,
    reauthentication_token character varying(255) DEFAULT ''::character varying,
    reauthentication_sent_at timestamp with time zone,
    is_sso_user boolean DEFAULT false NOT NULL,
    deleted_at timestamp with time zone,
    is_anonymous boolean DEFAULT false NOT NULL,
    CONSTRAINT users_email_change_confirm_status_check CHECK (((email_change_confirm_status >= 0) AND (email_change_confirm_status <= 2)))
);


ALTER TABLE auth.users OWNER TO supabase_auth_admin;

--
-- Name: TABLE users; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.users IS 'Auth: Stores user login data within a secure schema.';


--
-- Name: COLUMN users.is_sso_user; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.users.is_sso_user IS 'Auth: Set this column to true when the account comes from SSO. These accounts can have duplicate emails.';


--
-- Name: webauthn_challenges; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.webauthn_challenges (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid,
    challenge_type text NOT NULL,
    session_data jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    expires_at timestamp with time zone NOT NULL,
    CONSTRAINT webauthn_challenges_challenge_type_check CHECK ((challenge_type = ANY (ARRAY['signup'::text, 'registration'::text, 'authentication'::text])))
);


ALTER TABLE auth.webauthn_challenges OWNER TO supabase_auth_admin;

--
-- Name: webauthn_credentials; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.webauthn_credentials (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    credential_id bytea NOT NULL,
    public_key bytea NOT NULL,
    attestation_type text DEFAULT ''::text NOT NULL,
    aaguid uuid,
    sign_count bigint DEFAULT 0 NOT NULL,
    transports jsonb DEFAULT '[]'::jsonb NOT NULL,
    backup_eligible boolean DEFAULT false NOT NULL,
    backed_up boolean DEFAULT false NOT NULL,
    friendly_name text DEFAULT ''::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    last_used_at timestamp with time zone
);


ALTER TABLE auth.webauthn_credentials OWNER TO supabase_auth_admin;

--
-- Name: ai_insights; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ai_insights (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    institution_id uuid,
    kpi_id uuid,
    type character varying(50),
    title character varying(255),
    description text,
    value numeric,
    confidence numeric,
    created_at timestamp with time zone DEFAULT now(),
    CONSTRAINT ai_insights_type_check CHECK (((type)::text = ANY ((ARRAY['prediction'::character varying, 'anomaly'::character varying, 'recommendation'::character varying])::text[])))
);


ALTER TABLE public.ai_insights OWNER TO postgres;

--
-- Name: alerts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.alerts (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    institution_id uuid,
    kpi_id uuid,
    threshold numeric,
    actual_value numeric,
    severity character varying(20),
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.alerts OWNER TO postgres;

--
-- Name: institutions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.institutions (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    name character varying(255) NOT NULL,
    code character varying(50) NOT NULL
);


ALTER TABLE public.institutions OWNER TO postgres;

--
-- Name: kpi_definitions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.kpi_definitions (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    name character varying(255) NOT NULL,
    code character varying(100) NOT NULL,
    category character varying(100),
    unit character varying(50)
);


ALTER TABLE public.kpi_definitions OWNER TO postgres;

--
-- Name: kpi_values; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.kpi_values (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    institution_id uuid NOT NULL,
    kpi_id uuid NOT NULL,
    value numeric NOT NULL,
    period_date date NOT NULL,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.kpi_values OWNER TO postgres;

--
-- Name: reports; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reports (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    institution_id uuid,
    report_type character varying(50),
    start_date date,
    end_date date,
    file_url text,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.reports OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id uuid NOT NULL,
    institution_id uuid,
    full_name character varying(255),
    email character varying(255),
    role character varying(50) DEFAULT 'agent'::character varying,
    CONSTRAINT role_check CHECK (((role)::text = ANY ((ARRAY['super_admin'::character varying, 'admin'::character varying, 'agent'::character varying])::text[]))),
    CONSTRAINT role_institution_check CHECK (((((role)::text = 'admin'::text) AND (institution_id IS NOT NULL)) OR (((role)::text = ANY ((ARRAY['super_admin'::character varying, 'agent'::character varying])::text[])) AND (institution_id IS NULL))))
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: messages; Type: TABLE; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE TABLE realtime.messages (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
)
PARTITION BY RANGE (inserted_at);


ALTER TABLE realtime.messages OWNER TO supabase_realtime_admin;

--
-- Name: schema_migrations; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone
);


ALTER TABLE realtime.schema_migrations OWNER TO supabase_admin;

--
-- Name: subscription; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.subscription (
    id bigint NOT NULL,
    subscription_id uuid NOT NULL,
    entity regclass NOT NULL,
    filters realtime.user_defined_filter[] DEFAULT '{}'::realtime.user_defined_filter[] NOT NULL,
    claims jsonb NOT NULL,
    claims_role regrole GENERATED ALWAYS AS (realtime.to_regrole((claims ->> 'role'::text))) STORED NOT NULL,
    created_at timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    action_filter text DEFAULT '*'::text,
    CONSTRAINT subscription_action_filter_check CHECK ((action_filter = ANY (ARRAY['*'::text, 'INSERT'::text, 'UPDATE'::text, 'DELETE'::text])))
);


ALTER TABLE realtime.subscription OWNER TO supabase_admin;

--
-- Name: subscription_id_seq; Type: SEQUENCE; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE realtime.subscription ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME realtime.subscription_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: buckets; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.buckets (
    id text NOT NULL,
    name text NOT NULL,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    public boolean DEFAULT false,
    avif_autodetection boolean DEFAULT false,
    file_size_limit bigint,
    allowed_mime_types text[],
    owner_id text,
    type storage.buckettype DEFAULT 'STANDARD'::storage.buckettype NOT NULL
);


ALTER TABLE storage.buckets OWNER TO supabase_storage_admin;

--
-- Name: COLUMN buckets.owner; Type: COMMENT; Schema: storage; Owner: supabase_storage_admin
--

COMMENT ON COLUMN storage.buckets.owner IS 'Field is deprecated, use owner_id instead';


--
-- Name: buckets_analytics; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.buckets_analytics (
    name text NOT NULL,
    type storage.buckettype DEFAULT 'ANALYTICS'::storage.buckettype NOT NULL,
    format text DEFAULT 'ICEBERG'::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    deleted_at timestamp with time zone
);


ALTER TABLE storage.buckets_analytics OWNER TO supabase_storage_admin;

--
-- Name: buckets_vectors; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.buckets_vectors (
    id text NOT NULL,
    type storage.buckettype DEFAULT 'VECTOR'::storage.buckettype NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE storage.buckets_vectors OWNER TO supabase_storage_admin;

--
-- Name: migrations; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.migrations (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    hash character varying(40) NOT NULL,
    executed_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE storage.migrations OWNER TO supabase_storage_admin;

--
-- Name: objects; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.objects (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    bucket_id text,
    name text,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    last_accessed_at timestamp with time zone DEFAULT now(),
    metadata jsonb,
    path_tokens text[] GENERATED ALWAYS AS (string_to_array(name, '/'::text)) STORED,
    version text,
    owner_id text,
    user_metadata jsonb
);


ALTER TABLE storage.objects OWNER TO supabase_storage_admin;

--
-- Name: COLUMN objects.owner; Type: COMMENT; Schema: storage; Owner: supabase_storage_admin
--

COMMENT ON COLUMN storage.objects.owner IS 'Field is deprecated, use owner_id instead';


--
-- Name: s3_multipart_uploads; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.s3_multipart_uploads (
    id text NOT NULL,
    in_progress_size bigint DEFAULT 0 NOT NULL,
    upload_signature text NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    version text NOT NULL,
    owner_id text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    user_metadata jsonb,
    metadata jsonb
);


ALTER TABLE storage.s3_multipart_uploads OWNER TO supabase_storage_admin;

--
-- Name: s3_multipart_uploads_parts; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.s3_multipart_uploads_parts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    upload_id text NOT NULL,
    size bigint DEFAULT 0 NOT NULL,
    part_number integer NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    etag text NOT NULL,
    owner_id text,
    version text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE storage.s3_multipart_uploads_parts OWNER TO supabase_storage_admin;

--
-- Name: vector_indexes; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.vector_indexes (
    id text DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL COLLATE pg_catalog."C",
    bucket_id text NOT NULL,
    data_type text NOT NULL,
    dimension integer NOT NULL,
    distance_metric text NOT NULL,
    metadata_configuration jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE storage.vector_indexes OWNER TO supabase_storage_admin;

--
-- Name: refresh_tokens id; Type: DEFAULT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens ALTER COLUMN id SET DEFAULT nextval('auth.refresh_tokens_id_seq'::regclass);


--
-- Data for Name: audit_log_entries; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) FROM stdin;
\.


--
-- Data for Name: custom_oauth_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.custom_oauth_providers (id, provider_type, identifier, name, client_id, client_secret, acceptable_client_ids, scopes, pkce_enabled, attribute_mapping, authorization_params, enabled, email_optional, issuer, discovery_url, skip_nonce_check, cached_discovery, discovery_cached_at, authorization_url, token_url, userinfo_url, jwks_uri, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: flow_state; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.flow_state (id, user_id, auth_code, code_challenge_method, code_challenge, provider_type, provider_access_token, provider_refresh_token, created_at, updated_at, authentication_method, auth_code_issued_at, invite_token, referrer, oauth_client_state_id, linking_target_id, email_optional) FROM stdin;
\.


--
-- Data for Name: identities; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.identities (provider_id, user_id, identity_data, provider, last_sign_in_at, created_at, updated_at, id) FROM stdin;
c5f26541-dff7-4574-9091-358a6c3baf05	c5f26541-dff7-4574-9091-358a6c3baf05	{"sub": "c5f26541-dff7-4574-9091-358a6c3baf05", "email": "admin@admin.com", "email_verified": false, "phone_verified": false}	email	2026-04-25 14:33:54.39438+00	2026-04-25 14:33:54.394435+00	2026-04-25 14:33:54.394435+00	0087c591-4865-4e7a-9445-cb4cecb3805c
5a6ecfec-c7d6-41af-9432-e49ff3e7842e	5a6ecfec-c7d6-41af-9432-e49ff3e7842e	{"sub": "5a6ecfec-c7d6-41af-9432-e49ff3e7842e", "email": "hassen@gmail.com", "email_verified": false, "phone_verified": false}	email	2026-04-25 17:04:58.610003+00	2026-04-25 17:04:58.610069+00	2026-04-25 17:04:58.610069+00	832f22b2-7ec1-4796-885f-75c904c1958e
d58f805f-3c03-4c37-bad6-4e239d0a2514	d58f805f-3c03-4c37-bad6-4e239d0a2514	{"sub": "d58f805f-3c03-4c37-bad6-4e239d0a2514", "email": "hassen2@gmail.com", "email_verified": false, "phone_verified": false}	email	2026-04-25 17:37:47.364825+00	2026-04-25 17:37:47.36488+00	2026-04-25 17:37:47.36488+00	0d773c63-c689-494d-8624-202ee2f6b489
5b83c241-2553-4462-8aa3-0393ada157a5	5b83c241-2553-4462-8aa3-0393ada157a5	{"sub": "5b83c241-2553-4462-8aa3-0393ada157a5", "email": "hassen22@gmail.com", "email_verified": false, "phone_verified": false}	email	2026-04-25 17:38:08.600378+00	2026-04-25 17:38:08.600421+00	2026-04-25 17:38:08.600421+00	d58992a1-6905-4a65-b8bd-2dd74b467856
2f5f1bc1-e347-4c36-acc9-6d6c816b05f5	2f5f1bc1-e347-4c36-acc9-6d6c816b05f5	{"sub": "2f5f1bc1-e347-4c36-acc9-6d6c816b05f5", "email": "shady@gmail.com", "email_verified": false, "phone_verified": false}	email	2026-04-26 00:39:08.281865+00	2026-04-26 00:39:08.281922+00	2026-04-26 00:39:08.281922+00	e0853cba-37ed-48ff-8ef4-82e735fba72d
4e900029-58bf-48cc-9187-58d3b30dd55f	4e900029-58bf-48cc-9187-58d3b30dd55f	{"sub": "4e900029-58bf-48cc-9187-58d3b30dd55f", "email": "superadmin@ucar.tn"}	email	2026-04-26 01:09:07.609228+00	2026-04-26 01:09:07.609228+00	2026-04-26 01:09:07.609228+00	fa4b0586-c2b9-4092-b285-52e4bcc6c4c0
a6f0d99c-7d0b-4a25-9022-20e39e844680	a6f0d99c-7d0b-4a25-9022-20e39e844680	{"sub": "a6f0d99c-7d0b-4a25-9022-20e39e844680", "email": "hassenhomri1@gmail.com", "email_verified": false, "phone_verified": false}	email	2026-04-26 01:38:15.458525+00	2026-04-26 01:38:15.458586+00	2026-04-26 01:38:15.458586+00	bf4c8892-ec13-4ebb-a327-19487b6f3c0d
68e1be2f-d559-4837-a9c7-bd6fba6a3431	68e1be2f-d559-4837-a9c7-bd6fba6a3431	{"sub": "68e1be2f-d559-4837-a9c7-bd6fba6a3431", "email": "admin@ucar.tn", "email_verified": false, "phone_verified": false}	email	2026-04-26 03:11:57.857166+00	2026-04-26 03:11:57.857229+00	2026-04-26 03:11:57.857229+00	4e82e579-727c-409d-be84-d90519aa2f99
8cf6f14a-e9c3-482a-995b-d7408be90592	8cf6f14a-e9c3-482a-995b-d7408be90592	{"sub": "8cf6f14a-e9c3-482a-995b-d7408be90592", "email": "haho1@gmail.com", "email_verified": false, "phone_verified": false}	email	2026-04-26 03:16:19.149705+00	2026-04-26 03:16:19.149758+00	2026-04-26 03:16:19.149758+00	d344473d-8bff-4196-b0da-e416d6654bef
9f5b54c4-68dc-46c3-be6e-53ab97759716	9f5b54c4-68dc-46c3-be6e-53ab97759716	{"sub": "9f5b54c4-68dc-46c3-be6e-53ab97759716", "email": "hahohaho@gmail.com", "email_verified": false, "phone_verified": false}	email	2026-04-26 03:17:00.856715+00	2026-04-26 03:17:00.856764+00	2026-04-26 03:17:00.856764+00	1117a8e4-9b8d-4842-8395-58789ab0280c
\.


--
-- Data for Name: instances; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.instances (id, uuid, raw_base_config, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: mfa_amr_claims; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_amr_claims (session_id, created_at, updated_at, authentication_method, id) FROM stdin;
6ec9c030-28cb-45ba-939d-ea87ce307796	2026-04-25 17:05:28.349933+00	2026-04-25 17:05:28.349933+00	password	2e196c6a-e5b2-4c08-a754-419da075d1e2
6777b862-b82e-4a62-ac14-fa48284919aa	2026-04-25 17:17:27.270202+00	2026-04-25 17:17:27.270202+00	password	bdabbb0b-47aa-4414-a2d9-71254c228e4f
b6efb2c5-082b-4d12-b506-ecaf0e5f25ed	2026-04-25 17:37:47.378762+00	2026-04-25 17:37:47.378762+00	password	610de744-35b9-423c-834f-3f9fa57e8f7e
5128a95b-e764-4b09-a848-f518c7b14d9f	2026-04-25 17:38:08.607508+00	2026-04-25 17:38:08.607508+00	password	5b05e123-81e4-4dbb-9be5-3fc0d239f7f9
a27f268e-c693-46c2-854b-b6e586078cb9	2026-04-25 17:42:15.071773+00	2026-04-25 17:42:15.071773+00	password	441c4346-dc62-424a-a2e4-3cff3e329c74
98a84d93-a0dc-40c3-bd3c-45ba6bf6d696	2026-04-26 01:19:01.763766+00	2026-04-26 01:19:01.763766+00	password	6ebc9c37-e9fd-43ab-baef-ce5029bb1074
6f5febce-bcff-4637-8f03-1faffc34701f	2026-04-26 01:19:58.976487+00	2026-04-26 01:19:58.976487+00	password	834d74e3-d215-4012-be3b-eb1260526e8f
676dc62d-ffd3-4e33-80de-adb69c3ff746	2026-04-26 01:25:43.400019+00	2026-04-26 01:25:43.400019+00	password	d5d9dc61-f1e0-48bd-b848-9f0c8ab23bb0
2bf1a494-1bad-4fe3-ae06-2008997fb6d2	2026-04-26 01:26:13.490921+00	2026-04-26 01:26:13.490921+00	password	6c71daad-4411-4336-a693-6f5b9003a095
b10c7d17-405c-4c4b-b1c7-8d5e25749624	2026-04-26 01:26:18.560367+00	2026-04-26 01:26:18.560367+00	password	b8f49ab1-d7da-470b-b4d8-44c36fe52880
9d376ead-4520-4cd3-9538-ddcaba558f10	2026-04-26 02:02:07.853552+00	2026-04-26 02:02:07.853552+00	password	6598bf99-1092-4b6e-854a-823909120cb3
3c8dde41-dede-4f34-b640-bed83b7893a7	2026-04-26 02:06:04.095677+00	2026-04-26 02:06:04.095677+00	password	aba1d992-a077-42ff-9782-c68ebe79484e
594f235c-14b7-4f5e-886c-f179429a531f	2026-04-26 02:09:43.810774+00	2026-04-26 02:09:43.810774+00	password	ff4d1b89-a457-4bb4-9633-8276bcf1d929
90cb46a6-0a2e-4ef0-bc6e-0aa8fcc3b5dd	2026-04-26 02:13:07.319979+00	2026-04-26 02:13:07.319979+00	password	be3e0457-6ea0-49d3-ab1d-456587c052a7
185e81be-9c94-44cf-bed9-1988e681f7ac	2026-04-26 02:13:25.426038+00	2026-04-26 02:13:25.426038+00	password	ab3f5661-9670-48a6-b27d-519f39991838
e6a26eb8-fe0a-41ad-9630-2f281d4278ed	2026-04-26 02:14:59.784238+00	2026-04-26 02:14:59.784238+00	password	805299e0-27e1-47c6-8ef5-4d3786e10f44
ec3c5c13-77d9-450e-b6a2-2de721de5d1d	2026-04-26 02:21:55.029908+00	2026-04-26 02:21:55.029908+00	password	9f07e453-f54b-4784-ad6a-49cad99ee478
0eb849d6-06fb-416f-9bf7-8c640d141cc1	2026-04-26 02:48:00.819749+00	2026-04-26 02:48:00.819749+00	password	c6218cc3-e451-4aca-97ce-e07229f49dfa
35577a29-3d21-4f87-8562-4b9b98cc95d4	2026-04-26 02:52:50.445496+00	2026-04-26 02:52:50.445496+00	password	74ab4da5-d2a1-4dfa-8133-59ef0eedf30d
ce73a4fb-6dee-410e-a5bb-9741b685a0d5	2026-04-26 02:57:38.873711+00	2026-04-26 02:57:38.873711+00	password	8ba992c9-a5a9-439b-9f44-70bb67c28337
a4d63cd8-b714-4ef7-b149-056dab186af1	2026-04-26 02:58:54.50749+00	2026-04-26 02:58:54.50749+00	password	df52aba7-054e-47d9-bdb8-1d196c6c569b
cf094d3f-cc3a-4158-bbfc-cbd478b1f666	2026-04-26 02:58:57.654208+00	2026-04-26 02:58:57.654208+00	password	5b776111-4fda-4604-867a-424331648854
836ae22e-ac4b-48e8-ba2c-983e0ddff4c8	2026-04-26 02:59:14.968948+00	2026-04-26 02:59:14.968948+00	password	05f59d46-b613-401f-97f0-8b4db5dbc342
19784f5b-4732-497e-8925-2097dbf54bd7	2026-04-26 02:59:23.586138+00	2026-04-26 02:59:23.586138+00	password	7d46fdb4-e20d-4188-a05a-9148bebfa2fb
93ffa617-3dab-450a-97ec-04effdf81964	2026-04-26 03:00:29.56367+00	2026-04-26 03:00:29.56367+00	password	62328dc9-1e31-44ce-8e3f-ae4ca0e521f9
a0d69cd6-564e-4a01-94f6-1611d472a780	2026-04-26 03:03:49.879542+00	2026-04-26 03:03:49.879542+00	password	91d14d3b-355e-4633-a619-61a93020bb0c
44c90cd0-9d7d-4b8a-ad9f-98b105596cd4	2026-04-26 03:04:05.726316+00	2026-04-26 03:04:05.726316+00	password	cc8610d2-1559-4248-ba67-eee0d9865600
f1582bb9-ee89-49a4-955a-0ea6731ae97d	2026-04-26 03:17:13.795199+00	2026-04-26 03:17:13.795199+00	password	40331e63-bf28-440f-afac-c934a367e566
ae31225e-c70b-42a7-aaf4-7332eb588fd6	2026-04-26 03:20:41.241279+00	2026-04-26 03:20:41.241279+00	password	5a127fdb-75a7-4173-8249-3832bf2f6c4c
7919fb4f-5dbe-4504-9d74-ff97e7f6aeee	2026-04-26 03:23:51.819809+00	2026-04-26 03:23:51.819809+00	password	8293351f-47db-4f4c-b191-61f99991b18a
2567e5ee-c98d-4c1f-b7d4-a44a3dd12617	2026-04-26 03:43:44.240431+00	2026-04-26 03:43:44.240431+00	password	ee9e2bb8-dcdf-442c-bc3c-824381750f7d
19ee1ff9-457a-443e-b71e-bc188bcb185b	2026-04-26 03:50:48.396484+00	2026-04-26 03:50:48.396484+00	password	fa33d2f3-0f87-4847-adc2-fce3246c929b
526e587d-4caa-4d21-a2d1-ef8e65afcf11	2026-04-26 03:51:24.10614+00	2026-04-26 03:51:24.10614+00	password	e4d6e0e0-b0d7-4185-9f80-250ac12bca82
df78f21a-3a04-4d6e-b99b-61bf4a9178b2	2026-04-26 03:51:48.879076+00	2026-04-26 03:51:48.879076+00	password	db743f67-1fb2-4a33-8a8b-5499bf8a2443
f356cce1-31d7-4af5-bbaf-b8ff6cb54aa2	2026-04-26 03:54:16.303541+00	2026-04-26 03:54:16.303541+00	password	acf39c57-5728-4827-8bed-91f8b7933504
8a261e72-97df-43ea-b112-3b83afb1530c	2026-04-26 03:55:44.932613+00	2026-04-26 03:55:44.932613+00	password	56a207ea-3ecb-4f0d-acea-663c42d371a3
4eca4246-8fe6-48fd-8a6b-b9d4b977834e	2026-04-26 04:02:37.138388+00	2026-04-26 04:02:37.138388+00	password	243402fe-2fb4-4bb7-bd3b-ee9d3b85a672
ea0e5a35-f893-4374-8726-b3cd7c628dc5	2026-04-26 04:09:23.236654+00	2026-04-26 04:09:23.236654+00	password	98126a8c-4c39-4fbd-9fd6-5fbaa5264d3a
0667b98b-fc92-4322-b7a9-d6bf3209ed87	2026-04-26 04:11:59.465594+00	2026-04-26 04:11:59.465594+00	password	d29f678a-df57-4fb4-bfda-ce946e270e72
be04040c-a288-499c-b708-8492b42de2f8	2026-04-26 04:12:26.998468+00	2026-04-26 04:12:26.998468+00	password	12e01444-500b-4a3b-85f3-42612fa39d40
33501c3a-3682-4b10-812b-3567a322a989	2026-04-26 04:12:30.43036+00	2026-04-26 04:12:30.43036+00	password	bfd837d5-54bd-4e01-86a3-995882d17af9
\.


--
-- Data for Name: mfa_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_challenges (id, factor_id, created_at, verified_at, ip_address, otp_code, web_authn_session_data) FROM stdin;
\.


--
-- Data for Name: mfa_factors; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_factors (id, user_id, friendly_name, factor_type, status, created_at, updated_at, secret, phone, last_challenged_at, web_authn_credential, web_authn_aaguid, last_webauthn_challenge_data) FROM stdin;
\.


--
-- Data for Name: oauth_authorizations; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.oauth_authorizations (id, authorization_id, client_id, user_id, redirect_uri, scope, state, resource, code_challenge, code_challenge_method, response_type, status, authorization_code, created_at, expires_at, approved_at, nonce) FROM stdin;
\.


--
-- Data for Name: oauth_client_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.oauth_client_states (id, provider_type, code_verifier, created_at) FROM stdin;
\.


--
-- Data for Name: oauth_clients; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.oauth_clients (id, client_secret_hash, registration_type, redirect_uris, grant_types, client_name, client_uri, logo_uri, created_at, updated_at, deleted_at, client_type, token_endpoint_auth_method) FROM stdin;
\.


--
-- Data for Name: oauth_consents; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.oauth_consents (id, user_id, client_id, scopes, granted_at, revoked_at) FROM stdin;
\.


--
-- Data for Name: one_time_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.one_time_tokens (id, user_id, token_type, token_hash, relates_to, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.refresh_tokens (instance_id, id, token, user_id, revoked, created_at, updated_at, parent, session_id) FROM stdin;
00000000-0000-0000-0000-000000000000	1	33jzse3dh5t2	5a6ecfec-c7d6-41af-9432-e49ff3e7842e	f	2026-04-25 17:05:28.34252+00	2026-04-25 17:05:28.34252+00	\N	6ec9c030-28cb-45ba-939d-ea87ce307796
00000000-0000-0000-0000-000000000000	2	gzosbhlk2buh	5a6ecfec-c7d6-41af-9432-e49ff3e7842e	f	2026-04-25 17:17:27.267274+00	2026-04-25 17:17:27.267274+00	\N	6777b862-b82e-4a62-ac14-fa48284919aa
00000000-0000-0000-0000-000000000000	3	icuwdawrwd5e	d58f805f-3c03-4c37-bad6-4e239d0a2514	f	2026-04-25 17:37:47.376493+00	2026-04-25 17:37:47.376493+00	\N	b6efb2c5-082b-4d12-b506-ecaf0e5f25ed
00000000-0000-0000-0000-000000000000	4	eklftzqbfrzg	5b83c241-2553-4462-8aa3-0393ada157a5	f	2026-04-25 17:38:08.606232+00	2026-04-25 17:38:08.606232+00	\N	5128a95b-e764-4b09-a848-f518c7b14d9f
00000000-0000-0000-0000-000000000000	5	rn6g2liukowj	5a6ecfec-c7d6-41af-9432-e49ff3e7842e	t	2026-04-25 17:42:15.067256+00	2026-04-25 18:42:06.075523+00	\N	a27f268e-c693-46c2-854b-b6e586078cb9
00000000-0000-0000-0000-000000000000	6	vahvwrazzcwu	5a6ecfec-c7d6-41af-9432-e49ff3e7842e	t	2026-04-25 18:42:06.082353+00	2026-04-25 18:42:06.457805+00	rn6g2liukowj	a27f268e-c693-46c2-854b-b6e586078cb9
00000000-0000-0000-0000-000000000000	7	rjmfjaqsavpy	5a6ecfec-c7d6-41af-9432-e49ff3e7842e	f	2026-04-25 18:42:06.458225+00	2026-04-25 18:42:06.458225+00	vahvwrazzcwu	a27f268e-c693-46c2-854b-b6e586078cb9
00000000-0000-0000-0000-000000000000	8	57iphad3zmgy	5a6ecfec-c7d6-41af-9432-e49ff3e7842e	f	2026-04-26 01:19:01.747734+00	2026-04-26 01:19:01.747734+00	\N	98a84d93-a0dc-40c3-bd3c-45ba6bf6d696
00000000-0000-0000-0000-000000000000	9	yajn3wmzxrdu	5a6ecfec-c7d6-41af-9432-e49ff3e7842e	f	2026-04-26 01:19:58.974909+00	2026-04-26 01:19:58.974909+00	\N	6f5febce-bcff-4637-8f03-1faffc34701f
00000000-0000-0000-0000-000000000000	10	jxxbvora7rlk	5a6ecfec-c7d6-41af-9432-e49ff3e7842e	f	2026-04-26 01:25:43.393707+00	2026-04-26 01:25:43.393707+00	\N	676dc62d-ffd3-4e33-80de-adb69c3ff746
00000000-0000-0000-0000-000000000000	11	z35bvznb2l5u	5a6ecfec-c7d6-41af-9432-e49ff3e7842e	f	2026-04-26 01:26:13.488838+00	2026-04-26 01:26:13.488838+00	\N	2bf1a494-1bad-4fe3-ae06-2008997fb6d2
00000000-0000-0000-0000-000000000000	12	4wb3rpdpv5c6	5a6ecfec-c7d6-41af-9432-e49ff3e7842e	f	2026-04-26 01:26:18.559062+00	2026-04-26 01:26:18.559062+00	\N	b10c7d17-405c-4c4b-b1c7-8d5e25749624
00000000-0000-0000-0000-000000000000	15	pcg6iddivoft	5a6ecfec-c7d6-41af-9432-e49ff3e7842e	f	2026-04-26 02:02:07.84855+00	2026-04-26 02:02:07.84855+00	\N	9d376ead-4520-4cd3-9538-ddcaba558f10
00000000-0000-0000-0000-000000000000	16	jgosydrkltt2	5a6ecfec-c7d6-41af-9432-e49ff3e7842e	f	2026-04-26 02:06:04.092358+00	2026-04-26 02:06:04.092358+00	\N	3c8dde41-dede-4f34-b640-bed83b7893a7
00000000-0000-0000-0000-000000000000	17	c4o2mcqeaxbu	5a6ecfec-c7d6-41af-9432-e49ff3e7842e	f	2026-04-26 02:09:43.808225+00	2026-04-26 02:09:43.808225+00	\N	594f235c-14b7-4f5e-886c-f179429a531f
00000000-0000-0000-0000-000000000000	18	k6336qyjiyyw	5a6ecfec-c7d6-41af-9432-e49ff3e7842e	f	2026-04-26 02:13:07.313928+00	2026-04-26 02:13:07.313928+00	\N	90cb46a6-0a2e-4ef0-bc6e-0aa8fcc3b5dd
00000000-0000-0000-0000-000000000000	19	33qj27tzcxnn	a6f0d99c-7d0b-4a25-9022-20e39e844680	f	2026-04-26 02:13:25.424407+00	2026-04-26 02:13:25.424407+00	\N	185e81be-9c94-44cf-bed9-1988e681f7ac
00000000-0000-0000-0000-000000000000	20	pwwfacyvf6uw	a6f0d99c-7d0b-4a25-9022-20e39e844680	f	2026-04-26 02:14:59.781658+00	2026-04-26 02:14:59.781658+00	\N	e6a26eb8-fe0a-41ad-9630-2f281d4278ed
00000000-0000-0000-0000-000000000000	21	sa7cbvy75ezj	a6f0d99c-7d0b-4a25-9022-20e39e844680	f	2026-04-26 02:21:55.0231+00	2026-04-26 02:21:55.0231+00	\N	ec3c5c13-77d9-450e-b6a2-2de721de5d1d
00000000-0000-0000-0000-000000000000	22	2luwkles7jvo	a6f0d99c-7d0b-4a25-9022-20e39e844680	f	2026-04-26 02:48:00.817013+00	2026-04-26 02:48:00.817013+00	\N	0eb849d6-06fb-416f-9bf7-8c640d141cc1
00000000-0000-0000-0000-000000000000	23	pefwbxynfvsa	a6f0d99c-7d0b-4a25-9022-20e39e844680	f	2026-04-26 02:52:50.442065+00	2026-04-26 02:52:50.442065+00	\N	35577a29-3d21-4f87-8562-4b9b98cc95d4
00000000-0000-0000-0000-000000000000	24	nntuc5ndjiqg	a6f0d99c-7d0b-4a25-9022-20e39e844680	f	2026-04-26 02:57:38.86688+00	2026-04-26 02:57:38.86688+00	\N	ce73a4fb-6dee-410e-a5bb-9741b685a0d5
00000000-0000-0000-0000-000000000000	25	bah23vai2oyx	a6f0d99c-7d0b-4a25-9022-20e39e844680	f	2026-04-26 02:58:54.505153+00	2026-04-26 02:58:54.505153+00	\N	a4d63cd8-b714-4ef7-b149-056dab186af1
00000000-0000-0000-0000-000000000000	26	s2tz7ik4koh7	a6f0d99c-7d0b-4a25-9022-20e39e844680	f	2026-04-26 02:58:57.65277+00	2026-04-26 02:58:57.65277+00	\N	cf094d3f-cc3a-4158-bbfc-cbd478b1f666
00000000-0000-0000-0000-000000000000	27	o7wgcnxllpgo	a6f0d99c-7d0b-4a25-9022-20e39e844680	f	2026-04-26 02:59:14.966675+00	2026-04-26 02:59:14.966675+00	\N	836ae22e-ac4b-48e8-ba2c-983e0ddff4c8
00000000-0000-0000-0000-000000000000	28	gib22ytgc4sc	a6f0d99c-7d0b-4a25-9022-20e39e844680	f	2026-04-26 02:59:23.58484+00	2026-04-26 02:59:23.58484+00	\N	19784f5b-4732-497e-8925-2097dbf54bd7
00000000-0000-0000-0000-000000000000	29	iverubr64tyf	a6f0d99c-7d0b-4a25-9022-20e39e844680	f	2026-04-26 03:00:29.561388+00	2026-04-26 03:00:29.561388+00	\N	93ffa617-3dab-450a-97ec-04effdf81964
00000000-0000-0000-0000-000000000000	30	b4sgxvb5sabt	a6f0d99c-7d0b-4a25-9022-20e39e844680	f	2026-04-26 03:03:49.875476+00	2026-04-26 03:03:49.875476+00	\N	a0d69cd6-564e-4a01-94f6-1611d472a780
00000000-0000-0000-0000-000000000000	31	3ccckbaecm4k	a6f0d99c-7d0b-4a25-9022-20e39e844680	f	2026-04-26 03:04:05.725005+00	2026-04-26 03:04:05.725005+00	\N	44c90cd0-9d7d-4b8a-ad9f-98b105596cd4
00000000-0000-0000-0000-000000000000	32	wrd4vxmdiv6a	68e1be2f-d559-4837-a9c7-bd6fba6a3431	f	2026-04-26 03:17:13.792838+00	2026-04-26 03:17:13.792838+00	\N	f1582bb9-ee89-49a4-955a-0ea6731ae97d
00000000-0000-0000-0000-000000000000	34	tm2ggvo756yf	68e1be2f-d559-4837-a9c7-bd6fba6a3431	f	2026-04-26 03:20:41.235687+00	2026-04-26 03:20:41.235687+00	\N	ae31225e-c70b-42a7-aaf4-7332eb588fd6
00000000-0000-0000-0000-000000000000	35	f2zuiwg4bdq3	a6f0d99c-7d0b-4a25-9022-20e39e844680	f	2026-04-26 03:23:51.816409+00	2026-04-26 03:23:51.816409+00	\N	7919fb4f-5dbe-4504-9d74-ff97e7f6aeee
00000000-0000-0000-0000-000000000000	37	mj6evxsouarf	2f5f1bc1-e347-4c36-acc9-6d6c816b05f5	f	2026-04-26 03:43:44.237849+00	2026-04-26 03:43:44.237849+00	\N	2567e5ee-c98d-4c1f-b7d4-a44a3dd12617
00000000-0000-0000-0000-000000000000	38	strz4pvx2o3k	2f5f1bc1-e347-4c36-acc9-6d6c816b05f5	f	2026-04-26 03:50:48.391614+00	2026-04-26 03:50:48.391614+00	\N	19ee1ff9-457a-443e-b71e-bc188bcb185b
00000000-0000-0000-0000-000000000000	39	5pkq7zvrwb6o	a6f0d99c-7d0b-4a25-9022-20e39e844680	f	2026-04-26 03:51:24.104693+00	2026-04-26 03:51:24.104693+00	\N	526e587d-4caa-4d21-a2d1-ef8e65afcf11
00000000-0000-0000-0000-000000000000	40	77tykmjheoxi	c5f26541-dff7-4574-9091-358a6c3baf05	f	2026-04-26 03:51:48.877523+00	2026-04-26 03:51:48.877523+00	\N	df78f21a-3a04-4d6e-b99b-61bf4a9178b2
00000000-0000-0000-0000-000000000000	41	jfbqm4ev4fxs	5a6ecfec-c7d6-41af-9432-e49ff3e7842e	f	2026-04-26 03:54:16.299839+00	2026-04-26 03:54:16.299839+00	\N	f356cce1-31d7-4af5-bbaf-b8ff6cb54aa2
00000000-0000-0000-0000-000000000000	42	6vhd4jcyhjlq	5a6ecfec-c7d6-41af-9432-e49ff3e7842e	f	2026-04-26 03:55:44.930073+00	2026-04-26 03:55:44.930073+00	\N	8a261e72-97df-43ea-b112-3b83afb1530c
00000000-0000-0000-0000-000000000000	43	t2qtkudipiue	c5f26541-dff7-4574-9091-358a6c3baf05	f	2026-04-26 04:02:37.135117+00	2026-04-26 04:02:37.135117+00	\N	4eca4246-8fe6-48fd-8a6b-b9d4b977834e
00000000-0000-0000-0000-000000000000	44	gut56wqn7wax	c5f26541-dff7-4574-9091-358a6c3baf05	f	2026-04-26 04:09:23.232532+00	2026-04-26 04:09:23.232532+00	\N	ea0e5a35-f893-4374-8726-b3cd7c628dc5
00000000-0000-0000-0000-000000000000	45	7uuuyfwllpjm	c5f26541-dff7-4574-9091-358a6c3baf05	f	2026-04-26 04:11:59.456001+00	2026-04-26 04:11:59.456001+00	\N	0667b98b-fc92-4322-b7a9-d6bf3209ed87
00000000-0000-0000-0000-000000000000	46	enz25t2osaoq	5a6ecfec-c7d6-41af-9432-e49ff3e7842e	f	2026-04-26 04:12:26.995075+00	2026-04-26 04:12:26.995075+00	\N	be04040c-a288-499c-b708-8492b42de2f8
00000000-0000-0000-0000-000000000000	47	gvhsjqturg2j	c5f26541-dff7-4574-9091-358a6c3baf05	f	2026-04-26 04:12:30.428946+00	2026-04-26 04:12:30.428946+00	\N	33501c3a-3682-4b10-812b-3567a322a989
\.


--
-- Data for Name: saml_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.saml_providers (id, sso_provider_id, entity_id, metadata_xml, metadata_url, attribute_mapping, created_at, updated_at, name_id_format) FROM stdin;
\.


--
-- Data for Name: saml_relay_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.saml_relay_states (id, sso_provider_id, request_id, for_email, redirect_to, created_at, updated_at, flow_state_id) FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.schema_migrations (version) FROM stdin;
20171026211738
20171026211808
20171026211834
20180103212743
20180108183307
20180119214651
20180125194653
00
20210710035447
20210722035447
20210730183235
20210909172000
20210927181326
20211122151130
20211124214934
20211202183645
20220114185221
20220114185340
20220224000811
20220323170000
20220429102000
20220531120530
20220614074223
20220811173540
20221003041349
20221003041400
20221011041400
20221020193600
20221021073300
20221021082433
20221027105023
20221114143122
20221114143410
20221125140132
20221208132122
20221215195500
20221215195800
20221215195900
20230116124310
20230116124412
20230131181311
20230322519590
20230402418590
20230411005111
20230508135423
20230523124323
20230818113222
20230914180801
20231027141322
20231114161723
20231117164230
20240115144230
20240214120130
20240306115329
20240314092811
20240427152123
20240612123726
20240729123726
20240802193726
20240806073726
20241009103726
20250717082212
20250731150234
20250804100000
20250901200500
20250903112500
20250904133000
20250925093508
20251007112900
20251104100000
20251111201300
20251201000000
20260115000000
20260121000000
20260219120000
20260302000000
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sessions (id, user_id, created_at, updated_at, factor_id, aal, not_after, refreshed_at, user_agent, ip, tag, oauth_client_id, refresh_token_hmac_key, refresh_token_counter, scopes) FROM stdin;
6ec9c030-28cb-45ba-939d-ea87ce307796	5a6ecfec-c7d6-41af-9432-e49ff3e7842e	2026-04-25 17:05:28.334612+00	2026-04-25 17:05:28.334612+00	\N	aal1	\N	\N	python-httpx/0.28.1	197.4.220.127	\N	\N	\N	\N	\N
6777b862-b82e-4a62-ac14-fa48284919aa	5a6ecfec-c7d6-41af-9432-e49ff3e7842e	2026-04-25 17:17:27.261605+00	2026-04-25 17:17:27.261605+00	\N	aal1	\N	\N	python-httpx/0.28.1	197.4.220.127	\N	\N	\N	\N	\N
b6efb2c5-082b-4d12-b506-ecaf0e5f25ed	d58f805f-3c03-4c37-bad6-4e239d0a2514	2026-04-25 17:37:47.374269+00	2026-04-25 17:37:47.374269+00	\N	aal1	\N	\N	python-httpx/0.28.1	197.4.220.127	\N	\N	\N	\N	\N
5128a95b-e764-4b09-a848-f518c7b14d9f	5b83c241-2553-4462-8aa3-0393ada157a5	2026-04-25 17:38:08.605374+00	2026-04-25 17:38:08.605374+00	\N	aal1	\N	\N	python-httpx/0.28.1	197.4.220.127	\N	\N	\N	\N	\N
a27f268e-c693-46c2-854b-b6e586078cb9	5a6ecfec-c7d6-41af-9432-e49ff3e7842e	2026-04-25 17:42:15.059194+00	2026-04-25 18:42:06.460556+00	\N	aal1	\N	2026-04-25 18:42:06.460463	python-httpx/0.28.1	102.24.229.5	\N	\N	\N	\N	\N
98a84d93-a0dc-40c3-bd3c-45ba6bf6d696	5a6ecfec-c7d6-41af-9432-e49ff3e7842e	2026-04-26 01:19:01.730896+00	2026-04-26 01:19:01.730896+00	\N	aal1	\N	\N	python-httpx/0.28.1	196.187.147.86	\N	\N	\N	\N	\N
6f5febce-bcff-4637-8f03-1faffc34701f	5a6ecfec-c7d6-41af-9432-e49ff3e7842e	2026-04-26 01:19:58.970301+00	2026-04-26 01:19:58.970301+00	\N	aal1	\N	\N	python-httpx/0.28.1	196.187.147.86	\N	\N	\N	\N	\N
676dc62d-ffd3-4e33-80de-adb69c3ff746	5a6ecfec-c7d6-41af-9432-e49ff3e7842e	2026-04-26 01:25:43.381049+00	2026-04-26 01:25:43.381049+00	\N	aal1	\N	\N	python-httpx/0.28.1	196.187.147.86	\N	\N	\N	\N	\N
2bf1a494-1bad-4fe3-ae06-2008997fb6d2	5a6ecfec-c7d6-41af-9432-e49ff3e7842e	2026-04-26 01:26:13.487512+00	2026-04-26 01:26:13.487512+00	\N	aal1	\N	\N	python-httpx/0.28.1	196.187.147.86	\N	\N	\N	\N	\N
b10c7d17-405c-4c4b-b1c7-8d5e25749624	5a6ecfec-c7d6-41af-9432-e49ff3e7842e	2026-04-26 01:26:18.558035+00	2026-04-26 01:26:18.558035+00	\N	aal1	\N	\N	python-httpx/0.28.1	196.187.147.86	\N	\N	\N	\N	\N
9d376ead-4520-4cd3-9538-ddcaba558f10	5a6ecfec-c7d6-41af-9432-e49ff3e7842e	2026-04-26 02:02:07.841569+00	2026-04-26 02:02:07.841569+00	\N	aal1	\N	\N	python-httpx/0.28.1	196.187.147.86	\N	\N	\N	\N	\N
3c8dde41-dede-4f34-b640-bed83b7893a7	5a6ecfec-c7d6-41af-9432-e49ff3e7842e	2026-04-26 02:06:04.083653+00	2026-04-26 02:06:04.083653+00	\N	aal1	\N	\N	python-httpx/0.28.1	196.187.147.86	\N	\N	\N	\N	\N
594f235c-14b7-4f5e-886c-f179429a531f	5a6ecfec-c7d6-41af-9432-e49ff3e7842e	2026-04-26 02:09:43.804223+00	2026-04-26 02:09:43.804223+00	\N	aal1	\N	\N	python-httpx/0.28.1	196.187.147.86	\N	\N	\N	\N	\N
90cb46a6-0a2e-4ef0-bc6e-0aa8fcc3b5dd	5a6ecfec-c7d6-41af-9432-e49ff3e7842e	2026-04-26 02:13:07.303888+00	2026-04-26 02:13:07.303888+00	\N	aal1	\N	\N	python-httpx/0.28.1	196.187.147.86	\N	\N	\N	\N	\N
185e81be-9c94-44cf-bed9-1988e681f7ac	a6f0d99c-7d0b-4a25-9022-20e39e844680	2026-04-26 02:13:25.418895+00	2026-04-26 02:13:25.418895+00	\N	aal1	\N	\N	python-httpx/0.28.1	196.187.147.86	\N	\N	\N	\N	\N
e6a26eb8-fe0a-41ad-9630-2f281d4278ed	a6f0d99c-7d0b-4a25-9022-20e39e844680	2026-04-26 02:14:59.779782+00	2026-04-26 02:14:59.779782+00	\N	aal1	\N	\N	python-httpx/0.28.1	196.187.147.86	\N	\N	\N	\N	\N
ec3c5c13-77d9-450e-b6a2-2de721de5d1d	a6f0d99c-7d0b-4a25-9022-20e39e844680	2026-04-26 02:21:55.006913+00	2026-04-26 02:21:55.006913+00	\N	aal1	\N	\N	python-httpx/0.28.1	196.187.147.86	\N	\N	\N	\N	\N
0eb849d6-06fb-416f-9bf7-8c640d141cc1	a6f0d99c-7d0b-4a25-9022-20e39e844680	2026-04-26 02:48:00.810075+00	2026-04-26 02:48:00.810075+00	\N	aal1	\N	\N	python-httpx/0.28.1	196.187.147.86	\N	\N	\N	\N	\N
35577a29-3d21-4f87-8562-4b9b98cc95d4	a6f0d99c-7d0b-4a25-9022-20e39e844680	2026-04-26 02:52:50.437687+00	2026-04-26 02:52:50.437687+00	\N	aal1	\N	\N	python-httpx/0.28.1	196.187.147.86	\N	\N	\N	\N	\N
ce73a4fb-6dee-410e-a5bb-9741b685a0d5	a6f0d99c-7d0b-4a25-9022-20e39e844680	2026-04-26 02:57:38.854804+00	2026-04-26 02:57:38.854804+00	\N	aal1	\N	\N	python-httpx/0.28.1	196.187.147.86	\N	\N	\N	\N	\N
a4d63cd8-b714-4ef7-b149-056dab186af1	a6f0d99c-7d0b-4a25-9022-20e39e844680	2026-04-26 02:58:54.503361+00	2026-04-26 02:58:54.503361+00	\N	aal1	\N	\N	python-httpx/0.28.1	196.187.147.86	\N	\N	\N	\N	\N
cf094d3f-cc3a-4158-bbfc-cbd478b1f666	a6f0d99c-7d0b-4a25-9022-20e39e844680	2026-04-26 02:58:57.651736+00	2026-04-26 02:58:57.651736+00	\N	aal1	\N	\N	python-httpx/0.28.1	196.187.147.86	\N	\N	\N	\N	\N
836ae22e-ac4b-48e8-ba2c-983e0ddff4c8	a6f0d99c-7d0b-4a25-9022-20e39e844680	2026-04-26 02:59:14.955066+00	2026-04-26 02:59:14.955066+00	\N	aal1	\N	\N	python-httpx/0.28.1	196.187.147.86	\N	\N	\N	\N	\N
19784f5b-4732-497e-8925-2097dbf54bd7	a6f0d99c-7d0b-4a25-9022-20e39e844680	2026-04-26 02:59:23.583583+00	2026-04-26 02:59:23.583583+00	\N	aal1	\N	\N	python-httpx/0.28.1	196.187.147.86	\N	\N	\N	\N	\N
93ffa617-3dab-450a-97ec-04effdf81964	a6f0d99c-7d0b-4a25-9022-20e39e844680	2026-04-26 03:00:29.559641+00	2026-04-26 03:00:29.559641+00	\N	aal1	\N	\N	python-httpx/0.28.1	196.187.147.86	\N	\N	\N	\N	\N
a0d69cd6-564e-4a01-94f6-1611d472a780	a6f0d99c-7d0b-4a25-9022-20e39e844680	2026-04-26 03:03:49.866743+00	2026-04-26 03:03:49.866743+00	\N	aal1	\N	\N	python-httpx/0.28.1	196.187.147.86	\N	\N	\N	\N	\N
44c90cd0-9d7d-4b8a-ad9f-98b105596cd4	a6f0d99c-7d0b-4a25-9022-20e39e844680	2026-04-26 03:04:05.72371+00	2026-04-26 03:04:05.72371+00	\N	aal1	\N	\N	python-httpx/0.28.1	196.187.147.86	\N	\N	\N	\N	\N
f1582bb9-ee89-49a4-955a-0ea6731ae97d	68e1be2f-d559-4837-a9c7-bd6fba6a3431	2026-04-26 03:17:13.778759+00	2026-04-26 03:17:13.778759+00	\N	aal1	\N	\N	python-httpx/0.28.1	196.187.153.131	\N	\N	\N	\N	\N
ae31225e-c70b-42a7-aaf4-7332eb588fd6	68e1be2f-d559-4837-a9c7-bd6fba6a3431	2026-04-26 03:20:41.226331+00	2026-04-26 03:20:41.226331+00	\N	aal1	\N	\N	python-httpx/0.28.1	196.187.153.131	\N	\N	\N	\N	\N
7919fb4f-5dbe-4504-9d74-ff97e7f6aeee	a6f0d99c-7d0b-4a25-9022-20e39e844680	2026-04-26 03:23:51.809505+00	2026-04-26 03:23:51.809505+00	\N	aal1	\N	\N	python-httpx/0.28.1	196.187.147.86	\N	\N	\N	\N	\N
2567e5ee-c98d-4c1f-b7d4-a44a3dd12617	2f5f1bc1-e347-4c36-acc9-6d6c816b05f5	2026-04-26 03:43:44.233654+00	2026-04-26 03:43:44.233654+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	196.187.147.86	\N	\N	\N	\N	\N
19ee1ff9-457a-443e-b71e-bc188bcb185b	2f5f1bc1-e347-4c36-acc9-6d6c816b05f5	2026-04-26 03:50:48.377933+00	2026-04-26 03:50:48.377933+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	196.187.147.86	\N	\N	\N	\N	\N
526e587d-4caa-4d21-a2d1-ef8e65afcf11	a6f0d99c-7d0b-4a25-9022-20e39e844680	2026-04-26 03:51:24.103176+00	2026-04-26 03:51:24.103176+00	\N	aal1	\N	\N	python-httpx/0.28.1	196.187.147.86	\N	\N	\N	\N	\N
df78f21a-3a04-4d6e-b99b-61bf4a9178b2	c5f26541-dff7-4574-9091-358a6c3baf05	2026-04-26 03:51:48.876172+00	2026-04-26 03:51:48.876172+00	\N	aal1	\N	\N	python-httpx/0.28.1	196.187.147.86	\N	\N	\N	\N	\N
f356cce1-31d7-4af5-bbaf-b8ff6cb54aa2	5a6ecfec-c7d6-41af-9432-e49ff3e7842e	2026-04-26 03:54:16.289997+00	2026-04-26 03:54:16.289997+00	\N	aal1	\N	\N	python-httpx/0.28.1	196.187.147.86	\N	\N	\N	\N	\N
8a261e72-97df-43ea-b112-3b83afb1530c	5a6ecfec-c7d6-41af-9432-e49ff3e7842e	2026-04-26 03:55:44.923294+00	2026-04-26 03:55:44.923294+00	\N	aal1	\N	\N	python-httpx/0.28.1	196.187.147.86	\N	\N	\N	\N	\N
4eca4246-8fe6-48fd-8a6b-b9d4b977834e	c5f26541-dff7-4574-9091-358a6c3baf05	2026-04-26 04:02:37.128177+00	2026-04-26 04:02:37.128177+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	41.229.134.121	\N	\N	\N	\N	\N
ea0e5a35-f893-4374-8726-b3cd7c628dc5	c5f26541-dff7-4574-9091-358a6c3baf05	2026-04-26 04:09:23.220893+00	2026-04-26 04:09:23.220893+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	41.229.134.121	\N	\N	\N	\N	\N
0667b98b-fc92-4322-b7a9-d6bf3209ed87	c5f26541-dff7-4574-9091-358a6c3baf05	2026-04-26 04:11:59.441504+00	2026-04-26 04:11:59.441504+00	\N	aal1	\N	\N	python-httpx/0.28.1	196.187.147.86	\N	\N	\N	\N	\N
be04040c-a288-499c-b708-8492b42de2f8	5a6ecfec-c7d6-41af-9432-e49ff3e7842e	2026-04-26 04:12:26.981405+00	2026-04-26 04:12:26.981405+00	\N	aal1	\N	\N	python-httpx/0.28.1	196.187.147.86	\N	\N	\N	\N	\N
33501c3a-3682-4b10-812b-3567a322a989	c5f26541-dff7-4574-9091-358a6c3baf05	2026-04-26 04:12:30.427664+00	2026-04-26 04:12:30.427664+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	41.229.134.121	\N	\N	\N	\N	\N
\.


--
-- Data for Name: sso_domains; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sso_domains (id, sso_provider_id, domain, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: sso_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sso_providers (id, resource_id, created_at, updated_at, disabled) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, invited_at, confirmation_token, confirmation_sent_at, recovery_token, recovery_sent_at, email_change_token_new, email_change, email_change_sent_at, last_sign_in_at, raw_app_meta_data, raw_user_meta_data, is_super_admin, created_at, updated_at, phone, phone_confirmed_at, phone_change, phone_change_token, phone_change_sent_at, email_change_token_current, email_change_confirm_status, banned_until, reauthentication_token, reauthentication_sent_at, is_sso_user, deleted_at, is_anonymous) FROM stdin;
00000000-0000-0000-0000-000000000000	a6f0d99c-7d0b-4a25-9022-20e39e844680	authenticated	authenticated	hassenhomri1@gmail.com	$2a$10$.nwd4M7Fkn2fc0mMEL3X4eK4njl0wWQO4zp5.kbs/6RZWe0HCoSh6	2026-04-26 01:38:15.461471+00	\N		\N		\N			\N	2026-04-26 03:51:24.103072+00	{"provider": "email", "providers": ["email"]}	{"email_verified": true}	\N	2026-04-26 01:38:15.450785+00	2026-04-26 03:51:24.105645+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	8cf6f14a-e9c3-482a-995b-d7408be90592	authenticated	authenticated	haho1@gmail.com	$2a$10$jQrxQwRBxM/aV4854apuK.Wx2zN1Pk43jSYj2Jy8FeXJWwKN931cG	2026-04-26 03:16:19.153114+00	\N		\N		\N			\N	\N	{"provider": "email", "providers": ["email"]}	{"email_verified": true}	\N	2026-04-26 03:16:19.143144+00	2026-04-26 03:16:19.153987+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	d58f805f-3c03-4c37-bad6-4e239d0a2514	authenticated	authenticated	hassen2@gmail.com	$2a$10$u1oVwP9Lmtfk1RPjD9ziEe.A5keR8pIhdAoImlQDQsPgWyYnqmJEu	2026-04-25 17:37:47.368643+00	\N		\N		\N			\N	2026-04-25 17:37:47.374098+00	{"provider": "email", "providers": ["email"]}	{"sub": "d58f805f-3c03-4c37-bad6-4e239d0a2514", "email": "hassen2@gmail.com", "email_verified": true, "phone_verified": false}	\N	2026-04-25 17:37:47.350467+00	2026-04-25 17:37:47.378177+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	9f5b54c4-68dc-46c3-be6e-53ab97759716	authenticated	authenticated	hahohaho@gmail.com	$2a$10$Iue/fE8yGTYA9FJiIZyTY.3ZLZH.5by3T6pLorDWhUyQgvyGytQY6	2026-04-26 03:17:00.858216+00	\N		\N		\N			\N	\N	{"provider": "email", "providers": ["email"]}	{"email_verified": true}	\N	2026-04-26 03:17:00.855584+00	2026-04-26 03:17:00.858938+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	68e1be2f-d559-4837-a9c7-bd6fba6a3431	authenticated	authenticated	admin@ucar.tn	$2a$10$bbliobhamZ.bi4gXahDYYOyAeMxfdufdyebs6RCBZHzw/DTZ0sS9m	2026-04-26 03:11:57.864992+00	\N		\N		\N			\N	2026-04-26 03:20:41.226225+00	{"provider": "email", "providers": ["email"]}	{"email_verified": true}	\N	2026-04-26 03:11:57.837714+00	2026-04-26 03:20:41.239824+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	2f5f1bc1-e347-4c36-acc9-6d6c816b05f5	authenticated	authenticated	shady@gmail.com	$2a$10$LySluZudkR02CKijfDVW9.UW1EVcoQYpIgOMK/h42UXrfQyjSArni	2026-04-26 00:39:08.291317+00	\N		\N		\N			\N	2026-04-26 03:50:48.377236+00	{"provider": "email", "providers": ["email"]}	{"email_verified": true}	\N	2026-04-26 00:39:08.266504+00	2026-04-26 03:50:48.393368+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	5a6ecfec-c7d6-41af-9432-e49ff3e7842e	authenticated	authenticated	hassen@gmail.com	$2a$10$LJj1uCW/HKHbg/u82vPS7.1an/O9j1XPcTJis32YT23P0NZkEiPom	2026-04-25 17:04:58.616033+00	\N		\N		\N			\N	2026-04-26 04:12:26.981317+00	{"provider": "email", "providers": ["email"]}	{"email_verified": true}	\N	2026-04-25 17:04:58.596502+00	2026-04-26 04:12:26.997796+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	c5f26541-dff7-4574-9091-358a6c3baf05	authenticated	authenticated	admin@admin.com	$2a$10$AkhOe4JaM39SzBSOTQ1biO/Sn334efdT6DIRrVGDaXC8wgu3lmJ1K	2026-04-25 14:33:54.398801+00	\N		\N		\N			\N	2026-04-26 04:12:30.427559+00	{"provider": "email", "providers": ["email"]}	{"email_verified": true}	\N	2026-04-25 14:33:54.382068+00	2026-04-26 04:12:30.42992+00	\N	\N			\N		0	\N		\N	f	\N	f
\N	4e900029-58bf-48cc-9187-58d3b30dd55f	authenticated	authenticated	superadmin@ucar.tn	$2a$06$rB.gjbARhUu9.LJYhy8Y/.XDyeZtHQMw.jBl5ihW7VED0J9wP4eAe	2026-04-26 01:09:07.609228+00	\N		\N	\N	\N	\N	\N	\N	\N	{"provider": "email", "providers": ["email"]}	{"full_name": "Super Admin"}	f	\N	\N	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	5b83c241-2553-4462-8aa3-0393ada157a5	authenticated	authenticated	hassen22@gmail.com	$2a$10$Pjk4I9QR2hgB79NllZRLVuvsaIREIb.i9wu.AAHS7T/LYASaKay6.	2026-04-25 17:38:08.602624+00	\N		\N		\N			\N	2026-04-25 17:38:08.605287+00	{"provider": "email", "providers": ["email"]}	{"sub": "5b83c241-2553-4462-8aa3-0393ada157a5", "email": "hassen22@gmail.com", "email_verified": true, "phone_verified": false}	\N	2026-04-25 17:38:08.59796+00	2026-04-25 17:38:08.607122+00	\N	\N			\N		0	\N		\N	f	\N	f
\.


--
-- Data for Name: webauthn_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.webauthn_challenges (id, user_id, challenge_type, session_data, created_at, expires_at) FROM stdin;
\.


--
-- Data for Name: webauthn_credentials; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.webauthn_credentials (id, user_id, credential_id, public_key, attestation_type, aaguid, sign_count, transports, backup_eligible, backed_up, friendly_name, created_at, updated_at, last_used_at) FROM stdin;
\.


--
-- Data for Name: ai_insights; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ai_insights (id, institution_id, kpi_id, type, title, description, value, confidence, created_at) FROM stdin;
\.


--
-- Data for Name: alerts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.alerts (id, institution_id, kpi_id, threshold, actual_value, severity, created_at) FROM stdin;
\.


--
-- Data for Name: institutions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.institutions (id, name, code) FROM stdin;
1e506ddd-d08c-44c3-ad4a-7c0d2d829f1e	University A	UNI-A
8d351c6f-6f4a-4e01-9081-c30932db8182	University of Carthage	UCAR
5e0bad4f-2b61-4de3-8111-43203c09ae0b	UCAR Headquarters	UCAR-HQ
1c04440e-6673-4c5c-b040-51b186b38a86	ISET Charguia	ISET-CHAR
72d462e6-0a90-443a-90fa-dffddecd2fdb	ESCT	ESCT
7fd37699-1e3c-42af-af4c-643c4b7e9510	IPEIT	IPEIT
de593827-e016-4882-bb1b-a1fed2556756	IPEIEM	IPEIEM
8d1d0b4f-dd62-4374-90ca-d174dcdd57ac	ISSATS	ISSATS
de51595d-1f99-4544-a131-d08e0dceb7e2	ISSAT Manouba	ISSAT-MAN
df11976b-9cd9-4fb1-a0db-af20104e1e69	ISTMT	ISTMT
\.


--
-- Data for Name: kpi_definitions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.kpi_definitions (id, name, code, category, unit) FROM stdin;
bd27283a-985f-4006-ada1-23b7328afd6d	Success Rate	acad_success	Academic	%
4fe20bda-0c54-4f70-b4b7-bfab711b0142	Attendance Rate	acad_attendance	Academic	%
1cf0113f-e7a2-48d9-af82-34af97cd7711	Dropout Rate	acad_dropout	Academic	%
b9fdae0f-78ec-45cc-928d-1e747876278e	Pedagogical Progression	acad_progression	Academic	%
9c7451e4-1333-4bed-9ec4-c11fe8da0865	Employability Rate	emp_rate	Employment	%
571c9ef7-5442-42fd-ab93-5a9d9842e11e	Time to Employment	emp_time	Employment	months
c48a3cf9-4e56-4a1e-8aea-99f7b3cca7ce	Budget Execution Rate	fin_budget_exec	Finance	%
e6a897ca-1742-434c-9a7c-14a32545b064	Cost per Student	fin_cost_student	Finance	TND
57c3c5d1-8374-4601-b437-2977d9013457	Allocated vs Consumed Budget	fin_budget_compare	Finance	TND
61214382-5cf3-4336-88fb-65e61c88a3da	Energy Consumption	esg_energy	ESG	kWh
62b26a05-ddac-4b02-80b1-c7a500feef95	Carbon Footprint	esg_carbon	ESG	tCO2e
8c27c34d-5727-4cb9-a7ed-2987358ade55	Recycling Rate	esg_recycling	ESG	%
1789baf9-4896-4e00-9e0c-fa3c458bc96e	Campus Accessibility	esg_accessibility	ESG	score
91aa4d1d-0a24-47ef-816c-680f7449d766	Absenteeism Rate	hr_absenteeism	HR	%
975bd0d7-4e18-4487-bd8b-1fd29055d5ee	Teaching Load	hr_teaching_load	HR	hours
3bacbc58-e794-42e4-8fda-6d3480e616bb	Team Stability	hr_stability	HR	%
056029f2-4195-4797-b45f-f67c17fae28e	Number of Publications	res_pubs	Research	count
d9b0bc86-2812-4b84-a525-8ca4a6f7dcaa	Funding Secured	res_funding	Research	TND
6db2428c-3417-4da6-9abd-be52fd255f13	Patents Filed	res_patents	Research	count
25a965ca-f54a-49e8-8088-7307a679f2d6	Classroom Occupancy Rate	inf_occupancy	Infrastructure	%
d3c68b9e-79f0-459d-9dcb-99b4c9498f38	IT Equipment Status	inf_it_status	Infrastructure	score
ba7db54c-2d27-4296-b722-66c9b0e87e19	Active Agreements	part_agreements	Partnerships	count
093798c0-c892-498b-b887-ffe2b29f7cc6	International Mobility	part_mobility	Partnerships	count
f84c7f2e-f45d-4011-8f83-75fa33b2a027	Total Students	ACAD_01	Academic	\N
0f1a9642-a470-4877-8a80-03ec68a554e6	Repeat Rate	ACAD_05	Academic	\N
17452181-e28a-4f21-8939-660b89286880	Budget Execution	FIN_01	Finance	\N
f49ee23c-aa92-4927-81cf-648587c88b30	Research Papers	RES_01	Research	\N
bd8926a3-87d1-4f67-b23f-374f8748eddb	Faculty Count	HR_01	HR	\N
45bbd44d-5281-453b-aed8-5874d75cdb2c	Classroom Utilization	INF_01	Infrastructure	\N
\.


--
-- Data for Name: kpi_values; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.kpi_values (id, institution_id, kpi_id, value, period_date, created_at) FROM stdin;
b18a2ac8-df35-436c-9a1e-d3e0e24a06f6	1e506ddd-d08c-44c3-ad4a-7c0d2d829f1e	f84c7f2e-f45d-4011-8f83-75fa33b2a027	2003	2023-01-01	2026-04-26 03:54:49.415986+00
f7b0d961-995a-4328-885e-36ef29aa737a	1e506ddd-d08c-44c3-ad4a-7c0d2d829f1e	f84c7f2e-f45d-4011-8f83-75fa33b2a027	1995	2023-02-01	2026-04-26 03:54:49.713333+00
94b27790-fe38-432e-98dd-07ec64461a81	1e506ddd-d08c-44c3-ad4a-7c0d2d829f1e	f84c7f2e-f45d-4011-8f83-75fa33b2a027	2001	2023-03-01	2026-04-26 03:54:49.930673+00
1f578476-a45c-4bf9-9951-50eb0818e277	1e506ddd-d08c-44c3-ad4a-7c0d2d829f1e	f84c7f2e-f45d-4011-8f83-75fa33b2a027	1997	2023-04-01	2026-04-26 03:54:50.131183+00
b898e312-a5b3-499b-bec7-00c0b43170ec	1e506ddd-d08c-44c3-ad4a-7c0d2d829f1e	f84c7f2e-f45d-4011-8f83-75fa33b2a027	2004	2023-05-01	2026-04-26 03:54:50.333942+00
31a130ad-606d-471b-b25b-67c5f6697afc	1e506ddd-d08c-44c3-ad4a-7c0d2d829f1e	f84c7f2e-f45d-4011-8f83-75fa33b2a027	2001	2023-06-01	2026-04-26 03:54:50.53496+00
9b97a2b3-9b2d-4f48-b865-e93ca181bcc3	1e506ddd-d08c-44c3-ad4a-7c0d2d829f1e	bd27283a-985f-4006-ada1-23b7328afd6d	78	2023-01-01	2026-04-26 03:54:50.746904+00
34c0b12b-925a-467b-8c53-c65402ecae0f	1e506ddd-d08c-44c3-ad4a-7c0d2d829f1e	bd27283a-985f-4006-ada1-23b7328afd6d	78	2023-02-01	2026-04-26 03:54:50.955881+00
bd0448eb-61a8-445b-b06f-978570021974	1e506ddd-d08c-44c3-ad4a-7c0d2d829f1e	bd27283a-985f-4006-ada1-23b7328afd6d	72	2023-03-01	2026-04-26 03:54:51.150634+00
7dd97b97-810f-4e22-9e41-96f88b32049b	1e506ddd-d08c-44c3-ad4a-7c0d2d829f1e	bd27283a-985f-4006-ada1-23b7328afd6d	76	2023-04-01	2026-04-26 03:54:51.460995+00
76c91886-1369-4891-ba00-075d1af4e729	1e506ddd-d08c-44c3-ad4a-7c0d2d829f1e	bd27283a-985f-4006-ada1-23b7328afd6d	91	2023-05-01	2026-04-26 03:54:51.769609+00
7eb816d7-be73-4197-b94f-b4e05bcd6643	1e506ddd-d08c-44c3-ad4a-7c0d2d829f1e	bd27283a-985f-4006-ada1-23b7328afd6d	73	2023-06-01	2026-04-26 03:54:51.969072+00
d533057a-ead9-465f-9d66-04da19c2d4a6	1e506ddd-d08c-44c3-ad4a-7c0d2d829f1e	1cf0113f-e7a2-48d9-af82-34af97cd7711	11	2023-01-01	2026-04-26 03:54:52.167803+00
cbd4e301-d4b0-441c-941f-e69f6621c2d8	1e506ddd-d08c-44c3-ad4a-7c0d2d829f1e	1cf0113f-e7a2-48d9-af82-34af97cd7711	6	2023-02-01	2026-04-26 03:54:52.378862+00
a2f04436-ee59-4a3c-ad24-37a2b63f80c3	1e506ddd-d08c-44c3-ad4a-7c0d2d829f1e	1cf0113f-e7a2-48d9-af82-34af97cd7711	9	2023-03-01	2026-04-26 03:54:52.584181+00
97911b90-7d14-4cb9-b7b9-80c4e99cdbc9	1e506ddd-d08c-44c3-ad4a-7c0d2d829f1e	1cf0113f-e7a2-48d9-af82-34af97cd7711	18	2023-04-01	2026-04-26 03:54:52.789944+00
00601d51-bb2d-44cc-a24a-c3fee66b3472	1e506ddd-d08c-44c3-ad4a-7c0d2d829f1e	1cf0113f-e7a2-48d9-af82-34af97cd7711	22	2023-05-01	2026-04-26 03:54:52.993478+00
150cadf4-449d-4094-906f-45c83f647501	1e506ddd-d08c-44c3-ad4a-7c0d2d829f1e	1cf0113f-e7a2-48d9-af82-34af97cd7711	15	2023-06-01	2026-04-26 03:54:53.197016+00
c3c12633-cec6-45e8-97c9-440b4a64e5e8	1e506ddd-d08c-44c3-ad4a-7c0d2d829f1e	4fe20bda-0c54-4f70-b4b7-bfab711b0142	84	2023-01-01	2026-04-26 03:54:53.828829+00
65e1b39f-08ac-425d-ae2b-a91d1d633b7e	1e506ddd-d08c-44c3-ad4a-7c0d2d829f1e	4fe20bda-0c54-4f70-b4b7-bfab711b0142	79	2023-02-01	2026-04-26 03:54:54.027278+00
ec60a4d7-e6eb-4905-8708-a5969418fba8	1e506ddd-d08c-44c3-ad4a-7c0d2d829f1e	4fe20bda-0c54-4f70-b4b7-bfab711b0142	77	2023-03-01	2026-04-26 03:54:54.235826+00
6a52fdc1-9abb-41e1-95a2-ec6aa8bb9eaa	1e506ddd-d08c-44c3-ad4a-7c0d2d829f1e	4fe20bda-0c54-4f70-b4b7-bfab711b0142	88	2023-04-01	2026-04-26 03:54:54.424267+00
c55271cb-dcf3-4585-b079-208a2f633e8c	1e506ddd-d08c-44c3-ad4a-7c0d2d829f1e	4fe20bda-0c54-4f70-b4b7-bfab711b0142	76	2023-05-01	2026-04-26 03:54:54.644831+00
10124ac3-62f2-40ec-a346-e7f5ff7866af	1e506ddd-d08c-44c3-ad4a-7c0d2d829f1e	4fe20bda-0c54-4f70-b4b7-bfab711b0142	72	2023-06-01	2026-04-26 03:54:54.847223+00
1cf433a9-710f-426e-bd29-a16fc96ad989	1e506ddd-d08c-44c3-ad4a-7c0d2d829f1e	0f1a9642-a470-4877-8a80-03ec68a554e6	10	2023-01-01	2026-04-26 03:54:55.051573+00
2725a0ca-d859-43cc-a4e1-24ba866c15e9	1e506ddd-d08c-44c3-ad4a-7c0d2d829f1e	0f1a9642-a470-4877-8a80-03ec68a554e6	12	2023-02-01	2026-04-26 03:54:55.250618+00
fc7aeb4d-1caf-42eb-ab52-f6c0439d507f	1e506ddd-d08c-44c3-ad4a-7c0d2d829f1e	0f1a9642-a470-4877-8a80-03ec68a554e6	15	2023-03-01	2026-04-26 03:54:55.451833+00
033bb74c-d3b9-42f7-897f-24b3a38a737a	1e506ddd-d08c-44c3-ad4a-7c0d2d829f1e	0f1a9642-a470-4877-8a80-03ec68a554e6	18	2023-04-01	2026-04-26 03:54:56.111164+00
e8326cc1-8cf7-4342-975c-20d940c79133	1e506ddd-d08c-44c3-ad4a-7c0d2d829f1e	0f1a9642-a470-4877-8a80-03ec68a554e6	21	2023-05-01	2026-04-26 03:54:56.38776+00
d9132326-88bb-4067-a212-4dfbec729882	1e506ddd-d08c-44c3-ad4a-7c0d2d829f1e	0f1a9642-a470-4877-8a80-03ec68a554e6	13	2023-06-01	2026-04-26 03:54:56.577435+00
b560b04f-cef0-4d15-8dea-a0394e74047a	1e506ddd-d08c-44c3-ad4a-7c0d2d829f1e	17452181-e28a-4f21-8939-660b89286880	74	2023-01-01	2026-04-26 03:54:56.786876+00
f30b5171-0af6-425b-9191-7168ab797e81	1e506ddd-d08c-44c3-ad4a-7c0d2d829f1e	17452181-e28a-4f21-8939-660b89286880	72	2023-02-01	2026-04-26 03:54:56.983572+00
2c5b8d80-4d50-4b6d-a0f2-3f04ddd8a548	1e506ddd-d08c-44c3-ad4a-7c0d2d829f1e	17452181-e28a-4f21-8939-660b89286880	76	2023-03-01	2026-04-26 03:54:57.202888+00
bf4751a7-7ad1-4f58-8ff6-fb128d256766	1e506ddd-d08c-44c3-ad4a-7c0d2d829f1e	17452181-e28a-4f21-8939-660b89286880	79	2023-04-01	2026-04-26 03:54:57.387169+00
5ee3dd74-8048-433a-924a-44af4c661d8c	1e506ddd-d08c-44c3-ad4a-7c0d2d829f1e	17452181-e28a-4f21-8939-660b89286880	64	2023-05-01	2026-04-26 03:54:57.585017+00
7816fc89-f8c4-40ac-80b2-73e86109bb2a	1e506ddd-d08c-44c3-ad4a-7c0d2d829f1e	17452181-e28a-4f21-8939-660b89286880	82	2023-06-01	2026-04-26 03:54:57.767419+00
526e6fa9-963e-4c2f-b6a3-f9e0f2d210df	1e506ddd-d08c-44c3-ad4a-7c0d2d829f1e	62b26a05-ddac-4b02-80b1-c7a500feef95	60	2023-01-01	2026-04-26 03:54:57.960156+00
d6b76dcb-f23f-4668-a2e8-3f0fffbd012f	1e506ddd-d08c-44c3-ad4a-7c0d2d829f1e	62b26a05-ddac-4b02-80b1-c7a500feef95	59	2023-02-01	2026-04-26 03:54:58.139043+00
59df4543-50e5-4634-a0e1-03421172be10	1e506ddd-d08c-44c3-ad4a-7c0d2d829f1e	62b26a05-ddac-4b02-80b1-c7a500feef95	61	2023-03-01	2026-04-26 03:54:58.324373+00
cba8531b-1ade-4120-b948-1488857afc74	1e506ddd-d08c-44c3-ad4a-7c0d2d829f1e	62b26a05-ddac-4b02-80b1-c7a500feef95	62	2023-04-01	2026-04-26 03:54:58.504346+00
35c10f2b-7af4-4638-9f24-c7334c09b8d7	1e506ddd-d08c-44c3-ad4a-7c0d2d829f1e	62b26a05-ddac-4b02-80b1-c7a500feef95	70	2023-05-01	2026-04-26 03:54:58.685186+00
6ef4953d-825a-448c-8aaa-0be78dd30c6e	1e506ddd-d08c-44c3-ad4a-7c0d2d829f1e	62b26a05-ddac-4b02-80b1-c7a500feef95	69	2023-06-01	2026-04-26 03:54:58.887942+00
e8c10339-a1dd-4aa5-abf4-c475c1101606	1e506ddd-d08c-44c3-ad4a-7c0d2d829f1e	f49ee23c-aa92-4927-81cf-648587c88b30	56	2023-01-01	2026-04-26 03:54:59.079851+00
e564dfc2-bb11-455e-8fe0-47155852c1ad	1e506ddd-d08c-44c3-ad4a-7c0d2d829f1e	f49ee23c-aa92-4927-81cf-648587c88b30	62	2023-02-01	2026-04-26 03:54:59.290429+00
57cff62c-82e7-450f-bf41-306cb29b3cca	1e506ddd-d08c-44c3-ad4a-7c0d2d829f1e	f49ee23c-aa92-4927-81cf-648587c88b30	68	2023-03-01	2026-04-26 03:54:59.477842+00
ebae346b-e40c-4ab7-9266-99d94f46d10c	1e506ddd-d08c-44c3-ad4a-7c0d2d829f1e	f49ee23c-aa92-4927-81cf-648587c88b30	67	2023-04-01	2026-04-26 03:54:59.678763+00
98a57fb8-a598-46c7-9cdd-61308cd2a285	1e506ddd-d08c-44c3-ad4a-7c0d2d829f1e	f49ee23c-aa92-4927-81cf-648587c88b30	71	2023-05-01	2026-04-26 03:54:59.871539+00
37a9d3d8-b4a6-4317-8b94-23d24c844502	1e506ddd-d08c-44c3-ad4a-7c0d2d829f1e	f49ee23c-aa92-4927-81cf-648587c88b30	73	2023-06-01	2026-04-26 03:55:00.055804+00
31754f85-e0ee-408e-83e9-83404a2ab98d	1e506ddd-d08c-44c3-ad4a-7c0d2d829f1e	bd8926a3-87d1-4f67-b23f-374f8748eddb	62	2023-01-01	2026-04-26 03:55:00.311054+00
522236df-c2bf-4dd6-a314-a1eaf58b4688	1e506ddd-d08c-44c3-ad4a-7c0d2d829f1e	bd8926a3-87d1-4f67-b23f-374f8748eddb	55	2023-02-01	2026-04-26 03:55:00.506749+00
af9e5795-f1d2-4f75-b120-44140f671370	1e506ddd-d08c-44c3-ad4a-7c0d2d829f1e	bd8926a3-87d1-4f67-b23f-374f8748eddb	53	2023-03-01	2026-04-26 03:55:00.722015+00
f515e52b-90e2-4283-81a1-cf70e17b161a	1e506ddd-d08c-44c3-ad4a-7c0d2d829f1e	bd8926a3-87d1-4f67-b23f-374f8748eddb	60	2023-04-01	2026-04-26 03:55:00.928311+00
b197e7dc-da00-4fbd-9813-205b690df5d9	1e506ddd-d08c-44c3-ad4a-7c0d2d829f1e	bd8926a3-87d1-4f67-b23f-374f8748eddb	63	2023-05-01	2026-04-26 03:55:01.114649+00
7ca007b7-ab4d-4ad7-af17-59104f772eaa	1e506ddd-d08c-44c3-ad4a-7c0d2d829f1e	bd8926a3-87d1-4f67-b23f-374f8748eddb	59	2023-06-01	2026-04-26 03:55:01.301649+00
e141268a-4f2d-4c76-9868-c49bdc68ac1e	1e506ddd-d08c-44c3-ad4a-7c0d2d829f1e	45bbd44d-5281-453b-aed8-5874d75cdb2c	60	2023-01-01	2026-04-26 03:55:01.48307+00
51100b1e-f689-4a99-a6c6-7689adb0070f	1e506ddd-d08c-44c3-ad4a-7c0d2d829f1e	45bbd44d-5281-453b-aed8-5874d75cdb2c	64	2023-02-01	2026-04-26 03:55:01.680202+00
ec290de0-5e52-4b9e-b456-0102b3ee78a8	1e506ddd-d08c-44c3-ad4a-7c0d2d829f1e	45bbd44d-5281-453b-aed8-5874d75cdb2c	63	2023-03-01	2026-04-26 03:55:01.860777+00
4a6e39d3-54ce-4945-b9dd-10d8380dc779	1e506ddd-d08c-44c3-ad4a-7c0d2d829f1e	45bbd44d-5281-453b-aed8-5874d75cdb2c	50	2023-04-01	2026-04-26 03:55:02.058989+00
a3e39bd8-2874-4a44-9802-263b52a4052f	1e506ddd-d08c-44c3-ad4a-7c0d2d829f1e	45bbd44d-5281-453b-aed8-5874d75cdb2c	53	2023-05-01	2026-04-26 03:55:02.23971+00
c66f934c-57bf-4b5d-af5d-b3d842424834	1e506ddd-d08c-44c3-ad4a-7c0d2d829f1e	45bbd44d-5281-453b-aed8-5874d75cdb2c	63	2023-06-01	2026-04-26 03:55:02.560112+00
3a785959-50dc-42d1-8ace-0c6be4f4691a	8d351c6f-6f4a-4e01-9081-c30932db8182	f84c7f2e-f45d-4011-8f83-75fa33b2a027	2005	2023-01-01	2026-04-26 03:55:02.988955+00
ef6bcafd-9c89-4ad3-a68b-460b7232bdfe	8d351c6f-6f4a-4e01-9081-c30932db8182	f84c7f2e-f45d-4011-8f83-75fa33b2a027	1997	2023-02-01	2026-04-26 03:55:03.175548+00
a03f1ce4-afa0-41e0-ace1-ae69b3accc69	8d351c6f-6f4a-4e01-9081-c30932db8182	f84c7f2e-f45d-4011-8f83-75fa33b2a027	2004	2023-03-01	2026-04-26 03:55:03.35347+00
cfcb29d4-7a81-4fa5-a252-b8f9f61e12ea	8d351c6f-6f4a-4e01-9081-c30932db8182	f84c7f2e-f45d-4011-8f83-75fa33b2a027	1996	2023-04-01	2026-04-26 03:55:03.533839+00
5992d703-0e1c-4e3e-8bbb-56f729282ce2	8d351c6f-6f4a-4e01-9081-c30932db8182	f84c7f2e-f45d-4011-8f83-75fa33b2a027	1997	2023-05-01	2026-04-26 03:55:03.714988+00
a81f9ed7-c5b1-4ff9-a849-b07fe5e86091	8d351c6f-6f4a-4e01-9081-c30932db8182	f84c7f2e-f45d-4011-8f83-75fa33b2a027	1995	2023-06-01	2026-04-26 03:55:03.899846+00
96aa48c5-713e-4a7a-983e-b06de76fe660	8d351c6f-6f4a-4e01-9081-c30932db8182	bd27283a-985f-4006-ada1-23b7328afd6d	80	2023-01-01	2026-04-26 03:55:04.090086+00
94c10729-b07c-43c6-9265-f7e90ccdb3c5	8d351c6f-6f4a-4e01-9081-c30932db8182	bd27283a-985f-4006-ada1-23b7328afd6d	76	2023-02-01	2026-04-26 03:55:04.277661+00
10c824aa-76dd-4617-94ec-92a88355aa74	8d351c6f-6f4a-4e01-9081-c30932db8182	bd27283a-985f-4006-ada1-23b7328afd6d	87	2023-03-01	2026-04-26 03:55:04.459815+00
8f9cd59d-f7ae-40ac-8cf4-55014dd08cad	8d351c6f-6f4a-4e01-9081-c30932db8182	bd27283a-985f-4006-ada1-23b7328afd6d	88	2023-04-01	2026-04-26 03:55:04.648603+00
cdf2295a-2de2-4de9-848c-97386e5a1242	8d351c6f-6f4a-4e01-9081-c30932db8182	bd27283a-985f-4006-ada1-23b7328afd6d	82	2023-05-01	2026-04-26 03:55:04.829791+00
d357712b-e9d5-4fd6-8990-c857a5ede4d3	8d351c6f-6f4a-4e01-9081-c30932db8182	bd27283a-985f-4006-ada1-23b7328afd6d	72	2023-06-01	2026-04-26 03:55:05.009436+00
97d83cab-7740-4d4c-a987-172ee9b4a166	8d351c6f-6f4a-4e01-9081-c30932db8182	1cf0113f-e7a2-48d9-af82-34af97cd7711	15	2023-01-01	2026-04-26 03:55:05.210026+00
a3c17d1c-ab69-40e8-8840-3fe84a4f1ce0	8d351c6f-6f4a-4e01-9081-c30932db8182	1cf0113f-e7a2-48d9-af82-34af97cd7711	11	2023-02-01	2026-04-26 03:55:05.492249+00
1a179878-27c5-42ef-8de4-835b19a7078b	8d351c6f-6f4a-4e01-9081-c30932db8182	1cf0113f-e7a2-48d9-af82-34af97cd7711	10	2023-03-01	2026-04-26 03:55:05.691464+00
72cb7851-a2be-4b48-940e-5306c99d7587	8d351c6f-6f4a-4e01-9081-c30932db8182	1cf0113f-e7a2-48d9-af82-34af97cd7711	10	2023-04-01	2026-04-26 03:55:05.915067+00
eb168cc2-6444-4e0c-a8af-519d342a42aa	8d351c6f-6f4a-4e01-9081-c30932db8182	1cf0113f-e7a2-48d9-af82-34af97cd7711	15	2023-05-01	2026-04-26 03:55:06.198502+00
2a4ae76e-6558-4193-b4fb-e03a856b06e7	8d351c6f-6f4a-4e01-9081-c30932db8182	1cf0113f-e7a2-48d9-af82-34af97cd7711	29	2023-06-01	2026-04-26 03:55:06.406085+00
3c57e0c3-5620-476d-ae70-f7e8128adf50	8d351c6f-6f4a-4e01-9081-c30932db8182	4fe20bda-0c54-4f70-b4b7-bfab711b0142	76	2023-01-01	2026-04-26 03:55:06.630524+00
5d807427-f972-493c-b6d8-052be26b29ca	8d351c6f-6f4a-4e01-9081-c30932db8182	4fe20bda-0c54-4f70-b4b7-bfab711b0142	78	2023-02-01	2026-04-26 03:55:06.841335+00
d3e6d977-1fbb-4c72-9f0a-ce77b8b7f472	8d351c6f-6f4a-4e01-9081-c30932db8182	4fe20bda-0c54-4f70-b4b7-bfab711b0142	79	2023-03-01	2026-04-26 03:55:07.126361+00
4255399c-2f77-4cbb-98ad-b8b55f600a18	8d351c6f-6f4a-4e01-9081-c30932db8182	4fe20bda-0c54-4f70-b4b7-bfab711b0142	79	2023-04-01	2026-04-26 03:55:07.332458+00
de535898-caf6-4d67-b9d2-7a5569c9c5df	8d351c6f-6f4a-4e01-9081-c30932db8182	4fe20bda-0c54-4f70-b4b7-bfab711b0142	89	2023-05-01	2026-04-26 03:55:07.533703+00
7dd2d0b3-765b-4af9-96b6-5646abbae87d	8d351c6f-6f4a-4e01-9081-c30932db8182	4fe20bda-0c54-4f70-b4b7-bfab711b0142	73	2023-06-01	2026-04-26 03:55:07.741018+00
08aea8c3-ab37-4aa8-a2cb-3b4171686215	8d351c6f-6f4a-4e01-9081-c30932db8182	0f1a9642-a470-4877-8a80-03ec68a554e6	15	2023-01-01	2026-04-26 03:55:07.944525+00
40407281-4a3d-4499-9516-92392af22636	8d351c6f-6f4a-4e01-9081-c30932db8182	0f1a9642-a470-4877-8a80-03ec68a554e6	14	2023-02-01	2026-04-26 03:55:08.158034+00
b169f01f-b18a-46fd-93c2-fde5cad88615	8d351c6f-6f4a-4e01-9081-c30932db8182	0f1a9642-a470-4877-8a80-03ec68a554e6	9	2023-03-01	2026-04-26 03:55:08.359566+00
4ebe1b16-7dd0-468f-9eb4-b979d5398763	8d351c6f-6f4a-4e01-9081-c30932db8182	0f1a9642-a470-4877-8a80-03ec68a554e6	7	2023-04-01	2026-04-26 03:55:08.557727+00
c9c40f1f-4a13-4550-b8f7-d08bdc5bb20c	8d351c6f-6f4a-4e01-9081-c30932db8182	0f1a9642-a470-4877-8a80-03ec68a554e6	4	2023-05-01	2026-04-26 03:55:08.770708+00
e280d93e-ae39-46ea-86be-8cb52ccb1f23	8d351c6f-6f4a-4e01-9081-c30932db8182	0f1a9642-a470-4877-8a80-03ec68a554e6	1	2023-06-01	2026-04-26 03:55:09.071448+00
83c12a56-a9e2-4664-9659-51e80273e007	8d351c6f-6f4a-4e01-9081-c30932db8182	17452181-e28a-4f21-8939-660b89286880	78	2023-01-01	2026-04-26 03:55:09.281097+00
77c03ae9-e580-4266-8884-8df272c0f287	8d351c6f-6f4a-4e01-9081-c30932db8182	17452181-e28a-4f21-8939-660b89286880	76	2023-02-01	2026-04-26 03:55:09.469907+00
0b9a8831-aed6-44ef-a517-9b173f5ab0df	8d351c6f-6f4a-4e01-9081-c30932db8182	17452181-e28a-4f21-8939-660b89286880	82	2023-03-01	2026-04-26 03:55:09.650334+00
5bca6e5a-7fb4-4e4a-a3b1-994d7d2597c1	8d351c6f-6f4a-4e01-9081-c30932db8182	17452181-e28a-4f21-8939-660b89286880	82	2023-04-01	2026-04-26 03:55:09.846123+00
00f8a58c-2253-472d-ab0e-eba68b18b1ab	8d351c6f-6f4a-4e01-9081-c30932db8182	17452181-e28a-4f21-8939-660b89286880	85	2023-05-01	2026-04-26 03:55:10.025829+00
61483be0-b993-465e-b360-1085ec3e6155	8d351c6f-6f4a-4e01-9081-c30932db8182	17452181-e28a-4f21-8939-660b89286880	68	2023-06-01	2026-04-26 03:55:10.213611+00
a34612da-4ab5-41f3-9be0-a7ae6b129384	8d351c6f-6f4a-4e01-9081-c30932db8182	62b26a05-ddac-4b02-80b1-c7a500feef95	61	2023-01-01	2026-04-26 03:55:10.413259+00
7744001a-7783-4b82-94b5-5aa10e1dcd0f	8d351c6f-6f4a-4e01-9081-c30932db8182	62b26a05-ddac-4b02-80b1-c7a500feef95	64	2023-02-01	2026-04-26 03:55:10.600877+00
f4342a72-7d32-4d4e-be3c-655cbe63ef7e	8d351c6f-6f4a-4e01-9081-c30932db8182	62b26a05-ddac-4b02-80b1-c7a500feef95	61	2023-03-01	2026-04-26 03:55:10.7848+00
4290186d-1c52-408d-9308-ceb208ef9ec6	8d351c6f-6f4a-4e01-9081-c30932db8182	62b26a05-ddac-4b02-80b1-c7a500feef95	57	2023-04-01	2026-04-26 03:55:10.980689+00
3a644a7c-b8d3-4e2d-b9e7-c14ec0be6718	8d351c6f-6f4a-4e01-9081-c30932db8182	62b26a05-ddac-4b02-80b1-c7a500feef95	59	2023-05-01	2026-04-26 03:55:11.174347+00
310906cc-804d-4057-b715-9f81932374e0	8d351c6f-6f4a-4e01-9081-c30932db8182	62b26a05-ddac-4b02-80b1-c7a500feef95	55	2023-06-01	2026-04-26 03:55:11.365766+00
c00e7a4f-55ec-4518-a87e-53dafd15d1be	8d351c6f-6f4a-4e01-9081-c30932db8182	f49ee23c-aa92-4927-81cf-648587c88b30	57	2023-01-01	2026-04-26 03:55:11.55089+00
261bac0e-40d6-4265-93ae-230c70b1e610	8d351c6f-6f4a-4e01-9081-c30932db8182	f49ee23c-aa92-4927-81cf-648587c88b30	63	2023-02-01	2026-04-26 03:55:11.730965+00
d4075286-9949-4ee4-a1c3-efe5491e8ced	8d351c6f-6f4a-4e01-9081-c30932db8182	f49ee23c-aa92-4927-81cf-648587c88b30	52	2023-03-01	2026-04-26 03:55:11.917265+00
d3f83843-74d2-47ed-8085-ac11980b9641	8d351c6f-6f4a-4e01-9081-c30932db8182	f49ee23c-aa92-4927-81cf-648587c88b30	67	2023-04-01	2026-04-26 03:55:12.105863+00
e6e29a65-e5e4-412e-ba8d-5dd84dc8d5a2	8d351c6f-6f4a-4e01-9081-c30932db8182	f49ee23c-aa92-4927-81cf-648587c88b30	69	2023-05-01	2026-04-26 03:55:12.285711+00
eab58f22-5559-437b-a353-77e2f67698d8	8d351c6f-6f4a-4e01-9081-c30932db8182	f49ee23c-aa92-4927-81cf-648587c88b30	67	2023-06-01	2026-04-26 03:55:12.464855+00
c68949fe-a11b-4e6f-97cd-cb02c101b628	8d351c6f-6f4a-4e01-9081-c30932db8182	bd8926a3-87d1-4f67-b23f-374f8748eddb	59	2023-01-01	2026-04-26 03:55:12.6506+00
c64ff35d-6222-4ede-b0fd-f193880a3805	8d351c6f-6f4a-4e01-9081-c30932db8182	bd8926a3-87d1-4f67-b23f-374f8748eddb	63	2023-02-01	2026-04-26 03:55:12.840897+00
02121152-8ef4-41e7-a3a4-09f2a21ae456	8d351c6f-6f4a-4e01-9081-c30932db8182	bd8926a3-87d1-4f67-b23f-374f8748eddb	68	2023-03-01	2026-04-26 03:55:13.033477+00
7d34afb7-292e-48e4-9886-90c28ad7584c	8d351c6f-6f4a-4e01-9081-c30932db8182	bd8926a3-87d1-4f67-b23f-374f8748eddb	50	2023-04-01	2026-04-26 03:55:13.230215+00
e3b333e0-0828-4e8e-b373-3252ec595133	8d351c6f-6f4a-4e01-9081-c30932db8182	bd8926a3-87d1-4f67-b23f-374f8748eddb	74	2023-05-01	2026-04-26 03:55:13.472182+00
d81a0b9a-1bf5-4b94-8ed6-66653235c64b	8d351c6f-6f4a-4e01-9081-c30932db8182	bd8926a3-87d1-4f67-b23f-374f8748eddb	62	2023-06-01	2026-04-26 03:55:13.67864+00
ccc2ba77-aa76-44a5-8998-3eb31c5e76a9	8d351c6f-6f4a-4e01-9081-c30932db8182	45bbd44d-5281-453b-aed8-5874d75cdb2c	61	2023-01-01	2026-04-26 03:55:13.880738+00
ce7828d0-4202-406d-b94e-fe9c8be4669b	8d351c6f-6f4a-4e01-9081-c30932db8182	45bbd44d-5281-453b-aed8-5874d75cdb2c	60	2023-02-01	2026-04-26 03:55:14.090675+00
72a73976-8dcb-4acb-8d3f-6ab4d300563c	8d351c6f-6f4a-4e01-9081-c30932db8182	45bbd44d-5281-453b-aed8-5874d75cdb2c	54	2023-03-01	2026-04-26 03:55:14.291863+00
1a2880bf-2fae-4bac-93c2-6c4d8d5ec92c	8d351c6f-6f4a-4e01-9081-c30932db8182	45bbd44d-5281-453b-aed8-5874d75cdb2c	62	2023-04-01	2026-04-26 03:55:14.501466+00
c346114e-ea66-4fa0-b9f0-3cf852d38416	8d351c6f-6f4a-4e01-9081-c30932db8182	45bbd44d-5281-453b-aed8-5874d75cdb2c	60	2023-05-01	2026-04-26 03:55:14.709711+00
26b2eec6-8a8a-4ef0-87e8-ec64dbabcb71	8d351c6f-6f4a-4e01-9081-c30932db8182	45bbd44d-5281-453b-aed8-5874d75cdb2c	70	2023-06-01	2026-04-26 03:55:14.914713+00
f51716dc-951d-4c4c-999e-6f01b150fa75	5e0bad4f-2b61-4de3-8111-43203c09ae0b	f84c7f2e-f45d-4011-8f83-75fa33b2a027	1997	2023-01-01	2026-04-26 03:55:15.127265+00
422242af-543e-4b53-8030-41c479f94e07	5e0bad4f-2b61-4de3-8111-43203c09ae0b	f84c7f2e-f45d-4011-8f83-75fa33b2a027	2001	2023-02-01	2026-04-26 03:55:15.808655+00
6232c486-1069-4018-aad2-326f50d4cf48	5e0bad4f-2b61-4de3-8111-43203c09ae0b	f84c7f2e-f45d-4011-8f83-75fa33b2a027	2007	2023-03-01	2026-04-26 03:55:16.035184+00
43ebffd8-981b-4a4c-8fd0-2fd3cd4b28db	5e0bad4f-2b61-4de3-8111-43203c09ae0b	f84c7f2e-f45d-4011-8f83-75fa33b2a027	2004	2023-04-01	2026-04-26 03:55:16.34065+00
7dc9a4e6-5531-4058-92b3-8bd3004175fb	5e0bad4f-2b61-4de3-8111-43203c09ae0b	f84c7f2e-f45d-4011-8f83-75fa33b2a027	1998	2023-05-01	2026-04-26 03:55:16.546375+00
d831620a-5b0e-40ac-a617-0df0645d0f1c	5e0bad4f-2b61-4de3-8111-43203c09ae0b	f84c7f2e-f45d-4011-8f83-75fa33b2a027	1992	2023-06-01	2026-04-26 03:55:16.750321+00
819bc566-8cba-40a1-a6f8-3c7790a638e3	5e0bad4f-2b61-4de3-8111-43203c09ae0b	bd27283a-985f-4006-ada1-23b7328afd6d	80	2023-01-01	2026-04-26 03:55:16.95641+00
22f753b8-24c8-4b5a-b0f8-db514293e59d	5e0bad4f-2b61-4de3-8111-43203c09ae0b	bd27283a-985f-4006-ada1-23b7328afd6d	77	2023-02-01	2026-04-26 03:55:17.160937+00
c38421f4-0153-46fa-ab72-b15f77e417c7	5e0bad4f-2b61-4de3-8111-43203c09ae0b	bd27283a-985f-4006-ada1-23b7328afd6d	84	2023-03-01	2026-04-26 03:55:17.366147+00
23d4127c-e0c1-4545-8cb3-f0edd7eb06a7	5e0bad4f-2b61-4de3-8111-43203c09ae0b	bd27283a-985f-4006-ada1-23b7328afd6d	79	2023-04-01	2026-04-26 03:55:17.570917+00
f0f6512a-7f94-4562-ba65-be8e9751a39a	5e0bad4f-2b61-4de3-8111-43203c09ae0b	bd27283a-985f-4006-ada1-23b7328afd6d	85	2023-05-01	2026-04-26 03:55:17.779717+00
e2f8d2c6-4915-41a2-8644-a24db2041f66	5e0bad4f-2b61-4de3-8111-43203c09ae0b	bd27283a-985f-4006-ada1-23b7328afd6d	75	2023-06-01	2026-04-26 03:55:18.070083+00
a1577204-3fd8-4b49-a28a-0bc7d7241bcb	5e0bad4f-2b61-4de3-8111-43203c09ae0b	1cf0113f-e7a2-48d9-af82-34af97cd7711	7	2023-01-01	2026-04-26 03:55:18.286337+00
488cc6f1-4a23-4156-b97a-1d4c9033242b	5e0bad4f-2b61-4de3-8111-43203c09ae0b	1cf0113f-e7a2-48d9-af82-34af97cd7711	15	2023-02-01	2026-04-26 03:55:18.591453+00
7894f89a-62ae-4bdc-88dc-738202ceeb96	5e0bad4f-2b61-4de3-8111-43203c09ae0b	1cf0113f-e7a2-48d9-af82-34af97cd7711	7	2023-03-01	2026-04-26 03:55:18.793555+00
90b19e2a-b38b-46aa-8a60-3c7e32b9296f	5e0bad4f-2b61-4de3-8111-43203c09ae0b	1cf0113f-e7a2-48d9-af82-34af97cd7711	15	2023-04-01	2026-04-26 03:55:19.021108+00
f4c2521c-ee40-4fb2-b2c2-a0e8c168207a	5e0bad4f-2b61-4de3-8111-43203c09ae0b	1cf0113f-e7a2-48d9-af82-34af97cd7711	11	2023-05-01	2026-04-26 03:55:19.212662+00
dbd63f35-2b8f-405c-9e91-f45fe1ff20fd	5e0bad4f-2b61-4de3-8111-43203c09ae0b	1cf0113f-e7a2-48d9-af82-34af97cd7711	13	2023-06-01	2026-04-26 03:55:19.43838+00
bab82057-02a7-44a0-bca2-7005f8a8e183	5e0bad4f-2b61-4de3-8111-43203c09ae0b	4fe20bda-0c54-4f70-b4b7-bfab711b0142	85	2023-01-01	2026-04-26 03:55:19.725485+00
d737497c-2311-4c39-8515-cfdcca2cb868	5e0bad4f-2b61-4de3-8111-43203c09ae0b	4fe20bda-0c54-4f70-b4b7-bfab711b0142	73	2023-02-01	2026-04-26 03:55:19.926967+00
b57f43fb-5b0b-40bd-b999-e5d15549081b	5e0bad4f-2b61-4de3-8111-43203c09ae0b	4fe20bda-0c54-4f70-b4b7-bfab711b0142	86	2023-03-01	2026-04-26 03:55:20.157373+00
5f3eca03-ddfd-4572-a7e1-9b156cfdaae7	5e0bad4f-2b61-4de3-8111-43203c09ae0b	4fe20bda-0c54-4f70-b4b7-bfab711b0142	88	2023-04-01	2026-04-26 03:55:20.435093+00
b7d85641-3a9c-44d0-b876-b9a36e5771af	5e0bad4f-2b61-4de3-8111-43203c09ae0b	4fe20bda-0c54-4f70-b4b7-bfab711b0142	89	2023-05-01	2026-04-26 03:55:20.650331+00
61c6ddb4-4ab0-4b02-b48f-0a87d5fee958	5e0bad4f-2b61-4de3-8111-43203c09ae0b	4fe20bda-0c54-4f70-b4b7-bfab711b0142	68	2023-06-01	2026-04-26 03:55:20.998636+00
5bcf235e-1dc1-48f7-bfec-23878b44277a	5e0bad4f-2b61-4de3-8111-43203c09ae0b	0f1a9642-a470-4877-8a80-03ec68a554e6	8	2023-01-01	2026-04-26 03:55:21.255755+00
b98ca8c4-1757-45f3-b888-3f359a83ceaf	5e0bad4f-2b61-4de3-8111-43203c09ae0b	0f1a9642-a470-4877-8a80-03ec68a554e6	15	2023-02-01	2026-04-26 03:55:21.456026+00
c5f2c7e8-1b94-430c-9165-8653c233d847	5e0bad4f-2b61-4de3-8111-43203c09ae0b	0f1a9642-a470-4877-8a80-03ec68a554e6	15	2023-03-01	2026-04-26 03:55:21.683157+00
72c32699-09ce-4b10-8288-fbee69d705a8	5e0bad4f-2b61-4de3-8111-43203c09ae0b	0f1a9642-a470-4877-8a80-03ec68a554e6	8	2023-04-01	2026-04-26 03:55:21.896002+00
c92eb6cd-53f1-467a-b945-fcbfc0c4781b	5e0bad4f-2b61-4de3-8111-43203c09ae0b	0f1a9642-a470-4877-8a80-03ec68a554e6	7	2023-05-01	2026-04-26 03:55:22.084852+00
a4960860-b783-4712-8b91-407a26555fc2	5e0bad4f-2b61-4de3-8111-43203c09ae0b	0f1a9642-a470-4877-8a80-03ec68a554e6	6	2023-06-01	2026-04-26 03:55:22.318078+00
582d7068-040e-495d-bc95-62c8067fda8b	5e0bad4f-2b61-4de3-8111-43203c09ae0b	17452181-e28a-4f21-8939-660b89286880	76	2023-01-01	2026-04-26 03:55:22.509061+00
cc3923ca-7347-4bdc-9d39-c71a88dfe9c7	5e0bad4f-2b61-4de3-8111-43203c09ae0b	17452181-e28a-4f21-8939-660b89286880	68	2023-02-01	2026-04-26 03:55:22.756332+00
5aea543f-9ab6-436a-9f11-85f22c99e0d5	5e0bad4f-2b61-4de3-8111-43203c09ae0b	17452181-e28a-4f21-8939-660b89286880	82	2023-03-01	2026-04-26 03:55:23.0074+00
351b2a1c-a8a5-4e91-9f7d-585d0fadf03d	5e0bad4f-2b61-4de3-8111-43203c09ae0b	17452181-e28a-4f21-8939-660b89286880	73	2023-04-01	2026-04-26 03:55:23.331053+00
7719ebe3-f7a9-4894-b6c9-383cb874da5f	5e0bad4f-2b61-4de3-8111-43203c09ae0b	17452181-e28a-4f21-8939-660b89286880	84	2023-05-01	2026-04-26 03:55:23.664738+00
0a1b32bc-0332-4c4c-b3e5-bfe8119756e7	5e0bad4f-2b61-4de3-8111-43203c09ae0b	17452181-e28a-4f21-8939-660b89286880	67	2023-06-01	2026-04-26 03:55:23.870592+00
6040bb4e-5dd4-4036-8ccc-1389857e5513	5e0bad4f-2b61-4de3-8111-43203c09ae0b	62b26a05-ddac-4b02-80b1-c7a500feef95	55	2023-01-01	2026-04-26 03:55:24.078083+00
500792e1-1365-4b31-afea-52e38b8e7e95	5e0bad4f-2b61-4de3-8111-43203c09ae0b	62b26a05-ddac-4b02-80b1-c7a500feef95	61	2023-02-01	2026-04-26 03:55:24.285079+00
850134be-29f5-4365-9649-8e4b29436f52	5e0bad4f-2b61-4de3-8111-43203c09ae0b	62b26a05-ddac-4b02-80b1-c7a500feef95	68	2023-03-01	2026-04-26 03:55:24.494487+00
2f259e25-c168-4ad5-b8bd-fdaa53133b4a	5e0bad4f-2b61-4de3-8111-43203c09ae0b	62b26a05-ddac-4b02-80b1-c7a500feef95	66	2023-04-01	2026-04-26 03:55:24.74187+00
96416cef-7e90-4b1f-acf5-7b8997c460e3	5e0bad4f-2b61-4de3-8111-43203c09ae0b	62b26a05-ddac-4b02-80b1-c7a500feef95	56	2023-05-01	2026-04-26 03:55:24.996643+00
bbcbb778-a036-4fb1-9caf-9ae043e6c2af	5e0bad4f-2b61-4de3-8111-43203c09ae0b	62b26a05-ddac-4b02-80b1-c7a500feef95	75	2023-06-01	2026-04-26 03:55:25.194506+00
9b34bea2-6c6c-4cf7-a5be-6d7d532e597b	5e0bad4f-2b61-4de3-8111-43203c09ae0b	f49ee23c-aa92-4927-81cf-648587c88b30	60	2023-01-01	2026-04-26 03:55:25.394117+00
0911bfc6-9d1d-4811-b94f-e14bc0c4b11d	5e0bad4f-2b61-4de3-8111-43203c09ae0b	f49ee23c-aa92-4927-81cf-648587c88b30	61	2023-02-01	2026-04-26 03:55:25.63485+00
6e92f1bf-2dd8-49cf-a4c5-2056f0e56754	5e0bad4f-2b61-4de3-8111-43203c09ae0b	f49ee23c-aa92-4927-81cf-648587c88b30	65	2023-03-01	2026-04-26 03:55:25.881883+00
960be4dc-a38a-4432-8307-75f34c99d515	5e0bad4f-2b61-4de3-8111-43203c09ae0b	f49ee23c-aa92-4927-81cf-648587c88b30	56	2023-04-01	2026-04-26 03:55:26.077525+00
ee42c788-31ff-4853-9f70-0fe246297e58	5e0bad4f-2b61-4de3-8111-43203c09ae0b	f49ee23c-aa92-4927-81cf-648587c88b30	52	2023-05-01	2026-04-26 03:55:26.275532+00
6380a0e5-38d5-4d70-be69-0e7e86271d1b	5e0bad4f-2b61-4de3-8111-43203c09ae0b	f49ee23c-aa92-4927-81cf-648587c88b30	74	2023-06-01	2026-04-26 03:55:26.469226+00
0985dce8-1902-4555-8e5b-e81bf15334de	5e0bad4f-2b61-4de3-8111-43203c09ae0b	bd8926a3-87d1-4f67-b23f-374f8748eddb	63	2023-01-01	2026-04-26 03:55:26.659644+00
b5fe185c-c4dd-474a-b907-629ad63c6a8e	5e0bad4f-2b61-4de3-8111-43203c09ae0b	bd8926a3-87d1-4f67-b23f-374f8748eddb	59	2023-02-01	2026-04-26 03:55:26.84968+00
5ad60123-5b70-4760-920c-a0d163436a44	5e0bad4f-2b61-4de3-8111-43203c09ae0b	bd8926a3-87d1-4f67-b23f-374f8748eddb	52	2023-03-01	2026-04-26 03:55:27.040276+00
8a6c530f-5e0a-4e91-b5e7-b77c22fbdee2	5e0bad4f-2b61-4de3-8111-43203c09ae0b	bd8926a3-87d1-4f67-b23f-374f8748eddb	53	2023-04-01	2026-04-26 03:55:27.234192+00
f2fa34bc-ce03-4874-9a7b-47a0970b7a6c	5e0bad4f-2b61-4de3-8111-43203c09ae0b	bd8926a3-87d1-4f67-b23f-374f8748eddb	73	2023-05-01	2026-04-26 03:55:27.425057+00
8a12d8ae-a41a-4aa1-835d-ec033748955e	5e0bad4f-2b61-4de3-8111-43203c09ae0b	bd8926a3-87d1-4f67-b23f-374f8748eddb	70	2023-06-01	2026-04-26 03:55:27.623009+00
950ef6b7-82c6-46e7-be7e-13aa42bca3f7	5e0bad4f-2b61-4de3-8111-43203c09ae0b	45bbd44d-5281-453b-aed8-5874d75cdb2c	65	2023-01-01	2026-04-26 03:55:27.831374+00
a565c7e2-0db1-4ff9-84ac-c396a53abd59	5e0bad4f-2b61-4de3-8111-43203c09ae0b	45bbd44d-5281-453b-aed8-5874d75cdb2c	63	2023-02-01	2026-04-26 03:55:28.023344+00
5e373dcd-3928-4046-aa4f-fcd5a60921b0	5e0bad4f-2b61-4de3-8111-43203c09ae0b	45bbd44d-5281-453b-aed8-5874d75cdb2c	58	2023-03-01	2026-04-26 03:55:28.206643+00
55dc1d60-eabf-4dd0-b2a5-295a05de06f9	5e0bad4f-2b61-4de3-8111-43203c09ae0b	45bbd44d-5281-453b-aed8-5874d75cdb2c	59	2023-04-01	2026-04-26 03:55:28.399893+00
07d55870-5e58-4d51-bea7-62417611ce10	5e0bad4f-2b61-4de3-8111-43203c09ae0b	45bbd44d-5281-453b-aed8-5874d75cdb2c	68	2023-05-01	2026-04-26 03:55:28.586607+00
c1b8f4ae-b2c7-496f-b1c5-946fe7036260	5e0bad4f-2b61-4de3-8111-43203c09ae0b	45bbd44d-5281-453b-aed8-5874d75cdb2c	49	2023-06-01	2026-04-26 03:55:28.776017+00
7358c4a4-7728-4f12-a9a2-2257076836fa	1c04440e-6673-4c5c-b040-51b186b38a86	f84c7f2e-f45d-4011-8f83-75fa33b2a027	2003	2023-01-01	2026-04-26 03:55:28.9649+00
ddd61142-ddfa-48f6-a309-a7403de4909f	1c04440e-6673-4c5c-b040-51b186b38a86	f84c7f2e-f45d-4011-8f83-75fa33b2a027	1994	2023-02-01	2026-04-26 03:55:29.163161+00
f7d82b1d-e64d-4e54-9a95-00edfa4dbe88	1c04440e-6673-4c5c-b040-51b186b38a86	f84c7f2e-f45d-4011-8f83-75fa33b2a027	2007	2023-03-01	2026-04-26 03:55:29.350174+00
9ff31520-38a8-48f2-a819-6314e93d7db3	1c04440e-6673-4c5c-b040-51b186b38a86	f84c7f2e-f45d-4011-8f83-75fa33b2a027	2003	2023-04-01	2026-04-26 03:55:29.541409+00
831aa966-fca9-4c36-b8e1-82a6dc4e221b	1c04440e-6673-4c5c-b040-51b186b38a86	f84c7f2e-f45d-4011-8f83-75fa33b2a027	2009	2023-05-01	2026-04-26 03:55:29.756825+00
1f8c96e0-1cd8-436b-b7db-5f2df84f1f26	1c04440e-6673-4c5c-b040-51b186b38a86	f84c7f2e-f45d-4011-8f83-75fa33b2a027	1990	2023-06-01	2026-04-26 03:55:29.950898+00
035828f8-4279-4060-a4ab-8ad4c410f08e	1c04440e-6673-4c5c-b040-51b186b38a86	bd27283a-985f-4006-ada1-23b7328afd6d	80	2023-01-01	2026-04-26 03:55:30.151036+00
10079364-198a-4d31-bfc5-ce5d68caffb5	1c04440e-6673-4c5c-b040-51b186b38a86	bd27283a-985f-4006-ada1-23b7328afd6d	77	2023-02-01	2026-04-26 03:55:30.362955+00
a7fc52ec-ba99-4ed3-ad73-3b7a789814cc	1c04440e-6673-4c5c-b040-51b186b38a86	bd27283a-985f-4006-ada1-23b7328afd6d	78	2023-03-01	2026-04-26 03:55:30.567778+00
245d8bc2-24f1-475c-a684-18389a106e9b	1c04440e-6673-4c5c-b040-51b186b38a86	bd27283a-985f-4006-ada1-23b7328afd6d	72	2023-04-01	2026-04-26 03:55:30.753246+00
abe40dc4-49de-44fc-ae0b-4ccedd5fb5a2	1c04440e-6673-4c5c-b040-51b186b38a86	bd27283a-985f-4006-ada1-23b7328afd6d	74	2023-05-01	2026-04-26 03:55:30.950549+00
487ee6df-b9df-4797-8a60-31709d6f682e	1c04440e-6673-4c5c-b040-51b186b38a86	bd27283a-985f-4006-ada1-23b7328afd6d	93	2023-06-01	2026-04-26 03:55:31.140576+00
7ab39854-c02f-476f-a54c-00fb9faac65a	1c04440e-6673-4c5c-b040-51b186b38a86	1cf0113f-e7a2-48d9-af82-34af97cd7711	10	2023-01-01	2026-04-26 03:55:31.329751+00
f43ba2d8-9f00-4309-87ee-9c0aad305490	1c04440e-6673-4c5c-b040-51b186b38a86	1cf0113f-e7a2-48d9-af82-34af97cd7711	17	2023-02-01	2026-04-26 03:55:31.521898+00
56d36167-1a48-499d-b2c3-6fbc8d517040	1c04440e-6673-4c5c-b040-51b186b38a86	1cf0113f-e7a2-48d9-af82-34af97cd7711	20	2023-03-01	2026-04-26 03:55:31.715894+00
c824f61a-84d6-4580-8473-96f3a2c9569f	1c04440e-6673-4c5c-b040-51b186b38a86	1cf0113f-e7a2-48d9-af82-34af97cd7711	18	2023-04-01	2026-04-26 03:55:31.901355+00
50b566df-e78f-413d-a98f-efc6f9bbf9d8	1c04440e-6673-4c5c-b040-51b186b38a86	1cf0113f-e7a2-48d9-af82-34af97cd7711	10	2023-05-01	2026-04-26 03:55:32.089814+00
5b2370c5-7b2b-4cf6-b249-656f68e0fbe4	1c04440e-6673-4c5c-b040-51b186b38a86	1cf0113f-e7a2-48d9-af82-34af97cd7711	11	2023-06-01	2026-04-26 03:55:32.275738+00
d6ccc374-5ba3-4f43-ad19-4fed9154d85e	1c04440e-6673-4c5c-b040-51b186b38a86	4fe20bda-0c54-4f70-b4b7-bfab711b0142	77	2023-01-01	2026-04-26 03:55:32.460803+00
adee51f4-f7d3-4bf5-bd45-a494a9fba844	1c04440e-6673-4c5c-b040-51b186b38a86	4fe20bda-0c54-4f70-b4b7-bfab711b0142	79	2023-02-01	2026-04-26 03:55:32.647152+00
3f18fa9c-d321-4377-9ddf-af1e3b11f138	1c04440e-6673-4c5c-b040-51b186b38a86	4fe20bda-0c54-4f70-b4b7-bfab711b0142	80	2023-03-01	2026-04-26 03:55:32.834949+00
5f6858c6-b5d2-473f-8669-817f0a1f7e9b	1c04440e-6673-4c5c-b040-51b186b38a86	4fe20bda-0c54-4f70-b4b7-bfab711b0142	93	2023-04-01	2026-04-26 03:55:33.030024+00
fde1c482-70c6-4f19-b624-8cf1298d0be7	1c04440e-6673-4c5c-b040-51b186b38a86	4fe20bda-0c54-4f70-b4b7-bfab711b0142	83	2023-05-01	2026-04-26 03:55:33.215584+00
081ae127-a9b4-47c5-a4c4-fc464506d882	1c04440e-6673-4c5c-b040-51b186b38a86	4fe20bda-0c54-4f70-b4b7-bfab711b0142	77	2023-06-01	2026-04-26 03:55:33.399632+00
ffdb28d6-ed38-4da8-b88f-420cde14465e	1c04440e-6673-4c5c-b040-51b186b38a86	0f1a9642-a470-4877-8a80-03ec68a554e6	6	2023-01-01	2026-04-26 03:55:33.622582+00
aa27733e-684f-4d04-ae60-d2b3ff763f76	1c04440e-6673-4c5c-b040-51b186b38a86	0f1a9642-a470-4877-8a80-03ec68a554e6	12	2023-02-01	2026-04-26 03:55:33.807394+00
93c3fa15-b13d-43cf-9510-b5153f9a37f5	1c04440e-6673-4c5c-b040-51b186b38a86	0f1a9642-a470-4877-8a80-03ec68a554e6	4	2023-03-01	2026-04-26 03:55:34.010756+00
fc3dd875-3ebc-45d3-8e49-7d35efdfa6f0	1c04440e-6673-4c5c-b040-51b186b38a86	0f1a9642-a470-4877-8a80-03ec68a554e6	9	2023-04-01	2026-04-26 03:55:34.209814+00
45673627-ff80-486c-b670-2da262ef12d1	1c04440e-6673-4c5c-b040-51b186b38a86	0f1a9642-a470-4877-8a80-03ec68a554e6	9	2023-05-01	2026-04-26 03:55:34.420035+00
117f990c-238f-4389-b03a-14244fe6bd18	1c04440e-6673-4c5c-b040-51b186b38a86	0f1a9642-a470-4877-8a80-03ec68a554e6	1	2023-06-01	2026-04-26 03:55:35.203183+00
3f654217-6f47-4613-8ebe-dc1efd597587	1c04440e-6673-4c5c-b040-51b186b38a86	17452181-e28a-4f21-8939-660b89286880	72	2023-01-01	2026-04-26 03:55:35.413142+00
2ce4a7bb-3f39-472b-92d0-aa5f36df16d8	1c04440e-6673-4c5c-b040-51b186b38a86	17452181-e28a-4f21-8939-660b89286880	81	2023-02-01	2026-04-26 03:55:35.621293+00
711ef307-97fe-4f46-9d12-6d980d2fceb6	1c04440e-6673-4c5c-b040-51b186b38a86	17452181-e28a-4f21-8939-660b89286880	74	2023-03-01	2026-04-26 03:55:35.826047+00
1dd5af5d-ca26-4f9d-b088-8bf2e7fcd4f8	1c04440e-6673-4c5c-b040-51b186b38a86	17452181-e28a-4f21-8939-660b89286880	77	2023-04-01	2026-04-26 03:55:36.032353+00
ef5e62be-425e-4a29-9848-49621d081608	1c04440e-6673-4c5c-b040-51b186b38a86	17452181-e28a-4f21-8939-660b89286880	81	2023-05-01	2026-04-26 03:55:36.229723+00
c41cd97b-ca33-439b-9cc0-ec9d9cebe898	1c04440e-6673-4c5c-b040-51b186b38a86	17452181-e28a-4f21-8939-660b89286880	67	2023-06-01	2026-04-26 03:55:36.417919+00
7ad4bdf4-e131-42d0-b9f9-b05e2291e5cc	1c04440e-6673-4c5c-b040-51b186b38a86	62b26a05-ddac-4b02-80b1-c7a500feef95	62	2023-01-01	2026-04-26 03:55:36.61592+00
fbcec192-fd91-4322-a060-5c50808c8e2d	1c04440e-6673-4c5c-b040-51b186b38a86	62b26a05-ddac-4b02-80b1-c7a500feef95	55	2023-02-01	2026-04-26 03:55:36.810494+00
e41adc51-450a-4bd3-b6f4-6eac7fe23b21	1c04440e-6673-4c5c-b040-51b186b38a86	62b26a05-ddac-4b02-80b1-c7a500feef95	67	2023-03-01	2026-04-26 03:55:37.014681+00
c7e980ad-d22b-4a16-bfb5-c74ce7d0c28a	1c04440e-6673-4c5c-b040-51b186b38a86	62b26a05-ddac-4b02-80b1-c7a500feef95	57	2023-04-01	2026-04-26 03:55:37.213924+00
eabcf4a7-50a9-4817-aa95-6a630f8503f8	1c04440e-6673-4c5c-b040-51b186b38a86	62b26a05-ddac-4b02-80b1-c7a500feef95	66	2023-05-01	2026-04-26 03:55:37.402916+00
f8f63235-46d8-4b65-b50b-2aac9b0d348a	1c04440e-6673-4c5c-b040-51b186b38a86	62b26a05-ddac-4b02-80b1-c7a500feef95	62	2023-06-01	2026-04-26 03:55:37.592889+00
7bd33c97-a6e2-480d-8a15-0d2e33bdce3c	1c04440e-6673-4c5c-b040-51b186b38a86	f49ee23c-aa92-4927-81cf-648587c88b30	55	2023-01-01	2026-04-26 03:55:37.777824+00
fa791d21-f742-4806-be02-58a9ec278545	1c04440e-6673-4c5c-b040-51b186b38a86	f49ee23c-aa92-4927-81cf-648587c88b30	62	2023-02-01	2026-04-26 03:55:37.958915+00
e6d7f1dc-946b-425b-bbdd-e4b96de37c58	1c04440e-6673-4c5c-b040-51b186b38a86	f49ee23c-aa92-4927-81cf-648587c88b30	60	2023-03-01	2026-04-26 03:55:38.14817+00
20cd75ff-3792-45d7-b7f3-dca59a8fc56e	1c04440e-6673-4c5c-b040-51b186b38a86	f49ee23c-aa92-4927-81cf-648587c88b30	71	2023-04-01	2026-04-26 03:55:38.335625+00
d6e04c41-8bb0-4b7a-b2e1-9e39bd8a9848	1c04440e-6673-4c5c-b040-51b186b38a86	f49ee23c-aa92-4927-81cf-648587c88b30	47	2023-05-01	2026-04-26 03:55:38.534811+00
1978f511-5c66-4f9f-9212-1d95f6591b90	1c04440e-6673-4c5c-b040-51b186b38a86	f49ee23c-aa92-4927-81cf-648587c88b30	72	2023-06-01	2026-04-26 03:55:38.723855+00
60d2b77d-d1ef-4d4c-8835-af66ce714958	1c04440e-6673-4c5c-b040-51b186b38a86	bd8926a3-87d1-4f67-b23f-374f8748eddb	60	2023-01-01	2026-04-26 03:55:38.912691+00
1edd3f10-9063-4827-b6ee-cbda2c037a54	1c04440e-6673-4c5c-b040-51b186b38a86	bd8926a3-87d1-4f67-b23f-374f8748eddb	62	2023-02-01	2026-04-26 03:55:39.133985+00
00025ad9-887f-42e7-beeb-51815e9e94f4	1c04440e-6673-4c5c-b040-51b186b38a86	bd8926a3-87d1-4f67-b23f-374f8748eddb	57	2023-03-01	2026-04-26 03:55:39.349657+00
baf602c0-82cb-4a50-b1c3-633f2342c160	1c04440e-6673-4c5c-b040-51b186b38a86	bd8926a3-87d1-4f67-b23f-374f8748eddb	62	2023-04-01	2026-04-26 03:55:39.549254+00
fb265459-7ee9-4cc1-9333-02629b5607e1	1c04440e-6673-4c5c-b040-51b186b38a86	bd8926a3-87d1-4f67-b23f-374f8748eddb	57	2023-05-01	2026-04-26 03:55:39.733466+00
2123687e-823d-431b-80f5-db2c4407fbd4	1c04440e-6673-4c5c-b040-51b186b38a86	bd8926a3-87d1-4f67-b23f-374f8748eddb	61	2023-06-01	2026-04-26 03:55:39.951681+00
c6f5554e-386a-45f1-a2ea-e409113ef094	1c04440e-6673-4c5c-b040-51b186b38a86	45bbd44d-5281-453b-aed8-5874d75cdb2c	58	2023-01-01	2026-04-26 03:55:40.172815+00
eafce36b-1886-4075-8f22-fec3ccce150a	1c04440e-6673-4c5c-b040-51b186b38a86	45bbd44d-5281-453b-aed8-5874d75cdb2c	55	2023-02-01	2026-04-26 03:55:40.370102+00
9a56ba1a-645c-46d9-8037-d3d7de282866	1c04440e-6673-4c5c-b040-51b186b38a86	45bbd44d-5281-453b-aed8-5874d75cdb2c	59	2023-03-01	2026-04-26 03:55:40.579071+00
0fd348d3-462f-4200-a018-8c214c541a68	1c04440e-6673-4c5c-b040-51b186b38a86	45bbd44d-5281-453b-aed8-5874d75cdb2c	51	2023-04-01	2026-04-26 03:55:40.772496+00
565e475f-c752-47ba-b7fe-023374f7447a	1c04440e-6673-4c5c-b040-51b186b38a86	45bbd44d-5281-453b-aed8-5874d75cdb2c	61	2023-05-01	2026-04-26 03:55:40.980847+00
38066164-983e-4c06-a588-c48e4c77f0f0	1c04440e-6673-4c5c-b040-51b186b38a86	45bbd44d-5281-453b-aed8-5874d75cdb2c	65	2023-06-01	2026-04-26 03:55:41.204064+00
9b8ad362-be5b-4f45-95a8-1f9186830115	72d462e6-0a90-443a-90fa-dffddecd2fdb	f84c7f2e-f45d-4011-8f83-75fa33b2a027	2002	2023-01-01	2026-04-26 03:55:41.385006+00
9023a9ea-0d51-4b61-90ee-d513ecaf1baf	72d462e6-0a90-443a-90fa-dffddecd2fdb	f84c7f2e-f45d-4011-8f83-75fa33b2a027	2001	2023-02-01	2026-04-26 03:55:41.565912+00
f1cadf76-f516-41ed-a4e0-3be773308143	72d462e6-0a90-443a-90fa-dffddecd2fdb	f84c7f2e-f45d-4011-8f83-75fa33b2a027	1996	2023-03-01	2026-04-26 03:55:41.750081+00
ae428047-aacb-4c01-8a7c-89bda3e00217	72d462e6-0a90-443a-90fa-dffddecd2fdb	f84c7f2e-f45d-4011-8f83-75fa33b2a027	2007	2023-04-01	2026-04-26 03:55:42.939461+00
99f9bdbf-378e-494a-91f6-740d6bfba24c	72d462e6-0a90-443a-90fa-dffddecd2fdb	f84c7f2e-f45d-4011-8f83-75fa33b2a027	2000	2023-05-01	2026-04-26 03:55:43.120001+00
b9fe76ba-f1d9-4e41-9daa-9799567995a9	72d462e6-0a90-443a-90fa-dffddecd2fdb	f84c7f2e-f45d-4011-8f83-75fa33b2a027	1992	2023-06-01	2026-04-26 03:55:43.316854+00
0e7c6aa0-5fb6-4484-bc95-fc0d11a43db6	72d462e6-0a90-443a-90fa-dffddecd2fdb	bd27283a-985f-4006-ada1-23b7328afd6d	78	2023-01-01	2026-04-26 03:55:43.54433+00
17b5e7a4-22d6-47b1-be85-ff2b877da15d	72d462e6-0a90-443a-90fa-dffddecd2fdb	bd27283a-985f-4006-ada1-23b7328afd6d	87	2023-02-01	2026-04-26 03:55:43.749981+00
4a8a6580-090d-4663-a88c-b71711ebe532	72d462e6-0a90-443a-90fa-dffddecd2fdb	bd27283a-985f-4006-ada1-23b7328afd6d	80	2023-03-01	2026-04-26 03:55:44.500101+00
65687703-c72b-4fca-a70e-6876fa9ebc0f	72d462e6-0a90-443a-90fa-dffddecd2fdb	bd27283a-985f-4006-ada1-23b7328afd6d	83	2023-04-01	2026-04-26 03:55:44.806239+00
8d737618-c996-4d52-bdd0-a701702f9d86	72d462e6-0a90-443a-90fa-dffddecd2fdb	bd27283a-985f-4006-ada1-23b7328afd6d	86	2023-05-01	2026-04-26 03:55:45.003335+00
997ffd6f-e34b-4266-b118-7e43a8cebdc2	72d462e6-0a90-443a-90fa-dffddecd2fdb	bd27283a-985f-4006-ada1-23b7328afd6d	75	2023-06-01	2026-04-26 03:55:45.22386+00
cd2408f8-bcfa-41bf-83d5-f223770f1149	72d462e6-0a90-443a-90fa-dffddecd2fdb	1cf0113f-e7a2-48d9-af82-34af97cd7711	7	2023-01-01	2026-04-26 03:55:45.414069+00
2b23c5f4-c463-4394-b62a-fcf19e79795d	72d462e6-0a90-443a-90fa-dffddecd2fdb	1cf0113f-e7a2-48d9-af82-34af97cd7711	11	2023-02-01	2026-04-26 03:55:45.610501+00
8a555e09-cbfe-4a36-9b15-84d335289fe7	72d462e6-0a90-443a-90fa-dffddecd2fdb	1cf0113f-e7a2-48d9-af82-34af97cd7711	13	2023-03-01	2026-04-26 03:55:45.790077+00
17550706-1491-4225-8741-18611e8a1f6d	72d462e6-0a90-443a-90fa-dffddecd2fdb	1cf0113f-e7a2-48d9-af82-34af97cd7711	23	2023-04-01	2026-04-26 03:55:45.991711+00
00881d7b-7bc7-4b11-b769-fed15a6193cb	72d462e6-0a90-443a-90fa-dffddecd2fdb	1cf0113f-e7a2-48d9-af82-34af97cd7711	11	2023-05-01	2026-04-26 03:55:46.183761+00
b3f88c87-40a4-49f7-a885-c84b5bf4b1f3	72d462e6-0a90-443a-90fa-dffddecd2fdb	1cf0113f-e7a2-48d9-af82-34af97cd7711	12	2023-06-01	2026-04-26 03:55:46.373189+00
9cd68f82-0f83-4420-b84f-0826fe639ef8	72d462e6-0a90-443a-90fa-dffddecd2fdb	4fe20bda-0c54-4f70-b4b7-bfab711b0142	76	2023-01-01	2026-04-26 03:55:46.555845+00
29110160-4d33-419e-bb31-eb218542a433	72d462e6-0a90-443a-90fa-dffddecd2fdb	4fe20bda-0c54-4f70-b4b7-bfab711b0142	77	2023-02-01	2026-04-26 03:55:46.735542+00
c658c65e-9944-46f7-a98d-cafb51158b5a	72d462e6-0a90-443a-90fa-dffddecd2fdb	4fe20bda-0c54-4f70-b4b7-bfab711b0142	81	2023-03-01	2026-04-26 03:55:46.931748+00
8b638164-a5dd-4bfb-bda1-80cae48bdced	72d462e6-0a90-443a-90fa-dffddecd2fdb	4fe20bda-0c54-4f70-b4b7-bfab711b0142	76	2023-04-01	2026-04-26 03:55:47.109919+00
f15e8d14-b66c-4bb4-b34b-cda37c970386	72d462e6-0a90-443a-90fa-dffddecd2fdb	4fe20bda-0c54-4f70-b4b7-bfab711b0142	80	2023-05-01	2026-04-26 03:55:47.291648+00
801969d7-a215-49ec-ad92-58132dc3f7da	72d462e6-0a90-443a-90fa-dffddecd2fdb	4fe20bda-0c54-4f70-b4b7-bfab711b0142	72	2023-06-01	2026-04-26 03:55:47.4799+00
0da31f1b-e094-4fae-b8b1-34e7bcf73994	72d462e6-0a90-443a-90fa-dffddecd2fdb	0f1a9642-a470-4877-8a80-03ec68a554e6	11	2023-01-01	2026-04-26 03:55:47.785507+00
43633aa9-205d-4e69-a10b-8f227cfa4264	72d462e6-0a90-443a-90fa-dffddecd2fdb	0f1a9642-a470-4877-8a80-03ec68a554e6	15	2023-02-01	2026-04-26 03:55:48.085548+00
621cf3c3-b0b0-4f8e-b783-7a84ea77f397	72d462e6-0a90-443a-90fa-dffddecd2fdb	0f1a9642-a470-4877-8a80-03ec68a554e6	10	2023-03-01	2026-04-26 03:55:48.291916+00
15ab894d-4a47-41ea-8d4f-6fe4d63f48a2	72d462e6-0a90-443a-90fa-dffddecd2fdb	0f1a9642-a470-4877-8a80-03ec68a554e6	16	2023-04-01	2026-04-26 03:55:48.497274+00
232c7480-b0b2-43c0-a30f-9a36695a6c39	72d462e6-0a90-443a-90fa-dffddecd2fdb	0f1a9642-a470-4877-8a80-03ec68a554e6	1	2023-05-01	2026-04-26 03:55:48.710771+00
81778f1b-b5ff-45d1-acd6-4c0e5013b14d	72d462e6-0a90-443a-90fa-dffddecd2fdb	0f1a9642-a470-4877-8a80-03ec68a554e6	1	2023-06-01	2026-04-26 03:55:48.905631+00
9dd4dfc5-f9c8-4966-ae72-bc42882fb1c1	72d462e6-0a90-443a-90fa-dffddecd2fdb	17452181-e28a-4f21-8939-660b89286880	71	2023-01-01	2026-04-26 03:55:49.126024+00
4d44b40b-195b-4564-89f0-c00566c77e89	72d462e6-0a90-443a-90fa-dffddecd2fdb	17452181-e28a-4f21-8939-660b89286880	78	2023-02-01	2026-04-26 03:55:49.415521+00
d15228c5-98b7-437d-bf45-cacf593fd0e6	72d462e6-0a90-443a-90fa-dffddecd2fdb	17452181-e28a-4f21-8939-660b89286880	80	2023-03-01	2026-04-26 03:55:49.619976+00
7a3d5897-bab1-4d95-b731-789ae2c31a42	72d462e6-0a90-443a-90fa-dffddecd2fdb	17452181-e28a-4f21-8939-660b89286880	77	2023-04-01	2026-04-26 03:55:49.833195+00
0b6ea6ca-2e32-41de-9868-c2092a0b9f4b	72d462e6-0a90-443a-90fa-dffddecd2fdb	17452181-e28a-4f21-8939-660b89286880	77	2023-05-01	2026-04-26 03:55:50.032323+00
c7253c92-4f4d-4ef9-b19b-646fa9b393bd	72d462e6-0a90-443a-90fa-dffddecd2fdb	17452181-e28a-4f21-8939-660b89286880	85	2023-06-01	2026-04-26 03:55:50.242399+00
6dbd03a5-ff60-4e99-b48c-d176e73b613b	72d462e6-0a90-443a-90fa-dffddecd2fdb	62b26a05-ddac-4b02-80b1-c7a500feef95	57	2023-01-01	2026-04-26 03:55:50.442773+00
01fe83dd-9414-4e3c-91b5-9a509e8afd5a	72d462e6-0a90-443a-90fa-dffddecd2fdb	62b26a05-ddac-4b02-80b1-c7a500feef95	68	2023-02-01	2026-04-26 03:55:50.645481+00
c73905aa-1e3c-447b-be39-4c83401b254f	72d462e6-0a90-443a-90fa-dffddecd2fdb	62b26a05-ddac-4b02-80b1-c7a500feef95	61	2023-03-01	2026-04-26 03:55:50.851368+00
ba986211-52c6-4700-9634-2286f429ae1c	72d462e6-0a90-443a-90fa-dffddecd2fdb	62b26a05-ddac-4b02-80b1-c7a500feef95	61	2023-04-01	2026-04-26 03:55:51.055067+00
084f5a4d-05a6-428b-909e-5684034710bd	72d462e6-0a90-443a-90fa-dffddecd2fdb	62b26a05-ddac-4b02-80b1-c7a500feef95	60	2023-05-01	2026-04-26 03:55:51.255489+00
43c04867-d014-44b4-b1b9-19f2d5b011b6	72d462e6-0a90-443a-90fa-dffddecd2fdb	62b26a05-ddac-4b02-80b1-c7a500feef95	62	2023-06-01	2026-04-26 03:55:51.466704+00
2341c060-64c0-433f-9d25-bf336df94d49	72d462e6-0a90-443a-90fa-dffddecd2fdb	f49ee23c-aa92-4927-81cf-648587c88b30	62	2023-01-01	2026-04-26 03:55:51.772802+00
6c5baa32-704d-48f5-9b1d-5c734b54b0e3	72d462e6-0a90-443a-90fa-dffddecd2fdb	f49ee23c-aa92-4927-81cf-648587c88b30	58	2023-02-01	2026-04-26 03:55:51.975767+00
08e607c9-400e-4bfd-ab2a-1bb8ba9cc8f4	72d462e6-0a90-443a-90fa-dffddecd2fdb	f49ee23c-aa92-4927-81cf-648587c88b30	63	2023-03-01	2026-04-26 03:55:52.182526+00
fe7674ca-99ea-4aa4-96de-c839ceeb099b	72d462e6-0a90-443a-90fa-dffddecd2fdb	f49ee23c-aa92-4927-81cf-648587c88b30	69	2023-04-01	2026-04-26 03:55:52.396988+00
816ddf0d-8f24-4a7a-b297-674c99b56dd6	72d462e6-0a90-443a-90fa-dffddecd2fdb	f49ee23c-aa92-4927-81cf-648587c88b30	60	2023-05-01	2026-04-26 03:55:52.591978+00
08db8b41-076f-4042-a33f-171508cd06c8	72d462e6-0a90-443a-90fa-dffddecd2fdb	f49ee23c-aa92-4927-81cf-648587c88b30	51	2023-06-01	2026-04-26 03:55:52.797998+00
cab4aa3f-67b1-499f-9bad-1ffd7a5d7724	72d462e6-0a90-443a-90fa-dffddecd2fdb	bd8926a3-87d1-4f67-b23f-374f8748eddb	56	2023-01-01	2026-04-26 03:55:53.0023+00
26daae83-1268-4e39-b55d-f6a03147423e	72d462e6-0a90-443a-90fa-dffddecd2fdb	bd8926a3-87d1-4f67-b23f-374f8748eddb	56	2023-02-01	2026-04-26 03:55:53.227464+00
bd1f2398-27e3-4f59-827d-021c9ad8b640	72d462e6-0a90-443a-90fa-dffddecd2fdb	bd8926a3-87d1-4f67-b23f-374f8748eddb	55	2023-03-01	2026-04-26 03:55:53.509617+00
b57842ab-5db9-432a-852a-483b6ec35b9d	72d462e6-0a90-443a-90fa-dffddecd2fdb	bd8926a3-87d1-4f67-b23f-374f8748eddb	67	2023-04-01	2026-04-26 03:55:53.750974+00
8df4c72b-9895-40f1-8a10-dd42064cdbe5	72d462e6-0a90-443a-90fa-dffddecd2fdb	bd8926a3-87d1-4f67-b23f-374f8748eddb	65	2023-05-01	2026-04-26 03:55:54.024987+00
e7726607-ef3d-4700-b07e-55386389d40c	72d462e6-0a90-443a-90fa-dffddecd2fdb	bd8926a3-87d1-4f67-b23f-374f8748eddb	66	2023-06-01	2026-04-26 03:55:54.245685+00
b131695a-51cd-4627-b91a-f93a3b60de93	72d462e6-0a90-443a-90fa-dffddecd2fdb	45bbd44d-5281-453b-aed8-5874d75cdb2c	58	2023-01-01	2026-04-26 03:55:54.537288+00
cd7af0ac-42a9-4b3c-a52b-9abe618415e1	72d462e6-0a90-443a-90fa-dffddecd2fdb	45bbd44d-5281-453b-aed8-5874d75cdb2c	63	2023-02-01	2026-04-26 03:55:54.746937+00
717611e3-2ac3-4855-a8a0-e41c8315997e	72d462e6-0a90-443a-90fa-dffddecd2fdb	45bbd44d-5281-453b-aed8-5874d75cdb2c	59	2023-03-01	2026-04-26 03:55:54.956673+00
80ce2e75-9b60-4c0a-924e-11935a8f99ec	72d462e6-0a90-443a-90fa-dffddecd2fdb	45bbd44d-5281-453b-aed8-5874d75cdb2c	53	2023-04-01	2026-04-26 03:55:55.150786+00
424638bd-1070-4d28-91b1-0e62c671c826	72d462e6-0a90-443a-90fa-dffddecd2fdb	45bbd44d-5281-453b-aed8-5874d75cdb2c	62	2023-05-01	2026-04-26 03:55:55.368592+00
3220908a-fed2-4338-949d-31632d42df21	72d462e6-0a90-443a-90fa-dffddecd2fdb	45bbd44d-5281-453b-aed8-5874d75cdb2c	53	2023-06-01	2026-04-26 03:55:55.572523+00
e68f34ad-0bf0-478a-ab6f-d27305d49ac2	7fd37699-1e3c-42af-af4c-643c4b7e9510	f84c7f2e-f45d-4011-8f83-75fa33b2a027	1995	2023-01-01	2026-04-26 03:55:55.767965+00
4df8f732-9962-4453-9025-5c6320a3604e	7fd37699-1e3c-42af-af4c-643c4b7e9510	f84c7f2e-f45d-4011-8f83-75fa33b2a027	2008	2023-02-01	2026-04-26 03:55:55.976469+00
cbf5e0f6-19d2-433d-a706-3c26c502d9d3	7fd37699-1e3c-42af-af4c-643c4b7e9510	f84c7f2e-f45d-4011-8f83-75fa33b2a027	1996	2023-03-01	2026-04-26 03:55:56.177855+00
6bcc2143-c0fa-4a7a-833a-523789b38be3	7fd37699-1e3c-42af-af4c-643c4b7e9510	f84c7f2e-f45d-4011-8f83-75fa33b2a027	2000	2023-04-01	2026-04-26 03:55:56.385012+00
c6b7cbed-b029-46e9-b208-3a70c66cd586	7fd37699-1e3c-42af-af4c-643c4b7e9510	f84c7f2e-f45d-4011-8f83-75fa33b2a027	2013	2023-05-01	2026-04-26 03:55:56.587463+00
d839e8d0-5115-424a-8c26-f970c1605b85	7fd37699-1e3c-42af-af4c-643c4b7e9510	f84c7f2e-f45d-4011-8f83-75fa33b2a027	2014	2023-06-01	2026-04-26 03:55:56.783649+00
f8372ad1-da70-4146-aedf-f3546d5ec09b	7fd37699-1e3c-42af-af4c-643c4b7e9510	bd27283a-985f-4006-ada1-23b7328afd6d	83	2023-01-01	2026-04-26 03:55:56.998472+00
2ae53638-ac58-41a4-aee7-90387cf27fd0	7fd37699-1e3c-42af-af4c-643c4b7e9510	bd27283a-985f-4006-ada1-23b7328afd6d	79	2023-02-01	2026-04-26 03:55:57.195891+00
576ee515-ba1a-450c-a80d-8237bd3eb25b	7fd37699-1e3c-42af-af4c-643c4b7e9510	bd27283a-985f-4006-ada1-23b7328afd6d	85	2023-03-01	2026-04-26 03:55:57.40366+00
163ef995-e716-4d71-9a36-8ce5ab44e97c	7fd37699-1e3c-42af-af4c-643c4b7e9510	bd27283a-985f-4006-ada1-23b7328afd6d	83	2023-04-01	2026-04-26 03:55:57.60564+00
1da8ca1f-e1cc-42b5-9ba9-77fcbfa563d3	7fd37699-1e3c-42af-af4c-643c4b7e9510	bd27283a-985f-4006-ada1-23b7328afd6d	79	2023-05-01	2026-04-26 03:55:57.813973+00
20c5af6c-1349-4a08-9cbc-ead1ae9a1c91	7fd37699-1e3c-42af-af4c-643c4b7e9510	bd27283a-985f-4006-ada1-23b7328afd6d	75	2023-06-01	2026-04-26 03:55:58.014292+00
50bc6fd9-323c-4bd5-8b7b-277d4d4538f6	7fd37699-1e3c-42af-af4c-643c4b7e9510	1cf0113f-e7a2-48d9-af82-34af97cd7711	7	2023-01-01	2026-04-26 03:55:58.227374+00
925296aa-39c9-4395-a012-393ca8e68cbc	7fd37699-1e3c-42af-af4c-643c4b7e9510	1cf0113f-e7a2-48d9-af82-34af97cd7711	8	2023-02-01	2026-04-26 03:55:58.425015+00
205e86a6-f07c-475d-a384-25c2effb86c8	7fd37699-1e3c-42af-af4c-643c4b7e9510	1cf0113f-e7a2-48d9-af82-34af97cd7711	10	2023-03-01	2026-04-26 03:55:58.632626+00
80b5a121-aa6f-4049-9154-f35b89bc2b0a	7fd37699-1e3c-42af-af4c-643c4b7e9510	1cf0113f-e7a2-48d9-af82-34af97cd7711	15	2023-04-01	2026-04-26 03:55:58.834425+00
4466d485-00f9-4397-b6ad-3c5d0ca1f375	7fd37699-1e3c-42af-af4c-643c4b7e9510	1cf0113f-e7a2-48d9-af82-34af97cd7711	12	2023-05-01	2026-04-26 03:55:59.160337+00
6642c22b-af3d-4937-bf30-988f1a276355	7fd37699-1e3c-42af-af4c-643c4b7e9510	1cf0113f-e7a2-48d9-af82-34af97cd7711	19	2023-06-01	2026-04-26 03:55:59.355898+00
5677893f-4690-4847-aee0-3398c0b448ff	7fd37699-1e3c-42af-af4c-643c4b7e9510	4fe20bda-0c54-4f70-b4b7-bfab711b0142	76	2023-01-01	2026-04-26 03:55:59.559049+00
12ccfaa2-fdca-4d64-828c-97e828e24398	7fd37699-1e3c-42af-af4c-643c4b7e9510	4fe20bda-0c54-4f70-b4b7-bfab711b0142	87	2023-02-01	2026-04-26 03:55:59.763504+00
a965c293-04a4-4f7a-8657-5de3e39e19d9	7fd37699-1e3c-42af-af4c-643c4b7e9510	4fe20bda-0c54-4f70-b4b7-bfab711b0142	82	2023-03-01	2026-04-26 03:55:59.97518+00
ed8d6698-211e-4846-b559-1748815c6402	7fd37699-1e3c-42af-af4c-643c4b7e9510	4fe20bda-0c54-4f70-b4b7-bfab711b0142	91	2023-04-01	2026-04-26 03:56:00.270893+00
b6c9f3d4-6899-4bd7-a31a-ef23b5406d2b	7fd37699-1e3c-42af-af4c-643c4b7e9510	4fe20bda-0c54-4f70-b4b7-bfab711b0142	97	2023-05-01	2026-04-26 03:56:00.482812+00
9c5042f3-2504-4199-9dae-2a049bb9344d	7fd37699-1e3c-42af-af4c-643c4b7e9510	4fe20bda-0c54-4f70-b4b7-bfab711b0142	84	2023-06-01	2026-04-26 03:56:00.786563+00
5b6b0c53-a2e4-420c-9c99-8f42861a511e	7fd37699-1e3c-42af-af4c-643c4b7e9510	0f1a9642-a470-4877-8a80-03ec68a554e6	9	2023-01-01	2026-04-26 03:56:00.98311+00
b490605b-fd0b-4058-9d97-c2bbeb74346e	7fd37699-1e3c-42af-af4c-643c4b7e9510	0f1a9642-a470-4877-8a80-03ec68a554e6	7	2023-02-01	2026-04-26 03:56:01.188229+00
91c0c5cf-106e-474e-a151-8c1d65ed99b4	7fd37699-1e3c-42af-af4c-643c4b7e9510	0f1a9642-a470-4877-8a80-03ec68a554e6	7	2023-03-01	2026-04-26 03:56:01.406532+00
d1684559-6032-4ecd-8d85-dc630edf4677	7fd37699-1e3c-42af-af4c-643c4b7e9510	0f1a9642-a470-4877-8a80-03ec68a554e6	5	2023-04-01	2026-04-26 03:56:01.600783+00
d7262d03-3681-49b7-9c3c-6ca2ddbd4d84	7fd37699-1e3c-42af-af4c-643c4b7e9510	0f1a9642-a470-4877-8a80-03ec68a554e6	19	2023-05-01	2026-04-26 03:56:01.787333+00
61a5693a-16c0-4472-9a30-7d7017eccb4a	7fd37699-1e3c-42af-af4c-643c4b7e9510	0f1a9642-a470-4877-8a80-03ec68a554e6	15	2023-06-01	2026-04-26 03:56:01.962533+00
74e3fb85-8de4-4fbb-a668-7d432d6e73b5	7fd37699-1e3c-42af-af4c-643c4b7e9510	17452181-e28a-4f21-8939-660b89286880	80	2023-01-01	2026-04-26 03:56:02.150175+00
45980e4f-ea7e-410c-b2dc-93eec5d8e3d1	7fd37699-1e3c-42af-af4c-643c4b7e9510	17452181-e28a-4f21-8939-660b89286880	75	2023-02-01	2026-04-26 03:56:02.325441+00
c9c755a7-dc3b-46c2-9e65-0d3e54783119	7fd37699-1e3c-42af-af4c-643c4b7e9510	17452181-e28a-4f21-8939-660b89286880	72	2023-03-01	2026-04-26 03:56:02.498929+00
f4c4cae1-afd8-40b8-8203-467aaea0fc33	7fd37699-1e3c-42af-af4c-643c4b7e9510	17452181-e28a-4f21-8939-660b89286880	66	2023-04-01	2026-04-26 03:56:02.673094+00
5e044843-4acb-46de-8e46-ba4615fd4fdc	7fd37699-1e3c-42af-af4c-643c4b7e9510	17452181-e28a-4f21-8939-660b89286880	86	2023-05-01	2026-04-26 03:56:02.852406+00
4908102c-0b26-4db8-b3d5-ffe8494abf69	7fd37699-1e3c-42af-af4c-643c4b7e9510	17452181-e28a-4f21-8939-660b89286880	80	2023-06-01	2026-04-26 03:56:03.03764+00
488b31c1-b81c-4cc1-a3ac-d5e29eca8bfb	7fd37699-1e3c-42af-af4c-643c4b7e9510	62b26a05-ddac-4b02-80b1-c7a500feef95	60	2023-01-01	2026-04-26 03:56:03.213142+00
884dcff8-6fa2-40a7-9661-6c7bcb61785a	7fd37699-1e3c-42af-af4c-643c4b7e9510	62b26a05-ddac-4b02-80b1-c7a500feef95	58	2023-02-01	2026-04-26 03:56:03.388634+00
2f402510-ac69-4705-b13e-b923bb70b23c	7fd37699-1e3c-42af-af4c-643c4b7e9510	62b26a05-ddac-4b02-80b1-c7a500feef95	63	2023-03-01	2026-04-26 03:56:03.568516+00
6227a7ae-7a7e-4195-b488-b40b206cd1a9	7fd37699-1e3c-42af-af4c-643c4b7e9510	62b26a05-ddac-4b02-80b1-c7a500feef95	60	2023-04-01	2026-04-26 03:56:03.741504+00
9c050a02-0a28-46ca-866d-3fb54404a3d9	7fd37699-1e3c-42af-af4c-643c4b7e9510	62b26a05-ddac-4b02-80b1-c7a500feef95	69	2023-05-01	2026-04-26 03:56:03.923411+00
49dbf68f-c96f-4a56-bd99-9388ff0e8612	7fd37699-1e3c-42af-af4c-643c4b7e9510	62b26a05-ddac-4b02-80b1-c7a500feef95	59	2023-06-01	2026-04-26 03:56:04.115919+00
b8537a85-a72d-4ea2-88d3-84286545903e	7fd37699-1e3c-42af-af4c-643c4b7e9510	f49ee23c-aa92-4927-81cf-648587c88b30	56	2023-01-01	2026-04-26 03:56:04.309168+00
8617b5c1-78a2-4cec-a019-17c7bf7a07ef	7fd37699-1e3c-42af-af4c-643c4b7e9510	f49ee23c-aa92-4927-81cf-648587c88b30	59	2023-02-01	2026-04-26 03:56:04.491671+00
91d7e157-5348-4673-a92b-bcd9eaf78334	7fd37699-1e3c-42af-af4c-643c4b7e9510	f49ee23c-aa92-4927-81cf-648587c88b30	62	2023-03-01	2026-04-26 03:56:04.664935+00
71d3695d-aa2d-4590-bc34-70652b533e51	7fd37699-1e3c-42af-af4c-643c4b7e9510	f49ee23c-aa92-4927-81cf-648587c88b30	59	2023-04-01	2026-04-26 03:56:04.846784+00
2b78d08a-2ab8-4137-be4b-4b40f45a5be0	7fd37699-1e3c-42af-af4c-643c4b7e9510	f49ee23c-aa92-4927-81cf-648587c88b30	65	2023-05-01	2026-04-26 03:56:05.057278+00
9490e7cc-11fe-4f33-a237-17fb489fa789	7fd37699-1e3c-42af-af4c-643c4b7e9510	f49ee23c-aa92-4927-81cf-648587c88b30	67	2023-06-01	2026-04-26 03:56:05.248002+00
12531536-3f9f-421d-bb88-07a26edb4c13	7fd37699-1e3c-42af-af4c-643c4b7e9510	bd8926a3-87d1-4f67-b23f-374f8748eddb	64	2023-01-01	2026-04-26 03:56:05.434709+00
b77b81f4-f288-4820-b985-a71547ac793e	7fd37699-1e3c-42af-af4c-643c4b7e9510	bd8926a3-87d1-4f67-b23f-374f8748eddb	61	2023-02-01	2026-04-26 03:56:05.610908+00
30e96131-3e90-48e7-9825-4309b3179f79	7fd37699-1e3c-42af-af4c-643c4b7e9510	bd8926a3-87d1-4f67-b23f-374f8748eddb	61	2023-03-01	2026-04-26 03:56:05.799094+00
363a4def-5e97-474b-8c4c-63962265ae8b	7fd37699-1e3c-42af-af4c-643c4b7e9510	bd8926a3-87d1-4f67-b23f-374f8748eddb	58	2023-04-01	2026-04-26 03:56:06.003621+00
064dac8a-fb0c-4b36-91b6-7e16e9a1ed0c	7fd37699-1e3c-42af-af4c-643c4b7e9510	bd8926a3-87d1-4f67-b23f-374f8748eddb	68	2023-05-01	2026-04-26 03:56:06.187024+00
0353fd36-12ed-42cd-b2b4-5e9006965f4e	7fd37699-1e3c-42af-af4c-643c4b7e9510	bd8926a3-87d1-4f67-b23f-374f8748eddb	74	2023-06-01	2026-04-26 03:56:06.386455+00
13f6b1f4-85bd-434b-9bb8-e5edcee2342b	7fd37699-1e3c-42af-af4c-643c4b7e9510	45bbd44d-5281-453b-aed8-5874d75cdb2c	60	2023-01-01	2026-04-26 03:56:06.567222+00
7e7a3137-6603-4f62-9b86-4585956e1ec9	7fd37699-1e3c-42af-af4c-643c4b7e9510	45bbd44d-5281-453b-aed8-5874d75cdb2c	57	2023-02-01	2026-04-26 03:56:06.751847+00
878ea29b-bdda-45df-8cf8-f83fd4d460de	7fd37699-1e3c-42af-af4c-643c4b7e9510	45bbd44d-5281-453b-aed8-5874d75cdb2c	70	2023-03-01	2026-04-26 03:56:06.94046+00
558f9abe-3c0c-4bda-a19d-e2698e52f4b2	7fd37699-1e3c-42af-af4c-643c4b7e9510	45bbd44d-5281-453b-aed8-5874d75cdb2c	68	2023-04-01	2026-04-26 03:56:07.124528+00
dcf21672-742b-49c0-bda7-16d074d24de3	7fd37699-1e3c-42af-af4c-643c4b7e9510	45bbd44d-5281-453b-aed8-5874d75cdb2c	67	2023-05-01	2026-04-26 03:56:07.299382+00
715bed39-bc95-48ff-ab48-9c2349562d9c	7fd37699-1e3c-42af-af4c-643c4b7e9510	45bbd44d-5281-453b-aed8-5874d75cdb2c	50	2023-06-01	2026-04-26 03:56:07.482675+00
99651cea-df22-4606-92d0-8ab7c687b619	de593827-e016-4882-bb1b-a1fed2556756	f84c7f2e-f45d-4011-8f83-75fa33b2a027	1997	2023-01-01	2026-04-26 03:56:07.743298+00
21c56c93-d9f7-4fff-bbc7-ef0238cb7eee	de593827-e016-4882-bb1b-a1fed2556756	f84c7f2e-f45d-4011-8f83-75fa33b2a027	2000	2023-02-01	2026-04-26 03:56:07.948473+00
def75479-64e1-47fc-86df-46fd3c6f6afe	de593827-e016-4882-bb1b-a1fed2556756	f84c7f2e-f45d-4011-8f83-75fa33b2a027	2003	2023-03-01	2026-04-26 03:56:08.15399+00
a4a0076f-fdad-4e7d-acad-a65fbd6a7383	de593827-e016-4882-bb1b-a1fed2556756	f84c7f2e-f45d-4011-8f83-75fa33b2a027	2002	2023-04-01	2026-04-26 03:56:08.361597+00
d5bc2531-a046-44e3-b121-47764948a6fc	de593827-e016-4882-bb1b-a1fed2556756	f84c7f2e-f45d-4011-8f83-75fa33b2a027	2007	2023-05-01	2026-04-26 03:56:08.564415+00
148d5728-2218-4533-98ab-1c2544d774ff	de593827-e016-4882-bb1b-a1fed2556756	f84c7f2e-f45d-4011-8f83-75fa33b2a027	1992	2023-06-01	2026-04-26 03:56:08.768186+00
42707891-b671-4375-8558-d1ddf9d113ef	de593827-e016-4882-bb1b-a1fed2556756	bd27283a-985f-4006-ada1-23b7328afd6d	75	2023-01-01	2026-04-26 03:56:08.976084+00
c3a543ba-c5ee-49ca-b046-d075805c7834	de593827-e016-4882-bb1b-a1fed2556756	bd27283a-985f-4006-ada1-23b7328afd6d	79	2023-02-01	2026-04-26 03:56:09.18954+00
f48acd7b-b444-492b-b469-4c3cda559521	de593827-e016-4882-bb1b-a1fed2556756	bd27283a-985f-4006-ada1-23b7328afd6d	81	2023-03-01	2026-04-26 03:56:09.381924+00
eb47ab7e-0fc6-4a85-abfe-79ddfce79dea	de593827-e016-4882-bb1b-a1fed2556756	bd27283a-985f-4006-ada1-23b7328afd6d	85	2023-04-01	2026-04-26 03:56:09.604957+00
b8c7ab84-e029-4180-befb-12539ab2b9cb	de593827-e016-4882-bb1b-a1fed2556756	bd27283a-985f-4006-ada1-23b7328afd6d	91	2023-05-01	2026-04-26 03:56:09.895777+00
1f2d8de4-e15b-4122-a4f9-f885f7688bb1	de593827-e016-4882-bb1b-a1fed2556756	bd27283a-985f-4006-ada1-23b7328afd6d	89	2023-06-01	2026-04-26 03:56:10.100055+00
c715083a-c5fc-4f85-bd61-893896c5e890	de593827-e016-4882-bb1b-a1fed2556756	1cf0113f-e7a2-48d9-af82-34af97cd7711	15	2023-01-01	2026-04-26 03:56:10.314977+00
9d6076a3-ba3f-4705-9664-fabf35424c0c	de593827-e016-4882-bb1b-a1fed2556756	1cf0113f-e7a2-48d9-af82-34af97cd7711	8	2023-02-01	2026-04-26 03:56:10.509496+00
8e3321e9-016c-43fb-82fd-70550cd7c162	de593827-e016-4882-bb1b-a1fed2556756	1cf0113f-e7a2-48d9-af82-34af97cd7711	8	2023-03-01	2026-04-26 03:56:10.720441+00
f8a65dea-e9d4-444c-b315-50f0462c249e	de593827-e016-4882-bb1b-a1fed2556756	1cf0113f-e7a2-48d9-af82-34af97cd7711	17	2023-04-01	2026-04-26 03:56:10.927091+00
4db28f91-b735-4a1a-8a15-682d808c7d66	de593827-e016-4882-bb1b-a1fed2556756	1cf0113f-e7a2-48d9-af82-34af97cd7711	17	2023-05-01	2026-04-26 03:56:11.125095+00
beadefc5-259b-4762-adb2-fea48ca3b0e6	de593827-e016-4882-bb1b-a1fed2556756	1cf0113f-e7a2-48d9-af82-34af97cd7711	22	2023-06-01	2026-04-26 03:56:11.335598+00
911ed400-9ce6-4b8d-b5d5-57b6c19bafb8	de593827-e016-4882-bb1b-a1fed2556756	4fe20bda-0c54-4f70-b4b7-bfab711b0142	78	2023-01-01	2026-04-26 03:56:11.519163+00
abb8f142-34e1-4379-9e85-072e68c19e26	de593827-e016-4882-bb1b-a1fed2556756	4fe20bda-0c54-4f70-b4b7-bfab711b0142	85	2023-02-01	2026-04-26 03:56:11.710049+00
84c315b6-784d-40db-9d49-32a94f7ebf12	de593827-e016-4882-bb1b-a1fed2556756	4fe20bda-0c54-4f70-b4b7-bfab711b0142	81	2023-03-01	2026-04-26 03:56:11.903203+00
08ee8e2c-f0c9-43d6-a7bc-e3304157bce7	de593827-e016-4882-bb1b-a1fed2556756	4fe20bda-0c54-4f70-b4b7-bfab711b0142	75	2023-04-01	2026-04-26 03:56:12.091297+00
15eb641c-e878-407c-96b4-772585d0f0db	de593827-e016-4882-bb1b-a1fed2556756	4fe20bda-0c54-4f70-b4b7-bfab711b0142	69	2023-05-01	2026-04-26 03:56:12.277775+00
62f5f89c-d21b-4e64-bc5b-2f491c13cf6a	de593827-e016-4882-bb1b-a1fed2556756	4fe20bda-0c54-4f70-b4b7-bfab711b0142	95	2023-06-01	2026-04-26 03:56:12.47766+00
e9a17169-88a4-4080-bb15-af9fb25ca1c6	de593827-e016-4882-bb1b-a1fed2556756	0f1a9642-a470-4877-8a80-03ec68a554e6	6	2023-01-01	2026-04-26 03:56:12.663915+00
8f0fde81-36d7-4652-a23a-7ca664429594	de593827-e016-4882-bb1b-a1fed2556756	0f1a9642-a470-4877-8a80-03ec68a554e6	11	2023-02-01	2026-04-26 03:56:12.849945+00
27904709-5ab7-4151-a8db-f5da834702b2	de593827-e016-4882-bb1b-a1fed2556756	0f1a9642-a470-4877-8a80-03ec68a554e6	2	2023-03-01	2026-04-26 03:56:13.035371+00
6cbff6b5-2b9e-422e-9ce4-83c50d5cc349	de593827-e016-4882-bb1b-a1fed2556756	0f1a9642-a470-4877-8a80-03ec68a554e6	9	2023-04-01	2026-04-26 03:56:13.209548+00
b38e34fd-5b31-4fa9-bce9-378c6390bfa8	de593827-e016-4882-bb1b-a1fed2556756	0f1a9642-a470-4877-8a80-03ec68a554e6	20	2023-05-01	2026-04-26 03:56:13.384753+00
c9cfd648-508c-4b00-8db1-42a1f515a711	de593827-e016-4882-bb1b-a1fed2556756	0f1a9642-a470-4877-8a80-03ec68a554e6	18	2023-06-01	2026-04-26 03:56:13.587939+00
f9f50cdd-d812-4874-aac2-9aaaab746590	de593827-e016-4882-bb1b-a1fed2556756	17452181-e28a-4f21-8939-660b89286880	72	2023-01-01	2026-04-26 03:56:13.790409+00
32317295-5a13-4757-bca4-2b13049051cf	de593827-e016-4882-bb1b-a1fed2556756	17452181-e28a-4f21-8939-660b89286880	76	2023-02-01	2026-04-26 03:56:13.99574+00
e1fb2bb6-d432-47f6-92bf-4cb3cd8b6c2c	de593827-e016-4882-bb1b-a1fed2556756	17452181-e28a-4f21-8939-660b89286880	78	2023-03-01	2026-04-26 03:56:14.202634+00
b3b4991b-da6c-4470-b7dd-2af2a8762af2	de593827-e016-4882-bb1b-a1fed2556756	17452181-e28a-4f21-8939-660b89286880	86	2023-04-01	2026-04-26 03:56:14.403967+00
1d454f72-f4d4-4980-948d-eae6cdad3f91	de593827-e016-4882-bb1b-a1fed2556756	17452181-e28a-4f21-8939-660b89286880	68	2023-05-01	2026-04-26 03:56:14.620317+00
04d373fb-5cdc-442d-b421-011db55f1797	de593827-e016-4882-bb1b-a1fed2556756	17452181-e28a-4f21-8939-660b89286880	84	2023-06-01	2026-04-26 03:56:14.829668+00
fa52379a-17a6-42c2-87ba-334ba21b97b7	de593827-e016-4882-bb1b-a1fed2556756	62b26a05-ddac-4b02-80b1-c7a500feef95	64	2023-02-01	2026-04-26 03:56:15.220298+00
66878bfa-830f-43a8-9546-ff837a56bd4f	de593827-e016-4882-bb1b-a1fed2556756	62b26a05-ddac-4b02-80b1-c7a500feef95	63	2023-03-01	2026-04-26 03:56:15.424614+00
37c4f8fd-ff26-4b22-abdb-a60acb49eabe	de593827-e016-4882-bb1b-a1fed2556756	62b26a05-ddac-4b02-80b1-c7a500feef95	55	2023-04-01	2026-04-26 03:56:15.633783+00
674c2a65-55e2-40d4-bb00-b01fa97cc36c	de593827-e016-4882-bb1b-a1fed2556756	62b26a05-ddac-4b02-80b1-c7a500feef95	56	2023-05-01	2026-04-26 03:56:15.845158+00
e77e4237-62fe-4bbf-be56-6cfd5bcb4610	de593827-e016-4882-bb1b-a1fed2556756	62b26a05-ddac-4b02-80b1-c7a500feef95	53	2023-06-01	2026-04-26 03:56:16.04227+00
2c44983b-6912-49ca-ad12-251968ac08eb	de593827-e016-4882-bb1b-a1fed2556756	f49ee23c-aa92-4927-81cf-648587c88b30	65	2023-01-01	2026-04-26 03:56:16.240048+00
e386f1cd-1242-4201-8a3d-5b8926a14337	de593827-e016-4882-bb1b-a1fed2556756	f49ee23c-aa92-4927-81cf-648587c88b30	60	2023-02-01	2026-04-26 03:56:16.451848+00
61657ac7-905c-49f4-8aa5-3378d8645d06	de593827-e016-4882-bb1b-a1fed2556756	f49ee23c-aa92-4927-81cf-648587c88b30	54	2023-03-01	2026-04-26 03:56:16.75501+00
b4c76ddd-4003-4bad-a5b5-e9ef8fdb8bf5	de593827-e016-4882-bb1b-a1fed2556756	f49ee23c-aa92-4927-81cf-648587c88b30	62	2023-04-01	2026-04-26 03:56:16.960911+00
f134a2a9-6762-4d0f-ad5f-993aaf9c7199	de593827-e016-4882-bb1b-a1fed2556756	62b26a05-ddac-4b02-80b1-c7a500feef95	61	2023-01-01	2026-04-26 03:56:15.021816+00
adda9826-e09e-4bd1-8188-c6870966dfca	de593827-e016-4882-bb1b-a1fed2556756	f49ee23c-aa92-4927-81cf-648587c88b30	65	2023-05-01	2026-04-26 03:56:17.167336+00
94c56619-2c2e-4e20-b32b-9226ad8c52d0	de593827-e016-4882-bb1b-a1fed2556756	f49ee23c-aa92-4927-81cf-648587c88b30	65	2023-06-01	2026-04-26 03:56:17.371491+00
460d2bf8-493b-4956-af7b-246587bbaeb9	de593827-e016-4882-bb1b-a1fed2556756	bd8926a3-87d1-4f67-b23f-374f8748eddb	62	2023-01-01	2026-04-26 03:56:17.576404+00
d39a2798-aca2-4b96-be9a-0fb4e1769dcb	de593827-e016-4882-bb1b-a1fed2556756	bd8926a3-87d1-4f67-b23f-374f8748eddb	59	2023-02-01	2026-04-26 03:56:17.78052+00
047cfbec-dc12-4b84-bfd3-f520f907e303	de593827-e016-4882-bb1b-a1fed2556756	bd8926a3-87d1-4f67-b23f-374f8748eddb	61	2023-03-01	2026-04-26 03:56:17.986109+00
5c2b6492-6f8b-40d2-a6b7-e9c7e16bfe7f	de593827-e016-4882-bb1b-a1fed2556756	bd8926a3-87d1-4f67-b23f-374f8748eddb	59	2023-04-01	2026-04-26 03:56:18.189971+00
b7503ee7-1c2d-45a0-bc5c-122379c89021	de593827-e016-4882-bb1b-a1fed2556756	bd8926a3-87d1-4f67-b23f-374f8748eddb	54	2023-05-01	2026-04-26 03:56:18.391271+00
21eca534-ebb0-483f-b512-1bb064a05335	de593827-e016-4882-bb1b-a1fed2556756	bd8926a3-87d1-4f67-b23f-374f8748eddb	66	2023-06-01	2026-04-26 03:56:18.589852+00
adf6400e-d158-4dd2-bfca-9e6bdbba3306	de593827-e016-4882-bb1b-a1fed2556756	45bbd44d-5281-453b-aed8-5874d75cdb2c	64	2023-01-01	2026-04-26 03:56:18.807543+00
d1a2c018-9b6d-484d-9f5e-03f2f1bb9c77	de593827-e016-4882-bb1b-a1fed2556756	45bbd44d-5281-453b-aed8-5874d75cdb2c	62	2023-02-01	2026-04-26 03:56:19.010838+00
52092677-9f87-49f6-909d-b8c3460c3070	de593827-e016-4882-bb1b-a1fed2556756	45bbd44d-5281-453b-aed8-5874d75cdb2c	58	2023-03-01	2026-04-26 03:56:19.21766+00
222ef47e-3118-4190-a01d-812dbd447bc4	de593827-e016-4882-bb1b-a1fed2556756	45bbd44d-5281-453b-aed8-5874d75cdb2c	73	2023-04-01	2026-04-26 03:56:19.414053+00
a091d2d7-c09a-430e-989c-cb2d74689f69	de593827-e016-4882-bb1b-a1fed2556756	45bbd44d-5281-453b-aed8-5874d75cdb2c	75	2023-05-01	2026-04-26 03:56:19.618866+00
7d4889d7-cea7-4c7d-a93e-82afccbae089	de593827-e016-4882-bb1b-a1fed2556756	45bbd44d-5281-453b-aed8-5874d75cdb2c	60	2023-06-01	2026-04-26 03:56:19.83044+00
c34148ab-7178-48b3-b163-5fd3304bbfab	8d1d0b4f-dd62-4374-90ca-d174dcdd57ac	f84c7f2e-f45d-4011-8f83-75fa33b2a027	2000	2023-01-01	2026-04-26 03:56:20.041393+00
481f4f32-21a9-4fac-83bd-1d64e181b8de	8d1d0b4f-dd62-4374-90ca-d174dcdd57ac	f84c7f2e-f45d-4011-8f83-75fa33b2a027	2000	2023-02-01	2026-04-26 03:56:20.236704+00
a1bcefd7-7e42-4a32-a679-3bc36e420e8d	8d1d0b4f-dd62-4374-90ca-d174dcdd57ac	f84c7f2e-f45d-4011-8f83-75fa33b2a027	2002	2023-03-01	2026-04-26 03:56:20.452557+00
78a009fb-280b-4295-b646-ca9239fda2a8	8d1d0b4f-dd62-4374-90ca-d174dcdd57ac	f84c7f2e-f45d-4011-8f83-75fa33b2a027	2002	2023-04-01	2026-04-26 03:56:20.644215+00
e61c1231-cc5f-4934-b1f9-adce5c00e842	8d1d0b4f-dd62-4374-90ca-d174dcdd57ac	f84c7f2e-f45d-4011-8f83-75fa33b2a027	2014	2023-05-01	2026-04-26 03:56:20.858711+00
bc423780-3c19-42f3-b395-0f54bcdcd9dd	8d1d0b4f-dd62-4374-90ca-d174dcdd57ac	f84c7f2e-f45d-4011-8f83-75fa33b2a027	2011	2023-06-01	2026-04-26 03:56:21.071757+00
7079b697-3be7-4146-a89e-a312c0eac41b	8d1d0b4f-dd62-4374-90ca-d174dcdd57ac	bd27283a-985f-4006-ada1-23b7328afd6d	82	2023-01-01	2026-04-26 03:56:21.271431+00
ff3ea82d-16b4-4179-bade-168ddb476d46	8d1d0b4f-dd62-4374-90ca-d174dcdd57ac	bd27283a-985f-4006-ada1-23b7328afd6d	82	2023-02-01	2026-04-26 03:56:21.479527+00
f3360e3b-7c8c-4edd-8e3e-0ddccc617c6f	8d1d0b4f-dd62-4374-90ca-d174dcdd57ac	bd27283a-985f-4006-ada1-23b7328afd6d	75	2023-03-01	2026-04-26 03:56:21.774587+00
d7e78539-6d16-44ba-b207-e8abf060a872	8d1d0b4f-dd62-4374-90ca-d174dcdd57ac	bd27283a-985f-4006-ada1-23b7328afd6d	81	2023-04-01	2026-04-26 03:56:21.978823+00
eb3075a5-6790-4cb3-b9fe-4b7317d32d15	8d1d0b4f-dd62-4374-90ca-d174dcdd57ac	bd27283a-985f-4006-ada1-23b7328afd6d	77	2023-05-01	2026-04-26 03:56:22.192854+00
b9df7722-9f53-48e0-9891-a7ac561b589d	8d1d0b4f-dd62-4374-90ca-d174dcdd57ac	bd27283a-985f-4006-ada1-23b7328afd6d	97	2023-06-01	2026-04-26 03:56:22.39122+00
b6eb5e2f-a30d-47f2-9389-e3552fdec6fc	8d1d0b4f-dd62-4374-90ca-d174dcdd57ac	1cf0113f-e7a2-48d9-af82-34af97cd7711	13	2023-01-01	2026-04-26 03:56:22.576783+00
674aab81-42df-4316-aba8-c77d1976b718	8d1d0b4f-dd62-4374-90ca-d174dcdd57ac	1cf0113f-e7a2-48d9-af82-34af97cd7711	8	2023-02-01	2026-04-26 03:56:22.799799+00
1ac580c4-19e5-45ee-85b1-d4d9143ba2f9	8d1d0b4f-dd62-4374-90ca-d174dcdd57ac	1cf0113f-e7a2-48d9-af82-34af97cd7711	7	2023-03-01	2026-04-26 03:56:23.012185+00
e7eca31e-86a1-4446-a064-041032f3422c	8d1d0b4f-dd62-4374-90ca-d174dcdd57ac	1cf0113f-e7a2-48d9-af82-34af97cd7711	12	2023-04-01	2026-04-26 03:56:23.20475+00
5ae22d69-8024-4e2c-882c-626134596db3	8d1d0b4f-dd62-4374-90ca-d174dcdd57ac	1cf0113f-e7a2-48d9-af82-34af97cd7711	14	2023-05-01	2026-04-26 03:56:23.408996+00
7d8ff532-7363-4d23-a6c4-406ec06e25a8	8d1d0b4f-dd62-4374-90ca-d174dcdd57ac	1cf0113f-e7a2-48d9-af82-34af97cd7711	20	2023-06-01	2026-04-26 03:56:23.613284+00
5d0ff5af-18f9-45b2-a2e7-e6f8b2ea48d8	8d1d0b4f-dd62-4374-90ca-d174dcdd57ac	4fe20bda-0c54-4f70-b4b7-bfab711b0142	77	2023-01-01	2026-04-26 03:56:23.822148+00
c760e6a8-d9ea-4b66-b37b-165aa4698c5a	8d1d0b4f-dd62-4374-90ca-d174dcdd57ac	4fe20bda-0c54-4f70-b4b7-bfab711b0142	77	2023-02-01	2026-04-26 03:56:24.04399+00
e592e07b-ae70-4c70-a34b-c6f7f76d43f0	8d1d0b4f-dd62-4374-90ca-d174dcdd57ac	4fe20bda-0c54-4f70-b4b7-bfab711b0142	80	2023-03-01	2026-04-26 03:56:24.229407+00
55935141-86ed-4734-96fa-de016226d280	8d1d0b4f-dd62-4374-90ca-d174dcdd57ac	4fe20bda-0c54-4f70-b4b7-bfab711b0142	81	2023-04-01	2026-04-26 03:56:24.439327+00
92fb0905-5366-4a12-a5df-f41edd0000de	8d1d0b4f-dd62-4374-90ca-d174dcdd57ac	4fe20bda-0c54-4f70-b4b7-bfab711b0142	81	2023-05-01	2026-04-26 03:56:24.647717+00
3d0e4147-0fed-4ac2-a039-d5495209d292	8d1d0b4f-dd62-4374-90ca-d174dcdd57ac	4fe20bda-0c54-4f70-b4b7-bfab711b0142	75	2023-06-01	2026-04-26 03:56:24.849767+00
8cbdf328-7d8d-4807-8f29-3cc74a3b1cf9	8d1d0b4f-dd62-4374-90ca-d174dcdd57ac	0f1a9642-a470-4877-8a80-03ec68a554e6	12	2023-01-01	2026-04-26 03:56:25.060089+00
28040c63-1ac9-4f4e-ab7a-808a45b43a9e	8d1d0b4f-dd62-4374-90ca-d174dcdd57ac	0f1a9642-a470-4877-8a80-03ec68a554e6	9	2023-02-01	2026-04-26 03:56:25.318927+00
5d2f5369-4f6a-4d7f-91f3-05c8e35450e7	8d1d0b4f-dd62-4374-90ca-d174dcdd57ac	0f1a9642-a470-4877-8a80-03ec68a554e6	21	2023-03-01	2026-04-26 03:56:25.559228+00
313840e1-54fe-4855-b9cf-fecd23aedc38	8d1d0b4f-dd62-4374-90ca-d174dcdd57ac	0f1a9642-a470-4877-8a80-03ec68a554e6	10	2023-04-01	2026-04-26 03:56:25.749451+00
1f005b2c-b6f0-4620-8653-5199a0aa0c2e	8d1d0b4f-dd62-4374-90ca-d174dcdd57ac	0f1a9642-a470-4877-8a80-03ec68a554e6	27	2023-05-01	2026-04-26 03:56:25.947894+00
ca9991a5-52d2-445c-b3de-b9c8096388ce	8d1d0b4f-dd62-4374-90ca-d174dcdd57ac	0f1a9642-a470-4877-8a80-03ec68a554e6	24	2023-06-01	2026-04-26 03:56:26.129295+00
4e7e56e2-903f-41a8-bef2-b4c66cc6f33d	8d1d0b4f-dd62-4374-90ca-d174dcdd57ac	17452181-e28a-4f21-8939-660b89286880	80	2023-01-01	2026-04-26 03:56:26.330739+00
213385c5-7c91-4bfb-842e-aca2b630f320	8d1d0b4f-dd62-4374-90ca-d174dcdd57ac	17452181-e28a-4f21-8939-660b89286880	76	2023-02-01	2026-04-26 03:56:26.521298+00
3236efa4-0666-4750-9303-b21a7d802330	8d1d0b4f-dd62-4374-90ca-d174dcdd57ac	17452181-e28a-4f21-8939-660b89286880	77	2023-03-01	2026-04-26 03:56:26.711347+00
a29ffdfb-c62c-447a-bcc2-e75e548b8d46	8d1d0b4f-dd62-4374-90ca-d174dcdd57ac	17452181-e28a-4f21-8939-660b89286880	82	2023-04-01	2026-04-26 03:56:26.908873+00
a836157b-fb23-4d9b-b16d-9013910f5561	8d1d0b4f-dd62-4374-90ca-d174dcdd57ac	17452181-e28a-4f21-8939-660b89286880	67	2023-05-01	2026-04-26 03:56:27.122732+00
dc84f341-df23-4db5-bfb2-752cf331f5ac	8d1d0b4f-dd62-4374-90ca-d174dcdd57ac	17452181-e28a-4f21-8939-660b89286880	78	2023-06-01	2026-04-26 03:56:27.328198+00
8f12bd47-6cc7-4b05-a3cb-e51198a3e8e5	8d1d0b4f-dd62-4374-90ca-d174dcdd57ac	62b26a05-ddac-4b02-80b1-c7a500feef95	57	2023-01-01	2026-04-26 03:56:27.508273+00
406ad8ee-d8d1-4258-a68c-1411812030d6	8d1d0b4f-dd62-4374-90ca-d174dcdd57ac	62b26a05-ddac-4b02-80b1-c7a500feef95	59	2023-02-01	2026-04-26 03:56:27.717931+00
ab2eac71-c4a9-4e9d-8ec7-c3da903141b1	8d1d0b4f-dd62-4374-90ca-d174dcdd57ac	62b26a05-ddac-4b02-80b1-c7a500feef95	57	2023-03-01	2026-04-26 03:56:27.918252+00
2d35f1f9-4232-4727-a3c5-549fe95c4a69	8d1d0b4f-dd62-4374-90ca-d174dcdd57ac	62b26a05-ddac-4b02-80b1-c7a500feef95	64	2023-04-01	2026-04-26 03:56:28.1218+00
b8d5d4b4-b560-4d18-8b51-08fe51047429	8d1d0b4f-dd62-4374-90ca-d174dcdd57ac	62b26a05-ddac-4b02-80b1-c7a500feef95	72	2023-05-01	2026-04-26 03:56:28.324974+00
81b13283-d804-4268-8285-77c79602e2a4	8d1d0b4f-dd62-4374-90ca-d174dcdd57ac	62b26a05-ddac-4b02-80b1-c7a500feef95	71	2023-06-01	2026-04-26 03:56:28.510712+00
ae6b95c5-b3bd-40fa-a7bd-933a14d97998	8d1d0b4f-dd62-4374-90ca-d174dcdd57ac	f49ee23c-aa92-4927-81cf-648587c88b30	63	2023-01-01	2026-04-26 03:56:28.738118+00
54732d6a-f595-4c97-8e94-625ef80f2f49	8d1d0b4f-dd62-4374-90ca-d174dcdd57ac	f49ee23c-aa92-4927-81cf-648587c88b30	61	2023-02-01	2026-04-26 03:56:28.947868+00
685a1eee-57e0-40ec-9ffa-779d2a6bb7fe	8d1d0b4f-dd62-4374-90ca-d174dcdd57ac	f49ee23c-aa92-4927-81cf-648587c88b30	69	2023-03-01	2026-04-26 03:56:29.245769+00
7fd288d0-bf7b-4f8c-b119-927dfac63a06	8d1d0b4f-dd62-4374-90ca-d174dcdd57ac	f49ee23c-aa92-4927-81cf-648587c88b30	56	2023-04-01	2026-04-26 03:56:29.452058+00
c35b6905-f5cb-49d6-a976-b8915567fda4	8d1d0b4f-dd62-4374-90ca-d174dcdd57ac	f49ee23c-aa92-4927-81cf-648587c88b30	51	2023-05-01	2026-04-26 03:56:29.641317+00
ae79da92-394c-4c04-9d5b-e6fe78433fb9	8d1d0b4f-dd62-4374-90ca-d174dcdd57ac	f49ee23c-aa92-4927-81cf-648587c88b30	64	2023-06-01	2026-04-26 03:56:29.828549+00
547083e6-ab27-4177-ad30-2b66b374364d	8d1d0b4f-dd62-4374-90ca-d174dcdd57ac	bd8926a3-87d1-4f67-b23f-374f8748eddb	55	2023-01-01	2026-04-26 03:56:30.030907+00
a46435fe-badc-4fa5-982f-ac50bdd071bf	8d1d0b4f-dd62-4374-90ca-d174dcdd57ac	bd8926a3-87d1-4f67-b23f-374f8748eddb	59	2023-02-01	2026-04-26 03:56:30.226845+00
6f1f9d36-259f-4c5c-8b02-cc1d91e0953c	8d1d0b4f-dd62-4374-90ca-d174dcdd57ac	bd8926a3-87d1-4f67-b23f-374f8748eddb	66	2023-03-01	2026-04-26 03:56:30.422306+00
72d9d23e-f04c-4e2d-bb00-0e2965f8a35a	8d1d0b4f-dd62-4374-90ca-d174dcdd57ac	bd8926a3-87d1-4f67-b23f-374f8748eddb	55	2023-04-01	2026-04-26 03:56:30.610294+00
01eb6404-cca9-4110-aacc-f8d64360c2e9	8d1d0b4f-dd62-4374-90ca-d174dcdd57ac	bd8926a3-87d1-4f67-b23f-374f8748eddb	74	2023-05-01	2026-04-26 03:56:30.810162+00
0ea4cc7c-4caa-4f58-9712-1b065936d987	8d1d0b4f-dd62-4374-90ca-d174dcdd57ac	bd8926a3-87d1-4f67-b23f-374f8748eddb	77	2023-06-01	2026-04-26 03:56:31.002184+00
64fceee3-f18e-489a-ab5b-fb073c5c51c7	8d1d0b4f-dd62-4374-90ca-d174dcdd57ac	45bbd44d-5281-453b-aed8-5874d75cdb2c	65	2023-01-01	2026-04-26 03:56:31.185638+00
e0abef38-6308-437c-bf84-9e98f3dc195b	8d1d0b4f-dd62-4374-90ca-d174dcdd57ac	45bbd44d-5281-453b-aed8-5874d75cdb2c	66	2023-02-01	2026-04-26 03:56:31.375182+00
bbe4ce87-4723-48e0-b7f2-d67b41a3710c	8d1d0b4f-dd62-4374-90ca-d174dcdd57ac	45bbd44d-5281-453b-aed8-5874d75cdb2c	51	2023-03-01	2026-04-26 03:56:31.560252+00
9b9a4f91-5247-42b7-84a7-0c3c87eb3112	8d1d0b4f-dd62-4374-90ca-d174dcdd57ac	45bbd44d-5281-453b-aed8-5874d75cdb2c	52	2023-04-01	2026-04-26 03:56:31.73315+00
24a58d3d-1e98-4c4c-ab79-5fb3db129776	8d1d0b4f-dd62-4374-90ca-d174dcdd57ac	45bbd44d-5281-453b-aed8-5874d75cdb2c	71	2023-05-01	2026-04-26 03:56:31.910177+00
f5f769f0-68f5-4af0-8f64-d47768fcf6d9	8d1d0b4f-dd62-4374-90ca-d174dcdd57ac	45bbd44d-5281-453b-aed8-5874d75cdb2c	58	2023-06-01	2026-04-26 03:56:32.088846+00
ad13ef0e-d480-4924-b113-309ad9dfdc93	de51595d-1f99-4544-a131-d08e0dceb7e2	f84c7f2e-f45d-4011-8f83-75fa33b2a027	1995	2023-01-01	2026-04-26 03:56:32.284171+00
3f77dde0-b151-4c4b-a176-7de9c3fea90c	de51595d-1f99-4544-a131-d08e0dceb7e2	f84c7f2e-f45d-4011-8f83-75fa33b2a027	2001	2023-02-01	2026-04-26 03:56:32.774844+00
68f872c7-b3fe-4789-8eaa-563a11d289b0	de51595d-1f99-4544-a131-d08e0dceb7e2	f84c7f2e-f45d-4011-8f83-75fa33b2a027	2001	2023-03-01	2026-04-26 03:56:32.989611+00
238123d5-11dc-4ca8-82bd-2349bda1d3ab	de51595d-1f99-4544-a131-d08e0dceb7e2	f84c7f2e-f45d-4011-8f83-75fa33b2a027	1992	2023-04-01	2026-04-26 03:56:33.168518+00
607cd232-fac6-4ca5-9187-49c461d4e05c	de51595d-1f99-4544-a131-d08e0dceb7e2	f84c7f2e-f45d-4011-8f83-75fa33b2a027	1999	2023-05-01	2026-04-26 03:56:33.348934+00
893c4d37-4c63-4de7-9aa3-748fd846227e	de51595d-1f99-4544-a131-d08e0dceb7e2	f84c7f2e-f45d-4011-8f83-75fa33b2a027	1995	2023-06-01	2026-04-26 03:56:33.528435+00
4e14ad15-7100-4be7-a9a3-351876ee8fb1	de51595d-1f99-4544-a131-d08e0dceb7e2	bd27283a-985f-4006-ada1-23b7328afd6d	85	2023-01-01	2026-04-26 03:56:33.740322+00
983c5c7d-6d27-41c3-8213-956d7e52f4ce	de51595d-1f99-4544-a131-d08e0dceb7e2	bd27283a-985f-4006-ada1-23b7328afd6d	74	2023-02-01	2026-04-26 03:56:33.938236+00
ec744c64-b5ce-4f03-a612-70dcabc36cd0	de51595d-1f99-4544-a131-d08e0dceb7e2	bd27283a-985f-4006-ada1-23b7328afd6d	77	2023-03-01	2026-04-26 03:56:34.128759+00
3c8772a2-b8f6-43ca-b156-019bdc301075	de51595d-1f99-4544-a131-d08e0dceb7e2	bd27283a-985f-4006-ada1-23b7328afd6d	88	2023-04-01	2026-04-26 03:56:34.310808+00
f953a15d-cc45-4e87-9c8c-2748bcaa9084	de51595d-1f99-4544-a131-d08e0dceb7e2	bd27283a-985f-4006-ada1-23b7328afd6d	88	2023-05-01	2026-04-26 03:56:34.512622+00
fc5a2b0a-53c7-4b1a-a9b4-10c62ae58961	de51595d-1f99-4544-a131-d08e0dceb7e2	bd27283a-985f-4006-ada1-23b7328afd6d	84	2023-06-01	2026-04-26 03:56:34.688653+00
66cb6e15-7fcd-428b-b6f0-2707bedf23e1	de51595d-1f99-4544-a131-d08e0dceb7e2	1cf0113f-e7a2-48d9-af82-34af97cd7711	14	2023-01-01	2026-04-26 03:56:34.871765+00
db0163ea-ec81-4477-bcee-e733efdc7c30	de51595d-1f99-4544-a131-d08e0dceb7e2	1cf0113f-e7a2-48d9-af82-34af97cd7711	14	2023-02-01	2026-04-26 03:56:35.048877+00
49270e31-7403-4fe8-94fe-c4c86837d0f4	de51595d-1f99-4544-a131-d08e0dceb7e2	1cf0113f-e7a2-48d9-af82-34af97cd7711	11	2023-03-01	2026-04-26 03:56:35.233928+00
9eff1436-c090-4d95-bb53-f2e897d15d8c	de51595d-1f99-4544-a131-d08e0dceb7e2	1cf0113f-e7a2-48d9-af82-34af97cd7711	13	2023-04-01	2026-04-26 03:56:35.40861+00
02faed0f-7700-4a90-b168-3f95f1da13d1	de51595d-1f99-4544-a131-d08e0dceb7e2	1cf0113f-e7a2-48d9-af82-34af97cd7711	21	2023-05-01	2026-04-26 03:56:35.59268+00
c40179d6-963c-4968-9095-1dd586e0e610	de51595d-1f99-4544-a131-d08e0dceb7e2	1cf0113f-e7a2-48d9-af82-34af97cd7711	18	2023-06-01	2026-04-26 03:56:35.769723+00
0848e027-8db3-46de-8c8a-5c2bf1b81bea	de51595d-1f99-4544-a131-d08e0dceb7e2	4fe20bda-0c54-4f70-b4b7-bfab711b0142	84	2023-01-01	2026-04-26 03:56:35.943367+00
6fd7cb7c-52f5-423c-89a3-c225124527e4	de51595d-1f99-4544-a131-d08e0dceb7e2	4fe20bda-0c54-4f70-b4b7-bfab711b0142	77	2023-02-01	2026-04-26 03:56:36.129028+00
06c514b1-fc17-42c9-8ae1-2b44d8cc582b	de51595d-1f99-4544-a131-d08e0dceb7e2	4fe20bda-0c54-4f70-b4b7-bfab711b0142	87	2023-03-01	2026-04-26 03:56:36.308835+00
56bfdcaa-4273-47ae-8df1-d17e72802d4c	de51595d-1f99-4544-a131-d08e0dceb7e2	4fe20bda-0c54-4f70-b4b7-bfab711b0142	80	2023-04-01	2026-04-26 03:56:36.485606+00
a01f693b-e68a-4a1f-9e64-0a6419965b21	de51595d-1f99-4544-a131-d08e0dceb7e2	4fe20bda-0c54-4f70-b4b7-bfab711b0142	87	2023-05-01	2026-04-26 03:56:36.659513+00
65461a9e-c52e-495a-9347-4cff1bb811b5	de51595d-1f99-4544-a131-d08e0dceb7e2	4fe20bda-0c54-4f70-b4b7-bfab711b0142	82	2023-06-01	2026-04-26 03:56:36.833952+00
c9cf8b8a-b2f9-48f3-9612-c0e230b73d47	de51595d-1f99-4544-a131-d08e0dceb7e2	0f1a9642-a470-4877-8a80-03ec68a554e6	9	2023-01-01	2026-04-26 03:56:37.016313+00
be2462c4-6b3c-48fc-8d85-7d626d0bce54	de51595d-1f99-4544-a131-d08e0dceb7e2	0f1a9642-a470-4877-8a80-03ec68a554e6	3	2023-02-01	2026-04-26 03:56:37.197456+00
0bac1e6e-480d-4128-8f7d-d32091b2202f	de51595d-1f99-4544-a131-d08e0dceb7e2	0f1a9642-a470-4877-8a80-03ec68a554e6	14	2023-03-01	2026-04-26 03:56:37.372584+00
72922c75-3643-4f31-a558-43079a7e4c7a	de51595d-1f99-4544-a131-d08e0dceb7e2	0f1a9642-a470-4877-8a80-03ec68a554e6	8	2023-04-01	2026-04-26 03:56:37.547709+00
cd55b23a-b806-44d7-ae46-908e7233f0d9	de51595d-1f99-4544-a131-d08e0dceb7e2	0f1a9642-a470-4877-8a80-03ec68a554e6	4	2023-05-01	2026-04-26 03:56:37.744097+00
20f4fbdc-eb51-4054-b68b-274d0ca2c6c1	de51595d-1f99-4544-a131-d08e0dceb7e2	0f1a9642-a470-4877-8a80-03ec68a554e6	19	2023-06-01	2026-04-26 03:56:37.951477+00
b03abac8-ca6e-4e44-9357-1fa203290b02	de51595d-1f99-4544-a131-d08e0dceb7e2	17452181-e28a-4f21-8939-660b89286880	74	2023-01-01	2026-04-26 03:56:38.162812+00
2ec26ce9-d6be-4637-83b3-63ab958afd4d	de51595d-1f99-4544-a131-d08e0dceb7e2	17452181-e28a-4f21-8939-660b89286880	74	2023-02-01	2026-04-26 03:56:38.415648+00
1a758f47-c922-43f5-a9be-01da7850183c	de51595d-1f99-4544-a131-d08e0dceb7e2	17452181-e28a-4f21-8939-660b89286880	72	2023-03-01	2026-04-26 03:56:39.037766+00
b2ac3d58-b1a3-448c-9c10-22b8bd617637	de51595d-1f99-4544-a131-d08e0dceb7e2	17452181-e28a-4f21-8939-660b89286880	75	2023-04-01	2026-04-26 03:56:39.298919+00
913cc6cc-ee35-4f51-a989-e282c0ff4432	de51595d-1f99-4544-a131-d08e0dceb7e2	17452181-e28a-4f21-8939-660b89286880	86	2023-05-01	2026-04-26 03:56:39.692818+00
d5ec9d5e-9f0c-45de-93e2-17dc8eaed1a9	de51595d-1f99-4544-a131-d08e0dceb7e2	17452181-e28a-4f21-8939-660b89286880	64	2023-06-01	2026-04-26 03:56:40.291161+00
a00b0bde-f594-4f95-b3b2-dad7c57dd779	de51595d-1f99-4544-a131-d08e0dceb7e2	62b26a05-ddac-4b02-80b1-c7a500feef95	62	2023-01-01	2026-04-26 03:56:40.664996+00
a1cda445-48c7-41ac-b42d-1593ba1a952e	de51595d-1f99-4544-a131-d08e0dceb7e2	62b26a05-ddac-4b02-80b1-c7a500feef95	63	2023-02-01	2026-04-26 03:56:41.040243+00
5193756a-a341-4d99-92d7-180a5c18f827	de51595d-1f99-4544-a131-d08e0dceb7e2	62b26a05-ddac-4b02-80b1-c7a500feef95	64	2023-03-01	2026-04-26 03:56:41.488326+00
3bfd050b-457d-45ca-9eed-af70559e18f1	de51595d-1f99-4544-a131-d08e0dceb7e2	62b26a05-ddac-4b02-80b1-c7a500feef95	64	2023-04-01	2026-04-26 03:56:41.81923+00
f2c2775a-5c5e-475d-b8cc-0feff65af6f4	de51595d-1f99-4544-a131-d08e0dceb7e2	62b26a05-ddac-4b02-80b1-c7a500feef95	61	2023-05-01	2026-04-26 03:56:42.230679+00
a2f22eeb-9d55-485f-9780-34cae71fb9f7	de51595d-1f99-4544-a131-d08e0dceb7e2	62b26a05-ddac-4b02-80b1-c7a500feef95	73	2023-06-01	2026-04-26 03:56:42.550425+00
1211e1b9-ade2-4e5c-b2f7-a36a16f95111	de51595d-1f99-4544-a131-d08e0dceb7e2	f49ee23c-aa92-4927-81cf-648587c88b30	59	2023-01-01	2026-04-26 03:56:42.84744+00
c3506a99-d38e-4f81-afd9-09a273edfac4	de51595d-1f99-4544-a131-d08e0dceb7e2	f49ee23c-aa92-4927-81cf-648587c88b30	62	2023-02-01	2026-04-26 03:56:43.054581+00
b1c044d6-5517-49d2-b7d6-592a8354eadd	de51595d-1f99-4544-a131-d08e0dceb7e2	f49ee23c-aa92-4927-81cf-648587c88b30	62	2023-03-01	2026-04-26 03:56:43.358521+00
84ade54d-7b57-42a2-a5b0-a61d434c8527	de51595d-1f99-4544-a131-d08e0dceb7e2	f49ee23c-aa92-4927-81cf-648587c88b30	55	2023-04-01	2026-04-26 03:56:43.739083+00
71085e16-83ae-49fa-bb88-7f5ad67e41e9	de51595d-1f99-4544-a131-d08e0dceb7e2	f49ee23c-aa92-4927-81cf-648587c88b30	58	2023-05-01	2026-04-26 03:56:43.99792+00
12db4f4e-adb8-4697-a783-398d0ab09c3c	de51595d-1f99-4544-a131-d08e0dceb7e2	f49ee23c-aa92-4927-81cf-648587c88b30	54	2023-06-01	2026-04-26 03:56:44.173406+00
bda2e2cb-46dd-4dd5-82e8-39baa890fd00	de51595d-1f99-4544-a131-d08e0dceb7e2	bd8926a3-87d1-4f67-b23f-374f8748eddb	60	2023-01-01	2026-04-26 03:56:44.379269+00
cd501bdb-930e-42d1-b2de-aaa42f1dd762	de51595d-1f99-4544-a131-d08e0dceb7e2	bd8926a3-87d1-4f67-b23f-374f8748eddb	63	2023-02-01	2026-04-26 03:56:44.57887+00
a6f285a4-9716-4eb1-9a34-38490f471edd	de51595d-1f99-4544-a131-d08e0dceb7e2	bd8926a3-87d1-4f67-b23f-374f8748eddb	65	2023-03-01	2026-04-26 03:56:44.770941+00
9750731b-0c23-4b0e-934f-6f337ccd471e	de51595d-1f99-4544-a131-d08e0dceb7e2	bd8926a3-87d1-4f67-b23f-374f8748eddb	56	2023-04-01	2026-04-26 03:56:44.961833+00
cd52dbfd-592b-4169-b86b-668fc22bd4ce	de51595d-1f99-4544-a131-d08e0dceb7e2	bd8926a3-87d1-4f67-b23f-374f8748eddb	65	2023-05-01	2026-04-26 03:56:45.150085+00
99e805c0-8676-4bbb-a03e-e3bf217725f9	de51595d-1f99-4544-a131-d08e0dceb7e2	bd8926a3-87d1-4f67-b23f-374f8748eddb	77	2023-06-01	2026-04-26 03:56:45.323634+00
81ea2bee-9d53-4ae7-9e52-6e5ee0a473ac	de51595d-1f99-4544-a131-d08e0dceb7e2	45bbd44d-5281-453b-aed8-5874d75cdb2c	61	2023-01-01	2026-04-26 03:56:45.504304+00
571f4e7d-ba87-4c4b-86de-14d769c53a60	de51595d-1f99-4544-a131-d08e0dceb7e2	45bbd44d-5281-453b-aed8-5874d75cdb2c	56	2023-02-01	2026-04-26 03:56:45.685171+00
655dd9e8-da7e-4636-93ea-844ddc644514	de51595d-1f99-4544-a131-d08e0dceb7e2	45bbd44d-5281-453b-aed8-5874d75cdb2c	61	2023-03-01	2026-04-26 03:56:45.874447+00
ce518366-3fd6-40aa-9ac1-978d889d86be	de51595d-1f99-4544-a131-d08e0dceb7e2	45bbd44d-5281-453b-aed8-5874d75cdb2c	64	2023-04-01	2026-04-26 03:56:46.069682+00
a2e9b58d-1102-4275-a219-52d16c4c8330	de51595d-1f99-4544-a131-d08e0dceb7e2	45bbd44d-5281-453b-aed8-5874d75cdb2c	65	2023-05-01	2026-04-26 03:56:46.25102+00
bffed98f-6a46-49f6-b9c7-c0dcfda1b8e0	de51595d-1f99-4544-a131-d08e0dceb7e2	45bbd44d-5281-453b-aed8-5874d75cdb2c	48	2023-06-01	2026-04-26 03:56:46.428937+00
57e5064c-8b78-4493-b71b-cf549e71f49a	df11976b-9cd9-4fb1-a0db-af20104e1e69	f84c7f2e-f45d-4011-8f83-75fa33b2a027	1999	2023-01-01	2026-04-26 03:56:46.614096+00
c72f005e-98f6-487a-8055-f1ba8b428610	df11976b-9cd9-4fb1-a0db-af20104e1e69	f84c7f2e-f45d-4011-8f83-75fa33b2a027	2000	2023-02-01	2026-04-26 03:56:46.79953+00
d40a29c3-e4b5-4f16-afa7-81446b042071	df11976b-9cd9-4fb1-a0db-af20104e1e69	f84c7f2e-f45d-4011-8f83-75fa33b2a027	1992	2023-03-01	2026-04-26 03:56:46.977911+00
4a39f48e-3807-4ba6-965c-0325ac3bbbb8	df11976b-9cd9-4fb1-a0db-af20104e1e69	f84c7f2e-f45d-4011-8f83-75fa33b2a027	1990	2023-04-01	2026-04-26 03:56:47.153757+00
4d9f9c7b-d278-4fce-af21-e95b6a72d6a1	df11976b-9cd9-4fb1-a0db-af20104e1e69	f84c7f2e-f45d-4011-8f83-75fa33b2a027	1991	2023-05-01	2026-04-26 03:56:47.339419+00
cd675ca1-34d2-428f-9d1e-bcf5b515fe4b	df11976b-9cd9-4fb1-a0db-af20104e1e69	f84c7f2e-f45d-4011-8f83-75fa33b2a027	2012	2023-06-01	2026-04-26 03:56:47.514742+00
b26589f0-5dce-4f35-9292-9fd8173046f8	df11976b-9cd9-4fb1-a0db-af20104e1e69	bd27283a-985f-4006-ada1-23b7328afd6d	83	2023-01-01	2026-04-26 03:56:47.705531+00
4711c5c2-a3e0-4645-88d0-64da4ca285e7	df11976b-9cd9-4fb1-a0db-af20104e1e69	bd27283a-985f-4006-ada1-23b7328afd6d	74	2023-02-01	2026-04-26 03:56:47.895797+00
2c278fee-8184-429a-8550-3f1538bd79c4	df11976b-9cd9-4fb1-a0db-af20104e1e69	bd27283a-985f-4006-ada1-23b7328afd6d	80	2023-03-01	2026-04-26 03:56:48.097316+00
1539faef-8cfb-42c6-8435-89c4692fec85	df11976b-9cd9-4fb1-a0db-af20104e1e69	bd27283a-985f-4006-ada1-23b7328afd6d	81	2023-04-01	2026-04-26 03:56:48.287388+00
a437a323-5bf8-4bf7-a8d3-622ed2ba5401	df11976b-9cd9-4fb1-a0db-af20104e1e69	bd27283a-985f-4006-ada1-23b7328afd6d	74	2023-05-01	2026-04-26 03:56:48.467184+00
68d86912-d58d-4f2e-bb31-dd19b43392f8	df11976b-9cd9-4fb1-a0db-af20104e1e69	bd27283a-985f-4006-ada1-23b7328afd6d	94	2023-06-01	2026-04-26 03:56:48.646682+00
8eee6931-69f3-4b80-ad82-bc03897569a5	df11976b-9cd9-4fb1-a0db-af20104e1e69	1cf0113f-e7a2-48d9-af82-34af97cd7711	5	2023-01-01	2026-04-26 03:56:48.837055+00
9b5655bc-42a5-497a-b94d-669d5e510ce0	df11976b-9cd9-4fb1-a0db-af20104e1e69	1cf0113f-e7a2-48d9-af82-34af97cd7711	10	2023-02-01	2026-04-26 03:56:49.037478+00
538901c4-c57e-4f90-a149-87aa873e7e29	df11976b-9cd9-4fb1-a0db-af20104e1e69	1cf0113f-e7a2-48d9-af82-34af97cd7711	8	2023-03-01	2026-04-26 03:56:49.228008+00
9a07fafd-6d42-4915-88e1-46af543ab5d9	df11976b-9cd9-4fb1-a0db-af20104e1e69	1cf0113f-e7a2-48d9-af82-34af97cd7711	20	2023-04-01	2026-04-26 03:56:49.405687+00
ad3a82f2-8de9-442c-ad72-95b3d9d016a6	df11976b-9cd9-4fb1-a0db-af20104e1e69	1cf0113f-e7a2-48d9-af82-34af97cd7711	14	2023-05-01	2026-04-26 03:56:49.608726+00
59631005-1aa2-4d60-985e-1447c6361051	df11976b-9cd9-4fb1-a0db-af20104e1e69	1cf0113f-e7a2-48d9-af82-34af97cd7711	19	2023-06-01	2026-04-26 03:56:49.839156+00
d5ff5520-1844-42ce-b547-e118f6a22bf2	df11976b-9cd9-4fb1-a0db-af20104e1e69	4fe20bda-0c54-4f70-b4b7-bfab711b0142	81	2023-01-01	2026-04-26 03:56:50.035025+00
00871f3d-26a5-4292-b1d9-996bfcfe103c	df11976b-9cd9-4fb1-a0db-af20104e1e69	4fe20bda-0c54-4f70-b4b7-bfab711b0142	77	2023-02-01	2026-04-26 03:56:50.25626+00
f4120b33-341c-4a0b-a97c-1240933123aa	df11976b-9cd9-4fb1-a0db-af20104e1e69	4fe20bda-0c54-4f70-b4b7-bfab711b0142	75	2023-03-01	2026-04-26 03:56:50.459014+00
2f25eb50-0107-468e-90ba-a9f2f7015893	df11976b-9cd9-4fb1-a0db-af20104e1e69	4fe20bda-0c54-4f70-b4b7-bfab711b0142	85	2023-04-01	2026-04-26 03:56:50.856219+00
8d77df45-866d-4003-84f5-549e3ac1e771	df11976b-9cd9-4fb1-a0db-af20104e1e69	4fe20bda-0c54-4f70-b4b7-bfab711b0142	68	2023-05-01	2026-04-26 03:56:51.060836+00
c9a33ad8-2c1d-4cc2-a898-0b09e5e31883	df11976b-9cd9-4fb1-a0db-af20104e1e69	4fe20bda-0c54-4f70-b4b7-bfab711b0142	97	2023-06-01	2026-04-26 03:56:51.266577+00
60bdba38-9c03-4344-9785-7b14253452df	df11976b-9cd9-4fb1-a0db-af20104e1e69	0f1a9642-a470-4877-8a80-03ec68a554e6	12	2023-01-01	2026-04-26 03:56:51.476613+00
a20a8f69-a424-4ef1-af69-6106b4b55265	df11976b-9cd9-4fb1-a0db-af20104e1e69	0f1a9642-a470-4877-8a80-03ec68a554e6	9	2023-02-01	2026-04-26 03:56:51.673653+00
c3410e75-7b73-4544-8410-301fb6a621ca	df11976b-9cd9-4fb1-a0db-af20104e1e69	0f1a9642-a470-4877-8a80-03ec68a554e6	11	2023-03-01	2026-04-26 03:56:51.851242+00
b98a7555-c277-43bf-9c64-90003c161577	df11976b-9cd9-4fb1-a0db-af20104e1e69	0f1a9642-a470-4877-8a80-03ec68a554e6	21	2023-04-01	2026-04-26 03:56:52.047815+00
72bb0ec6-ab7c-4d44-95a7-51ab4ee49ee1	df11976b-9cd9-4fb1-a0db-af20104e1e69	0f1a9642-a470-4877-8a80-03ec68a554e6	13	2023-05-01	2026-04-26 03:56:52.231889+00
2469f787-2275-4254-9d1e-04662d3f3d5d	df11976b-9cd9-4fb1-a0db-af20104e1e69	0f1a9642-a470-4877-8a80-03ec68a554e6	11	2023-06-01	2026-04-26 03:56:52.420915+00
23269169-1c53-42ae-83f5-ac8428517c9d	df11976b-9cd9-4fb1-a0db-af20104e1e69	17452181-e28a-4f21-8939-660b89286880	73	2023-01-01	2026-04-26 03:56:52.600506+00
4f3c96cf-7a05-4187-b002-7a0f98f0e47d	df11976b-9cd9-4fb1-a0db-af20104e1e69	17452181-e28a-4f21-8939-660b89286880	78	2023-02-01	2026-04-26 03:56:52.788003+00
9c3b9f58-3a61-4e65-8d8f-750076c5dea4	df11976b-9cd9-4fb1-a0db-af20104e1e69	17452181-e28a-4f21-8939-660b89286880	78	2023-03-01	2026-04-26 03:56:52.971021+00
73edc510-4774-459e-9398-15c6583a70d5	df11976b-9cd9-4fb1-a0db-af20104e1e69	17452181-e28a-4f21-8939-660b89286880	84	2023-04-01	2026-04-26 03:56:53.150412+00
d18634a1-b989-4a4e-8e7d-0ee0be0a745a	df11976b-9cd9-4fb1-a0db-af20104e1e69	17452181-e28a-4f21-8939-660b89286880	78	2023-05-01	2026-04-26 03:56:53.332642+00
88c81e30-97ee-4d15-b8ba-1cacb441cdaa	df11976b-9cd9-4fb1-a0db-af20104e1e69	17452181-e28a-4f21-8939-660b89286880	90	2023-06-01	2026-04-26 03:56:53.515385+00
50e2ee66-3023-466a-a34e-835ef5d0f145	df11976b-9cd9-4fb1-a0db-af20104e1e69	62b26a05-ddac-4b02-80b1-c7a500feef95	55	2023-01-01	2026-04-26 03:56:53.703915+00
36b70d66-e7f2-4bfd-a371-0eee58716462	df11976b-9cd9-4fb1-a0db-af20104e1e69	62b26a05-ddac-4b02-80b1-c7a500feef95	59	2023-02-01	2026-04-26 03:56:53.907804+00
dd4311af-37c2-4fae-b8bc-95b9cb9774a8	df11976b-9cd9-4fb1-a0db-af20104e1e69	62b26a05-ddac-4b02-80b1-c7a500feef95	63	2023-03-01	2026-04-26 03:56:54.123878+00
3f22a11e-6a5f-4d1f-a136-0f3bd5935afa	df11976b-9cd9-4fb1-a0db-af20104e1e69	62b26a05-ddac-4b02-80b1-c7a500feef95	56	2023-04-01	2026-04-26 03:56:54.34115+00
0f4dfb6f-51e8-4693-90a3-a21bc7f74a0a	df11976b-9cd9-4fb1-a0db-af20104e1e69	62b26a05-ddac-4b02-80b1-c7a500feef95	75	2023-05-01	2026-04-26 03:56:54.533004+00
8902986a-bc94-4a7c-b016-932fe06f6e9d	df11976b-9cd9-4fb1-a0db-af20104e1e69	62b26a05-ddac-4b02-80b1-c7a500feef95	63	2023-06-01	2026-04-26 03:56:54.727169+00
44e2edcb-4ec8-4f0f-bfb0-a54a0e390a06	df11976b-9cd9-4fb1-a0db-af20104e1e69	f49ee23c-aa92-4927-81cf-648587c88b30	62	2023-01-01	2026-04-26 03:56:54.935023+00
31888c26-f68b-4e40-b332-4aeb323be4e7	df11976b-9cd9-4fb1-a0db-af20104e1e69	f49ee23c-aa92-4927-81cf-648587c88b30	64	2023-02-01	2026-04-26 03:56:55.1431+00
0bd54466-0927-4a44-b82e-5cf8c372c516	df11976b-9cd9-4fb1-a0db-af20104e1e69	f49ee23c-aa92-4927-81cf-648587c88b30	63	2023-03-01	2026-04-26 03:56:55.332541+00
271141f4-c6ed-490d-83a0-0a625c9094d9	df11976b-9cd9-4fb1-a0db-af20104e1e69	f49ee23c-aa92-4927-81cf-648587c88b30	65	2023-04-01	2026-04-26 03:56:55.538338+00
657bf85d-881c-4b3e-90f7-9f054cce526d	df11976b-9cd9-4fb1-a0db-af20104e1e69	f49ee23c-aa92-4927-81cf-648587c88b30	58	2023-05-01	2026-04-26 03:56:55.722569+00
60a44433-ba3b-42c5-9863-68d2ef845151	df11976b-9cd9-4fb1-a0db-af20104e1e69	f49ee23c-aa92-4927-81cf-648587c88b30	54	2023-06-01	2026-04-26 03:56:56.054325+00
9ab9b267-9000-41ba-ade7-c183074b8ce7	df11976b-9cd9-4fb1-a0db-af20104e1e69	bd8926a3-87d1-4f67-b23f-374f8748eddb	60	2023-01-01	2026-04-26 03:56:56.299156+00
856ce4af-a1a3-46ac-bdb4-c7ad6026bf08	df11976b-9cd9-4fb1-a0db-af20104e1e69	bd8926a3-87d1-4f67-b23f-374f8748eddb	63	2023-02-01	2026-04-26 03:56:56.500326+00
a2aa315f-a61f-464f-98c4-77ec05a4a7e1	df11976b-9cd9-4fb1-a0db-af20104e1e69	bd8926a3-87d1-4f67-b23f-374f8748eddb	56	2023-03-01	2026-04-26 03:56:56.69552+00
98aa0895-0b47-40b8-a938-50e3e0c56f20	df11976b-9cd9-4fb1-a0db-af20104e1e69	bd8926a3-87d1-4f67-b23f-374f8748eddb	62	2023-04-01	2026-04-26 03:56:56.899461+00
545b2c5d-0b18-4307-b11c-71de157da0de	df11976b-9cd9-4fb1-a0db-af20104e1e69	bd8926a3-87d1-4f67-b23f-374f8748eddb	69	2023-05-01	2026-04-26 03:56:57.105227+00
8daf5a9a-7c54-42b6-9ae4-2d4f094230fe	df11976b-9cd9-4fb1-a0db-af20104e1e69	bd8926a3-87d1-4f67-b23f-374f8748eddb	67	2023-06-01	2026-04-26 03:56:57.414285+00
38f7c830-43d0-4068-af18-d048c02ce1f5	df11976b-9cd9-4fb1-a0db-af20104e1e69	45bbd44d-5281-453b-aed8-5874d75cdb2c	55	2023-01-01	2026-04-26 03:56:57.616776+00
761138d8-1ab5-4325-bf39-d33633c14129	df11976b-9cd9-4fb1-a0db-af20104e1e69	45bbd44d-5281-453b-aed8-5874d75cdb2c	62	2023-02-01	2026-04-26 03:56:57.820735+00
58946e79-8f92-4918-b0a1-fb5d77de223f	df11976b-9cd9-4fb1-a0db-af20104e1e69	45bbd44d-5281-453b-aed8-5874d75cdb2c	64	2023-03-01	2026-04-26 03:56:58.026231+00
3c88e44f-d837-4af7-9e7c-85b7c0602178	df11976b-9cd9-4fb1-a0db-af20104e1e69	45bbd44d-5281-453b-aed8-5874d75cdb2c	56	2023-04-01	2026-04-26 03:56:58.236579+00
308fba25-7dff-4a8f-8ad5-baacf9c54782	df11976b-9cd9-4fb1-a0db-af20104e1e69	45bbd44d-5281-453b-aed8-5874d75cdb2c	63	2023-05-01	2026-04-26 03:56:58.43564+00
db0b4d82-0110-4bb7-8266-45953a0dc733	df11976b-9cd9-4fb1-a0db-af20104e1e69	45bbd44d-5281-453b-aed8-5874d75cdb2c	58	2023-06-01	2026-04-26 03:56:58.638573+00
\.


--
-- Data for Name: reports; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reports (id, institution_id, report_type, start_date, end_date, file_url, created_at) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, institution_id, full_name, email, role) FROM stdin;
c5f26541-dff7-4574-9091-358a6c3baf05	\N	\N	you@email.com	super_admin
4e900029-58bf-48cc-9187-58d3b30dd55f	\N	Super Administrateur UCAR	superadmin@ucar.tn	super_admin
68e1be2f-d559-4837-a9c7-bd6fba6a3431	\N	System Administrator	admin@ucar.tn	super_admin
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.schema_migrations (version, inserted_at) FROM stdin;
20211116024918	2026-04-25 11:00:29
20211116045059	2026-04-25 11:00:29
20211116050929	2026-04-25 11:00:29
20211116051442	2026-04-25 11:00:29
20211116212300	2026-04-25 11:00:29
20211116213355	2026-04-25 11:00:29
20211116213934	2026-04-25 11:00:29
20211116214523	2026-04-25 11:00:29
20211122062447	2026-04-25 11:00:29
20211124070109	2026-04-25 11:00:29
20211202204204	2026-04-25 11:00:29
20211202204605	2026-04-25 11:00:29
20211210212804	2026-04-25 11:00:29
20211228014915	2026-04-25 11:00:29
20220107221237	2026-04-25 11:00:29
20220228202821	2026-04-25 11:00:29
20220312004840	2026-04-25 11:00:29
20220603231003	2026-04-25 11:00:29
20220603232444	2026-04-25 11:00:29
20220615214548	2026-04-25 11:00:29
20220712093339	2026-04-25 11:00:29
20220908172859	2026-04-25 11:00:29
20220916233421	2026-04-25 11:00:29
20230119133233	2026-04-25 11:00:29
20230128025114	2026-04-25 11:00:29
20230128025212	2026-04-25 11:00:29
20230227211149	2026-04-25 11:00:29
20230228184745	2026-04-25 11:00:29
20230308225145	2026-04-25 11:00:29
20230328144023	2026-04-25 11:00:29
20231018144023	2026-04-25 11:00:29
20231204144023	2026-04-25 11:00:29
20231204144024	2026-04-25 11:00:29
20231204144025	2026-04-25 11:00:29
20240108234812	2026-04-25 11:00:29
20240109165339	2026-04-25 11:00:29
20240227174441	2026-04-25 11:00:29
20240311171622	2026-04-25 11:00:29
20240321100241	2026-04-25 11:00:29
20240401105812	2026-04-25 11:00:29
20240418121054	2026-04-25 11:00:29
20240523004032	2026-04-25 11:00:29
20240618124746	2026-04-25 11:00:29
20240801235015	2026-04-25 11:00:29
20240805133720	2026-04-25 11:00:29
20240827160934	2026-04-25 11:00:29
20240919163303	2026-04-25 11:00:29
20240919163305	2026-04-25 11:00:29
20241019105805	2026-04-25 11:00:29
20241030150047	2026-04-25 11:00:29
20241108114728	2026-04-25 11:00:29
20241121104152	2026-04-25 11:00:29
20241130184212	2026-04-25 11:00:29
20241220035512	2026-04-25 11:00:29
20241220123912	2026-04-25 11:00:29
20241224161212	2026-04-25 11:00:29
20250107150512	2026-04-25 11:00:29
20250110162412	2026-04-25 11:00:29
20250123174212	2026-04-25 11:00:30
20250128220012	2026-04-25 11:00:30
20250506224012	2026-04-25 11:00:30
20250523164012	2026-04-25 11:00:30
20250714121412	2026-04-25 11:00:30
20250905041441	2026-04-25 11:00:30
20251103001201	2026-04-25 11:00:30
20251120212548	2026-04-25 11:00:30
20251120215549	2026-04-25 11:00:30
20260218120000	2026-04-25 11:00:30
20260326120000	2026-04-25 11:00:30
\.


--
-- Data for Name: subscription; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.subscription (id, subscription_id, entity, filters, claims, created_at, action_filter) FROM stdin;
\.


--
-- Data for Name: buckets; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.buckets (id, name, owner, created_at, updated_at, public, avif_autodetection, file_size_limit, allowed_mime_types, owner_id, type) FROM stdin;
\.


--
-- Data for Name: buckets_analytics; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.buckets_analytics (name, type, format, created_at, updated_at, id, deleted_at) FROM stdin;
\.


--
-- Data for Name: buckets_vectors; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.buckets_vectors (id, type, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.migrations (id, name, hash, executed_at) FROM stdin;
0	create-migrations-table	e18db593bcde2aca2a408c4d1100f6abba2195df	2026-04-25 07:50:36.659101
1	initialmigration	6ab16121fbaa08bbd11b712d05f358f9b555d777	2026-04-25 07:50:36.692057
2	storage-schema	f6a1fa2c93cbcd16d4e487b362e45fca157a8dbd	2026-04-25 07:50:36.695407
3	pathtoken-column	2cb1b0004b817b29d5b0a971af16bafeede4b70d	2026-04-25 07:50:36.72304
4	add-migrations-rls	427c5b63fe1c5937495d9c635c263ee7a5905058	2026-04-25 07:50:36.733493
5	add-size-functions	79e081a1455b63666c1294a440f8ad4b1e6a7f84	2026-04-25 07:50:36.736724
6	change-column-name-in-get-size	ded78e2f1b5d7e616117897e6443a925965b30d2	2026-04-25 07:50:36.740613
7	add-rls-to-buckets	e7e7f86adbc51049f341dfe8d30256c1abca17aa	2026-04-25 07:50:36.744605
8	add-public-to-buckets	fd670db39ed65f9d08b01db09d6202503ca2bab3	2026-04-25 07:50:36.747944
9	fix-search-function	af597a1b590c70519b464a4ab3be54490712796b	2026-04-25 07:50:36.751592
10	search-files-search-function	b595f05e92f7e91211af1bbfe9c6a13bb3391e16	2026-04-25 07:50:36.755322
11	add-trigger-to-auto-update-updated_at-column	7425bdb14366d1739fa8a18c83100636d74dcaa2	2026-04-25 07:50:36.759588
12	add-automatic-avif-detection-flag	8e92e1266eb29518b6a4c5313ab8f29dd0d08df9	2026-04-25 07:50:36.76366
13	add-bucket-custom-limits	cce962054138135cd9a8c4bcd531598684b25e7d	2026-04-25 07:50:36.76724
14	use-bytes-for-max-size	941c41b346f9802b411f06f30e972ad4744dad27	2026-04-25 07:50:36.771151
15	add-can-insert-object-function	934146bc38ead475f4ef4b555c524ee5d66799e5	2026-04-25 07:50:36.794717
16	add-version	76debf38d3fd07dcfc747ca49096457d95b1221b	2026-04-25 07:50:36.798469
17	drop-owner-foreign-key	f1cbb288f1b7a4c1eb8c38504b80ae2a0153d101	2026-04-25 07:50:36.802024
18	add_owner_id_column_deprecate_owner	e7a511b379110b08e2f214be852c35414749fe66	2026-04-25 07:50:36.805597
19	alter-default-value-objects-id	02e5e22a78626187e00d173dc45f58fa66a4f043	2026-04-25 07:50:36.810681
20	list-objects-with-delimiter	cd694ae708e51ba82bf012bba00caf4f3b6393b7	2026-04-25 07:50:36.814151
21	s3-multipart-uploads	8c804d4a566c40cd1e4cc5b3725a664a9303657f	2026-04-25 07:50:36.819416
22	s3-multipart-uploads-big-ints	9737dc258d2397953c9953d9b86920b8be0cdb73	2026-04-25 07:50:36.833919
23	optimize-search-function	9d7e604cddc4b56a5422dc68c9313f4a1b6f132c	2026-04-25 07:50:36.842797
24	operation-function	8312e37c2bf9e76bbe841aa5fda889206d2bf8aa	2026-04-25 07:50:36.846333
25	custom-metadata	d974c6057c3db1c1f847afa0e291e6165693b990	2026-04-25 07:50:36.849774
26	objects-prefixes	215cabcb7f78121892a5a2037a09fedf9a1ae322	2026-04-25 07:50:36.85327
27	search-v2	859ba38092ac96eb3964d83bf53ccc0b141663a6	2026-04-25 07:50:36.856474
28	object-bucket-name-sorting	c73a2b5b5d4041e39705814fd3a1b95502d38ce4	2026-04-25 07:50:36.859413
29	create-prefixes	ad2c1207f76703d11a9f9007f821620017a66c21	2026-04-25 07:50:36.86233
30	update-object-levels	2be814ff05c8252fdfdc7cfb4b7f5c7e17f0bed6	2026-04-25 07:50:36.865218
31	objects-level-index	b40367c14c3440ec75f19bbce2d71e914ddd3da0	2026-04-25 07:50:36.868175
32	backward-compatible-index-on-objects	e0c37182b0f7aee3efd823298fb3c76f1042c0f7	2026-04-25 07:50:36.871103
33	backward-compatible-index-on-prefixes	b480e99ed951e0900f033ec4eb34b5bdcb4e3d49	2026-04-25 07:50:36.874008
34	optimize-search-function-v1	ca80a3dc7bfef894df17108785ce29a7fc8ee456	2026-04-25 07:50:36.876911
35	add-insert-trigger-prefixes	458fe0ffd07ec53f5e3ce9df51bfdf4861929ccc	2026-04-25 07:50:36.879787
36	optimise-existing-functions	6ae5fca6af5c55abe95369cd4f93985d1814ca8f	2026-04-25 07:50:36.882845
37	add-bucket-name-length-trigger	3944135b4e3e8b22d6d4cbb568fe3b0b51df15c1	2026-04-25 07:50:36.885695
38	iceberg-catalog-flag-on-buckets	02716b81ceec9705aed84aa1501657095b32e5c5	2026-04-25 07:50:36.88946
39	add-search-v2-sort-support	6706c5f2928846abee18461279799ad12b279b78	2026-04-25 07:50:36.899616
40	fix-prefix-race-conditions-optimized	7ad69982ae2d372b21f48fc4829ae9752c518f6b	2026-04-25 07:50:36.902469
41	add-object-level-update-trigger	07fcf1a22165849b7a029deed059ffcde08d1ae0	2026-04-25 07:50:36.905436
42	rollback-prefix-triggers	771479077764adc09e2ea2043eb627503c034cd4	2026-04-25 07:50:36.908373
43	fix-object-level	84b35d6caca9d937478ad8a797491f38b8c2979f	2026-04-25 07:50:36.911177
44	vector-bucket-type	99c20c0ffd52bb1ff1f32fb992f3b351e3ef8fb3	2026-04-25 07:50:36.914009
45	vector-buckets	049e27196d77a7cb76497a85afae669d8b230953	2026-04-25 07:50:36.917465
46	buckets-objects-grants	fedeb96d60fefd8e02ab3ded9fbde05632f84aed	2026-04-25 07:50:36.926478
47	iceberg-table-metadata	649df56855c24d8b36dd4cc1aeb8251aa9ad42c2	2026-04-25 07:50:36.930032
48	iceberg-catalog-ids	e0e8b460c609b9999ccd0df9ad14294613eed939	2026-04-25 07:50:36.932949
49	buckets-objects-grants-postgres	072b1195d0d5a2f888af6b2302a1938dd94b8b3d	2026-04-25 07:50:36.949201
50	search-v2-optimised	6323ac4f850aa14e7387eb32102869578b5bd478	2026-04-25 07:50:36.954148
51	index-backward-compatible-search	2ee395d433f76e38bcd3856debaf6e0e5b674011	2026-04-25 07:50:37.514994
52	drop-not-used-indexes-and-functions	5cc44c8696749ac11dd0dc37f2a3802075f3a171	2026-04-25 07:50:37.51675
53	drop-index-lower-name	d0cb18777d9e2a98ebe0bc5cc7a42e57ebe41854	2026-04-25 07:50:37.525312
54	drop-index-object-level	6289e048b1472da17c31a7eba1ded625a6457e67	2026-04-25 07:50:37.527571
55	prevent-direct-deletes	262a4798d5e0f2e7c8970232e03ce8be695d5819	2026-04-25 07:50:37.529142
56	fix-optimized-search-function	cb58526ebc23048049fd5bf2fd148d18b04a2073	2026-04-25 07:50:37.533225
57	s3-multipart-uploads-metadata	f127886e00d1b374fadbc7c6b31e09336aad5287	2026-04-25 07:50:37.537844
58	operation-ergonomics	00ca5d483b3fe0d522133d9002ccc5df98365120	2026-04-25 07:50:37.541319
\.


--
-- Data for Name: objects; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.objects (id, bucket_id, name, owner, created_at, updated_at, last_accessed_at, metadata, version, owner_id, user_metadata) FROM stdin;
\.


--
-- Data for Name: s3_multipart_uploads; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.s3_multipart_uploads (id, in_progress_size, upload_signature, bucket_id, key, version, owner_id, created_at, user_metadata, metadata) FROM stdin;
\.


--
-- Data for Name: s3_multipart_uploads_parts; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.s3_multipart_uploads_parts (id, upload_id, size, part_number, bucket_id, key, etag, owner_id, version, created_at) FROM stdin;
\.


--
-- Data for Name: vector_indexes; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.vector_indexes (id, name, bucket_id, data_type, dimension, distance_metric, metadata_configuration, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: secrets; Type: TABLE DATA; Schema: vault; Owner: supabase_admin
--

COPY vault.secrets (id, name, description, secret, key_id, nonce, created_at, updated_at) FROM stdin;
\.


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: supabase_auth_admin
--

SELECT pg_catalog.setval('auth.refresh_tokens_id_seq', 47, true);


--
-- Name: subscription_id_seq; Type: SEQUENCE SET; Schema: realtime; Owner: supabase_admin
--

SELECT pg_catalog.setval('realtime.subscription_id_seq', 1, false);


--
-- Name: mfa_amr_claims amr_id_pk; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT amr_id_pk PRIMARY KEY (id);


--
-- Name: audit_log_entries audit_log_entries_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.audit_log_entries
    ADD CONSTRAINT audit_log_entries_pkey PRIMARY KEY (id);


--
-- Name: custom_oauth_providers custom_oauth_providers_identifier_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.custom_oauth_providers
    ADD CONSTRAINT custom_oauth_providers_identifier_key UNIQUE (identifier);


--
-- Name: custom_oauth_providers custom_oauth_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.custom_oauth_providers
    ADD CONSTRAINT custom_oauth_providers_pkey PRIMARY KEY (id);


--
-- Name: flow_state flow_state_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.flow_state
    ADD CONSTRAINT flow_state_pkey PRIMARY KEY (id);


--
-- Name: identities identities_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_pkey PRIMARY KEY (id);


--
-- Name: identities identities_provider_id_provider_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_provider_id_provider_unique UNIQUE (provider_id, provider);


--
-- Name: instances instances_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.instances
    ADD CONSTRAINT instances_pkey PRIMARY KEY (id);


--
-- Name: mfa_amr_claims mfa_amr_claims_session_id_authentication_method_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_authentication_method_pkey UNIQUE (session_id, authentication_method);


--
-- Name: mfa_challenges mfa_challenges_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_pkey PRIMARY KEY (id);


--
-- Name: mfa_factors mfa_factors_last_challenged_at_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_last_challenged_at_key UNIQUE (last_challenged_at);


--
-- Name: mfa_factors mfa_factors_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_pkey PRIMARY KEY (id);


--
-- Name: oauth_authorizations oauth_authorizations_authorization_code_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_authorization_code_key UNIQUE (authorization_code);


--
-- Name: oauth_authorizations oauth_authorizations_authorization_id_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_authorization_id_key UNIQUE (authorization_id);


--
-- Name: oauth_authorizations oauth_authorizations_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_pkey PRIMARY KEY (id);


--
-- Name: oauth_client_states oauth_client_states_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_client_states
    ADD CONSTRAINT oauth_client_states_pkey PRIMARY KEY (id);


--
-- Name: oauth_clients oauth_clients_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_clients
    ADD CONSTRAINT oauth_clients_pkey PRIMARY KEY (id);


--
-- Name: oauth_consents oauth_consents_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_pkey PRIMARY KEY (id);


--
-- Name: oauth_consents oauth_consents_user_client_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_user_client_unique UNIQUE (user_id, client_id);


--
-- Name: one_time_tokens one_time_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_pkey PRIMARY KEY (id);


--
-- Name: refresh_tokens refresh_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_pkey PRIMARY KEY (id);


--
-- Name: refresh_tokens refresh_tokens_token_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_token_unique UNIQUE (token);


--
-- Name: saml_providers saml_providers_entity_id_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_entity_id_key UNIQUE (entity_id);


--
-- Name: saml_providers saml_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_pkey PRIMARY KEY (id);


--
-- Name: saml_relay_states saml_relay_states_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: sso_domains sso_domains_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_pkey PRIMARY KEY (id);


--
-- Name: sso_providers sso_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_providers
    ADD CONSTRAINT sso_providers_pkey PRIMARY KEY (id);


--
-- Name: users users_phone_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_phone_key UNIQUE (phone);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: webauthn_challenges webauthn_challenges_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.webauthn_challenges
    ADD CONSTRAINT webauthn_challenges_pkey PRIMARY KEY (id);


--
-- Name: webauthn_credentials webauthn_credentials_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.webauthn_credentials
    ADD CONSTRAINT webauthn_credentials_pkey PRIMARY KEY (id);


--
-- Name: ai_insights ai_insights_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ai_insights
    ADD CONSTRAINT ai_insights_pkey PRIMARY KEY (id);


--
-- Name: alerts alerts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alerts
    ADD CONSTRAINT alerts_pkey PRIMARY KEY (id);


--
-- Name: institutions institutions_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.institutions
    ADD CONSTRAINT institutions_code_key UNIQUE (code);


--
-- Name: institutions institutions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.institutions
    ADD CONSTRAINT institutions_pkey PRIMARY KEY (id);


--
-- Name: kpi_definitions kpi_definitions_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kpi_definitions
    ADD CONSTRAINT kpi_definitions_code_key UNIQUE (code);


--
-- Name: kpi_definitions kpi_definitions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kpi_definitions
    ADD CONSTRAINT kpi_definitions_pkey PRIMARY KEY (id);


--
-- Name: kpi_values kpi_values_institution_id_kpi_id_period_date_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kpi_values
    ADD CONSTRAINT kpi_values_institution_id_kpi_id_period_date_key UNIQUE (institution_id, kpi_id, period_date);


--
-- Name: kpi_values kpi_values_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kpi_values
    ADD CONSTRAINT kpi_values_pkey PRIMARY KEY (id);


--
-- Name: reports reports_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reports
    ADD CONSTRAINT reports_pkey PRIMARY KEY (id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE ONLY realtime.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: subscription pk_subscription; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.subscription
    ADD CONSTRAINT pk_subscription PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: buckets_analytics buckets_analytics_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.buckets_analytics
    ADD CONSTRAINT buckets_analytics_pkey PRIMARY KEY (id);


--
-- Name: buckets buckets_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.buckets
    ADD CONSTRAINT buckets_pkey PRIMARY KEY (id);


--
-- Name: buckets_vectors buckets_vectors_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.buckets_vectors
    ADD CONSTRAINT buckets_vectors_pkey PRIMARY KEY (id);


--
-- Name: migrations migrations_name_key; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_name_key UNIQUE (name);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: objects objects_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT objects_pkey PRIMARY KEY (id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_pkey PRIMARY KEY (id);


--
-- Name: s3_multipart_uploads s3_multipart_uploads_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_pkey PRIMARY KEY (id);


--
-- Name: vector_indexes vector_indexes_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.vector_indexes
    ADD CONSTRAINT vector_indexes_pkey PRIMARY KEY (id);


--
-- Name: audit_logs_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX audit_logs_instance_id_idx ON auth.audit_log_entries USING btree (instance_id);


--
-- Name: confirmation_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX confirmation_token_idx ON auth.users USING btree (confirmation_token) WHERE ((confirmation_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: custom_oauth_providers_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX custom_oauth_providers_created_at_idx ON auth.custom_oauth_providers USING btree (created_at);


--
-- Name: custom_oauth_providers_enabled_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX custom_oauth_providers_enabled_idx ON auth.custom_oauth_providers USING btree (enabled);


--
-- Name: custom_oauth_providers_identifier_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX custom_oauth_providers_identifier_idx ON auth.custom_oauth_providers USING btree (identifier);


--
-- Name: custom_oauth_providers_provider_type_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX custom_oauth_providers_provider_type_idx ON auth.custom_oauth_providers USING btree (provider_type);


--
-- Name: email_change_token_current_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX email_change_token_current_idx ON auth.users USING btree (email_change_token_current) WHERE ((email_change_token_current)::text !~ '^[0-9 ]*$'::text);


--
-- Name: email_change_token_new_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX email_change_token_new_idx ON auth.users USING btree (email_change_token_new) WHERE ((email_change_token_new)::text !~ '^[0-9 ]*$'::text);


--
-- Name: factor_id_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX factor_id_created_at_idx ON auth.mfa_factors USING btree (user_id, created_at);


--
-- Name: flow_state_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX flow_state_created_at_idx ON auth.flow_state USING btree (created_at DESC);


--
-- Name: identities_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX identities_email_idx ON auth.identities USING btree (email text_pattern_ops);


--
-- Name: INDEX identities_email_idx; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON INDEX auth.identities_email_idx IS 'Auth: Ensures indexed queries on the email column';


--
-- Name: identities_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX identities_user_id_idx ON auth.identities USING btree (user_id);


--
-- Name: idx_auth_code; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_auth_code ON auth.flow_state USING btree (auth_code);


--
-- Name: idx_oauth_client_states_created_at; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_oauth_client_states_created_at ON auth.oauth_client_states USING btree (created_at);


--
-- Name: idx_user_id_auth_method; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_user_id_auth_method ON auth.flow_state USING btree (user_id, authentication_method);


--
-- Name: idx_users_created_at_desc; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_users_created_at_desc ON auth.users USING btree (created_at DESC);


--
-- Name: idx_users_email; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_users_email ON auth.users USING btree (email);


--
-- Name: idx_users_last_sign_in_at_desc; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_users_last_sign_in_at_desc ON auth.users USING btree (last_sign_in_at DESC);


--
-- Name: idx_users_name; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_users_name ON auth.users USING btree (((raw_user_meta_data ->> 'name'::text))) WHERE ((raw_user_meta_data ->> 'name'::text) IS NOT NULL);


--
-- Name: mfa_challenge_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX mfa_challenge_created_at_idx ON auth.mfa_challenges USING btree (created_at DESC);


--
-- Name: mfa_factors_user_friendly_name_unique; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX mfa_factors_user_friendly_name_unique ON auth.mfa_factors USING btree (friendly_name, user_id) WHERE (TRIM(BOTH FROM friendly_name) <> ''::text);


--
-- Name: mfa_factors_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX mfa_factors_user_id_idx ON auth.mfa_factors USING btree (user_id);


--
-- Name: oauth_auth_pending_exp_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_auth_pending_exp_idx ON auth.oauth_authorizations USING btree (expires_at) WHERE (status = 'pending'::auth.oauth_authorization_status);


--
-- Name: oauth_clients_deleted_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_clients_deleted_at_idx ON auth.oauth_clients USING btree (deleted_at);


--
-- Name: oauth_consents_active_client_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_consents_active_client_idx ON auth.oauth_consents USING btree (client_id) WHERE (revoked_at IS NULL);


--
-- Name: oauth_consents_active_user_client_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_consents_active_user_client_idx ON auth.oauth_consents USING btree (user_id, client_id) WHERE (revoked_at IS NULL);


--
-- Name: oauth_consents_user_order_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_consents_user_order_idx ON auth.oauth_consents USING btree (user_id, granted_at DESC);


--
-- Name: one_time_tokens_relates_to_hash_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX one_time_tokens_relates_to_hash_idx ON auth.one_time_tokens USING hash (relates_to);


--
-- Name: one_time_tokens_token_hash_hash_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX one_time_tokens_token_hash_hash_idx ON auth.one_time_tokens USING hash (token_hash);


--
-- Name: one_time_tokens_user_id_token_type_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX one_time_tokens_user_id_token_type_key ON auth.one_time_tokens USING btree (user_id, token_type);


--
-- Name: reauthentication_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX reauthentication_token_idx ON auth.users USING btree (reauthentication_token) WHERE ((reauthentication_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: recovery_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX recovery_token_idx ON auth.users USING btree (recovery_token) WHERE ((recovery_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: refresh_tokens_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_instance_id_idx ON auth.refresh_tokens USING btree (instance_id);


--
-- Name: refresh_tokens_instance_id_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_instance_id_user_id_idx ON auth.refresh_tokens USING btree (instance_id, user_id);


--
-- Name: refresh_tokens_parent_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_parent_idx ON auth.refresh_tokens USING btree (parent);


--
-- Name: refresh_tokens_session_id_revoked_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_session_id_revoked_idx ON auth.refresh_tokens USING btree (session_id, revoked);


--
-- Name: refresh_tokens_updated_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_updated_at_idx ON auth.refresh_tokens USING btree (updated_at DESC);


--
-- Name: saml_providers_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_providers_sso_provider_id_idx ON auth.saml_providers USING btree (sso_provider_id);


--
-- Name: saml_relay_states_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_created_at_idx ON auth.saml_relay_states USING btree (created_at DESC);


--
-- Name: saml_relay_states_for_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_for_email_idx ON auth.saml_relay_states USING btree (for_email);


--
-- Name: saml_relay_states_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_sso_provider_id_idx ON auth.saml_relay_states USING btree (sso_provider_id);


--
-- Name: sessions_not_after_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_not_after_idx ON auth.sessions USING btree (not_after DESC);


--
-- Name: sessions_oauth_client_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_oauth_client_id_idx ON auth.sessions USING btree (oauth_client_id);


--
-- Name: sessions_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_user_id_idx ON auth.sessions USING btree (user_id);


--
-- Name: sso_domains_domain_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX sso_domains_domain_idx ON auth.sso_domains USING btree (lower(domain));


--
-- Name: sso_domains_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sso_domains_sso_provider_id_idx ON auth.sso_domains USING btree (sso_provider_id);


--
-- Name: sso_providers_resource_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX sso_providers_resource_id_idx ON auth.sso_providers USING btree (lower(resource_id));


--
-- Name: sso_providers_resource_id_pattern_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sso_providers_resource_id_pattern_idx ON auth.sso_providers USING btree (resource_id text_pattern_ops);


--
-- Name: unique_phone_factor_per_user; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX unique_phone_factor_per_user ON auth.mfa_factors USING btree (user_id, phone);


--
-- Name: user_id_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX user_id_created_at_idx ON auth.sessions USING btree (user_id, created_at);


--
-- Name: users_email_partial_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX users_email_partial_key ON auth.users USING btree (email) WHERE (is_sso_user = false);


--
-- Name: INDEX users_email_partial_key; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON INDEX auth.users_email_partial_key IS 'Auth: A partial unique index that applies only when is_sso_user is false';


--
-- Name: users_instance_id_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_instance_id_email_idx ON auth.users USING btree (instance_id, lower((email)::text));


--
-- Name: users_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_instance_id_idx ON auth.users USING btree (instance_id);


--
-- Name: users_is_anonymous_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_is_anonymous_idx ON auth.users USING btree (is_anonymous);


--
-- Name: webauthn_challenges_expires_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX webauthn_challenges_expires_at_idx ON auth.webauthn_challenges USING btree (expires_at);


--
-- Name: webauthn_challenges_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX webauthn_challenges_user_id_idx ON auth.webauthn_challenges USING btree (user_id);


--
-- Name: webauthn_credentials_credential_id_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX webauthn_credentials_credential_id_key ON auth.webauthn_credentials USING btree (credential_id);


--
-- Name: webauthn_credentials_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX webauthn_credentials_user_id_idx ON auth.webauthn_credentials USING btree (user_id);


--
-- Name: idx_ai_insights_institution; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_ai_insights_institution ON public.ai_insights USING btree (institution_id);


--
-- Name: idx_kpi_values_date; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_kpi_values_date ON public.kpi_values USING btree (period_date);


--
-- Name: idx_kpi_values_fast; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_kpi_values_fast ON public.kpi_values USING btree (institution_id, kpi_id, period_date);


--
-- Name: idx_kpi_values_institution; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_kpi_values_institution ON public.kpi_values USING btree (institution_id);


--
-- Name: idx_users_institution; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_users_institution ON public.users USING btree (institution_id);


--
-- Name: ix_realtime_subscription_entity; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE INDEX ix_realtime_subscription_entity ON realtime.subscription USING btree (entity);


--
-- Name: messages_inserted_at_topic_index; Type: INDEX; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE INDEX messages_inserted_at_topic_index ON ONLY realtime.messages USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: subscription_subscription_id_entity_filters_action_filter_key; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE UNIQUE INDEX subscription_subscription_id_entity_filters_action_filter_key ON realtime.subscription USING btree (subscription_id, entity, filters, action_filter);


--
-- Name: bname; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX bname ON storage.buckets USING btree (name);


--
-- Name: bucketid_objname; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX bucketid_objname ON storage.objects USING btree (bucket_id, name);


--
-- Name: buckets_analytics_unique_name_idx; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX buckets_analytics_unique_name_idx ON storage.buckets_analytics USING btree (name) WHERE (deleted_at IS NULL);


--
-- Name: idx_multipart_uploads_list; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_multipart_uploads_list ON storage.s3_multipart_uploads USING btree (bucket_id, key, created_at);


--
-- Name: idx_objects_bucket_id_name; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_objects_bucket_id_name ON storage.objects USING btree (bucket_id, name COLLATE "C");


--
-- Name: idx_objects_bucket_id_name_lower; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_objects_bucket_id_name_lower ON storage.objects USING btree (bucket_id, lower(name) COLLATE "C");


--
-- Name: name_prefix_search; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX name_prefix_search ON storage.objects USING btree (name text_pattern_ops);


--
-- Name: vector_indexes_name_bucket_id_idx; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX vector_indexes_name_bucket_id_idx ON storage.vector_indexes USING btree (name, bucket_id);


--
-- Name: subscription tr_check_filters; Type: TRIGGER; Schema: realtime; Owner: supabase_admin
--

CREATE TRIGGER tr_check_filters BEFORE INSERT OR UPDATE ON realtime.subscription FOR EACH ROW EXECUTE FUNCTION realtime.subscription_check_filters();


--
-- Name: buckets enforce_bucket_name_length_trigger; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER enforce_bucket_name_length_trigger BEFORE INSERT OR UPDATE OF name ON storage.buckets FOR EACH ROW EXECUTE FUNCTION storage.enforce_bucket_name_length();


--
-- Name: buckets protect_buckets_delete; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER protect_buckets_delete BEFORE DELETE ON storage.buckets FOR EACH STATEMENT EXECUTE FUNCTION storage.protect_delete();


--
-- Name: objects protect_objects_delete; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER protect_objects_delete BEFORE DELETE ON storage.objects FOR EACH STATEMENT EXECUTE FUNCTION storage.protect_delete();


--
-- Name: objects update_objects_updated_at; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER update_objects_updated_at BEFORE UPDATE ON storage.objects FOR EACH ROW EXECUTE FUNCTION storage.update_updated_at_column();


--
-- Name: identities identities_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: mfa_amr_claims mfa_amr_claims_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- Name: mfa_challenges mfa_challenges_auth_factor_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_auth_factor_id_fkey FOREIGN KEY (factor_id) REFERENCES auth.mfa_factors(id) ON DELETE CASCADE;


--
-- Name: mfa_factors mfa_factors_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: oauth_authorizations oauth_authorizations_client_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_client_id_fkey FOREIGN KEY (client_id) REFERENCES auth.oauth_clients(id) ON DELETE CASCADE;


--
-- Name: oauth_authorizations oauth_authorizations_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: oauth_consents oauth_consents_client_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_client_id_fkey FOREIGN KEY (client_id) REFERENCES auth.oauth_clients(id) ON DELETE CASCADE;


--
-- Name: oauth_consents oauth_consents_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: one_time_tokens one_time_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: refresh_tokens refresh_tokens_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- Name: saml_providers saml_providers_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: saml_relay_states saml_relay_states_flow_state_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_flow_state_id_fkey FOREIGN KEY (flow_state_id) REFERENCES auth.flow_state(id) ON DELETE CASCADE;


--
-- Name: saml_relay_states saml_relay_states_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: sessions sessions_oauth_client_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_oauth_client_id_fkey FOREIGN KEY (oauth_client_id) REFERENCES auth.oauth_clients(id) ON DELETE CASCADE;


--
-- Name: sessions sessions_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: sso_domains sso_domains_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: webauthn_challenges webauthn_challenges_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.webauthn_challenges
    ADD CONSTRAINT webauthn_challenges_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: webauthn_credentials webauthn_credentials_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.webauthn_credentials
    ADD CONSTRAINT webauthn_credentials_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: ai_insights ai_insights_institution_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ai_insights
    ADD CONSTRAINT ai_insights_institution_id_fkey FOREIGN KEY (institution_id) REFERENCES public.institutions(id) ON DELETE CASCADE;


--
-- Name: ai_insights ai_insights_kpi_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ai_insights
    ADD CONSTRAINT ai_insights_kpi_id_fkey FOREIGN KEY (kpi_id) REFERENCES public.kpi_definitions(id);


--
-- Name: alerts alerts_institution_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alerts
    ADD CONSTRAINT alerts_institution_id_fkey FOREIGN KEY (institution_id) REFERENCES public.institutions(id);


--
-- Name: alerts alerts_kpi_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alerts
    ADD CONSTRAINT alerts_kpi_id_fkey FOREIGN KEY (kpi_id) REFERENCES public.kpi_definitions(id);


--
-- Name: kpi_values kpi_values_institution_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kpi_values
    ADD CONSTRAINT kpi_values_institution_id_fkey FOREIGN KEY (institution_id) REFERENCES public.institutions(id) ON DELETE CASCADE;


--
-- Name: kpi_values kpi_values_kpi_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kpi_values
    ADD CONSTRAINT kpi_values_kpi_id_fkey FOREIGN KEY (kpi_id) REFERENCES public.kpi_definitions(id) ON DELETE CASCADE;


--
-- Name: reports reports_institution_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reports
    ADD CONSTRAINT reports_institution_id_fkey FOREIGN KEY (institution_id) REFERENCES public.institutions(id);


--
-- Name: users users_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_id_fkey FOREIGN KEY (id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: users users_institution_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_institution_id_fkey FOREIGN KEY (institution_id) REFERENCES public.institutions(id) ON DELETE CASCADE;


--
-- Name: objects objects_bucketId_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT "objects_bucketId_fkey" FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads s3_multipart_uploads_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_upload_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_upload_id_fkey FOREIGN KEY (upload_id) REFERENCES storage.s3_multipart_uploads(id) ON DELETE CASCADE;


--
-- Name: vector_indexes vector_indexes_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.vector_indexes
    ADD CONSTRAINT vector_indexes_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets_vectors(id);


--
-- Name: audit_log_entries; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.audit_log_entries ENABLE ROW LEVEL SECURITY;

--
-- Name: flow_state; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.flow_state ENABLE ROW LEVEL SECURITY;

--
-- Name: identities; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.identities ENABLE ROW LEVEL SECURITY;

--
-- Name: instances; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.instances ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_amr_claims; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_amr_claims ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_challenges; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_challenges ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_factors; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_factors ENABLE ROW LEVEL SECURITY;

--
-- Name: one_time_tokens; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.one_time_tokens ENABLE ROW LEVEL SECURITY;

--
-- Name: refresh_tokens; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.refresh_tokens ENABLE ROW LEVEL SECURITY;

--
-- Name: saml_providers; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.saml_providers ENABLE ROW LEVEL SECURITY;

--
-- Name: saml_relay_states; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.saml_relay_states ENABLE ROW LEVEL SECURITY;

--
-- Name: schema_migrations; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.schema_migrations ENABLE ROW LEVEL SECURITY;

--
-- Name: sessions; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sessions ENABLE ROW LEVEL SECURITY;

--
-- Name: sso_domains; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sso_domains ENABLE ROW LEVEL SECURITY;

--
-- Name: sso_providers; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sso_providers ENABLE ROW LEVEL SECURITY;

--
-- Name: users; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.users ENABLE ROW LEVEL SECURITY;

--
-- Name: ai_insights Enable read access for all users; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable read access for all users" ON public.ai_insights FOR SELECT USING (true);


--
-- Name: alerts Enable read access for all users; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable read access for all users" ON public.alerts FOR SELECT USING (true);


--
-- Name: institutions Enable read access for all users; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable read access for all users" ON public.institutions FOR SELECT USING (true);


--
-- Name: kpi_definitions Enable read access for all users; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable read access for all users" ON public.kpi_definitions FOR SELECT USING (true);


--
-- Name: kpi_values Enable read access for all users; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable read access for all users" ON public.kpi_values FOR SELECT USING (true);


--
-- Name: reports Enable read access for all users; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable read access for all users" ON public.reports FOR SELECT USING (true);


--
-- Name: users Enable read access for all users; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable read access for all users" ON public.users FOR SELECT USING (true);


--
-- Name: ai_insights; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.ai_insights ENABLE ROW LEVEL SECURITY;

--
-- Name: alerts; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.alerts ENABLE ROW LEVEL SECURITY;

--
-- Name: institutions; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.institutions ENABLE ROW LEVEL SECURITY;

--
-- Name: kpi_definitions; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.kpi_definitions ENABLE ROW LEVEL SECURITY;

--
-- Name: kpi_values; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.kpi_values ENABLE ROW LEVEL SECURITY;

--
-- Name: kpi_values read access; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "read access" ON public.kpi_values FOR SELECT USING (((auth.uid() IN ( SELECT users.id
   FROM public.users
  WHERE ((users.role)::text = ANY ((ARRAY['super_admin'::character varying, 'agent'::character varying])::text[])))) OR (institution_id IN ( SELECT users.institution_id
   FROM public.users
  WHERE ((users.id = auth.uid()) AND ((users.role)::text = 'admin'::text))))));


--
-- Name: reports; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.reports ENABLE ROW LEVEL SECURITY;

--
-- Name: users; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.users ENABLE ROW LEVEL SECURITY;

--
-- Name: kpi_values write access; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "write access" ON public.kpi_values FOR INSERT WITH CHECK (((auth.uid() IN ( SELECT users.id
   FROM public.users
  WHERE ((users.role)::text = 'super_admin'::text))) OR (institution_id IN ( SELECT users.institution_id
   FROM public.users
  WHERE ((users.id = auth.uid()) AND ((users.role)::text = 'admin'::text))))));


--
-- Name: messages; Type: ROW SECURITY; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE realtime.messages ENABLE ROW LEVEL SECURITY;

--
-- Name: buckets; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.buckets ENABLE ROW LEVEL SECURITY;

--
-- Name: buckets_analytics; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.buckets_analytics ENABLE ROW LEVEL SECURITY;

--
-- Name: buckets_vectors; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.buckets_vectors ENABLE ROW LEVEL SECURITY;

--
-- Name: migrations; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.migrations ENABLE ROW LEVEL SECURITY;

--
-- Name: objects; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.objects ENABLE ROW LEVEL SECURITY;

--
-- Name: s3_multipart_uploads; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.s3_multipart_uploads ENABLE ROW LEVEL SECURITY;

--
-- Name: s3_multipart_uploads_parts; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.s3_multipart_uploads_parts ENABLE ROW LEVEL SECURITY;

--
-- Name: vector_indexes; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.vector_indexes ENABLE ROW LEVEL SECURITY;

--
-- Name: supabase_realtime; Type: PUBLICATION; Schema: -; Owner: postgres
--

CREATE PUBLICATION supabase_realtime WITH (publish = 'insert, update, delete, truncate');


ALTER PUBLICATION supabase_realtime OWNER TO postgres;

--
-- Name: SCHEMA auth; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA auth TO anon;
GRANT USAGE ON SCHEMA auth TO authenticated;
GRANT USAGE ON SCHEMA auth TO service_role;
GRANT ALL ON SCHEMA auth TO supabase_auth_admin;
GRANT ALL ON SCHEMA auth TO dashboard_user;
GRANT USAGE ON SCHEMA auth TO postgres;


--
-- Name: SCHEMA extensions; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA extensions TO anon;
GRANT USAGE ON SCHEMA extensions TO authenticated;
GRANT USAGE ON SCHEMA extensions TO service_role;
GRANT ALL ON SCHEMA extensions TO dashboard_user;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT USAGE ON SCHEMA public TO anon;
GRANT USAGE ON SCHEMA public TO authenticated;
GRANT USAGE ON SCHEMA public TO service_role;


--
-- Name: SCHEMA realtime; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA realtime TO postgres;
GRANT USAGE ON SCHEMA realtime TO anon;
GRANT USAGE ON SCHEMA realtime TO authenticated;
GRANT USAGE ON SCHEMA realtime TO service_role;
GRANT ALL ON SCHEMA realtime TO supabase_realtime_admin;


--
-- Name: SCHEMA storage; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA storage TO postgres WITH GRANT OPTION;
GRANT USAGE ON SCHEMA storage TO anon;
GRANT USAGE ON SCHEMA storage TO authenticated;
GRANT USAGE ON SCHEMA storage TO service_role;
GRANT ALL ON SCHEMA storage TO supabase_storage_admin WITH GRANT OPTION;
GRANT ALL ON SCHEMA storage TO dashboard_user;


--
-- Name: SCHEMA vault; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA vault TO postgres WITH GRANT OPTION;
GRANT USAGE ON SCHEMA vault TO service_role;


--
-- Name: FUNCTION email(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.email() TO dashboard_user;


--
-- Name: FUNCTION jwt(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.jwt() TO postgres;
GRANT ALL ON FUNCTION auth.jwt() TO dashboard_user;


--
-- Name: FUNCTION role(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.role() TO dashboard_user;


--
-- Name: FUNCTION uid(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.uid() TO dashboard_user;


--
-- Name: FUNCTION armor(bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.armor(bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.armor(bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.armor(bytea) TO dashboard_user;


--
-- Name: FUNCTION armor(bytea, text[], text[]); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.armor(bytea, text[], text[]) FROM postgres;
GRANT ALL ON FUNCTION extensions.armor(bytea, text[], text[]) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.armor(bytea, text[], text[]) TO dashboard_user;


--
-- Name: FUNCTION crypt(text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.crypt(text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.crypt(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.crypt(text, text) TO dashboard_user;


--
-- Name: FUNCTION dearmor(text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.dearmor(text) FROM postgres;
GRANT ALL ON FUNCTION extensions.dearmor(text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.dearmor(text) TO dashboard_user;


--
-- Name: FUNCTION decrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION decrypt_iv(bytea, bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION digest(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.digest(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.digest(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.digest(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION digest(text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.digest(text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.digest(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.digest(text, text) TO dashboard_user;


--
-- Name: FUNCTION encrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION encrypt_iv(bytea, bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION gen_random_bytes(integer); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_random_bytes(integer) FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_random_bytes(integer) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_random_bytes(integer) TO dashboard_user;


--
-- Name: FUNCTION gen_random_uuid(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_random_uuid() FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_random_uuid() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_random_uuid() TO dashboard_user;


--
-- Name: FUNCTION gen_salt(text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_salt(text) FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_salt(text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_salt(text) TO dashboard_user;


--
-- Name: FUNCTION gen_salt(text, integer); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_salt(text, integer) FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_salt(text, integer) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_salt(text, integer) TO dashboard_user;


--
-- Name: FUNCTION grant_pg_cron_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION extensions.grant_pg_cron_access() FROM supabase_admin;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO supabase_admin WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO dashboard_user;


--
-- Name: FUNCTION grant_pg_graphql_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.grant_pg_graphql_access() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION grant_pg_net_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION extensions.grant_pg_net_access() FROM supabase_admin;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO supabase_admin WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO dashboard_user;


--
-- Name: FUNCTION hmac(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.hmac(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.hmac(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.hmac(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION hmac(text, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.hmac(text, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.hmac(text, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.hmac(text, text, text) TO dashboard_user;


--
-- Name: FUNCTION pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT shared_blk_read_time double precision, OUT shared_blk_write_time double precision, OUT local_blk_read_time double precision, OUT local_blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision, OUT jit_deform_count bigint, OUT jit_deform_time double precision, OUT stats_since timestamp with time zone, OUT minmax_stats_since timestamp with time zone); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT shared_blk_read_time double precision, OUT shared_blk_write_time double precision, OUT local_blk_read_time double precision, OUT local_blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision, OUT jit_deform_count bigint, OUT jit_deform_time double precision, OUT stats_since timestamp with time zone, OUT minmax_stats_since timestamp with time zone) FROM postgres;
GRANT ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT shared_blk_read_time double precision, OUT shared_blk_write_time double precision, OUT local_blk_read_time double precision, OUT local_blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision, OUT jit_deform_count bigint, OUT jit_deform_time double precision, OUT stats_since timestamp with time zone, OUT minmax_stats_since timestamp with time zone) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT shared_blk_read_time double precision, OUT shared_blk_write_time double precision, OUT local_blk_read_time double precision, OUT local_blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision, OUT jit_deform_count bigint, OUT jit_deform_time double precision, OUT stats_since timestamp with time zone, OUT minmax_stats_since timestamp with time zone) TO dashboard_user;


--
-- Name: FUNCTION pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) FROM postgres;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) TO dashboard_user;


--
-- Name: FUNCTION pg_stat_statements_reset(userid oid, dbid oid, queryid bigint, minmax_only boolean); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint, minmax_only boolean) FROM postgres;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint, minmax_only boolean) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint, minmax_only boolean) TO dashboard_user;


--
-- Name: FUNCTION pgp_armor_headers(text, OUT key text, OUT value text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) TO dashboard_user;


--
-- Name: FUNCTION pgp_key_id(bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_key_id(bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_key_id(bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_key_id(bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt(text, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt(text, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt_bytea(bytea, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt_bytea(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt(bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt_bytea(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt_bytea(bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt(text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt(text, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt_bytea(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt_bytea(bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgrst_ddl_watch(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgrst_ddl_watch() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgrst_drop_watch(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgrst_drop_watch() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION set_graphql_placeholder(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.set_graphql_placeholder() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION uuid_generate_v1(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v1() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1() TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v1mc(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v1mc() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1mc() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1mc() TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v3(namespace uuid, name text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v4(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v4() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v4() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v4() TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v5(namespace uuid, name text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) TO dashboard_user;


--
-- Name: FUNCTION uuid_nil(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_nil() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_nil() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_nil() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_dns(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_dns() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_dns() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_dns() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_oid(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_oid() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_oid() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_oid() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_url(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_url() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_url() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_url() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_x500(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_x500() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_x500() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_x500() TO dashboard_user;


--
-- Name: FUNCTION graphql("operationName" text, query text, variables jsonb, extensions jsonb); Type: ACL; Schema: graphql_public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO postgres;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO anon;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO authenticated;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO service_role;


--
-- Name: FUNCTION pg_reload_conf(); Type: ACL; Schema: pg_catalog; Owner: supabase_admin
--

GRANT ALL ON FUNCTION pg_catalog.pg_reload_conf() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION get_auth(p_usename text); Type: ACL; Schema: pgbouncer; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgbouncer.get_auth(p_usename text) FROM PUBLIC;
GRANT ALL ON FUNCTION pgbouncer.get_auth(p_usename text) TO pgbouncer;


--
-- Name: FUNCTION apply_rls(wal jsonb, max_record_bytes integer); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO postgres;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO anon;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO authenticated;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO service_role;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO supabase_realtime_admin;


--
-- Name: FUNCTION broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) TO postgres;
GRANT ALL ON FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) TO dashboard_user;


--
-- Name: FUNCTION build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO postgres;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO anon;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO authenticated;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO service_role;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO supabase_realtime_admin;


--
-- Name: FUNCTION "cast"(val text, type_ regtype); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO postgres;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO dashboard_user;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO anon;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO authenticated;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO service_role;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO supabase_realtime_admin;


--
-- Name: FUNCTION check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO postgres;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO anon;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO authenticated;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO service_role;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO supabase_realtime_admin;


--
-- Name: FUNCTION is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO postgres;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO anon;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO authenticated;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO service_role;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO supabase_realtime_admin;


--
-- Name: FUNCTION list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO postgres;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO dashboard_user;


--
-- Name: FUNCTION quote_wal2json(entity regclass); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO postgres;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO anon;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO authenticated;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO service_role;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO supabase_realtime_admin;


--
-- Name: FUNCTION send(payload jsonb, event text, topic text, private boolean); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) TO postgres;
GRANT ALL ON FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) TO dashboard_user;


--
-- Name: FUNCTION subscription_check_filters(); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO postgres;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO dashboard_user;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO anon;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO authenticated;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO service_role;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO supabase_realtime_admin;


--
-- Name: FUNCTION to_regrole(role_name text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO postgres;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO anon;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO authenticated;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO service_role;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO supabase_realtime_admin;


--
-- Name: FUNCTION topic(); Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON FUNCTION realtime.topic() TO postgres;
GRANT ALL ON FUNCTION realtime.topic() TO dashboard_user;


--
-- Name: FUNCTION _crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault._crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault._crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea) TO service_role;


--
-- Name: FUNCTION create_secret(new_secret text, new_name text, new_description text, new_key_id uuid); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault.create_secret(new_secret text, new_name text, new_description text, new_key_id uuid) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault.create_secret(new_secret text, new_name text, new_description text, new_key_id uuid) TO service_role;


--
-- Name: FUNCTION update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault.update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault.update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid) TO service_role;


--
-- Name: TABLE audit_log_entries; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.audit_log_entries TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.audit_log_entries TO postgres;
GRANT SELECT ON TABLE auth.audit_log_entries TO postgres WITH GRANT OPTION;


--
-- Name: TABLE custom_oauth_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.custom_oauth_providers TO postgres;
GRANT ALL ON TABLE auth.custom_oauth_providers TO dashboard_user;


--
-- Name: TABLE flow_state; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.flow_state TO postgres;
GRANT SELECT ON TABLE auth.flow_state TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.flow_state TO dashboard_user;


--
-- Name: TABLE identities; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.identities TO postgres;
GRANT SELECT ON TABLE auth.identities TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.identities TO dashboard_user;


--
-- Name: TABLE instances; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.instances TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.instances TO postgres;
GRANT SELECT ON TABLE auth.instances TO postgres WITH GRANT OPTION;


--
-- Name: TABLE mfa_amr_claims; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.mfa_amr_claims TO postgres;
GRANT SELECT ON TABLE auth.mfa_amr_claims TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_amr_claims TO dashboard_user;


--
-- Name: TABLE mfa_challenges; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.mfa_challenges TO postgres;
GRANT SELECT ON TABLE auth.mfa_challenges TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_challenges TO dashboard_user;


--
-- Name: TABLE mfa_factors; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.mfa_factors TO postgres;
GRANT SELECT ON TABLE auth.mfa_factors TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_factors TO dashboard_user;


--
-- Name: TABLE oauth_authorizations; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.oauth_authorizations TO postgres;
GRANT ALL ON TABLE auth.oauth_authorizations TO dashboard_user;


--
-- Name: TABLE oauth_client_states; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.oauth_client_states TO postgres;
GRANT ALL ON TABLE auth.oauth_client_states TO dashboard_user;


--
-- Name: TABLE oauth_clients; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.oauth_clients TO postgres;
GRANT ALL ON TABLE auth.oauth_clients TO dashboard_user;


--
-- Name: TABLE oauth_consents; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.oauth_consents TO postgres;
GRANT ALL ON TABLE auth.oauth_consents TO dashboard_user;


--
-- Name: TABLE one_time_tokens; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.one_time_tokens TO postgres;
GRANT SELECT ON TABLE auth.one_time_tokens TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.one_time_tokens TO dashboard_user;


--
-- Name: TABLE refresh_tokens; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.refresh_tokens TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.refresh_tokens TO postgres;
GRANT SELECT ON TABLE auth.refresh_tokens TO postgres WITH GRANT OPTION;


--
-- Name: SEQUENCE refresh_tokens_id_seq; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON SEQUENCE auth.refresh_tokens_id_seq TO dashboard_user;
GRANT ALL ON SEQUENCE auth.refresh_tokens_id_seq TO postgres;


--
-- Name: TABLE saml_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.saml_providers TO postgres;
GRANT SELECT ON TABLE auth.saml_providers TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.saml_providers TO dashboard_user;


--
-- Name: TABLE saml_relay_states; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.saml_relay_states TO postgres;
GRANT SELECT ON TABLE auth.saml_relay_states TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.saml_relay_states TO dashboard_user;


--
-- Name: TABLE schema_migrations; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT SELECT ON TABLE auth.schema_migrations TO postgres WITH GRANT OPTION;


--
-- Name: TABLE sessions; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.sessions TO postgres;
GRANT SELECT ON TABLE auth.sessions TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sessions TO dashboard_user;


--
-- Name: TABLE sso_domains; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.sso_domains TO postgres;
GRANT SELECT ON TABLE auth.sso_domains TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sso_domains TO dashboard_user;


--
-- Name: TABLE sso_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.sso_providers TO postgres;
GRANT SELECT ON TABLE auth.sso_providers TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sso_providers TO dashboard_user;


--
-- Name: TABLE users; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.users TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.users TO postgres;
GRANT SELECT ON TABLE auth.users TO postgres WITH GRANT OPTION;


--
-- Name: TABLE webauthn_challenges; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.webauthn_challenges TO postgres;
GRANT ALL ON TABLE auth.webauthn_challenges TO dashboard_user;


--
-- Name: TABLE webauthn_credentials; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.webauthn_credentials TO postgres;
GRANT ALL ON TABLE auth.webauthn_credentials TO dashboard_user;


--
-- Name: TABLE pg_stat_statements; Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON TABLE extensions.pg_stat_statements FROM postgres;
GRANT ALL ON TABLE extensions.pg_stat_statements TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE extensions.pg_stat_statements TO dashboard_user;


--
-- Name: TABLE pg_stat_statements_info; Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON TABLE extensions.pg_stat_statements_info FROM postgres;
GRANT ALL ON TABLE extensions.pg_stat_statements_info TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE extensions.pg_stat_statements_info TO dashboard_user;


--
-- Name: TABLE ai_insights; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.ai_insights TO anon;
GRANT ALL ON TABLE public.ai_insights TO authenticated;
GRANT ALL ON TABLE public.ai_insights TO service_role;


--
-- Name: TABLE alerts; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.alerts TO anon;
GRANT ALL ON TABLE public.alerts TO authenticated;
GRANT ALL ON TABLE public.alerts TO service_role;


--
-- Name: TABLE institutions; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.institutions TO anon;
GRANT ALL ON TABLE public.institutions TO authenticated;
GRANT ALL ON TABLE public.institutions TO service_role;


--
-- Name: TABLE kpi_definitions; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.kpi_definitions TO anon;
GRANT ALL ON TABLE public.kpi_definitions TO authenticated;
GRANT ALL ON TABLE public.kpi_definitions TO service_role;


--
-- Name: TABLE kpi_values; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.kpi_values TO anon;
GRANT ALL ON TABLE public.kpi_values TO authenticated;
GRANT ALL ON TABLE public.kpi_values TO service_role;


--
-- Name: TABLE reports; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.reports TO anon;
GRANT ALL ON TABLE public.reports TO authenticated;
GRANT ALL ON TABLE public.reports TO service_role;


--
-- Name: TABLE users; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.users TO anon;
GRANT ALL ON TABLE public.users TO authenticated;
GRANT ALL ON TABLE public.users TO service_role;


--
-- Name: TABLE messages; Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON TABLE realtime.messages TO postgres;
GRANT ALL ON TABLE realtime.messages TO dashboard_user;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO anon;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO authenticated;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO service_role;


--
-- Name: TABLE schema_migrations; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.schema_migrations TO postgres;
GRANT ALL ON TABLE realtime.schema_migrations TO dashboard_user;
GRANT SELECT ON TABLE realtime.schema_migrations TO anon;
GRANT SELECT ON TABLE realtime.schema_migrations TO authenticated;
GRANT SELECT ON TABLE realtime.schema_migrations TO service_role;
GRANT ALL ON TABLE realtime.schema_migrations TO supabase_realtime_admin;


--
-- Name: TABLE subscription; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.subscription TO postgres;
GRANT ALL ON TABLE realtime.subscription TO dashboard_user;
GRANT SELECT ON TABLE realtime.subscription TO anon;
GRANT SELECT ON TABLE realtime.subscription TO authenticated;
GRANT SELECT ON TABLE realtime.subscription TO service_role;
GRANT ALL ON TABLE realtime.subscription TO supabase_realtime_admin;


--
-- Name: SEQUENCE subscription_id_seq; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO postgres;
GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO dashboard_user;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO anon;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO authenticated;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO service_role;
GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO supabase_realtime_admin;


--
-- Name: TABLE buckets; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

REVOKE ALL ON TABLE storage.buckets FROM supabase_storage_admin;
GRANT ALL ON TABLE storage.buckets TO supabase_storage_admin WITH GRANT OPTION;
GRANT ALL ON TABLE storage.buckets TO service_role;
GRANT ALL ON TABLE storage.buckets TO authenticated;
GRANT ALL ON TABLE storage.buckets TO anon;
GRANT ALL ON TABLE storage.buckets TO postgres WITH GRANT OPTION;


--
-- Name: TABLE buckets_analytics; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.buckets_analytics TO service_role;
GRANT ALL ON TABLE storage.buckets_analytics TO authenticated;
GRANT ALL ON TABLE storage.buckets_analytics TO anon;


--
-- Name: TABLE buckets_vectors; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT SELECT ON TABLE storage.buckets_vectors TO service_role;
GRANT SELECT ON TABLE storage.buckets_vectors TO authenticated;
GRANT SELECT ON TABLE storage.buckets_vectors TO anon;


--
-- Name: TABLE objects; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

REVOKE ALL ON TABLE storage.objects FROM supabase_storage_admin;
GRANT ALL ON TABLE storage.objects TO supabase_storage_admin WITH GRANT OPTION;
GRANT ALL ON TABLE storage.objects TO service_role;
GRANT ALL ON TABLE storage.objects TO authenticated;
GRANT ALL ON TABLE storage.objects TO anon;
GRANT ALL ON TABLE storage.objects TO postgres WITH GRANT OPTION;


--
-- Name: TABLE s3_multipart_uploads; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.s3_multipart_uploads TO service_role;
GRANT SELECT ON TABLE storage.s3_multipart_uploads TO authenticated;
GRANT SELECT ON TABLE storage.s3_multipart_uploads TO anon;


--
-- Name: TABLE s3_multipart_uploads_parts; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.s3_multipart_uploads_parts TO service_role;
GRANT SELECT ON TABLE storage.s3_multipart_uploads_parts TO authenticated;
GRANT SELECT ON TABLE storage.s3_multipart_uploads_parts TO anon;


--
-- Name: TABLE vector_indexes; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT SELECT ON TABLE storage.vector_indexes TO service_role;
GRANT SELECT ON TABLE storage.vector_indexes TO authenticated;
GRANT SELECT ON TABLE storage.vector_indexes TO anon;


--
-- Name: TABLE secrets; Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT SELECT,REFERENCES,DELETE,TRUNCATE ON TABLE vault.secrets TO postgres WITH GRANT OPTION;
GRANT SELECT,DELETE ON TABLE vault.secrets TO service_role;


--
-- Name: TABLE decrypted_secrets; Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT SELECT,REFERENCES,DELETE,TRUNCATE ON TABLE vault.decrypted_secrets TO postgres WITH GRANT OPTION;
GRANT SELECT,DELETE ON TABLE vault.decrypted_secrets TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON SEQUENCES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON FUNCTIONS TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON TABLES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON SEQUENCES TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON FUNCTIONS TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON TABLES TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON SEQUENCES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON FUNCTIONS TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON TABLES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO service_role;


--
-- Name: issue_graphql_placeholder; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_graphql_placeholder ON sql_drop
         WHEN TAG IN ('DROP EXTENSION')
   EXECUTE FUNCTION extensions.set_graphql_placeholder();


ALTER EVENT TRIGGER issue_graphql_placeholder OWNER TO supabase_admin;

--
-- Name: issue_pg_cron_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_cron_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_cron_access();


ALTER EVENT TRIGGER issue_pg_cron_access OWNER TO supabase_admin;

--
-- Name: issue_pg_graphql_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_graphql_access ON ddl_command_end
         WHEN TAG IN ('CREATE FUNCTION')
   EXECUTE FUNCTION extensions.grant_pg_graphql_access();


ALTER EVENT TRIGGER issue_pg_graphql_access OWNER TO supabase_admin;

--
-- Name: issue_pg_net_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_net_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_net_access();


ALTER EVENT TRIGGER issue_pg_net_access OWNER TO supabase_admin;

--
-- Name: pgrst_ddl_watch; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER pgrst_ddl_watch ON ddl_command_end
   EXECUTE FUNCTION extensions.pgrst_ddl_watch();


ALTER EVENT TRIGGER pgrst_ddl_watch OWNER TO supabase_admin;

--
-- Name: pgrst_drop_watch; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER pgrst_drop_watch ON sql_drop
   EXECUTE FUNCTION extensions.pgrst_drop_watch();


ALTER EVENT TRIGGER pgrst_drop_watch OWNER TO supabase_admin;

--
-- PostgreSQL database dump complete
--

\unrestrict 0wXmONGXSIED8loJsI3EcWfXRclWmYNsqYd8wSNDrplI750hHbFFtL1wwUiJWnN

