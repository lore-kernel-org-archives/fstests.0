Received: from mx1.redhat.com ([209.132.183.28]:50332 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750929AbcGUGz2 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 21 Jul 2016 02:55:28 -0400
Date: Thu, 21 Jul 2016 14:55:26 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH 2/2] generic/130: Improve xfs_io filter
Message-ID: <20160721065526.GB27776@eguan.usersys.redhat.com>
References: <1469081856-6424-1-git-send-email-jack@suse.cz>
 <1469081856-6424-2-git-send-email-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1469081856-6424-2-git-send-email-jack@suse.cz>
Sender: fstests-owner@vger.kernel.org
To: Jan Kara <jack@suse.cz>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Jul 21, 2016 at 08:17:36AM +0200, Jan Kara wrote:
> On my test setup xfs_io reports 'nan' in bytes/s and ops/s fields when
> the operation takes zero time. Account for that in _filter_xfs_io.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  common/filter | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/common/filter b/common/filter
> index b229a97dfa0e..37f07c8ca1ac 100644
> --- a/common/filter
> +++ b/common/filter
> @@ -221,7 +221,7 @@ common_line_filter()
>  
>  _filter_xfs_io()
>  {
> -    sed -e "s/[0-9/.]* [GMKiBbytes]*, [0-9]* ops\; [0-9/:. sec]* ([inf0-9/.]* [EPGMKiBbytes]*\/sec and [inf0-9/.]* ops\/sec)/XXX Bytes, X ops\; XX:XX:XX.X (XXX YYY\/sec and XXX ops\/sec)/"
> +    sed -e "s/[0-9/.]* [GMKiBbytes]*, [0-9]* ops\; [0-9/:. sec]* ([infnan0-9/.]* [EPGMKiBbytes]*\/sec and [infnan0-9/.]* ops\/sec)/XXX Bytes, X ops\; XX:XX:XX.X (XXX YYY\/sec and XXX ops\/sec)/"

Seems adding only 'a' to the char set is sufficient, 'n' is already in
the set, i.e.

- ...([inf0-9/.]* ...
+ ...([infa0-9/.]* ...

Thanks,
Eryu
