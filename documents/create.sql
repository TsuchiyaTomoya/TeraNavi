#データベース作成
create database tera_db character set utf8;
#ユーザー作成
create user 'TERA_NAVI'@'localhost' identified by 'tera';
#権限追加
grant all privileges on tera_db.* to 'TERA_NAVI'@'localhost';
#追加した権限を適用
FLUSH PRIVILEGES;
-- サンプル表de
create table tera_db.sampleusers(
	id char(8),
	name varchar(80)
);

#秘密の質問表
create table tera_db.secret_questions(
	secret_question_id int(1) primary key auto_increment,
	secret_question_body varchar(80) not null,
	index(secret_question_id)
)engine=InnoDB;

#ユーザー表
create table tera_db.users(
	user_id int(8) primary key auto_increment,
	login_id varchar(30) not null unique,
	user_name varchar(100) not null,
	user_name_kana varchar(100) not null,
	-- 男→m　女→f
	sex char(1) not null,
	-- 表示→0　非表示→1
	sex_visible_flag char(1) default '0',
	birth_date char(8),
	mail_address varchar(40) not null unique,
	password varchar(10) not null,
	fk_secret_question_id int(1),
	secret_answer varchar(100) not null,
	user_header_path varchar(255) default 'http://pingendo.github.io/pingendo-bootstrap/assets/placeholder.png',
	user_icon_path varchar(255) default '/TeraNavi/imgPath/default/default_user_icon.jpg',
	blog_title varchar(200) default 'ようこそブログへ',
	blog_header_path varchar(255) default 'http://pingendo.github.io/pingendo-bootstrap/assets/placeholder.png',
	-- 通常ユーザ→0, 管理者→1, 建築監督→2, 建築→3, 建築夜間→4, インテリア→5、ゲーム→6、情報処理→7、Web→8、環境→9、バイオ→10、師岡→11
	admin_flag char(2) not null,
	last_login_date char(100),
	admin_last_login_date char(100),
	-- 正常→0, ロック→1, 無期限ロック→2, 削除→3
	user_status_flag char(1) not null,
	user_lock_start_date date,
	-- 深夜12時にチェックする
	user_lock_end_date date,
	blog_explanation varchar(100),
	user_profile varchar(2000),
	-- 開設してない→0,開設してる→１
	blog_status_flag char(1) default '0',
	index(user_id),index(user_name),
	foreign key(fk_secret_question_id) references tera_db.secret_questions(secret_question_id)
)engine=InnoDB;

#　コミュニティ表
create table tera_db.communities(
	community_id int(10) primary key auto_increment,
	community_name varchar(50),
	community_profile varchar(400),
	community_icon_path varchar(255) default 'http://pingendo.github.io/pingendo-bootstrap/assets/placeholder.png',
	community_header_path varchar(255) default 'http://pingendo.github.io/pingendo-bootstrap/assets/placeholder.png',
	community_created_date datetime,
	fk_user_id int(8),
	-- 通常→0　削除→1
	community_delete_flag char(1) not null,
	index(community_id),
	foreign key(fk_user_id) references tera_db.users(user_id)
)engine=InnoDB;

#記事表
create table tera_db.articles(
	article_id int(10) primary key auto_increment,
	fk_user_id int(8),
	article_title varchar(100) default 'こんにちは',
	article_body varchar(20000),
	article_created_date datetime,
	-- 公開→0 下書き→1 削除→2
	article_status_flag char(1) not null,
	index(article_id),
	foreign key(fk_user_id) references tera_db.users(user_id)
)engine=InnoDB;

#タグ表
create table tera_db.tags(
	tag_id int(10) primary key auto_increment,
	tag_name varchar(30) not null,
	index(tag_id)
)engine=InnoDB;

#記事タグ表
create table tera_db.articles_tags(
	fk_article_id int(10),
	fk_tag_id int(10),
	foreign key (fk_article_id) references tera_db.articles(article_id),
	foreign key(fk_tag_id) references tera_db.tags(tag_id)
)engine=InnoDB;

#コミュニティユーザーリスト表
create table tera_db.community_members_list(
	fk_user_id int(10),
	fk_community_id int(10),
	-- 一般ユーザは0, 管理者は1
	community_admin_flag char(1) not null,
	-- 退会フラグ。通常は0、退会は1
	community_withdrawal_flag char(1),
	foreign key(fk_user_id) references tera_db.users(user_id),
	foreign key(fk_community_id) references tera_db.communities(community_id),
	primary key(fk_user_id,fk_community_id)
)engine=InnoDB;

#コメント表
create table tera_db.comments(
	comment_id int(10) primary key auto_increment,
	fk_article_id int(10),
	comment_date datetime not null,
	fk_user_id int(10),
	comment_body varchar(800),
	-- 通常→0　削除→1
	comment_delete_flag char(1) not null,
	index(comment_id),
	foreign key(fk_article_id) references tera_db.articles(article_id),
	foreign key (fk_user_id) references tera_db.users(user_id)
)engine=InnoDB;

#DM表
create table tera_db.direct_messages(
	message_id int(10) primary key auto_increment,
	message_body varchar(800),
	message_date datetime not null,
	fk_send_user_id int(8),
	fk_receive_user_id int(10),index(message_id),
	foreign key(fk_send_user_id) references tera_db.users(user_id),
	foreign key(fk_receive_user_id) references tera_db.users(user_id)
)engine=InnoDB;

#お問い合わせ表
create table tera_db.contacts(
	contact_id int(10) primary key auto_increment,
	contact_user_name varchar(50) not null,
	contact_title varchar(160) not null,
	contact_body varchar(10000),
	contact_date datetime not null,
	contact_address varchar(40) not null,
	contact_category varchar(100),index(contact_id)
)engine=InnoDB;

#警告表
create table tera_db.cautions(
	caution_id int(10) primary key auto_increment,
	fk_user_id int(10),
	fk_caution_user_id int(10),
	caution_date datetime,
	caution_title varchar(100) not null,
	caution_body varchar(10000) not null,
	report_page_url varchar(400),
	index(caution_id),
	foreign key(fk_user_id) references tera_db.users(user_id),
	foreign key(fk_caution_user_id) references tera_db.users(user_id)
)engine=InnoDB;

#トピック表
create table tera_db.topics(
	topic_id int(10) primary key auto_increment,
	fk_community_id int(10),
	fk_create_user_id int(10),
	topic_name varchar(50) not null,
	topic_updatetime_date datetime,
	topic_created_date datetime,
	index(topic_id),
	foreign key(fk_community_id) references tera_db.communities(community_id),
	foreign key(fk_create_user_id) references tera_db.users(user_id)
)engine=InnoDB;

#チャット表
create table tera_db.chat(
	chat_id int(8) primary key auto_increment,
	fk_user_id int(8),
	fk_topic_id int(10),
	chat_body varchar(600),
	chat_date datetime,
	-- 通常→0　削除→1
	chat_delete_flag char(1) not null,
	index(chat_id),
	foreign key(fk_user_id) references tera_db.users(user_id),
	foreign key(fk_topic_id) references tera_db.topics(topic_id)
)engine=InnoDB;

#登録キー表
create table tera_db.sign_up_keys(
	sign_up_key varchar(140) primary key,
	-- 未使用→0, 使用済み→1
	key_status char(1) not null,
	index(sign_up_key)
)engine=InnoDB;

#ポリシー表
create table tera_db.policy(
	policy_id int(10) primary key auto_increment,
	policy_date datetime,
	policy_body varchar(10000) not null,
	index(policy_id)
)engine=InnoDB;

#利用規約表
create table tera_db.rules(
	rule_id int(10) primary key auto_increment,
	rule_date datetime,
	rule_body varchar(10000) not null,
	index(rule_id)
)engine=InnoDB;


create table tera_db.admin_mail_acount(
	mail_address varchar(200),
	password varchar(100)
);
