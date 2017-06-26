Received: from mx1.redhat.com ([209.132.183.28]:52154 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751656AbdFZD7c (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 25 Jun 2017 23:59:32 -0400
Date: Mon, 26 Jun 2017 11:59:27 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] generic/401: Test mountpoint not subdir for filetype
 support
Message-ID: <20170626035927.GQ23360@eguan.usersys.redhat.com>
References: <8b64d345-4dbd-cf14-bf57-58b67c8115cd@redhat.com>
 <63bb7dca-e407-abea-e432-2e946a8fd435@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63bb7dca-e407-abea-e432-2e946a8fd435@sandeen.net>
Sender: fstests-owner@vger.kernel.org
To: Eric Sandeen <sandeen@sandeen.net>
Cc: Eric Sandeen <sandeen@redhat.com>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Fri, Jun 23, 2017 at 11:12:41AM -0500, Eric Sandeen wrote:
> With pending changes for xfs_info/xfs_growfs, the tool
> now requires an actual mount point to work properly.
> 
> Change this test to test $SCRATCH_MNT not the subdir
> beneath it.
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> ---
> 
> Sorry, forgot [PATCH], adding to make sure Eryu sees it.

Thanks! Saw it :)

Eryu

> 
> diff --git a/tests/generic/401 b/tests/generic/401
> index 04bd1a5..74f2bea 100755
> --- a/tests/generic/401
> +++ b/tests/generic/401
> @@ -79,7 +79,7 @@ mknod $testdir/p p
>  src/t_dir_type $testdir d | grep -F '.' | sort
>  
>  # Test that either all file types are unknown or all are correct
> -if _supports_filetype $testdir; then
> +if _supports_filetype $SCRATCH_MNT; then
>  	# print real file types
>  	src/t_dir_type $testdir | grep -vF '.' | sort
>  else
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
