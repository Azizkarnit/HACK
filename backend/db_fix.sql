-- ==============================================================================
-- U-OS Database Fix: Schema Alignment & Synchronization
-- INSTRUCTIONS: Run this entire script in your Supabase SQL Editor.
-- ==============================================================================

-- 1. RELAX USER CONSTRAINTS
ALTER TABLE public.users DROP CONSTRAINT IF EXISTS role_institution_check;
ALTER TABLE public.users ADD CONSTRAINT role_institution_check CHECK (
  (role = 'super_admin' AND institution_id IS NULL) 
  OR 
  (role = 'admin' AND institution_id IS NOT NULL)
  OR 
  (role = 'agent')
);

-- 2. ADD MISSING COLUMNS TO ALL TABLES (ALIGNS WITH MASSIVE SEEDER)

-- KPI VALUES: Add period and period_date if missing
DO $$ BEGIN 
  IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name='kpi_values' AND column_name='period') THEN
    ALTER TABLE public.kpi_values ADD COLUMN period text DEFAULT 'monthly';
  END IF;
  IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name='kpi_values' AND column_name='period_date') THEN
    ALTER TABLE public.kpi_values ADD COLUMN period_date date;
  END IF;
END $$;

-- ALERTS: Add message, actual_value, and threshold
DO $$ BEGIN 
  IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name='alerts' AND column_name='message') THEN
    ALTER TABLE public.alerts ADD COLUMN message text;
  END IF;
  IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name='alerts' AND column_name='actual_value') THEN
    ALTER TABLE public.alerts ADD COLUMN actual_value float8;
  END IF;
  IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name='alerts' AND column_name='threshold') THEN
    ALTER TABLE public.alerts ADD COLUMN threshold float8;
  END IF;
END $$;

-- AI INSIGHTS: Add content, title, and type
DO $$ BEGIN 
  IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name='ai_insights' AND column_name='content') THEN
    ALTER TABLE public.ai_insights ADD COLUMN content text;
  END IF;
  IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name='ai_insights' AND column_name='title') THEN
    ALTER TABLE public.ai_insights ADD COLUMN title text;
  END IF;
  IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name='ai_insights' AND column_name='status') THEN
    ALTER TABLE public.ai_insights ADD COLUMN status text DEFAULT 'active';
  END IF;
END $$;

-- 3. USER SYNC TRIGGER (Ensures Auth users mirror to public.users)
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS trigger AS $$
DECLARE
  extracted_inst_id uuid;
BEGIN
  IF new.raw_user_meta_data->>'institution_id' IS NOT NULL AND new.raw_user_meta_data->>'institution_id' != 'null' AND new.raw_user_meta_data->>'institution_id' != '' THEN
    extracted_inst_id := (new.raw_user_meta_data->>'institution_id')::uuid;
  ELSE
    extracted_inst_id := NULL;
  END IF;

  INSERT INTO public.users (id, email, full_name, role, institution_id)
  VALUES (
    new.id,
    new.email,
    new.raw_user_meta_data->>'full_name',
    COALESCE(new.raw_user_meta_data->>'role', 'agent'),
    extracted_inst_id
  )
  ON CONFLICT (id) DO UPDATE SET
    email = EXCLUDED.email,
    full_name = EXCLUDED.full_name,
    role = EXCLUDED.role,
    institution_id = EXCLUDED.institution_id;
  RETURN new;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
CREATE TRIGGER on_auth_user_created AFTER INSERT ON auth.users FOR EACH ROW EXECUTE PROCEDURE public.handle_new_user();

DROP TRIGGER IF EXISTS on_auth_user_updated ON auth.users;
CREATE TRIGGER on_auth_user_updated AFTER UPDATE ON auth.users FOR EACH ROW EXECUTE PROCEDURE public.handle_new_user();

-- 4. SYSTEM ACTIVITY TRACKER
CREATE TABLE IF NOT EXISTS public.system_activity (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  type text NOT NULL,
  institution_id uuid REFERENCES public.institutions(id),
  created_at timestamp with time zone DEFAULT now()
);

-- Done!
