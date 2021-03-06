#### ECSHOP数据表


-- 表的结构 `ecs_account_log`
CREATE TABLE IF NOT EXISTS `ecs_account_log` (
`log_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID号',
`user_id` mediumint(8) unsigned NOT NULL COMMENT '用户登录后保存在session中的id号，跟users表中的user_id对应',
`user_money` decimal(10,2) NOT NULL COMMENT '用户该笔记录的余额',
`frozen_money` decimal(10,2) NOT NULL COMMENT '被冻结的资金',
`rank_points` mediumint(9) NOT NULL COMMENT '等级积分，跟消费积分是分开的',
`pay_points` mediumint(9) NOT NULL COMMENT '消费积分，跟等级积分是分开的',
`change_time` int(10) unsigned NOT NULL COMMENT '该笔操作发生的时间',
`change_desc` varchar(255) NOT NULL COMMENT '该笔操作的备注，一般是，充值或者提现。也可是是管理员后台写的任何在备注',
`change_type` tinyint(3) unsigned NOT NULL COMMENT '操作类型，0为充值，1为提现，2为管理员调节，99为其他类型',
PRIMARY KEY (`log_id`),
KEY `user_id` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='用户帐号情况记录表，包括资金和积分等' AUTO_INCREMENT=42 ;
-- ------------------------------------------------------
-- 表的结构 `ecs_ad`
CREATE TABLE IF NOT EXISTS `ecs_ad` (
`ad_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID号',
`position_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '0,站外广告；从1开始代表的是该广告所处的广告位，同表ad_position中的字段position_id的值',
`media_type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '广告类型，0，图片；1，flash;2,代码；3，文字',
`ad_name` varchar(60) NOT NULL COMMENT '该条广告记录的广告名称',
`ad_link` varchar(255) NOT NULL COMMENT '广告链接地址',
`ad_code` text NOT NULL COMMENT '广告链接的表现，文字广告就是文字或图片和flash就是它们的地址，代码广告就是代码内容',
`start_time` int(11) NOT NULL DEFAULT '0' COMMENT '广告开始时间',
`end_time` int(11) NOT NULL DEFAULT '0' COMMENT '广告结束时间',
`link_man` varchar(60) NOT NULL COMMENT '广告联系人',
`link_email` varchar(60) NOT NULL COMMENT '广告联系人的邮箱',
`link_phone` varchar(60) NOT NULL COMMENT '广告联系人的电话',
`click_count` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '该广告点击数',
`enabled` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '该广告是否关闭，1，开启；0，关闭；关闭后广告将不再有效，直至重新开启',
PRIMARY KEY (`ad_id`),
KEY `position_id` (`position_id`),
KEY `enabled` (`enabled`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='广告列表配置表，包括站内站外的图片，文字，flash，代码广告' AUTO_INCREMENT=6 ;
-- ------------------------------------------------------
-- 表的结构 `ecs_admin_action`
CREATE TABLE IF NOT EXISTS `ecs_admin_action` (
`action_id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID号',
`parent_id` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '该id项的父id，对应本表的action_id字段',
`action_code` varchar(20) NOT NULL COMMENT '代表权限的英文字符串，对应汉文在语言文件中，如果该字段有某个字符串，就表示有该权限',
PRIMARY KEY (`action_id`),
KEY `parent_id` (`parent_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='管理员权限列表树' AUTO_INCREMENT=104 ;
-- ------------------------------------------------------
-- 表的结构 `ecs_admin_log`
CREATE TABLE IF NOT EXISTS `ecs_admin_log` (
`log_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID号',
`log_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '写日志时间',
`user_id` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '该日志所记录的操作者id，同ecs_admin_user的user_id',
`log_info` varchar(255) NOT NULL COMMENT '管理操作内容',
`ip_address` varchar(15) NOT NULL COMMENT '管理者登录ip',
PRIMARY KEY (`log_id`),
KEY `log_time` (`log_time`),
KEY `user_id` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='管理员操作日志表' AUTO_INCREMENT=158 ;
-- ------------------------------------------------------
-- 表的结构 `ecs_admin_message`
CREATE TABLE IF NOT EXISTS `ecs_admin_message` (
`message_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID号',
`sender_id` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '发送该留言的管理员id，同ecs_admin_user的user_id',
`receiver_id` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '接收消息的管理员id，同ecs_admin_user的user_id，如果是给多个管理员发送，则同一个消息给每个管理员id发送一条',
`sent_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '留言发送时间',
`read_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '留言阅读时间',
`readed` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '留言是否阅读，1，已阅读；0，未阅读',
`deleted` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '留言是否已经是否已经被删除，1，已删除；0，未删除',
`title` varchar(150) NOT NULL COMMENT '留言的主题',
`message` text NOT NULL COMMENT '留言的内容',
PRIMARY KEY (`message_id`),
KEY `sender_id` (`sender_id`,`receiver_id`),
KEY `receiver_id` (`receiver_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='管理员留言记录表' AUTO_INCREMENT=7 ;
-- ------------------------------------------------------
-- 表的结构 `ecs_admin_user`
CREATE TABLE IF NOT EXISTS `ecs_admin_user` (
`user_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID号，管理员代号',
`user_name` varchar(60) NOT NULL COMMENT '管理员登录名',
`email` varchar(60) NOT NULL COMMENT '管理员邮箱',
`password` varchar(32) NOT NULL COMMENT '管理员登录秘密加密串',
`add_time` int(11) NOT NULL DEFAULT '0' COMMENT '管理员添加时间',
`last_login` int(11) NOT NULL DEFAULT '0' COMMENT '管理员最后一次登录时间',
`last_ip` varchar(15) NOT NULL COMMENT '管理员最后一次登录ip',
`action_list` text NOT NULL COMMENT '管理员管理权限列表',
`nav_list` text NOT NULL COMMENT '管理员导航栏配置项',
`lang_type` varchar(50) NOT NULL,
`agency_id` smallint(5) unsigned NOT NULL COMMENT '该管理员负责的办事处的id，同ecs_agency的agency_id字段。如果管理员没负责办事处，则此处为0',
`todolist` longtext COMMENT '记事本记录的数据',
PRIMARY KEY (`user_id`),
KEY `user_name` (`user_name`),
KEY `agency_id` (`agency_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='管理员资料权限列表' AUTO_INCREMENT=4 ;
-- ------------------------------------------------------
-- 表的结构 `ecs_adsense`
CREATE TABLE IF NOT EXISTS `ecs_adsense` (
`from_ad` smallint(5) NOT NULL DEFAULT '0' COMMENT '广告代号，-1是站外广告，如果是站内广告则为ecs_ad的ad_id',
`referer` varchar(255) NOT NULL COMMENT '页面来源',
`clicks` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '点击率',
KEY `from_ad` (`from_ad`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='广告点击率统计表';
-- ------------------------------------------------------
-- 表的结构 `ecs_ad_position`
CREATE TABLE IF NOT EXISTS `ecs_ad_position` (
`position_id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT COMMENT '广告位自增id',
`position_name` varchar(60) NOT NULL COMMENT '广告位名称',
`ad_width` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '广告位宽度',
`ad_height` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '广告位高度',
`position_desc` varchar(255) NOT NULL COMMENT '广告位描述',
`position_style` text NOT NULL COMMENT '广告位模板代码',
PRIMARY KEY (`position_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='广告位置配置表' AUTO_INCREMENT=2 ;
-- ------------------------------------------------------
-- 表的结构 `ecs_affiliate_log`
CREATE TABLE IF NOT EXISTS `ecs_affiliate_log` (
`log_id` mediumint(8) NOT NULL AUTO_INCREMENT,
`order_id` mediumint(8) NOT NULL,
`time` int(10) NOT NULL,
`user_id` mediumint(8) NOT NULL,
`user_name` varchar(60) DEFAULT NULL,
`money` decimal(10,2) NOT NULL DEFAULT '0.00',
`point` int(10) NOT NULL DEFAULT '0',
`separate_type` tinyint(1) NOT NULL DEFAULT '0',
PRIMARY KEY (`log_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='分成相关的表，还没研究透' AUTO_INCREMENT=1 ;
-- ------------------------------------------------------
-- 表的结构 `ecs_agency`
CREATE TABLE IF NOT EXISTS `ecs_agency` (
`agency_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT '办事处ID',
`agency_name` varchar(255) NOT NULL COMMENT '办事处名字',
`agency_desc` text NOT NULL COMMENT '办事处描述',
PRIMARY KEY (`agency_id`),
KEY `agency_name` (`agency_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='办事处信息' AUTO_INCREMENT=5 ;
-- ------------------------------------------------------
-- 表的结构 `ecs_area_region`
CREATE TABLE IF NOT EXISTS `ecs_area_region` (
`shipping_area_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '配送区域的id号，等同于ecs_shipping_area的shipping_area_id的值',
`region_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '地区列表，等同于ecs_region的region_id',
PRIMARY KEY (`shipping_area_id`,`region_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='记录表ecs_shipping_area中的shipping_area_name的地区名包括ecs_region中的城市';
-- ------------------------------------------------------
-- 表的结构 `ecs_article`
CREATE TABLE IF NOT EXISTS `ecs_article` (
`article_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID号',
`cat_id` smallint(5) NOT NULL DEFAULT '0' COMMENT '该文章的分类，同ecs_article_cat的cat_id,如果不在，将自动成为保留类型而不能删除',
`title` varchar(150) NOT NULL COMMENT '文章题目',
`content` longtext NOT NULL COMMENT '文章内容',
`author` varchar(30) NOT NULL COMMENT '文章作者',
`author_email` varchar(60) NOT NULL COMMENT '文章作者的email',
`keywords` varchar(255) NOT NULL COMMENT '文章的关键字',
`article_type` tinyint(1) unsigned NOT NULL DEFAULT '2' COMMENT '文章类型，0，普通；1，置顶；2和大于2的，为保留文章，保留文章不能删除',
`is_open` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '是否显示。1，显示；0，不显示',
`add_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文章添加时间',
`file_url` varchar(255) NOT NULL COMMENT '上传文件或者外部文件的url',
`open_type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0,正常；当该字段为1或者2时，会在文章最后添加一个链接“相关下载”，连接地址等于file_url的值；但程序在此处有bug',
`link` varchar(255) NOT NULL COMMENT '该文章标题所引用的连接，如果该项有值将不能显示文章内容，即该表中content的值',
PRIMARY KEY (`article_id`),
KEY `cat_id` (`cat_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='文章内容表' AUTO_INCREMENT=11 ;
-- ------------------------------------------------------
-- 表的结构 `ecs_article_cat`
CREATE TABLE IF NOT EXISTS `ecs_article_cat` (
`cat_id` smallint(5) NOT NULL AUTO_INCREMENT COMMENT '自增ID号',
`cat_name` varchar(255) NOT NULL COMMENT '分类名称',
`cat_type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '分类类型；1，普通分类；2，系统分类；3，网店信息；4，帮助分类；5，网店帮助',
`keywords` varchar(255) NOT NULL COMMENT '分类关键字',
`cat_desc` varchar(255) NOT NULL COMMENT '分类说明文字',
`sort_order` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '分类显示顺序',
`show_in_nav` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否在导航栏显示；0，否；1，是',
`parent_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '父节点id，取值于该表cat_id字段',
PRIMARY KEY (`cat_id`),
KEY `cat_type` (`cat_type`),
KEY `sort_order` (`sort_order`),
KEY `parent_id` (`parent_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='文章分类信息表' AUTO_INCREMENT=7 ;
-- ------------------------------------------------------
-- 表的结构 `ecs_attribute`
CREATE TABLE IF NOT EXISTS `ecs_attribute` (
`attr_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID号',
`cat_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '商品类型，同ecs_goods_type的cat_id',
`attr_name` varchar(60) NOT NULL COMMENT '属性名称',
`attr_input_type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '当添加商品时，该属性的添加类别；0，为手工输入；1，为选择输入；2，为多行文本输入',
`attr_type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '属性是否多选；0，否；1，是；如果可以多选，则可以自定义属性，并且可以根据值的不同定不同的价',
`attr_values` text NOT NULL COMMENT '如果attr_input_type为1，即选择输入，则attr_name对应的值的取值就是该字段的值',
`attr_index` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '属性是否可以检索；0，不需要检索；1，关键字检索；2，范围检索；该属性应该是如果检索的话，可以通过该属性找到有该属性的商品',
`sort_order` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '属性显示的顺序，数字越大越靠前，如果数字一样则按id顺序',
`is_linked` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否关联；0，不关联；1，关联；如果关联，那么用户在购买该商品时，具有有该属性相同值的商品将被推荐给用户',
`attr_group` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '属性分组，相同的为一个属性组。该值应该取自ecs_goods_type的attr_group的值的顺序',
PRIMARY KEY (`attr_id`),
KEY `cat_id` (`cat_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='商品类型属性表，该表记录的是每个商品类型的所有属性的配置情况，具体的商品的属性不在该表' AUTO_INCREMENT=175 ;
-- ------------------------------------------------------
-- 表的结构 `ecs_auction_log`
CREATE TABLE IF NOT EXISTS `ecs_auction_log` (
`log_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID号',
`act_id` mediumint(8) unsigned NOT NULL COMMENT '拍卖活动的id，取值于ecs_goods_activity的act_id字段',
`bid_user` mediumint(8) unsigned NOT NULL COMMENT '出价的用户id，取值于ecs_users的user_id',
`bid_price` decimal(10,2) unsigned NOT NULL COMMENT '出价价格',
`bid_time` int(10) unsigned NOT NULL COMMENT '出价时间',
PRIMARY KEY (`log_id`),
KEY `act_id` (`act_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='拍卖出价记录信息表' AUTO_INCREMENT=3 ;
-- ------------------------------------------------------
-- 表的结构 `ecs_auto_manage`
CREATE TABLE IF NOT EXISTS `ecs_auto_manage` (
`item_id` mediumint(8) NOT NULL COMMENT '如果是商品就是ecs_goods的goods_id，如果是文章就是ecs_article的article_id',
`type` varchar(10) NOT NULL COMMENT 'goods是商品，article是文章',
`starttime` int(10) NOT NULL COMMENT '上线时间',
`endtime` int(10) NOT NULL COMMENT '下线时间',
PRIMARY KEY (`item_id`,`type`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='处理文章，商品自动上下线的计划任务列表；需要安装计划任务插件才有效';
-- ------------------------------------------------------
-- 表的结构 `ecs_bonus_type`
CREATE TABLE IF NOT EXISTS `ecs_bonus_type` (
`type_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT '红包类型流水号',
`type_name` varchar(60) NOT NULL COMMENT '红包名称',
`type_money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '红包所值的金额',
`send_type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '红包发送类型.0,按用户如会员等级,会员名称发放;1,按商品类别发送;2,按订单金额所达到的额度发送;3,线下发送',
`min_amount` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '如果是按金额发送红包,该项是最小金额.即只要购买超过该金额的商品都可以领到红包',
`max_amount` decimal(10,2) unsigned NOT NULL DEFAULT '0.00',
`send_start_date` int(11) NOT NULL DEFAULT '0' COMMENT '红包发送的开始时间',
`send_end_date` int(11) NOT NULL DEFAULT '0' COMMENT '红包发送的结束时间',
`use_start_date` int(11) NOT NULL DEFAULT '0' COMMENT '红包可以使用的开始时间',
`use_end_date` int(11) NOT NULL DEFAULT '0' COMMENT '红包可以使用的结束时间',
`min_goods_amount` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '可以使用该红包的商品的最低价格.即只要达到该价格的商品才可以使用红包',
PRIMARY KEY (`type_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='红包类型表' AUTO_INCREMENT=6 ;
-- ------------------------------------------------------
-- 表的结构 `ecs_booking_goods`
CREATE TABLE IF NOT EXISTS `ecs_booking_goods` (
`rec_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID号',
`user_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '登记该缺货记录的用户的id，取值ecs_users的user_id',
`email` varchar(60) NOT NULL COMMENT '页面填的用户的email，默认取值于ecs_users的email',
`link_man` varchar(60) NOT NULL COMMENT '页面填的用户的姓名，默认取值于ecs_users的consignee ',
`tel` varchar(60) NOT NULL COMMENT '页面填的用户的电话，默认取值于ecs_users的tel',
`goods_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '缺货登记的商品id，取值于ecs_goods的 goods_id',
`goods_desc` varchar(255) NOT NULL COMMENT '缺货登记时留的订购描述',
`goods_number` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '订购数量',
`booking_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '缺货登记的时间',
`is_dispose` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否已经被处理',
`dispose_user` varchar(30) NOT NULL COMMENT '处理该缺货登记的管理员用户名，取值于session,该session取值于ecs_admin_user的user_name',
`dispose_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '处理的时间',
`dispose_note` varchar(255) NOT NULL COMMENT '处理时管理员留的备注',
PRIMARY KEY (`rec_id`),
KEY `user_id` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='缺货登记的订购和处理记录表' AUTO_INCREMENT=4 ; 
-- ------------------------------------------------------
-- 表的结构 `ecs_brand` 
CREATE TABLE IF NOT EXISTS `ecs_brand` ( 
`brand_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID号', 
`brand_name` varchar(60) NOT NULL COMMENT '品牌名称', 
`brand_logo` varchar(80) NOT NULL COMMENT '上传的该品牌公司logo图片', 
`brand_desc` text NOT NULL COMMENT '品牌描述', 
`site_url` varchar(255) NOT NULL COMMENT '品牌的网址', 
`sort_order` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '品牌在前台页面的显示顺序，数字越大越靠后', 
`is_show` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '该品牌是否显示，0，否；1，显示', 
PRIMARY KEY (`brand_id`), 
KEY `is_show` (`is_show`) 
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='商品品牌信息记录表' AUTO_INCREMENT=9 ; 
-- -----------------------------------------------------

-- 表的结构 `ecs_card` 
CREATE TABLE IF NOT EXISTS `ecs_card` ( 
`card_id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID号', 
`card_name` varchar(120) NOT NULL COMMENT '贺卡名称', 
`card_img` varchar(255) NOT NULL COMMENT '贺卡图纸的名称', 
`card_fee` decimal(6,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '贺卡所需费用', 
`free_money` decimal(6,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '订单达到该字段的值后使用此贺卡免费', 
`card_desc` varchar(255) NOT NULL COMMENT '贺卡的描述', 
PRIMARY KEY (`card_id`) 
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='贺卡的配置的信息' AUTO_INCREMENT=2 ; 
-- -----------------------------------------------------
-- 表的结构 `ecs_cart` 
CREATE TABLE IF NOT EXISTS `ecs_cart` ( 
`rec_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID号', 
`user_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '用户登录id，取自session，', 
`session_id` char(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '登录的sessionid，如果该用户退出，该sessionid对应的购物车中的所有记录都将被删除', 
`goods_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '商品的id，取自表goods的goods_id', 
`goods_sn` varchar(60) NOT NULL COMMENT '商品的货号，取自表goods的goods_sn', 
`goods_name` varchar(120) NOT NULL COMMENT '商品的名称，取自表goods的goods_name', 
`market_price` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '商品的市场价，取自表goods的market_price', 
`goods_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '商品的本店价，取自表goods的shop_price', 
`goods_number` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '商品的购买数量，在购物车时，实际库存不减少', 
`goods_attr` text NOT NULL COMMENT '商品的属性，中括号里是该属性特有的价格', 
`is_real` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '取自ecs_goods的is_real', 
`extension_code` varchar(30) NOT NULL COMMENT '商品的扩展属性，取自ecs_goods的extension_code', 
`parent_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '该商品的父商品id，没有该值为0，有的话那该商品就是该id的配件', 
`rec_type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '购物车商品类型，0，普通；1，团够；2，拍卖；3，夺宝奇兵', 
`is_gift` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '是否是赠品，0，否；其他，是参加优惠活动的id，取值于ecs_favourable_activity 的act_id', 
`can_handsel` tinyint(3) unsigned NOT NULL DEFAULT '0', 
`goods_attr_id` mediumint(8) NOT NULL COMMENT '该商品的属性的id，取自goods_attr的goods_attr_id，如果有多个，只记录了最后一个，可能是个bug', 
PRIMARY KEY (`rec_id`), 
KEY `session_id` (`session_id`) 
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='购物车购物信息记录表' AUTO_INCREMENT=82 ; 
-- -----------------------------------------------------
-- 表的结构 `ecs_category` 
CREATE TABLE IF NOT EXISTS `ecs_category` ( 
`cat_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID号', 
`cat_name` varchar(90) NOT NULL COMMENT '分类名称', 
`keywords` varchar(255) NOT NULL COMMENT '分类的关键字，可能是为了搜索', 
`cat_desc` varchar(255) NOT NULL COMMENT '分类描述', 
`parent_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '该分类的父id，取值于该表的cat_id字段', 
`sort_order` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '该分类在页面显示的顺序，数字越大顺序越靠后；同数字，id在前的先显示', 
`template_file` varchar(50) NOT NULL COMMENT '不确定字段，按名字和表设计猜，应该是该分类的单独模板文件的名字', 
`measure_unit` varchar(15) NOT NULL COMMENT '该分类的计量单位', 
`show_in_nav` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否显示在导航栏，0，不；1，显示在导航栏', 
`style` varchar(150) NOT NULL COMMENT '该分类的单独的样式表的包括文件名部分的文件路径', 
`is_show` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '是否在前台页面显示，1，显示；0，不显示', 
`grade` tinyint(4) NOT NULL DEFAULT '0' COMMENT '该分类的最高和最低价之间的价格分级，当大于1时，会根据最大最小价格区间分成区间，会在页面显示价格范围，如0-300,300-600,600-900这种', 
`filter_attr` smallint(6) NOT NULL DEFAULT '0' COMMENT '如果该字段有值，则该分类将还会按照该值对应在表goods_attr的goods_attr_id所对应的属性筛选，如，封面颜色下有红，黑分类筛选 ', 
PRIMARY KEY (`cat_id`), 
KEY `parent_id` (`parent_id`) 
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='商品分类表，记录商品分类信息' AUTO_INCREMENT=9 ; 
-- ------------------------------------------------------
-- 表的结构 `ecs_collect_goods` 
CREATE TABLE IF NOT EXISTS `ecs_collect_goods` ( 
`rec_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '收藏记录的自增id', 
`user_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '该条收藏记录的会员id，取值于ecs_users的user_id', 
`goods_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '收藏的商品id，取值于ecs_goods的goods_id', 
`add_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '收藏时间', 
`is_attention` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否关注该收藏商品，1，是；0，否', 
PRIMARY KEY (`rec_id`), 
KEY `user_id` (`user_id`), 
KEY `goods_id` (`goods_id`), 
KEY `is_attention` (`is_attention`) 
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='会员收藏商品的记录列表，一条记录一个收藏商品' AUTO_INCREMENT=3 ; 
-- ------------------------------------------------------
-- 表的结构 `ecs_comment` 
CREATE TABLE IF NOT EXISTS `ecs_comment` ( 
`comment_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户评论的自增id', 
`comment_type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '用户评论的类型；0，评论的是商品；1，评论的是文章', 
`id_value` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '文章或者商品的id，文章对应的是ecs_article 的article_id；商品对应的是ecs_goods的goods_id', 
`email` varchar(60) NOT NULL COMMENT '评论时提交的email地址，默认取的ecs_users的email', 
`user_name` varchar(60) NOT NULL COMMENT '评论该文章或商品的人的名称，取值ecs_users的user_name', 
`content` text NOT NULL COMMENT '评论的内容', 
`comment_rank` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '该文章或者商品的星级；只有1到5星；由数字代替；其中5是代表5星', 
`add_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '评论的时间', 
`ip_address` varchar(15) NOT NULL COMMENT '评论时的用户ip', 
`status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否被管理员批准显示，1，是；0，未批准显示', 
`parent_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '评论的父节点；取值该表的comment_id字段；如果该字段为0，则是一个普通评论，否则该条评论就是该字段的值所对应的评论的回复', 
`user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '发表该评论的用户的用户id，取值于ecs_users的user_id', 
PRIMARY KEY (`comment_id`), 
KEY `parent_id` (`parent_id`), 
KEY `id_value` (`id_value`) 
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='用户对文章和产品的评论列表' AUTO_INCREMENT=5 ; 
-- ------------------------------------------------------

-- 表的结构 `ecs_crons` 
CREATE TABLE IF NOT EXISTS `ecs_crons` ( 
`cron_id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID号', 
`cron_code` varchar(20) NOT NULL COMMENT '该插件文件在相应路径下的不包括''.php''部分的文件名，运行该插件将通过该字段的值寻找将运行的文件', 
`cron_name` varchar(120) NOT NULL COMMENT '计划任务的名称', 
`cron_desc` text COMMENT '计划人物的描述', 
`cron_order` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '应该是用了设置计划任务执行的顺序的，即当同时触发2个任务时先执行哪一个，如果一样应该是id在前的先执行暂不确定', 
`cron_config` text NOT NULL COMMENT '对每次处理的数据的数量的值，类型，名称序列化；比如删几天的日志，每次执行几个商品或文章的处理', 
`thistime` int(10) NOT NULL DEFAULT '0' COMMENT '该计划任务上次被执行的时间', 
`nextime` int(10) NOT NULL COMMENT '该计划任务下次被执行的时间', 
`day` tinyint(2) NOT NULL COMMENT '如果该字段有值，则计划任务将在每月的这一天执行该计划人物', 
`week` varchar(1) NOT NULL COMMENT '如果该字段有值，则计划任务将在每周的这一天执行该计划人物', 
`hour` varchar(2) NOT NULL COMMENT '如果该字段有值，则该计划任务将在每天的这个小时段执行该计划任务', 
`minute` varchar(255) NOT NULL COMMENT '如果该字段有值，则该计划任务将在每小时的这个分钟段执行该计划任务，该字段的值可以多个，用空格间隔', 
`enable` tinyint(1) NOT NULL DEFAULT '1' COMMENT '该计划任务是否开启；0，关闭；1，开启', 
`run_once` tinyint(1) NOT NULL DEFAULT '0' COMMENT '执行后是否关闭，这个关闭的意思还得再研究下', 
`allow_ip` varchar(100) NOT NULL COMMENT '允许运行该计划人物的服务器ip', 
`alow_files` varchar(255) NOT NULL COMMENT '运行触发该计划人物的文件列表可多个值，为空代表所有许可的文件都可以', 
PRIMARY KEY (`cron_id`), 
KEY `nextime` (`nextime`), 
KEY `enable` (`enable`), 
KEY `cron_code` (`cron_code`) 
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='计划任务插件安装配置信息' AUTO_INCREMENT=4 ; 
-- ------------------------------------------------------
-- 表的结构 `ecs_email_list` 
CREATE TABLE IF NOT EXISTS `ecs_email_list` ( 
`id` mediumint(8) NOT NULL AUTO_INCREMENT COMMENT '邮件订阅的自增id', 
`email` varchar(60) NOT NULL COMMENT '邮件订阅所填的邮箱地址', 
`stat` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否确认，可以用户确认也可以管理员确认；0，未确认；1，已确认', 
`hash` varchar(10) NOT NULL COMMENT '邮箱确认的验证码，系统生成后发送到用户邮箱，用户验证激活时通过该值判断是否合法；主要用来防止非法验证邮箱', 
PRIMARY KEY (`id`) 
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='增加电子杂志订阅表' AUTO_INCREMENT=5 ; 
-- ------------------------------------------------------
-- 表的结构 `ecs_email_sendlist` 
CREATE TABLE IF NOT EXISTS `ecs_email_sendlist` ( 
`id` mediumint(8) NOT NULL AUTO_INCREMENT COMMENT '邮件发送队列自增id', 
`email` varchar(100) NOT NULL COMMENT '该邮件将要发送到的邮箱地址', 
`template_id` mediumint(8) NOT NULL COMMENT '该邮件的模板id，取值于ecs_mail_templates的template_id', 
`email_content` text NOT NULL COMMENT '邮件发送的内容', 
`error` tinyint(1) NOT NULL DEFAULT '0' COMMENT '错误次数，不知干什么用的，猜应该是发送邮件的失败记录', 
`pri` tinyint(10) NOT NULL COMMENT '该邮件发送的优先级；0，普通；1，高', 
`last_send` int(10) NOT NULL COMMENT '上一次发送的时间', 
PRIMARY KEY (`id`) 
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='增加发送队列表' AUTO_INCREMENT=18 ; 
-- ------------------------------------------------------
-- 表的结构 `ecs_error_log` 
CREATE TABLE IF NOT EXISTS `ecs_error_log` ( 
`id` int(10) NOT NULL AUTO_INCREMENT COMMENT '计划任务错误自增id', 
`info` varchar(255) NOT NULL COMMENT '错误详细信息', 
`file` varchar(100) NOT NULL COMMENT '产生错误的执行文件的绝对路径', 
`time` int(10) NOT NULL COMMENT '错误发生的时间', 
PRIMARY KEY (`id`), 
KEY `time` (`time`) 
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='该表用来记录页面触发计划任务时失败所产生的错误，从程序来看，目前主要是记录某计划任务所对应的插件文件不存在的错误' AUTO_INCREMENT=1 ; 
-- ------------------------------------------------------
-- 表的结构 `ecs_favourable_activity` 
CREATE TABLE IF NOT EXISTS `ecs_favourable_activity` ( 
`act_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT '优惠活动的自增id', 
`act_name` varchar(255) NOT NULL COMMENT '优惠活动的活动名称', 
`start_time` int(10) unsigned NOT NULL COMMENT '活动的开始时间', 
`end_time` int(10) unsigned NOT NULL COMMENT '活动的结束时间', 
`user_rank` varchar(255) NOT NULL COMMENT '可以参加活动的用户信息，取值于ecs_user_rank的rank_id；其中0是非会员，其他是相应的会员等级；多个值用逗号分隔', 
`act_range` tinyint(3) unsigned NOT NULL COMMENT '优惠范围；0，全部商品；1，按分类；2，按品牌；3，按商品', 
`act_range_ext` varchar(255) NOT NULL COMMENT '根据优惠活动范围的不同，该处意义不同；但是都是优惠范围的约束；如，如果是商品，该处是商品的id，如果是品牌，该处是品牌的id', 
`min_amount` decimal(10,2) unsigned NOT NULL COMMENT '订单达到金额下限，才参加活动', 
`max_amount` decimal(10,2) unsigned NOT NULL COMMENT '参加活动的订单金额下限，0，表示没有上限', 
`act_type` tinyint(3) unsigned NOT NULL COMMENT '参加活动的优惠方式；0，送赠品或优惠购买；1，现金减免；价格打折优惠', 
`act_type_ext` decimal(10,2) unsigned NOT NULL COMMENT '如果是送赠品，该处是允许的最大数量，0，无数量限制；现今减免，则是减免金额，单位元；打折，是折扣值，100算，8折就是80', 
`gift` text NOT NULL COMMENT '如果有特惠商品，这里是序列化后的特惠商品的id,name,price信息;取值于ecs_goods的goods_id，goods_name，价格是添加活动时填写的', 
`sort_order` tinyint(3) unsigned NOT NULL COMMENT '活动在优惠活动页面显示的先后顺序，数字越大越靠后', 
PRIMARY KEY (`act_id`), 
KEY `act_name` (`act_name`) 
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='优惠活动的配置信息，优惠活动包括送礼，减免，打折' AUTO_INCREMENT=5 ;
-- ------------------------------------------------------
-- 表的结构 `ecs_feedback` 
CREATE TABLE IF NOT EXISTS `ecs_feedback` ( 
`msg_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '反馈信息自增id', 
`parent_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '父节点，取自该表msg_id；反馈该值为0；回复反馈为节点id', 
`user_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '反馈的用户的id', 
`user_name` varchar(60) NOT NULL COMMENT '反馈的用户的用户名', 
`user_email` varchar(60) NOT NULL COMMENT '反馈的用户的邮箱', 
`msg_title` varchar(200) NOT NULL COMMENT '反馈的标题，回复为reply', 
`msg_type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '反馈的类型，0，留言；1，投诉；2，询问；3，售后；4，求购', 
`msg_content` text NOT NULL COMMENT '反馈的内容', 
`msg_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '反馈的时间', 
`message_img` varchar(255) NOT NULL DEFAULT '0' COMMENT '用户上传的文件的地址', 
`order_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '该反馈关联的订单id，由用户提交，取值于 ecs_order_info的order_id；0，为无匹配；', 
PRIMARY KEY (`msg_id`), 
KEY `user_id` (`user_id`) 
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='用户反馈信息表，包括留言，投诉，咨询等' AUTO_INCREMENT=7 ; 
-- ------------------------------------------------------

-- 表的结构 `ecs_friend_link` 
CREATE TABLE IF NOT EXISTS `ecs_friend_link` ( 
`link_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT '友情链接自增id', 
`link_name` varchar(255) NOT NULL COMMENT '友情链接的名称，img的alt的内容;', 
`link_url` varchar(255) NOT NULL COMMENT '友情链接网站的链接地址', 
`link_logo` varchar(255) NOT NULL COMMENT '友情链接的logo', 
`show_order` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '在页面的显示顺序', 
PRIMARY KEY (`link_id`), 
KEY `show_order` (`show_order`) 
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='友情链接配置信息表' AUTO_INCREMENT=3 ; 
-- ------------------------------------------------------
-- 表的结构 `ecs_goods` 
CREATE TABLE IF NOT EXISTS `ecs_goods` ( 
`goods_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '商品的自增id', 
`cat_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '商品所属商品分类id，取值ecs_category的cat_id', 
`goods_sn` varchar(60) NOT NULL COMMENT '商品的唯一货号', 
`goods_name` varchar(120) NOT NULL COMMENT '商品的名称', 
`goods_name_style` varchar(60) NOT NULL DEFAULT '+' COMMENT '商品名称显示的样式；包括颜色和字体样式；格式如#ff00ff+strong', 
`click_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '商品点击数', 
`brand_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '品牌id，取值于ecs_brand 的brand_id', 
`provider_name` varchar(100) NOT NULL COMMENT '供货人的名称，程序还没实现该功能', 
`goods_number` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '商品库存数量', 
`goods_weight` decimal(10,3) unsigned NOT NULL DEFAULT '0.000' COMMENT '商品的重量，以千克为单位', 
`market_price` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '市场售价', 
`shop_price` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '本店售价', 
`promote_price` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '促销价格', 
`promote_start_date` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '促销价格开始日期', 
`promote_end_date` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '促销价结束日期', 
`warn_number` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '商品报警数量', 
`keywords` varchar(255) NOT NULL COMMENT '商品关键字，放在商品页的关键字中，为搜索引擎收录用', 
`goods_brief` varchar(255) NOT NULL COMMENT '商品的简短描述', 
`goods_desc` text NOT NULL COMMENT '商品的详细描述', 
`goods_thumb` varchar(255) NOT NULL COMMENT '商品在前台显示的微缩图片，如在分类筛选时显示的小图片', 
`goods_img` varchar(255) NOT NULL COMMENT '商品的实际大小图片，如进入该商品页时介绍商品属性所显示的大图片', 
`original_img` varchar(255) NOT NULL COMMENT '应该是上传的商品的原始图片', 
`is_real` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '是否是实物，1，是；0，否；比如虚拟卡就为0，不是实物', 
`extension_code` varchar(30) NOT NULL COMMENT '商品的扩展属性，比如像虚拟卡', 
`is_on_sale` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '该商品是否开放销售，1，是；0，否', 
`is_alone_sale` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '是否能单独销售，1，是；0，否；如果不能单独销售，则只能作为某商品的配件或者赠品销售', 
`integral` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '购买该商品可以使用的积分数量，估计应该是用积分代替金额消费；但程序好像还没有实现该功能', 
`add_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '商品的添加时间', 
`sort_order` smallint(4) unsigned NOT NULL DEFAULT '0' COMMENT '应该是商品的显示顺序，不过该版程序中没实现该功能', 
`is_delete` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '商品是否已经删除，0，否；1，已删除', 
`is_best` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否是精品；0，否；1，是', 
`is_new` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否是新品；0，否；1，是', 
`is_hot` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否热销，0，否；1，是', 
`is_promote` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否特价促销；0，否；1，是', 
`bonus_type_id` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '购买该商品所能领到的红包类型', 
`last_update` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最近一次更新商品配置的时间', 
`goods_type` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '商品所属类型id，取值表goods_type的cat_id', 
`seller_note` varchar(255) NOT NULL COMMENT '商品的商家备注，仅商家可见', 
`give_integral` int(11) NOT NULL DEFAULT '-1' COMMENT '购买该商品时每笔成功交易赠送的积分数量。', 
PRIMARY KEY (`goods_id`), 
KEY `goods_sn` (`goods_sn`), 
KEY `cat_id` (`cat_id`), 
KEY `last_update` (`last_update`), 
KEY `brand_id` (`brand_id`), 
KEY `goods_weight` (`goods_weight`), 
KEY `promote_end_date` (`promote_end_date`), 
KEY `promote_start_date` (`promote_start_date`), 
KEY `goods_number` (`goods_number`) 
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='商品表' AUTO_INCREMENT=35 ; 
-- ------------------------------------------------------
-- 表的结构 `ecs_goods_activity` 
CREATE TABLE IF NOT EXISTS `ecs_goods_activity` ( 
`act_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID号', 
`act_name` varchar(255) NOT NULL COMMENT '促销活动的名称', 
`act_desc` text NOT NULL COMMENT '促销活动的描述', 
`act_type` tinyint(3) unsigned NOT NULL, 
`goods_id` mediumint(8) unsigned NOT NULL COMMENT '参加活动的id，取值于ecs_goods的goods_id', 
`goods_name` varchar(255) NOT NULL COMMENT '商品的名称，取值于ecs_goods的goods_id', 
`start_time` int(10) unsigned NOT NULL COMMENT '活动开始时间', 
`end_time` int(10) unsigned NOT NULL COMMENT '活动结束时间', 
`is_finished` tinyint(3) unsigned NOT NULL COMMENT '活动是否结束，0，结束；1，未结束', 
`ext_info` text NOT NULL COMMENT '序列化后的促销活动的配置信息，包括最低价，最高价，出价幅度，保证金等', 
PRIMARY KEY (`act_id`), 
KEY `act_name` (`act_name`,`act_type`,`goods_id`) 
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='拍卖活动和夺宝奇兵活动配置信息表' AUTO_INCREMENT=5 ; 
-- ------------------------------------------------------
-- 表的结构 `ecs_goods_article`
CREATE TABLE IF NOT EXISTS `ecs_goods_article` (
`goods_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '商品id，取自ecs_goods的goods_id',
`article_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '文章id，取自 ecs_article 的article_id',
`admin_id` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '猜想是管理员的id，但是程序中似乎没有提及到',
PRIMARY KEY (`goods_id`,`article_id`,`admin_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='文章关联产品表，即文章中提到的相关产品';
-- ------------------------------------------------------
-- 表的结构 `ecs_goods_attr`
CREATE TABLE IF NOT EXISTS `ecs_goods_attr` (
`goods_attr_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID号',
`goods_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '该具体属性属于的商品，取值于ecs_goods的goods_id',
`attr_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '该具体属性属于的属性类型的id，取自ecs_attribute 的attr_id',
`attr_value` text NOT NULL COMMENT '该具体属性的值',
`attr_price` varchar(255) NOT NULL COMMENT '该属性对应在商品原价格上要加的价格',
PRIMARY KEY (`goods_attr_id`),
KEY `goods_id` (`goods_id`),
KEY `attr_id` (`attr_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='具体商品的属性表' AUTO_INCREMENT=62 ;
-- ------------------------------------------------------
-- 表的结构 `ecs_goods_cat`
CREATE TABLE IF NOT EXISTS `ecs_goods_cat` (
`goods_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '商品id',
`cat_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '商品分类id',
PRIMARY KEY (`goods_id`,`cat_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='商品的扩展分类';
-- ------------------------------------------------------
-- 表的结构 `ecs_goods_gallery`
CREATE TABLE IF NOT EXISTS `ecs_goods_gallery` (
`img_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '商品相册自增id',
`goods_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '图片属于商品的id',
`img_url` varchar(255) NOT NULL COMMENT '实际图片url',
`img_desc` varchar(255) NOT NULL COMMENT '图片说明信息',
`thumb_url` varchar(255) NOT NULL COMMENT '微缩图片url',
`img_original` varchar(255) NOT NULL COMMENT '根据名字猜，应该是上传的图片文件的最原始的文件的url',
PRIMARY KEY (`img_id`),
KEY `goods_id` (`goods_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='商品相册表，只出现在页面的商品相册中' AUTO_INCREMENT=23 ;
-- ------------------------------------------------------
-- 表的结构 `ecs_goods_type`
CREATE TABLE IF NOT EXISTS `ecs_goods_type` (
`cat_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID号',
`cat_name` varchar(60) NOT NULL COMMENT '商品类型名',
`enabled` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '类型状态，1，为可用；0为不可用；不可用的类型，在添加商品的时候选择商品属性将不可选',
`attr_group` varchar(255) NOT NULL COMMENT '商品属性分组，将一个商品类型的属性分成组，在显示的时候也是按组显示。该字段的值显示在属性的前一行，像标题的作用',
PRIMARY KEY (`cat_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='商品类型表，该表每条记录就是一个商品类型' AUTO_INCREMENT=10 ;
-- ------------------------------------------------------
-- 表的结构 `ecs_group_goods`
CREATE TABLE IF NOT EXISTS `ecs_group_goods` (
`parent_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '父商品id',
`goods_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '配件商品id',
`goods_price` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '配件商品的价格',
`admin_id` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '添加该配件的管理员的id',
PRIMARY KEY (`parent_id`,`goods_id`,`admin_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='该表应该是商品配件配置表';
-- ------------------------------------------------------
-- 表的结构 `ecs_keywords`
CREATE TABLE IF NOT EXISTS `ecs_keywords` (
`date` date NOT NULL DEFAULT '0000-00-00' COMMENT '搜索日期',
`searchengine` varchar(20) NOT NULL COMMENT '搜索引擎，默认是ecshop',
`keyword` varchar(90) NOT NULL COMMENT '搜索关键字，即用户填写的搜索内容',
`count` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '搜索次数，按天累加',
PRIMARY KEY (`date`,`searchengine`,`keyword`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='页面搜索关键字搜索记录';
-- ------------------------------------------------------
-- 表的结构 `ecs_link_goods`
CREATE TABLE IF NOT EXISTS `ecs_link_goods` (
`goods_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '商品id',
`link_goods_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '被关联的商品的id',
`is_double` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否是双向关联；0，否；1，是',
`admin_id` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '添加此关联商品信息的管理员id',
PRIMARY KEY (`goods_id`,`link_goods_id`,`admin_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='关联商品信息表，关联商品是什么意思还没研究明白';
-- ------------------------------------------------------
-- 表的结构 `ecs_mail_templates`
CREATE TABLE IF NOT EXISTS `ecs_mail_templates` (
`template_id` tinyint(1) unsigned NOT NULL AUTO_INCREMENT COMMENT '邮件模板自增id',
`template_code` varchar(30) NOT NULL COMMENT '模板字符串名称，主要用于插件言语包时匹配语言包文件等用途',
`is_html` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '邮件是否是html格式；0，否；1，是',
`template_subject` varchar(200) NOT NULL COMMENT '该邮件模板的邮件主题',
`template_content` text NOT NULL COMMENT '邮件模板的内容',
`last_modify` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后一次修改模板的时间',
`last_send` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最近一次发送的时间，好像仅在杂志才记录',
`type` varchar(10) NOT NULL COMMENT '该邮件模板的邮件类型；共2个类型；magazine，杂志订阅；template，关注订阅',
PRIMARY KEY (`template_id`),
UNIQUE KEY `template_code` (`template_code`),
KEY `type` (`type`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='各种邮件的模板配置模板包括杂志模板' AUTO_INCREMENT=13 ;
-- ------------------------------------------------------
-- 表的结构 `ecs_member_price`
CREATE TABLE IF NOT EXISTS `ecs_member_price` (
`price_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '折扣价自增id',
`goods_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '商品的id',
`user_rank` tinyint(3) NOT NULL DEFAULT '0' COMMENT '会员登记id',
`user_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '指定商品对指定会员等级的固定定价价格，单位元',
PRIMARY KEY (`price_id`),
KEY `goods_id` (`goods_id`,`user_rank`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='商品不按照会员的折扣定价，而是再单独为不同的会员等级定的价；' AUTO_INCREMENT=3 ;
-- ------------------------------------------------------
-- 表的结构 `ecs_nav`
CREATE TABLE IF NOT EXISTS `ecs_nav` (
`id` mediumint(8) NOT NULL AUTO_INCREMENT COMMENT '导航配置自增id',
`ctype` varchar(10) DEFAULT NULL,
`cid` smallint(5) unsigned DEFAULT NULL,
`name` varchar(255) NOT NULL COMMENT '导航显示标题',
`ifshow` tinyint(1) NOT NULL COMMENT '是否显示',
`vieworder` tinyint(1) NOT NULL COMMENT '页面显示顺序，数字越大越靠后',
`opennew` tinyint(1) NOT NULL COMMENT '导航链接页面是否在新窗口打开，1，是；其他，否',
`url` varchar(255) NOT NULL COMMENT '链接的页面地址',
`type` varchar(10) NOT NULL COMMENT '处于导航栏的位置，top为顶部；middle为中间；bottom,为底部',
PRIMARY KEY (`id`),
KEY `type` (`type`),
KEY `ifshow` (`ifshow`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='上中下3个导航栏的显示配置' AUTO_INCREMENT=17 ;
-- ------------------------------------------------------
-- 表的结构 `ecs_order_action`
CREATE TABLE IF NOT EXISTS `ecs_order_action` (
`action_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '流水号',
`order_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '被操作的交易号',
`action_user` varchar(30) NOT NULL COMMENT '操作该次的人员',
`order_status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '作何操作.0，未确认；1，已确认；2，已取消；3，无效；4，退货；',
`shipping_status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '发货状态。0，未发货；1，已发货；2，已收货；3，备货中',
`pay_status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '支付状态.0,未付款;1,付款中;2,已付款;',
`action_note` varchar(255) NOT NULL COMMENT '操作备注',
`log_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '操作时间',
PRIMARY KEY (`action_id`),
KEY `order_id` (`order_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='对订单操作日志表' AUTO_INCREMENT=18 ;
-- ------------------------------------------------------
-- 表的结构 `ecs_order_goods`
CREATE TABLE IF NOT EXISTS `ecs_order_goods` (
`rec_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '订单商品信息自增id',
`order_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '订单商品信息对应的详细信息id，取值order_info的order_id',
`goods_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '商品的的id，取值表ecs_goods 的goods_id',
`goods_name` varchar(120) NOT NULL COMMENT '商品的名称，取值表ecs_goods ',
`goods_sn` varchar(60) NOT NULL COMMENT '商品的唯一货号，取值ecs_goods ',
`goods_number` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT '商品的购买数量',
`market_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '商品的市场售价，取值ecs_goods ',
`goods_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '商品的本店售价，取值ecs_goods ',
`goods_attr` text NOT NULL COMMENT '购买该商品时所选择的属性；',
`send_number` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '当不是实物时，是否已发货，0，否；1，是',
`is_real` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否是实物，0，否；1，是；取值ecs_goods ',
`extension_code` varchar(30) NOT NULL COMMENT '商品的扩展属性，比如像虚拟卡。取值ecs_goods ',
`parent_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '父商品id，取值于ecs_cart的parent_id；如果有该值则是值多代表的物品的配件',
`is_gift` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '是否参加优惠活动，0，否；其他，取值于ecs_cart 的is_gift，跟其一样，是参加的优惠活动的id',
PRIMARY KEY (`rec_id`),
KEY `order_id` (`order_id`),
KEY `goods_id` (`goods_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='订单的商品信息，注：订单的商品信息基本都是从购物车所对应的表中取来的。' AUTO_INCREMENT=27 ;
-- ------------------------------------------------------
-- 表的结构 `ecs_order_info`
CREATE TABLE IF NOT EXISTS `ecs_order_info` (
`order_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '订单详细信息自增id',
`order_sn` varchar(20) NOT NULL COMMENT '订单号，唯一',
`user_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '用户id，同ecs_users的user_id',
`order_status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '订单状态。0，未确认；1，已确认；2，已取消；3，无效；4，退货；',
`shipping_status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '商品配送情况，0，未发货；1，已发货；2，已收货；3，备货中',
`pay_status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '支付状态；0，未付款；1，付款中；2，已付款',
`consignee` varchar(60) NOT NULL COMMENT '收货人的姓名，用户页面填写，默认取值于表user_address',
`country` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '收货人的国家，用户页面填写，默认取值于表user_address，其id对应的值在ecs_region',
`province` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '收货人的省份，用户页面填写，默认取值于表user_address，其id对应的值在ecs_region',
`city` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '收货人的城市，用户页面填写，默认取值于表user_address，其id对应的值在ecs_region',
`district` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '收货人的地区，用户页面填写，默认取值于表user_address，其id对应的值在ecs_region',
`address` varchar(255) NOT NULL COMMENT '收货人的详细地址，用户页面填写，默认取值于表user_address',
`zipcode` varchar(60) NOT NULL COMMENT '收货人的邮编，用户页面填写，默认取值于表user_address',
`tel` varchar(60) NOT NULL COMMENT '收货人的电话，用户页面填写，默认取值于表user_address',
`mobile` varchar(60) NOT NULL COMMENT '收货人的手机，用户页面填写，默认取值于表user_address',
`email` varchar(60) NOT NULL COMMENT '收货人的手机，用户页面填写，默认取值于表user_address',
`best_time` varchar(120) NOT NULL COMMENT '收货人的最佳送货时间，用户页面填写，默认取值于表user_address',
`sign_building` varchar(120) NOT NULL COMMENT '收货人的地址的标志性建筑，用户页面填写，默认取值于表user_address',
`postscript` varchar(255) NOT NULL COMMENT '订单附言，由用户提交订单前填写',
`shipping_id` tinyint(3) NOT NULL DEFAULT '0' COMMENT '用户选择的配送方式id，取值表ecs_shipping',
`shipping_name` varchar(120) NOT NULL COMMENT '用户选择的配送方式的名称，取值表ecs_shipping',
`pay_id` tinyint(3) NOT NULL DEFAULT '0' COMMENT '用户选择的支付方式的id，取值表ecs_payment',
`pay_name` varchar(120) NOT NULL COMMENT '用户选择的支付方式的名称，取值表ecs_payment',
`how_oos` varchar(120) NOT NULL COMMENT '缺货处理方式，等待所有商品备齐后再发； 取消订单；与店主协商',
`how_surplus` varchar(120) NOT NULL COMMENT '根据字段猜测应该是余额处理方式，程序未作这部分实现',
`pack_name` varchar(120) NOT NULL COMMENT '包装名称，取值表ecs_pack',
`card_name` varchar(120) NOT NULL COMMENT '贺卡的名称，取值ecs_card ',
`card_message` varchar(255) NOT NULL COMMENT '贺卡内容，由用户提交',
`inv_payee` varchar(120) NOT NULL COMMENT '发票抬头，用户页面填写',
`inv_content` varchar(120) NOT NULL COMMENT '发票内容，用户页面选择，取值ecs_shop_config的code字段的值为invoice_content的value',
`goods_amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '商品总金额',
`shipping_fee` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '配送费用',
`insure_fee` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '保价费用',
`pay_fee` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '支付费用,跟支付方式的配置相关，取值表ecs_payment',
`pack_fee` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '包装费用，取值表取值表ecs_pack',
`card_fee` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '贺卡费用，取值ecs_card ',
`money_paid` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '已付款金额',
`surplus` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '该订单使用余额的数量，取用户设定余额，用户可用余额，订单金额中最小者',
`integral` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '使用的积分的数量，取用户使用积分，商品可用积分，用户拥有积分中最小者',
`integral_money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '使用积分金额',
`bonus` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '使用红包金额',
`order_amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '应付款金额',
`from_ad` smallint(5) NOT NULL DEFAULT '0' COMMENT '订单由某广告带来的广告id，应该取值于ecs_ad',
`referer` varchar(255) NOT NULL COMMENT '订单的来源页面',
`add_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '订单生成时间',
`confirm_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '订单确认时间',
`pay_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '订单支付时间',
`shipping_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '订单配送时间',
`pack_id` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '包装id，取值取值表ecs_pack',
`card_id` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '贺卡id，用户在页面选择，取值取值ecs_card ',
`bonus_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '红包的id，ecs_user_bonus的bonus_id',
`invoice_no` varchar(50) NOT NULL COMMENT '发货单号，发货时填写，可在订单查询查看',
`extension_code` varchar(30) NOT NULL COMMENT '通过活动购买的商品的代号；GROUP_BUY是团购；AUCTION，是拍卖；SNATCH，夺宝奇兵；正常普通产品该处为空',
`extension_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '通过活动购买的物品的id，取值ecs_goods_activity；如果是正常普通商品，该处为0',
`to_buyer` varchar(255) NOT NULL COMMENT '商家给客户的留言,当该字段有值时可以在订单查询看到',
`pay_note` varchar(255) NOT NULL COMMENT '付款备注，在订单管理里编辑修改',
`agency_id` smallint(5) unsigned NOT NULL COMMENT '该笔订单被指派给的办事处的id，根据订单内容和办事处负责范围自动决定，也可以有管理员修改，取值于表ecs_agency',
`inv_type` varchar(60) NOT NULL COMMENT '发票类型，用户页面选择，取值ecs_shop_config的code字段的值为invoice_type的value',
`tax` decimal(10,2) NOT NULL COMMENT '发票税额',
`is_separate` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0，未分成或等待分成；1，已分成；2，取消分成；',
`parent_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '能获得推荐分成的用户id，id取值于表ecs_users',
`discount` decimal(10,2) NOT NULL COMMENT '折扣金额',
PRIMARY KEY (`order_id`),
UNIQUE KEY `order_sn` (`order_sn`),
KEY `user_id` (`user_id`),
KEY `order_status` (`order_status`),
KEY `shipping_status` (`shipping_status`),
KEY `pay_status` (`pay_status`),
KEY `shipping_id` (`shipping_id`),
KEY `pay_id` (`pay_id`),
KEY `extension_code` (`extension_code`,`extension_id`),
KEY `agency_id` (`agency_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='订单的配送，贺卡等详细信息' AUTO_INCREMENT=24 ;
-- ------------------------------------------------------

-- 表的结构 `ecs_pack`
CREATE TABLE IF NOT EXISTS `ecs_pack` (
`pack_id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT COMMENT '包装配置的自增id',
`pack_name` varchar(120) NOT NULL COMMENT '包装的名称',
`pack_img` varchar(255) NOT NULL COMMENT '包装图纸',
`pack_fee` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '包装的费用',
`free_money` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '订单达到此金额可以免除该包装费用',
`pack_desc` varchar(255) NOT NULL COMMENT '包装描述',
PRIMARY KEY (`pack_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='商品包装信息配置表' AUTO_INCREMENT=2 ;
-- ------------------------------------------------------
-- 表的结构 `ecs_payment`
CREATE TABLE IF NOT EXISTS `ecs_payment` (
`pay_id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT COMMENT '已安装的支付方式自增id',
`pay_code` varchar(20) NOT NULL COMMENT '支付方式的英文缩写，其实就是该支付方式处理插件的不带后缀的文件名部分',
`pay_name` varchar(120) NOT NULL COMMENT '支付方式名称',
`pay_fee` varchar(10) NOT NULL DEFAULT '0' COMMENT '支付费用',
`pay_desc` text NOT NULL COMMENT '支付方式描述',
`pay_order` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '支付方式在页面的显示顺序',
`pay_config` text NOT NULL COMMENT '支付方式的配置信息，包括商户号和密钥什么的',
`enabled` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否可用，0，否；1，是',
`is_cod` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否货到付款，0，否；1，是',
`is_online` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否在线支付，0，否；1，是',
PRIMARY KEY (`pay_id`),
UNIQUE KEY `pay_code` (`pay_code`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='安装的支付方式配置信息' AUTO_INCREMENT=7 ;
-- ------------------------------------------------------
-- 表的结构 `ecs_pay_log`
CREATE TABLE IF NOT EXISTS `ecs_pay_log` (
`log_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '支付记录自增id',
`order_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '对应的交易记录的id，取值表ecs_order_info ',
`order_amount` decimal(10,2) unsigned NOT NULL COMMENT '支付金额',
`order_type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '支付类型；0，订单支付；1，会员预付款支付',
`is_paid` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否已支付，0，否；1，是',
PRIMARY KEY (`log_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='系统支付记录' AUTO_INCREMENT=28 ;
-- ------------------------------------------------------
-- 表的结构 `ecs_plugins`
CREATE TABLE IF NOT EXISTS `ecs_plugins` (
`code` varchar(30) NOT NULL DEFAULT '',
`version` varchar(10) NOT NULL DEFAULT '',
`library` varchar(255) NOT NULL DEFAULT '',
`assign` tinyint(1) unsigned NOT NULL DEFAULT '0',
`install_date` int(10) unsigned NOT NULL DEFAULT '0',
PRIMARY KEY (`code`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
-- ------------------------------------------------------
-- 表的结构 `ecs_region`
CREATE TABLE IF NOT EXISTS `ecs_region` (
`region_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT '表示该地区的id',
`parent_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '该地区的上一个节点的地区id',
`region_name` varchar(120) NOT NULL COMMENT '地区的名字',
`region_type` tinyint(1) NOT NULL DEFAULT '2' COMMENT '该地区的下一个节点的地区id',
`agency_id` smallint(5) unsigned NOT NULL COMMENT '办事处的id,这里有一个bug,同一个省不能有多个办事处,该字段只记录最新的那个办事处的id',
PRIMARY KEY (`region_id`),
KEY `parent_id` (`parent_id`),
KEY `region_type` (`region_type`),
KEY `agency_id` (`agency_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='地区列表' AUTO_INCREMENT=419 ;
-- ------------------------------------------------------
-- 表的结构 `ecs_searchengine`
CREATE TABLE IF NOT EXISTS `ecs_searchengine` (
`date` date NOT NULL DEFAULT '0000-00-00' COMMENT '搜索引擎访问日期',
`searchengine` varchar(20) NOT NULL COMMENT '搜索引擎名称',
`count` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '访问次数',
PRIMARY KEY (`date`,`searchengine`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='搜索引擎访问记录';
-- ------------------------------------------------------
-- 表的结构 `ecs_sessions`
CREATE TABLE IF NOT EXISTS `ecs_sessions` (
`sesskey` char(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'sessionid,',
`expiry` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'session创建时间',
`userid` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '如果不是管理员，记录用户id',
`adminid` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '如果是管理员记录管理员id',
`ip` char(15) NOT NULL COMMENT '客户端ip',
`data` char(255) NOT NULL COMMENT '序列化后的session数据，如果session数据大于255则将数据存到表ecs_sessions_data，此处为空',
PRIMARY KEY (`sesskey`),
KEY `expiry` (`expiry`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='session记录表';
-- ------------------------------------------------------
-- 表的结构 `ecs_sessions_data`
CREATE TABLE IF NOT EXISTS `ecs_sessions_data` (
`sesskey` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'sessionid',
`expiry` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'session创建时间',
`data` longtext NOT NULL COMMENT 'session序列化后的数据',
PRIMARY KEY (`sesskey`),
KEY `expiry` (`expiry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='session数据表（超过255字节的session内容会保存在该表）';
-- ------------------------------------------------------
-- 表的结构 `ecs_shipping`
CREATE TABLE IF NOT EXISTS `ecs_shipping` (
`shipping_id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID号',
`shipping_code` varchar(20) NOT NULL COMMENT '配送方式的字符串代号',
`shipping_name` varchar(120) NOT NULL COMMENT '配送方式的名称',
`shipping_desc` varchar(255) NOT NULL COMMENT '配送方式的描述',
`insure` varchar(10) NOT NULL DEFAULT '0' COMMENT '保价费用，单位元，或者是百分数，该值直接输出为报价费用',
`support_cod` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否支持货到付款，1，支持；0，不支持',
`enabled` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '该配送方式是否被禁用，1，可用；0，禁用',
PRIMARY KEY (`shipping_id`),
KEY `shipping_code` (`shipping_code`,`enabled`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='配送方式配置信息表' AUTO_INCREMENT=9 ;
-- ------------------------------------------------------
-- 表的结构 `ecs_shipping_area`
CREATE TABLE IF NOT EXISTS `ecs_shipping_area` (
`shipping_area_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID号',
`shipping_area_name` varchar(150) NOT NULL COMMENT '配送方式中的配送区域的名字',
`shipping_id` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '该配送区域所属的配送方式，同ecs_shipping的shipping_id',
`configure` text NOT NULL COMMENT '序列化的该配送区域的费用配置信息',
PRIMARY KEY (`shipping_area_id`),
KEY `shipping_id` (`shipping_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='配送方式所属的配送区域和配送费用信息' AUTO_INCREMENT=9 ;
-- ------------------------------------------------------
-- 表的结构 `ecs_shop_config`
CREATE TABLE IF NOT EXISTS `ecs_shop_config` (
`id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT '全站配置信息自增id',
`parent_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '父节点id，取值于该表id字段的值',
`code` varchar(30) NOT NULL COMMENT '跟变量名的作用差不多，其实就是语言包中的字符串索引，如$_LANG[''cfg_range''][''cart_confirm'']',
`type` varchar(10) NOT NULL COMMENT '该配置的类型，text，文本输入框；password，密码输入框；textarea，文本区域；select，单选；options，循环生成多选；file,文件上传；manual，手动生成多选；group，是标题分组；hidden，不在页面显示',
`store_range` varchar(255) NOT NULL COMMENT '当语言包中的code字段对应的是一个数组时，那该处就是该数组的索引，如$_LANG[''cfg_range''] [''cart_confirm''][1]；只有type字段为select,options时才有值',
`store_dir` varchar(255) NOT NULL COMMENT '当type为file时才有值，文件上传后的保存目录',
`value` text NOT NULL COMMENT '该项配置的值',
`sort_order` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '显示顺序，数字越大越靠后',
PRIMARY KEY (`id`),
UNIQUE KEY `code` (`code`),
KEY `parent_id` (`parent_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='全站配置信息表' AUTO_INCREMENT=903 ;
-- ------------------------------------------------------
-- 表的结构 `ecs_snatch_log`
CREATE TABLE IF NOT EXISTS `ecs_snatch_log` (
`log_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID号',
`snatch_id` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '夺宝奇兵活动号，取值于ecs_goods_activity的act_id字段',
`user_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '出价的用户id，取值于ecs_users的user_id',
`bid_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '出价的价格',
`bid_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '出价的时间',
PRIMARY KEY (`log_id`),
KEY `snatch_id` (`snatch_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='夺宝奇兵出价记录表' AUTO_INCREMENT=5 ;
-- ------------------------------------------------------
-- 表的结构 `ecs_stats`
CREATE TABLE IF NOT EXISTS `ecs_stats` (
`access_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '访问时间',
`ip_address` varchar(15) NOT NULL COMMENT '访问者ip',
`visit_times` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT '访问次数，如果之前有过访问次数，在以前的基础上＋1',
`browser` varchar(60) NOT NULL COMMENT '浏览器及版本',
`system` varchar(20) NOT NULL COMMENT '操作系统',
`language` varchar(20) NOT NULL COMMENT '语言',
`area` varchar(30) NOT NULL COMMENT 'ip所在地区',
`referer_domain` varchar(100) NOT NULL COMMENT '页面访问来源域名',
`referer_path` varchar(200) NOT NULL COMMENT '页面访问来源除域名外的路径部分',
`access_url` varchar(255) NOT NULL COMMENT '访问页面文件名',
KEY `access_time` (`access_time`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='访问信息记录表';
-- ------------------------------------------------------
-- 表的结构 `ecs_tag`
CREATE TABLE IF NOT EXISTS `ecs_tag` (
`tag_id` mediumint(8) NOT NULL AUTO_INCREMENT COMMENT '商品标签自增id',
`user_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '用户的id',
`goods_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '商品的id',
`tag_words` varchar(255) NOT NULL COMMENT '标签内容',
PRIMARY KEY (`tag_id`),
KEY `user_id` (`user_id`),
KEY `goods_id` (`goods_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='商品的标记' AUTO_INCREMENT=3 ;
-- ------------------------------------------------------
-- 表的结构 `ecs_template`
CREATE TABLE IF NOT EXISTS `ecs_template` (
`filename` varchar(30) NOT NULL COMMENT '该条模板配置属于哪个模板页面',
`region` varchar(40) NOT NULL COMMENT '该条模板配置在它所属的模板文件中的位置',
`library` varchar(40) NOT NULL COMMENT '该条模板配置在它所属的模板文件中的位置处应该引入的lib的相对目录地址',
`sort_order` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '模板文件中这个位置的引入lib项的值的显示顺序',
`id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '字段意义待查',
`number` tinyint(1) unsigned NOT NULL DEFAULT '5' COMMENT '每次显示多少个值',
`type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '属于哪个动态项，0，固定项；1，分类下的商品；2，品牌下的商品；3，文章列表；4，广告位 ',
`theme` varchar(60) NOT NULL COMMENT '该模板配置项属于哪套模板的模板名',
`remarks` varchar(30) NOT NULL COMMENT '备注，可能是预留字段，没有值所以没确定用途',
KEY `filename` (`filename`,`region`),
KEY `theme` (`theme`),
KEY `remarks` (`remarks`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='模板设置数据表';
-- ------------------------------------------------------
-- 表的结构 `ecs_topic`
CREATE TABLE IF NOT EXISTS `ecs_topic` (
`topic_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '专题自增id',
`title` varchar(255) NOT NULL DEFAULT '''''' COMMENT '专题名称',
`intro` text NOT NULL COMMENT '专题介绍',
`start_time` int(11) NOT NULL DEFAULT '0' COMMENT '专题开始时间',
`end_time` int(10) NOT NULL DEFAULT '0' COMMENT '结束时间',
`data` text NOT NULL COMMENT '专题数据内容，包括分类，商品等',
`template` varchar(255) NOT NULL DEFAULT '''''' COMMENT '专题模板文件',
`css` text NOT NULL COMMENT '专题样式代码',
KEY `topic_id` (`topic_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='专题活动配置表' AUTO_INCREMENT=2 ;
-- ------------------------------------------------------
-- 表的结构 `ecs_users`
CREATE TABLE IF NOT EXISTS `ecs_users` (
`user_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '会员资料自增id',
`email` varchar(60) NOT NULL COMMENT '会员邮箱',
`user_name` varchar(60) NOT NULL COMMENT '用户名',
`password` varchar(32) NOT NULL COMMENT '用户密码',
`question` varchar(255) NOT NULL COMMENT '安全问题答案',
`answer` varchar(255) NOT NULL COMMENT '安全问题',
`sex` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '性别，0，保密；1，男；2，女',
`birthday` date NOT NULL DEFAULT '0000-00-00' COMMENT '生日日期',
`user_money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '用户现有资金',
`frozen_money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '用户冻结资金',
`pay_points` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '消费积分',
`rank_points` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '会员等级积分',
`address_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '收货信息id，取值表ecs_user_address ',
`reg_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
`last_login` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '最后一次登录时间',
`last_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '应该是最后一次修改信息时间，该表信息从其他表同步过来考虑',
`last_ip` varchar(15) NOT NULL COMMENT '最后一次登录ip',
`visit_count` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '登录次数',
`user_rank` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '会员登记id，取值ecs_user_rank',
`is_special` tinyint(3) unsigned NOT NULL DEFAULT '0',
`salt` varchar(10) NOT NULL DEFAULT '0',
`parent_id` mediumint(9) NOT NULL DEFAULT '0' COMMENT '推荐人会员id，',
`flag` tinyint(3) unsigned NOT NULL DEFAULT '0',
`alias` varchar(60) NOT NULL COMMENT '昵称',
`msn` varchar(60) NOT NULL COMMENT 'msn',
`qq` varchar(20) NOT NULL COMMENT 'qq号',
`office_phone` varchar(20) NOT NULL COMMENT '办公电话',
`home_phone` varchar(20) NOT NULL COMMENT '家庭电话',
`mobile_phone` varchar(20) NOT NULL COMMENT '手机',
`is_validated` tinyint(3) unsigned NOT NULL DEFAULT '0',
`credit_line` decimal(10,2) unsigned NOT NULL COMMENT '信用额度，目前2.6.0版好像没有作实现',
PRIMARY KEY (`user_id`),
UNIQUE KEY `user_name` (`user_name`),
KEY `email` (`email`),
KEY `parent_id` (`parent_id`),
KEY `flag` (`flag`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC AUTO_INCREMENT=21 ;
-- ------------------------------------------------------
-- 表的结构 `ecs_user_account`
CREATE TABLE IF NOT EXISTS `ecs_user_account` (
`id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID号',
`user_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '用户登录后保存在session中的id号，跟users表中的user_id对应',
`admin_user` varchar(255) NOT NULL COMMENT '操作该笔交易的管理员的用户名',
`amount` decimal(10,2) NOT NULL COMMENT '资金的数目，正数为增加，负数为减少',
`add_time` int(10) NOT NULL DEFAULT '0' COMMENT '记录插入时间',
`paid_time` int(10) NOT NULL DEFAULT '0' COMMENT '记录更新时间',
`admin_note` varchar(255) NOT NULL COMMENT '管理员的被准',
`user_note` varchar(255) NOT NULL COMMENT '用户的被准',
`process_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '操作类型，1，退款；0，预付费，其实就是充值',
`payment` varchar(90) NOT NULL COMMENT '支付渠道的名称，取自payment的pay_name字段',
`is_paid` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否已经付款，０，未付；１，已付',
PRIMARY KEY (`id`),
KEY `user_id` (`user_id`),
KEY `is_paid` (`is_paid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='用户资金流动表，包括提现和充值' AUTO_INCREMENT=7 ;
-- ------------------------------------------------------
-- 表的结构 `ecs_user_address`
CREATE TABLE IF NOT EXISTS `ecs_user_address` (
`address_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
`address_name` varchar(50) NOT NULL,
`user_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '用户表中的流水号',
`consignee` varchar(60) NOT NULL COMMENT '收货人的名字',
`email` varchar(60) NOT NULL COMMENT '收货人的email',
`country` smallint(5) NOT NULL DEFAULT '0' COMMENT '收货人的国家',
`province` smallint(5) NOT NULL DEFAULT '0' COMMENT '收货人的省份',
`city` smallint(5) NOT NULL DEFAULT '0' COMMENT '收货人的城市',
`district` smallint(5) NOT NULL DEFAULT '0' COMMENT '收货人的地区',
`address` varchar(120) NOT NULL COMMENT '收货人的详细地址',
`zipcode` varchar(60) NOT NULL COMMENT '收货人的邮编',
`tel` varchar(60) NOT NULL COMMENT '收货人的电话',
`mobile` varchar(60) NOT NULL COMMENT '收货人的手机',
`sign_building` varchar(120) NOT NULL COMMENT '收货地址的标志性建筑名',
`best_time` varchar(120) NOT NULL COMMENT '收货人的最佳收货时间',
PRIMARY KEY (`address_id`),
KEY `user_id` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='收货人的信息表' AUTO_INCREMENT=4 ;
-- ------------------------------------------------------
-- 表的结构 `ecs_user_bonus`
CREATE TABLE IF NOT EXISTS `ecs_user_bonus` (
`bonus_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '红包的流水号',
`bonus_type_id` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '红包发送类型.0,按用户如会员等级,会员名称发放;1,按商品类别发送;2,按订单金额所达到的额度发送;3,线下发送',
`bonus_sn` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '红包号,如果为0就是没有红包号.如果大于0,就需要输入该红包号才能使用红包',
`user_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '该红包属于某会员的id.如果为0,就是该红包不属于某会员',
`used_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '红包使用的时间',
`order_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '使用了该红包的交易号',
`emailed` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '猜的，应该是是否已经将红包发送到用户的邮箱；1，是；0，否；',
PRIMARY KEY (`bonus_id`),
KEY `user_id` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='已经发送的红包信息列表' AUTO_INCREMENT=122 ;
-- ------------------------------------------------------
-- 表的结构 `ecs_user_feed`
CREATE TABLE IF NOT EXISTS `ecs_user_feed` (
`feed_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
`user_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
`value_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
`goods_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
`feed_type` tinyint(1) unsigned NOT NULL DEFAULT '0',
`is_feed` tinyint(1) unsigned NOT NULL DEFAULT '0',
PRIMARY KEY (`feed_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;
-- ------------------------------------------------------
-- 表的结构 `ecs_user_rank`
CREATE TABLE IF NOT EXISTS `ecs_user_rank` (
`rank_id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT COMMENT '会员等级编号，其中0是非会员',
`rank_name` varchar(30) NOT NULL COMMENT '会员等级名称',
`min_points` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '该等级的最低积分',
`max_points` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '该等级的最高积分',
`discount` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '该会员等级的商品折扣',
`show_price` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '是否在不是该等级会员购买页面显示该会员等级的折扣价格.1,显示;0,不显示',
`special_rank` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否事特殊会员等级组.0,不是;1,是',
PRIMARY KEY (`rank_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='会员等级配置信息' AUTO_INCREMENT=3 ;
-- ------------------------------------------------------
-- 表的结构 `ecs_virtual_card`
CREATE TABLE IF NOT EXISTS `ecs_virtual_card` (
`card_id` mediumint(8) NOT NULL AUTO_INCREMENT COMMENT '虚拟卡卡号自增id',
`goods_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '该虚拟卡对应的商品id，取值于表ecs_goods',
`card_sn` varchar(60) NOT NULL COMMENT '加密后的卡号',
`card_password` varchar(60) NOT NULL COMMENT '加密后的密码',
`add_date` int(11) NOT NULL DEFAULT '0' COMMENT '卡号添加日期',
`end_date` int(11) NOT NULL DEFAULT '0' COMMENT '卡号截至使用日期',
`is_saled` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否卖出，0，否；1，是',
`order_sn` varchar(20) NOT NULL COMMENT '卖出该卡号的交易号，取值表ecs_order_info',
`crc32` int(11) NOT NULL DEFAULT '0' COMMENT 'crc32后的key',
PRIMARY KEY (`card_id`),
KEY `goods_id` (`goods_id`),
KEY `car_sn` (`card_sn`),
KEY `is_saled` (`is_saled`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='虚拟卡卡号库' AUTO_INCREMENT=8 ;
-- ------------------------------------------------------
-- 表的结构 `ecs_vote`
CREATE TABLE IF NOT EXISTS `ecs_vote` (
`vote_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT '在线调查自增id',
`vote_name` varchar(250) NOT NULL COMMENT '在线调查主题',
`start_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '在线调查开始时间',
`end_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '在线调查结束时间',
`can_multi` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '能否多选，0，可以；1，不可以',
`vote_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '投票人数也可以说投票次数',
PRIMARY KEY (`vote_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='网站调查信息记录表' AUTO_INCREMENT=3 ;
-- ------------------------------------------------------
-- 表的结构 `ecs_vote_log`
CREATE TABLE IF NOT EXISTS `ecs_vote_log` (
`log_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '投票记录自增id',
`vote_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '关联的投票主题id，取值表ecs_vote',
`ip_address` varchar(15) NOT NULL COMMENT '投票的ip地址',
`vote_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '投票的时间',
PRIMARY KEY (`log_id`),
KEY `vote_id` (`vote_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='投票记录表' AUTO_INCREMENT=5 ;
-- ------------------------------------------------------
-- 表的结构 `ecs_vote_option`
CREATE TABLE IF NOT EXISTS `ecs_vote_option` (
`option_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT '投票选项自增id',
`vote_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '关联的投票主题id，取值表ecs_vote',
`option_name` varchar(250) NOT NULL COMMENT '投票选项的值',
`option_count` int(8) unsigned NOT NULL DEFAULT '0' COMMENT '该选项的票数',
PRIMARY KEY (`option_id`),
KEY `vote_id` (`vote_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='投票的选项内容表' AUTO_INCREMENT=8 ;
-- ------------------------------------------------------
-- 表的结构 `ecs_wholesale`
CREATE TABLE IF NOT EXISTS `ecs_wholesale` (
`act_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '批发方案自增id',
`goods_id` mediumint(8) unsigned NOT NULL COMMENT '商品id',
`goods_name` varchar(255) NOT NULL COMMENT '商品名称',
`rank_ids` varchar(255) NOT NULL COMMENT '适用会员登记，多个值之间用逗号分隔，取值于ecs_user_rank',
`prices` text NOT NULL COMMENT '序列化后的商品属性，数量，价格',
`enabled` tinyint(3) unsigned NOT NULL COMMENT '批发方案是否可用',
PRIMARY KEY (`act_id`),
KEY `goods_id` (`goods_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='批发方案表' AUTO_INCREMENT=3 ;