 
<h1>Profile for {$user.username|escape:"htmlall"}</h1>

<table class="data">
	<tr><th>Username:</th><td>{$user.username|escape:"htmlall"}</td></tr>
	{if $user.ID==$userdata.ID || $userdata.role==2}<tr><th title="Not public">Email:</th><td>{$user.email}</td></tr>{/if}
	<tr><th>Registered:</th><td title="{$user.createddate}">{$user.createddate|date_format}  ({$user.createddate|timeago} ago)</td></tr>
	<tr><th>Last Login:</th><td title="{$user.lastlogin}">{$user.lastlogin|date_format}  ({$user.lastlogin|timeago} ago)</td></tr>
	{if $user.ID==$userdata.ID || $userdata.role==2}<tr><th title="Not public">Site Api/Rss Key:</th><td><a href="{$smarty.const.WWW_TOP}/rss?t=0&amp;dl=1&amp;i={$userdata.ID}&amp;r={$userdata.rsstoken}">{$user.rsstoken}</a></td></tr>{/if}
	<tr><th>Grabs:</th><td>{$user.grabs}</td></tr>
	
	{if ($user.ID==$userdata.ID || $userdata.role==2) && $site->registerstatus==1}
	<tr>
		<th title="Not public">Invites:</th>
		<td>{$user.invites} 
		{if $user.invites > 0}
			[<a id="lnkSendInvite" onclick="return false;" href="#">Send Invite</a>]
			<span title="Your invites will be reduced when the invitation is claimed." class="invitesuccess" id="divInviteSuccess">Invite Sent</span>
			<span class="invitefailed" id="divInviteError"></span>
			<div style="display:none;" id="divInvite">
				<form id="frmSendInvite" method="GET">
					<label for="txtInvite">Email</label>:
					<input type="text" id="txtInvite" />
					<input type="submit" value="Send"/>
				</form>
			</div>
		{/if}
		</td>
	</tr>
	{/if}
	
	{if $userinvitedby.username != ""}
	<tr><th>Invited By:</th><td><a title="View {$userinvitedby.username}'s profile" href="{$smarty.const.WWW_TOP}/profile?name={$userinvitedby.username}">{$userinvitedby.username}</a></td>
	{/if}
	
	<tr><th>UI Preferences:</th>
		<td>
			{if $user.movieview == "1"}View movie covers{else}View standard movie category{/if}<br/>
			{if $user.musicview == "1"}View music covers{else}View standard music category{/if}<br/>
			{if $user.consoleview == "1"}View console covers{else}View standard console category{/if}
		</td>
	</tr>
	{if $user.ID==$userdata.ID || $userdata.role==2}<tr><th title="Not public">Excluded Categories:</th><td>{$exccats|replace:",":"<br/>"}</td></tr>{/if}
	{if $user.ID==$userdata.ID}<tr><th></th><td><a href="{$smarty.const.WWW_TOP}/profileedit">Edit</a></td></tr>{/if}
</table>

{if $commentslist|@count > 0}
<div style="padding-top:20px;">
	<a id="comments"></a>
	<h2>Comments</h2>

	{$pager}

	<table style="margin-top:10px;" class="data Sortable">

		<tr>
			<th>date</th>
			<th>comment</th>
		</tr>

		
		{foreach from=$commentslist item=comment}
		<tr>
			<td width="80" title="{$comment.createddate}">{$comment.createddate|date_format}</td>
			<td>{$comment.text|escape:"htmlall"|nl2br}</td>
		</tr>
		{/foreach}
	</table>
</div>
{/if}