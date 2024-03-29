<?php

require_once("config.php");
require_once(WWW_DIR."/lib/adminpage.php");
require_once(WWW_DIR."/lib/releases.php");

$page = new AdminPage();

$releases = new Releases();

$page->title = "Comments List";

$commentcount = $releases->getCommentCount();
$offset = isset($_REQUEST["offset"]) ? $_REQUEST["offset"] : 0;
$page->smarty->assign('pagertotalitems',$commentcount);
$page->smarty->assign('pageroffset',$offset);
$page->smarty->assign('pageritemsperpage',ITEMS_PER_PAGE);
$page->smarty->assign('pagerquerybase', WWW_TOP."/comments-list.php?offset=");
$pager = $page->smarty->fetch($page->getCommonTemplate("pager.tpl"));
$page->smarty->assign('pager', $pager);

$commentslist = $releases->getCommentsRange($offset, ITEMS_PER_PAGE);
$page->smarty->assign('commentslist',$commentslist);	

$page->content = $page->smarty->fetch('comments-list.tpl');
$page->render();

?>
