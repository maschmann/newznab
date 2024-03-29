 
<h1>{$page->title}</h1>

<h2>For <a href="{$smarty.const.WWW_TOP}/details/{$rel.guid}/{$rel.searchname|escape:"htmlall"}">{$rel.searchname|escape:'htmlall'}</a></h2>

<table style="width:100%;margin-bottom:10px;" class="data Sortable highlight">

	<tr>
		<th>#</th>
		<th>filename</th>
		<th></th>
		<th style="text-align:center;">completion</th>
		<th style="text-align:center;">size</th>
	</tr>

	{foreach item=i name=iteration from=$files item=file}
	<tr class="{cycle values=",alt"}">
		<td width="20">{$smarty.foreach.iteration.index+1}</td>
		<td>{$file.title|escape:'htmlall'}</td>
		
		{assign var="icon" value='views/images/fileicons/'|cat:$file.ext|cat:".png"} 
		{if $file.ext == "" || !is_file("$icon")}
			{assign var="icon" value='file'}
		{else}
			{assign var="icon" value=$file.ext}
		{/if}
		
		{assign var="completion" value=($file.partsactual/$file.partstotal*100)|number_format:1}
		
		<td><img title=".{$file.ext}" alt="{$file.ext}" src="{$smarty.const.WWW_TOP}/views/images/fileicons/{$icon}.png" /></td>
		<td class="less right">{if $completion < 100}<span class="warning">{$completion}%</span>{else}{$completion}%{/if}</td>
		<td class="less right">{if $file.size < 100000}{$file.size|fsize_format:"KB"}{else}{$file.size|fsize_format:"MB"}{/if}</td>
	</tr>
	{/foreach}

</table>	

