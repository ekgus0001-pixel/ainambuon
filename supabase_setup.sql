-- ============================================================
--  AI남부ON - InBody 280 기록 테이블 생성 SQL
--  Supabase > SQL Editor 에서 이 스크립트를 실행하세요
-- ============================================================

-- 1. 테이블 생성
CREATE TABLE IF NOT EXISTS public.inbody_records (
  id                uuid          PRIMARY KEY DEFAULT gen_random_uuid(),
  created_at        timestamptz   NOT NULL DEFAULT now(),

  -- 수검자 기본 정보
  gender            text          NOT NULL CHECK (gender IN ('male', 'female')),
  age               integer       NOT NULL,
  height_cm         numeric(5,1)  NOT NULL,

  -- 체성분 분석
  weight_kg         numeric(5,1)  NOT NULL,
  smm_kg            numeric(5,1)  NOT NULL,   -- 골격근량
  bfm_kg            numeric(5,1)  NOT NULL,   -- 체지방량
  tbw_l             numeric(5,1),             -- 체수분 (L)
  protein_kg        numeric(5,2),             -- 단백질
  mineral_kg        numeric(5,2),             -- 무기질

  -- 비만 지표
  bmi               numeric(4,1)  NOT NULL,
  pbf_pct           numeric(4,1)  NOT NULL,   -- 체지방률 (%)
  vfl_level         integer,                  -- 내장지방 레벨 (1~20)
  inbody_score      integer,                  -- 인바디 점수 (0~100)

  -- C-I-D 체형 분석 결과
  cid_type          char(1)       CHECK (cid_type IN ('C', 'I', 'D')),
  bmr_kcal          integer,                  -- 기초대사량
  tdee_kcal         integer,                  -- 유지 대사량

  -- 부위별 근육량 (kg)
  arm_r_kg          numeric(4,1),
  arm_l_kg          numeric(4,1),
  trunk_kg          numeric(5,1),
  leg_r_kg          numeric(4,1),
  leg_l_kg          numeric(4,1),

  -- 생성된 마크다운 리포트 전문
  markdown_report   text
);

-- 2. 인덱스 (최신순 조회 성능용)
CREATE INDEX IF NOT EXISTS idx_inbody_records_created_at
  ON public.inbody_records (created_at DESC);

-- 3. Row Level Security (RLS) 설정
--    - 기본: 인증 없이도 INSERT/SELECT/DELETE 가능 (Public 앱용)
--    - 보안이 필요하다면 아래 정책을 수정하세요

ALTER TABLE public.inbody_records ENABLE ROW LEVEL SECURITY;

-- 전체 공개 읽기 허용
CREATE POLICY "Public read"   ON public.inbody_records
  FOR SELECT USING (true);

-- 전체 공개 쓰기 허용
CREATE POLICY "Public insert" ON public.inbody_records
  FOR INSERT WITH CHECK (true);

-- 전체 공개 삭제 허용
CREATE POLICY "Public delete" ON public.inbody_records
  FOR DELETE USING (true);

-- ============================================================
--  ✅ 완료! 위 SQL 실행 후 index.html 상단 설정값을 채워주세요:
--
--    const SUPABASE_URL = 'https://YOUR_PROJECT_ID.supabase.co';
--    const SUPABASE_KEY = 'YOUR_ANON_KEY';
-- ============================================================
