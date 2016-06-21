Received: from mx1.redhat.com ([209.132.183.28]:41162 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751501AbcFUMBc (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 21 Jun 2016 08:01:32 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 86AB763E12
	for <fstests@vger.kernel.org>; Tue, 21 Jun 2016 12:01:31 +0000 (UTC)
Date: Tue, 21 Jun 2016 20:01:29 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] xfs/186: fix test for crc=0, ftype=1
Message-ID: <20160621120129.GW5140@eguan.usersys.redhat.com>
References: <cf27c5c1-65ea-ef8b-c06c-cf4af1520d39@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf27c5c1-65ea-ef8b-c06c-cf4af1520d39@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eric Sandeen <sandeen@redhat.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Fri, Jun 17, 2016 at 12:54:43PM -0500, Eric Sandeen wrote:
> Test 186 won't run when crcs are enabled, because
> attrv1 is not allowed with crc=1.
> 
> However, ftype is still allowed with crc=0, so
> this creates v3 directories, and xfs_db prints
> them as such (along with the filetype), which
> breaks the test output.
> 
> We can filter & replace to fix up the test in
> this case.
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>

This fixes the problems I hit, and it looks fine to me.

But xfs/186 still fails with MKFS_OPTIONS="-m crc=1 -b size=512", but
that's a different issue, I'll send another patch to fix it.

Thanks,
Eryu

> ---
> 
> diff --git a/tests/xfs/186 b/tests/xfs/186
> index 8e18975..cf66623 100755
> --- a/tests/xfs/186
> +++ b/tests/xfs/186
> @@ -76,12 +76,17 @@ _rmv_eas()
>  	done
>  }
>  
> +# If filetype is available (-n ftype=1) will get v3 dirs;
> +# just filter/replace to make this look teh same as if we
> +# had v2 dirs, as we are not interested in this info.
>  _filter_inode()
>  {
>  	tee -a $seqres.full | \
>  		sed -e "s/core.forkoff/forkoff/g" | \
> -		egrep '^u.sfdir2|^a.sfattr|forkoff' | \
> -		egrep -v 'inumber|parent'
> +		egrep '^u.sfdir2|^u.sfdir3|^a.sfattr|forkoff' | \
> +		egrep -v 'inumber|parent' | \
> +		sed -e s/sfdir3/sfdir2/g | \
> +		grep -v filetype
>  }
>  
>  _filter_version()
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
