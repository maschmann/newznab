<?php
require_once(WWW_DIR."/lib/site.php");

if ($users->isLoggedIn())
	$page->show404();

$showregister = 1;	
	
if ($page->site->registerstatus == Sites::REGISTER_STATUS_CLOSED)
{
	$page->smarty->assign('error', "Registrations are currently disabled.");
	$showregister = 0;	
}
elseif ($page->site->registerstatus == Sites::REGISTER_STATUS_INVITE && !(isset($_GET["invite"]) || isset($_POST["invitecode"])))
{
	$page->smarty->assign('error', "Registrations are currently invite only.");
	$showregister = 0;	
}

if ($showregister == 0)
{
	$page->smarty->assign('showregister', "0");
}
else
{	

	$action = isset($_REQUEST['action']) ? $_REQUEST['action'] : 'view';

	switch($action) 
	{
		case 'submit':
			
			$page->smarty->assign('username', $_POST['username']);
			$page->smarty->assign('password', $_POST['password']);
			$page->smarty->assign('confirmpassword', $_POST['confirmpassword']);
			$page->smarty->assign('email', $_POST['email']);
			$page->smarty->assign('invitecode', $_POST["invitecode"]);
			
			//
			// check uname/email isnt in use, password valid.
			// if all good create new user account and redirect back to home page
			//
			if ($_POST['password'] != $_POST['confirmpassword'])
			{
				$page->smarty->assign('error', "Password Mismatch");
			}
			else
			{
				$ret = $users->signup($_POST['username'], $_POST['password'], $_POST['email'], $_SERVER['REMOTE_ADDR'], Users::ROLE_USER, Users::DEFAULT_INVITES, $_POST['invitecode']);
				if ($ret > 0)
				{
					$users->login($ret, $_SERVER['REMOTE_ADDR']);
					header("Location: ".WWW_TOP."/");
				}
				else
				{
					switch ($ret)
					{
						case Users::ERR_SIGNUP_BADUNAME:
							$page->smarty->assign('error', "Your username must be longer than three characters.");
							break;
						case Users::ERR_SIGNUP_BADPASS:
							$page->smarty->assign('error', "Your password must be longer than five characters.");
							break;
						case Users::ERR_SIGNUP_BADEMAIL:
							$page->smarty->assign('error', "Your email is not a valid format.");
							break;
						case Users::ERR_SIGNUP_UNAMEINUSE:
							$page->smarty->assign('error', "Sorry, the username is already taken.");
							break;
						case Users::ERR_SIGNUP_EMAILINUSE:
							$page->smarty->assign('error', "Sorry, the email is already in use.");
							break;
						case Users::ERR_SIGNUP_BADINVITECODE:
							$page->smarty->assign('error', "Sorry, the invite code is old or has been used.");
							break;
						default:
							$page->smarty->assign('error', "Failed to register.");
							break;
					}
				}
			}
			break;
			case "view":
			{
				if (isset($_GET["invite"]))
				{
					//
					// see if its a valid invite
					//
					$invite = $users->getInvite($_GET["invite"]);
					if (!$invite)
					{
						$page->smarty->assign('error', sprintf("Bad or invite code older than %d days.", Users::DEFAULT_INVITE_EXPIRY_DAYS));
						$page->smarty->assign('showregister', "0");
					}
					else
					{
						$page->smarty->assign('invitecode', $invite["guid"]);
					}
				}
				break;
			}
	}
}

$page->meta_title = "Register";
$page->meta_keywords = "register,signup,registration";
$page->meta_description = "Register";

$page->content = $page->smarty->fetch('register.tpl');
$page->render();

?>