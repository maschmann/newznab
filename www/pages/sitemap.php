<?php
require_once(WWW_DIR."/lib/sitemaps.php");

$te = $page->smarty;

$arPages = array();

$arPages[] = buildURL("Home", "Home Page", "/", 'daily', '1.0');


$role=0;
if ($page->userdata != null)
	$role = $page->userdata["role"];

//
// useful links
//
$contents = new Contents();
$contentlist =  $contents->getForMenuByTypeAndRole(Contents::TYPEUSEFUL, $role);
foreach ($contentlist as $content)
{
	$arPages[] = buildURL("Useful Links", $content->title, '/content/'.$content->id.$content->url, 'monthly', '0.50');	
}

//
// articles
//
$contentlist =  $contents->getForMenuByTypeAndRole(Contents::TYPEARTICLE, $role);
foreach ($contentlist as $content)
{
	$arPages[] = buildURL("Articles", $content->title, '/content/'.$content->id.$content->url, 'monthly', '0.50');	
}

//
// static pages
//
$arPages[] = buildURL("Useful Links", "Contact Us", "/contact-us", 'yearly', '0.30');	
$arPages[] = buildURL("Useful Links", "Site Map", "/sitemap", 'weekly', '0.50');	
$arPages[] = buildURL("Useful Links", "Rss Feeds", "/rss", 'weekly', '0.50');	

$arPages[] = buildURL("Nzb", "Search Nzb", "/search", 'weekly', '0.50');	
$arPages[] = buildURL("Nzb", "Browse Nzb", "/browse", 'daily', '0.80');	



//
// echo appropriate site map
//
asort($arPages);
$page->smarty->assign('sitemaps',$arPages);	

if (isset($_GET["type"]) && $_GET["type"] == "xml")
{
	echo $page->smarty->fetch('sitemap-xml.tpl');
}
else
{
	$page->title = $page->site->title. " site map";
	$page->meta_title = $page->site->title. " site map";
	$page->meta_keywords = "sitemap,site,map";
	$page->meta_description = $page->site->title." site map shows all our pages.";
	$page->content = $page->smarty->fetch('sitemap.tpl');
	$page->render();
}

function buildURL($type, $name, $url, $freq='daily', $p='1.0')
{
	$s = new Sitemap($type, $name, $url, $freq, $p);
	return $s;
}

?>







