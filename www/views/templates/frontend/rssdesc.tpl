 
			<h1>{$page->title}</h1>

			<p>
				Here you can choose rss feeds from site categories. The feeds will present either decriptions or 
				downloads of Nzb files.
			</p>
			
			<ul>
				<li>
					Add this string to your feed URL to allow NZB downloads without logging in: <span style="font-family:courier;">&amp;i={$userdata.ID}&amp;r={$userdata.rsstoken}</span>
				</li>
				<li>
					To remove the nzb from your cart after download add this string to your feed URL: <span style="font-family:courier;">&amp;del=1</span> 
				</li>
				<li>
					To change the default link to download an nzb: <span style="font-family:courier;">&amp;dl=1</span>
				</li>
				<li>
					To change the number of results (default is 25, max is 100) returned: <span style="font-family:courier;">&amp;num=50</span> 
				</li>
			</ul>
			
			<p>
				Most Nzb clients which support Nzb rss feeds will appreciate the full URL, with download link and your user token.
			</p>
			
			<p>
				The feeds include additional attributes to help provide better filtering in your Nzb client, such as size, group and categorisation. If you want to chain multiple categories together or do more advanced searching, use the <a href="{$smarty.const.WWW_TOP}/apihelp">api</a>, which returns its data in an rss compatible format.
			</p>
			
			<h2>Available Feeds</h2>
			<h3>General</h3>
			<ul style="text-align: left;">
				<li>
					Full site feed<br/>
					<a href="{$smarty.const.WWW_TOP}/rss?t=0&amp;dl=1&amp;i={$userdata.ID}&amp;r={$userdata.rsstoken}">{$smarty.const.WWW_TOP}/rss?t=0&amp;dl=1&amp;i={$userdata.ID}&amp;r={$userdata.rsstoken}</a>
				</li>
				<li>
					My cart feed<br/>
					<a href="{$smarty.const.WWW_TOP}/rss?t=-2&amp;dl=1&amp;i={$userdata.ID}&amp;r={$userdata.rsstoken}&amp;del=1">{$smarty.const.WWW_TOP}/rss?t=-2&amp;dl=1&amp;i={$userdata.ID}&amp;r={$userdata.rsstoken}&amp;del=1</a>
				</li>

			</ul>
			<h3>Parent Category</h3>
			<ul style="text-align: left;">
				{foreach from=$parentcategorylist item=category}
					<li>
						{$category.title} feed <br/>
						<a href="{$smarty.const.WWW_TOP}/rss?t={$category.ID}&amp;dl=1&amp;i={$userdata.ID}&amp;r={$userdata.rsstoken}">{$smarty.const.WWW_TOP}/rss?t={$category.ID}&amp;dl=1&amp;i={$userdata.ID}&amp;r={$userdata.rsstoken}</a>
					</li>
				{/foreach}

			</ul>
			<h3>Sub Category</h3>
			<ul style="text-align: left;">

				{foreach from=$categorylist item=category}
					<li>
						{$category.title} feed <br/>
						<a href="{$smarty.const.WWW_TOP}/rss?t={$category.ID}&amp;dl=1&amp;i={$userdata.ID}&amp;r={$userdata.rsstoken}">{$smarty.const.WWW_TOP}/rss?t={$category.ID}&amp;dl=1&amp;i={$userdata.ID}&amp;r={$userdata.rsstoken}</a>
					</li>
				{/foreach}
			</ul>
			
			<h2>Additional Feeds</h2>
			<ul style="text-align: left;">
				<li>
					Tv Series Feed (Use the tv rage id)<br/>
					<a href="{$smarty.const.WWW_TOP}/rss?rage=1234&amp;dl=1&amp;i={$userdata.ID}&amp;r={$userdata.rsstoken}">{$smarty.const.WWW_TOP}/rss/?rage=1234&amp;dl=1&amp;i={$userdata.ID}&amp;r={$userdata.rsstoken}</a>
				</li>
			</ul>
