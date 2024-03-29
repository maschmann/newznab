 
<h1>Browse {$catname}</h1>

<form name="browseby" action="movies">
<table class="rndbtn" border="0" cellpadding="2" cellspacing="0">
	<tr>
		<th class="left"><label for="movietitle">Title</label></th>
		<th class="left"><label for="movieactors">Actor</label></th>
		<th class="left"><label for="moviedirector">Director</label></th>
		<th class="left"><label for="rating">Rating</label></th>
		<th class="left"><label for="genre">Genre</label></th>
		<th class="left"><label for="year">Year</label></th>
		<th class="left"><label for="category">Category</label></th>
		<th></th>
	</tr>
	<tr>
		<td><input id="movietitle" type="text" name="title" value="{$title}" size="15" /></td>
		<td><input id="movieactors" type="text" name="actors" value="{$actors}" size="15" /></td>
		<td><input id="moviedirector" type="text" name="director" value="{$director}" size="15" /></td>
		<td>
			<select id="rating" name="rating">
			<option class="grouping" value=""></option>
			{foreach from=$ratings item=rate}
				<option {if $rating==$rate}selected="selected"{/if} value="{$rate}">{$rate}</option>
			{/foreach}
			</select>
		</td>
		<td>
			<select id="genre" name="genre">
			<option class="grouping" value=""></option>
			{foreach from=$genres item=gen}
				<option {if $gen==$genre}selected="selected"{/if} value="{$gen}">{$gen}</option>
			{/foreach}
			</select>
		</td>
		<td>
			<select id="year" name="year">
			<option class="grouping" value=""></option>
			{foreach from=$years item=yr}
				<option {if $yr==$year}selected="selected"{/if} value="{$yr}">{$yr}</option>
			{/foreach}
			</select>
		</td>
		<td>
			<select id="category" name="t">
			<option class="grouping" value="2000"></option>
			{foreach from=$catlist item=ct}
				<option {if $ct.ID==$category}selected="selected"{/if} value="{$ct.ID}">{$ct.title}</option>
			{/foreach}
			</select>
		</td>
		<td><input type="submit" value="Go" /></td>
	</tr>
</table>
</form>
<p></p>

{if $results|@count > 0}

<form id="nzb_multi_operations_form" action="get">

<div class="nzb_multi_operations">
	View: <b>Covers</b> | <a href="{$smarty.const.WWW_TOP}/browse?t={$category}">List</a><br />
	<small>With Selected:</small>
	<input type="button" class="nzb_multi_operations_download" value="Download NZBs" />
	<input type="button" class="nzb_multi_operations_cart" value="Add to Cart" />
	<input type="button" class="nzb_multi_operations_sab" value="Send to SAB" />
</div>
<br/>

{$pager}

<table style="width:100%;" class="data highlight icons" id="coverstable">
	<tr>
		<th width="130"><input type="checkbox" class="nzb_check_all" /></th>
		<th>title<br/><a title="Sort Descending" href="{$orderbytitle_desc}"><img src="{$smarty.const.WWW_TOP}/views/images/sorting/arrow_down.gif" alt="" /></a><a title="Sort Ascending" href="{$orderbytitle_asc}"><img src="{$smarty.const.WWW_TOP}/views/images/sorting/arrow_up.gif" alt="" /></a></th>
		<th>year<br/><a title="Sort Descending" href="{$orderbyyear_desc}"><img src="{$smarty.const.WWW_TOP}/views/images/sorting/arrow_down.gif" alt="" /></a><a title="Sort Ascending" href="{$orderbyyear_asc}"><img src="{$smarty.const.WWW_TOP}/views/images/sorting/arrow_up.gif" alt="" /></a></th>
		<th>rating<br/><a title="Sort Descending" href="{$orderbyrating_desc}"><img src="{$smarty.const.WWW_TOP}/views/images/sorting/arrow_down.gif" alt="" /></a><a title="Sort Ascending" href="{$orderbyrating_asc}"><img src="{$smarty.const.WWW_TOP}/views/images/sorting/arrow_up.gif" alt="" /></a></th>
	</tr>

	{foreach from=$results item=result}
		<tr class="{cycle values=",alt"}">
			<td class="mid">
				<div class="movcover">
				<a target="_blank" href="{$site->dereferrer_link}http://www.imdb.com/title/tt{$result.imdbID}/" name="name{$result.imdbID}" title="View movie info" class="modal_imdb" rel="movie" >
					<img class="shadow" src="{$smarty.const.WWW_TOP}/covers/movies/{if $result.cover == 1}{$result.imdbID}-cover.jpg{else}no-cover.jpg{/if}" width="120" border="0" alt="{$result.title|escape:"htmlall"}" />
				</a>
				<div class="movextra">
					<a target="_blank" href="{$site->dereferrer_link}http://www.imdb.com/title/tt{$result.imdbID}/" name="name{$result.imdbID}" title="View movie info" class="rndbtn modal_imdb" rel="movie" >Cover</a>
					<a class="rndbtn" target="_blank" href="{$site->dereferrer_link}http://www.imdb.com/title/tt{$result.imdbID}/" name="imdb{$result.imdbID}" title="View imdb page">Imdb</a>
				</div>
				</div>
			</td>
			<td colspan="3" class="left">
				<h2>{$result.title|escape:"htmlall"} (<a class="title" title="{$result.year}" href="{$smarty.const.WWW_TOP}/movies?year={$result.year}">{$result.year}</a>) {if $result.rating != ''}{$result.rating}/10{/if}</h2>
				{if $result.tagline != ''}<b>{$result.tagline}</b><br />{/if}
				{if $result.plot != ''}{$result.plot}<br /><br />{/if}
				{if $result.genre != ''}<b>Genre:</b> {$result.genre}<br />{/if}
				{if $result.director != ''}<b>Director:</b> {$result.director}<br />{/if}
				{if $result.actors != ''}<b>Starring:</b> {$result.actors}<br /><br />{/if}
				<div class="movextra">
					<table>
						{assign var="msplits" value=","|explode:$result.grp_release_id}
						{assign var="mguid" value=","|explode:$result.grp_release_guid}
						{assign var="mnfo" value=","|explode:$result.grp_release_nfoID}
						{assign var="mgrp" value=","|explode:$result.grp_release_grpname}
						{assign var="mname" value="#"|explode:$result.grp_release_name}
						{assign var="mpostdate" value=","|explode:$result.grp_release_postdate}
						{assign var="msize" value=","|explode:$result.grp_release_size}
						{assign var="mtotalparts" value=","|explode:$result.grp_release_totalparts}
						{assign var="mcomments" value=","|explode:$result.grp_release_comments}
						{assign var="mgrabs" value=","|explode:$result.grp_release_grabs}
						{foreach from=$msplits item=m}
						<tr id="guid{$mguid[$m@index]}" {if $m@index > 1}class="mlextra"{/if}>
							<td>
								<div class="icon"><input type="checkbox" class="nzb_check" value="{$mguid[$m@index]}" /></div>							
							</td>
							<td>
								<a href="{$smarty.const.WWW_TOP}/details/{$mguid[$m@index]}/{$mname[$m@index]|escape:"htmlall"}">{$mname[$m@index]|escape:"htmlall"}</a>
								<div>
								Posted {$mpostdate[$m@index]|timeago},  {$msize[$m@index]|fsize_format:"MB"},  <a title="View file list" href="{$smarty.const.WWW_TOP}/filelist/{$mguid[$m@index]}">{$mtotalparts[$m@index]} files</a>,  <a title="View comments for {$mname[$m@index]|escape:"htmlall"}" href="{$smarty.const.WWW_TOP}/details/{$mguid[$m@index]}/{$mname[$m@index]|escape:"htmlall"}#comments">{$mcomments[$m@index]} cmt{if $mcomments[$m@index] != 1}s{/if}</a>, {$mgrabs[$m@index]} grab{if $mgrabs[$m@index] != 1}s{/if},								
								{if $mnfo[$m@index] > 0}<a href="{$smarty.const.WWW_TOP}/nfo/{$mguid[$m@index]}" title="View Nfo" class="modal_nfo" rel="nfo">Nfo</a>, {/if}
								<a href="{$smarty.const.WWW_TOP}/browse?g={$mgrp[$m@index]}" title="Browse releases in {$mgrp[$m@index]|replace:"alt.binaries":"a.b"}">Grp</a>
								</div>
							</td>
							<td class="icons">
								<div class="icon icon_nzb"><a title="Download Nzb" href="{$smarty.const.WWW_TOP}/getnzb/{$mguid[$m@index]}/{$mname[$m@index]|escape:"htmlall"}">&nbsp;</a></div>
								<div class="icon icon_cart" title="Add to Cart"></div>
								<div class="icon icon_sab" title="Send to my Sabnzbd"></div>
							</td>
						</tr>
						{if $m@index == 1 && $m@total > 2}
							<tr><td colspan="5"><a class="mlmore" href="#">{$m@total-2} more...</a></td></tr>
						{/if}
						{/foreach}		
					</table>
				</div>
			</td>
		</tr>
	{/foreach}
	
</table>

<br/>

{$pager}

<div class="nzb_multi_operations">
	<small>With Selected:</small>
	<input type="button" class="nzb_multi_operations_download" value="Download NZBs" />
	<input type="button" class="nzb_multi_operations_cart" value="Add to Cart" />
	<input type="button" class="nzb_multi_operations_sab" value="Send to SAB" />
</div>

</form>

{/if}

<br/><br/><br/>
