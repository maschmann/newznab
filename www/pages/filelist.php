<?php
require_once(WWW_DIR."/lib/releases.php");
require_once(WWW_DIR."/lib/nzb.php");

$releases = new Releases;
$nzb = new Nzb;

if (!$users->isLoggedIn())
	$page->show403();

if (isset($_GET["id"]))
{
	$rel = $releases->getByGuid($_GET["id"]);
	if (!$rel)
		$page->show404();

	$nzbpath = $nzb->getNZBPath($_GET["id"], $page->site->nzbpath);

	if (!file_exists($nzbpath)) 
		$page->show404();

	ob_start();
	@readgzfile($nzbpath);
	$nzbfile = ob_get_contents();
	ob_end_clean();
		
	$ret = $nzb->nzbFileList($nzbfile);
		
	$page->smarty->assign('rel', $rel);
	$page->smarty->assign('files', $ret);

	$page->title = "File List";
	$page->meta_title = "View Nzb file list";
	$page->meta_keywords = "view,nzb,file,list,description,details";
	$page->meta_description = "View Nzb File List";
	
	$page->content = $page->smarty->fetch('viewfilelist.tpl');
	$page->render();
}

?>