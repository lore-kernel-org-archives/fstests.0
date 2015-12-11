Received: from mx1.redhat.com ([209.132.183.28]:46163 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751395AbbLKJ0M (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 11 Dec 2015 04:26:12 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (Postfix) with ESMTPS id 11B1819CBD1
	for <fstests@vger.kernel.org>; Fri, 11 Dec 2015 09:26:12 +0000 (UTC)
Date: Fri, 11 Dec 2015 17:26:07 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH V2] xfs/242: remove open-coded check for "zero" command
Message-ID: <20151211092607.GU2535@eguan.usersys.redhat.com>
References: <56620046.7060101@redhat.com>
 <56620D66.9070108@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56620D66.9070108@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eric Sandeen <sandeen@redhat.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Fri, Dec 04, 2015 at 04:02:14PM -0600, Eric Sandeen wrote:
> We have helpers for this, no need to open-code it.
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>

Reviewed-by: Eryu Guan <eguan@redhat.com>

> ---
> 
> v2: clarify subject w/ "xfs/242"
> 
> diff --git a/tests/xfs/242 b/tests/xfs/242
> index 304e69f..4e1a8b4 100755
> --- a/tests/xfs/242
> +++ b/tests/xfs/242
> @@ -47,14 +47,7 @@ _supported_fs xfs
>  _supported_os Linux
>  _require_test
>  
> -_test_io_zero()
> -{
> -	$XFS_IO_PROG -c "zero help" 2>&1 | \
> -			grep 'command "zero" not found' > /dev/null
> -	echo $?
> -}
> -
> -[ $(_test_io_zero) -eq 0 ] && _notrun "zero command not supported"
> +_require_xfs_io_command "zero"
>  
>  testfile=$TEST_DIR/242.$$
>  
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
