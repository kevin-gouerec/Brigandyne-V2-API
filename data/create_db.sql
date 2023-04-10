BEGIN;

DROP TABLE IF EXISTS "character", "skill", "folk", "archetype", "career","group_career", "speciality", "talent", "motivation", "spell", "magic_field", "magic_trick", "personnality", "character_has_speciality", "character_has_talent", "character_has_career", "character_has_skill", "character_has_personnality", "archetype_modify_personnality", "archetype_modify_skill", "archetype_access_talent", "folk_has_talent","folk_modify_skill", "career_access_speciality","folk_has_speciality", "career_access_talent";

CREATE TABLE "skill" (
  "id" INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  "name" TEXT NOT NULL DEFAULT '',
  "short_name" TEXT NOT NULL DEFAULT '',  
  "description" TEXT NOT NULL DEFAULT '',
  "created_at" TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  "updated_at" TIMESTAMPTZ
);

CREATE TABLE "motivation" (
  "id" INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  "name" TEXT NOT NULL DEFAULT '',
  "description" TEXT NOT NULL DEFAULT '',
  "created_at" TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  "updated_at" TIMESTAMPTZ
);

CREATE TABLE "speciality" (
  "id" INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  "name" TEXT NOT NULL DEFAULT '',
  "type" TEXT NOT NULL DEFAULT '',
  "description" TEXT NOT NULL DEFAULT '',
  "bonus" INTEGER NOT NULL DEFAULT 0,
  "created_at" TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  "updated_at" TIMESTAMPTZ
);

CREATE TABLE "talent" (
  "id" INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  "name" TEXT NOT NULL DEFAULT '',
  "description" TEXT NOT NULL DEFAULT '',
  "frequency" TEXT NOT NULL DEFAULT '',
  "resume" TEXT NOT NULL DEFAULT '',
  "created_at" TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  "updated_at" TIMESTAMPTZ
);

CREATE TABLE "magic_trick" (
  "id" INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  "name" TEXT NOT NULL DEFAULT '',
  "description" TEXT NOT NULL DEFAULT '',
  "created_at" TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  "updated_at" TIMESTAMPTZ
);

CREATE TABLE "spell" (
  "id" INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  "name" TEXT NOT NULL DEFAULT '',
  "formula" TEXT NOT NULL DEFAULT '',
  "ritual" BOOLEAN NOT NULL DEFAULT 'FALSE',
  "difficulty" INTEGER NOT NULL DEFAULT 0,
  "duration" TEXT NOT NULL DEFAULT '',
  "range" TEXT NOT NULL DEFAULT '',
  "opposition" TEXT,
  "effect" TEXT NOT NULL DEFAULT '',
  "critical" TEXT,
  "created_at" TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  "updated_at" TIMESTAMPTZ
);

CREATE TABLE "magic_field" (
  "id" INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  "name" TEXT NOT NULL DEFAULT '',
  "description" TEXT NOT NULL DEFAULT '',
  "effect" TEXT NOT NULL DEFAULT '',
  "created_at" TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  "updated_at" TIMESTAMPTZ
);

CREATE TABLE "personnality" (
  "id" INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  "name" TEXT NOT NULL DEFAULT '',
  "description" TEXT NOT NULL DEFAULT '',
  "adventure" TEXT NOT NULL DEFAULT '',
  "madness" TEXT NOT NULL DEFAULT '',
  "type" TEXT NOT NULL DEFAULT '',
  "link_id" INTEGER NOT NULL,
  "created_at" TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  "updated_at" TIMESTAMPTZ
);

CREATE TABLE "archetype" (
  "id" INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  "name" TEXT NOT NULL DEFAULT '',
  "description" TEXT NOT NULL DEFAULT '',
  "created_at" TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  "updated_at" TIMESTAMPTZ
);

CREATE TABLE "group_career" (
  "id" INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  "name" TEXT NOT NULL DEFAULT '',
  "description" TEXT NOT NULL DEFAULT '',
  "starting_stuff" TEXT NOT NULL DEFAULT '',    
  "created_at" TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  "updated_at" TIMESTAMPTZ
);

CREATE TABLE "career" (
  "id" INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  "name" TEXT NOT NULL DEFAULT '',
  "group_id" INTEGER NOT NULL REFERENCES group_career("id") ON DELETE CASCADE,
  "description" TEXT NOT NULL DEFAULT '',
  "income" TEXT NOT NULL DEFAULT '',
  "starting_stuff" TEXT NOT NULL DEFAULT '',   
  "created_at" TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  "updated_at" TIMESTAMPTZ
);

CREATE TABLE "folk" (
  "id" INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  "name" TEXT NOT NULL DEFAULT '',
  "description" TEXT NOT NULL DEFAULT '',  
  "special" TEXT NOT NULL DEFAULT '',
  "fate" INTEGER NOT NULL DEFAULT 0,  
  "created_at" TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  "updated_at" TIMESTAMPTZ
);

CREATE TABLE "character" (
  "id" INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  "name" TEXT NOT NULL DEFAULT '',
  "age" INTEGER NOT NULL DEFAULT 0,
  "gender" TEXT NOT NULL DEFAULT '',
  "hair" TEXT NOT NULL DEFAULT '',
  "eyes" TEXT NOT NULL DEFAULT '',
  "size" INTEGER NOT NULL DEFAULT 0,
  "weight" INTEGER NOT NULL DEFAULT 0,
  "description" TEXT NOT NULL DEFAULT '',
  "religion" TEXT NOT NULL DEFAULT '',
  "hand" TEXT NOT NULL DEFAULT '',
  "languages" TEXT NOT NULL DEFAULT '',
  "gear" TEXT NOT NULL DEFAULT '',
  "experience" INTEGER NOT NULL DEFAULT 0,
  "folk_id" INTEGER NOT NULL REFERENCES folk("id") ON DELETE CASCADE,
  "motivation_id" INTEGER NOT NULL REFERENCES motivation("id") ON DELETE CASCADE,
  "archetype_id" INTEGER NOT NULL REFERENCES archetype("id") ON DELETE CASCADE,    
  "created_at" TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  "updated_at" TIMESTAMPTZ
);

CREATE TABLE "character_has_speciality" (
  "character_id" INTEGER NOT NULL REFERENCES character("id") ON DELETE CASCADE,
  "speciality_id" INTEGER NOT NULL REFERENCES speciality("id") ON DELETE CASCADE,
  "cost" INTEGER NOT NULL DEFAULT 100,
  "created_at" TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE "character_has_talent" (
  "character_id" INTEGER NOT NULL REFERENCES character("id") ON DELETE CASCADE,
  "talent_id" INTEGER NOT NULL REFERENCES talent("id") ON DELETE CASCADE,
  "cost" INTEGER NOT NULL DEFAULT 100,      
  "created_at" TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE "character_has_career" (
  "character_id" INTEGER NOT NULL REFERENCES character("id") ON DELETE CASCADE,
  "career_id" INTEGER NOT NULL REFERENCES career("id") ON DELETE CASCADE,
  "actual" BOOLEAN NOT NULL DEFAULT 'TRUE', 
  "created_at" TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE "character_has_skill" (
  "character_id" INTEGER NOT NULL REFERENCES character("id") ON DELETE CASCADE,
  "skill_id" INTEGER NOT NULL REFERENCES skill("id") ON DELETE CASCADE,
  "augmentation" INTEGER NOT NULL DEFAULT 0,
  "cost" INTEGER NOT NULL DEFAULT 0,  
  "created_at" TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE "character_has_personnality" (
  "character_id" INTEGER NOT NULL REFERENCES character("id") ON DELETE CASCADE,
  "personnality_id" INTEGER NOT NULL REFERENCES personnality("id") ON DELETE CASCADE,
  "value" INTEGER NOT NULL DEFAULT 0,
  "created_at" TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE "archetype_modify_personnality" (
  "archetype_id" INTEGER NOT NULL REFERENCES archetype("id") ON DELETE CASCADE,
  "personnality_id" INTEGER NOT NULL REFERENCES personnality("id") ON DELETE CASCADE,
  "choice" INTEGER NOT NULL DEFAULT 0,
  "created_at" TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE "archetype_modify_skill" (
  "archetype_id" INTEGER NOT NULL REFERENCES archetype("id") ON DELETE CASCADE,
  "skill_id" INTEGER NOT NULL REFERENCES skill("id") ON DELETE CASCADE,
  "modifier" INTEGER NOT NULL DEFAULT 0,
  "choice" INTEGER NOT NULL DEFAULT 0,
  "created_at" TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE "archetype_access_talent" (
  "archetype_id" INTEGER NOT NULL REFERENCES archetype("id") ON DELETE CASCADE,
  "talent_id" INTEGER NOT NULL REFERENCES talent("id") ON DELETE CASCADE,
  "created_at" TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE "folk_has_talent" (
  "folk_id" INTEGER NOT NULL REFERENCES folk("id") ON DELETE CASCADE,
  "talent_id" INTEGER NOT NULL REFERENCES talent("id") ON DELETE CASCADE, 
  "created_at" TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE "folk_has_speciality" (
  "folk_id" INTEGER NOT NULL REFERENCES folk("id") ON DELETE CASCADE,
  "speciality_id" INTEGER NOT NULL REFERENCES speciality("id") ON DELETE CASCADE, 
  "created_at" TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE "folk_modify_skill" (
  "folk_id" INTEGER NOT NULL REFERENCES folk("id") ON DELETE CASCADE,
  "skill_id" INTEGER NOT NULL REFERENCES skill("id") ON DELETE CASCADE,
  "base_value" INTEGER NOT NULL DEFAULT 0,
  "max_value" INTEGER,    
  "created_at" TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE "career_access_speciality" (
  "career_id" INTEGER NOT NULL REFERENCES career("id") ON DELETE CASCADE,
  "speciality_id" INTEGER NOT NULL REFERENCES speciality("id") ON DELETE CASCADE,
  "created_at" TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE "career_access_talent" (
  "career_id" INTEGER NOT NULL REFERENCES career("id") ON DELETE CASCADE,
  "talent_id" INTEGER NOT NULL REFERENCES talent("id") ON DELETE CASCADE,
  "created_at" TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

COMMIT;