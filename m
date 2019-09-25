Received: from mail-pf1-f195.google.com ([209.85.210.195]:38821 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388199AbfIYNId (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 25 Sep 2019 09:08:33 -0400
Received: by mail-pf1-f195.google.com with SMTP id h195so3391594pfe.5
        for <fstests@vger.kernel.org>; Wed, 25 Sep 2019 06:08:32 -0700 (PDT)
Date: Wed, 25 Sep 2019 21:08:26 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH] generic/442: add sync before dmsetup remove
Message-ID: <20190925130824.GU2622@desktop>
References: <1569400158-5297-1-git-send-email-suyj.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1569400158-5297-1-git-send-email-suyj.fnst@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Su Yanjun <suyj.fnst@cn.fujitsu.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Sep 25, 2019 at 04:29:18PM +0800, Su Yanjun wrote:
> This test case sometime fails. Because "dmsetup remove error-test" may
> fail when some writeback is going on.
> 
> This patch adds sync before dmsetup remove operation.
> 
> Signed-off-by: Su Yanjun <suyj.fnst@cn.fujitsu.com>
> ---
>  tests/generic/442 | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/generic/442 b/tests/generic/442
> index fe6d460..d48ca36 100755
> --- a/tests/generic/442
> +++ b/tests/generic/442
> @@ -43,6 +43,7 @@ $here/src/fsync-err -d $here/src/dmerror $DMERROR_DEV

fsync-err should have flipped $DMERROR_DEV to working mode and fsync
each open fd before exit if fsync-err didn't report any failure. So
there should be no on-going writeback.

>  
>  # success, all done
>  _dmerror_load_working_table
> +sync
>  _dmerror_cleanup

And _dmerror_cleanup umount $DMERROR_DEV first, then tear down the dm
device. Could you check if fsync-err returns successfully and umount
succeeds as well?

Thanks,
Eryu

>  _scratch_mkfs > $seqres.full 2>&1
>  status=0
> -- 
> 2.7.4
> 
> 
> 
