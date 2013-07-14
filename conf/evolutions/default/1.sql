# --- First database schema

# --- !Ups
create table RELEASE_PLAN (
  ID				smallint unsigned not null auto_increment,
  NAME				varchar(50) not null,
  RELEASE_LENGTH	int unsigned not null,
  constraint PK_RELEASE_PLAN primary key (ID)
);

create table PROJECT (
  ID				smallint unsigned not null auto_increment,
  NAME				varchar(50) not null,
  DESCRIPTION		varchar(2500),
  RELEASE_PLAN_ID	smallint unsigned not null,
  constraint PK_PROJECT primary key (ID)
);

alter table PROJECT add constraint FK_PROJECT__RELEASE_PLAN foreign key (RELEASE_PLAN_ID) references RELEASE_PLAN(ID) on delete restrict on update restrict;

create table PROJECT_RELEASE (
  ID				int unsigned not null auto_increment,
  NAME				varchar(50) not null,
  RELEASE_PLAN_ID	smallint unsigned not null,
  START_DATE		date not null,
  END_DATE			date not null,
  constraint PK_PROJECT_RELEASE primary key (ID)
);

alter table PROJECT_RELEASE add constraint FK_PROJECT_RELEASE__RELEASE_PLAN foreign key (RELEASE_PLAN_ID) references RELEASE_PLAN(ID) on delete restrict on update restrict;

create table STORY (
  ID					bigint unsigned not null auto_increment,
  PROJECT_ID			smallint unsigned not null,
  PROJECT_RELEASE_ID	int unsigned not null,
  NAME					varchar(250) not null,
  DESCRIPTION			varchar(5000),
  POINTS				tinyint unsigned,
  constraint PK_STORY primary key (ID)
);

alter table STORY add constraint FK_STORY__PROJECT foreign key (PROJECT_ID) references PROJECT(ID) on delete restrict on update restrict;
alter table STORY add constraint FK_STORY__PROJECT_RELEASE foreign key (PROJECT_RELEASE_ID) references PROJECT_RELEASE(ID) on delete restrict on update restrict;

create index IX_STORY__PROJECT on STORY(PROJECT_ID);
create index IX_STORY__PROJECT_RELEASE on STORY(PROJECT_RELEASE_ID);

create table TASK (
  ID			bigint unsigned not null auto_increment,
  STORY_ID		bigint unsigned not null,
  NAME			varchar(250) not null,
  DESCRIPTION	varchar(5000),
  constraint PK_TASK primary key (ID)
);

alter table TASK add constraint FK_TASK__STORY foreign key (STORY_ID) references STORY(ID) on delete restrict on update restrict;

create index IX_TASK__STORY on TASK(STORY_ID);

# --- !Downs
drop index IX_STORY__PROJECT_RELEASE on STORY;
drop index IX_STORY__PROJECT on STORY;

drop table if exists TASK;
drop table if exists STORY;
drop table if exists PROJECT_RELEASE;
drop table if exists PROJECT;
drop table if exists RELEASE_PLAN;
