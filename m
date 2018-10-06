Received: from mail-pl1-f196.google.com ([209.85.214.196]:41150 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727161AbeJFS2G (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 6 Oct 2018 14:28:06 -0400
Date: Sat, 6 Oct 2018 19:25:07 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH v2 3/9] geneirc/077 fix min size for btrfs
Message-ID: <20181006112507.GL17817@desktop>
References: <1537849462-619-1-git-send-email-anand.jain@oracle.com>
 <1537849462-619-4-git-send-email-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537849462-619-4-git-send-email-anand.jain@oracle.com>
Sender: fstests-owner@vger.kernel.org
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Sep 25, 2018 at 12:24:16PM +0800, Anand Jain wrote:
> If btrfs need to be tested at its default blockgroup which is non-mixed,
> then it needs at least 256mb.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

(Sorry for the late review..)

> ---
>  tests/generic/077 | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/tests/generic/077 b/tests/generic/077
> index ef6af18c83e3..ec236992513f 100755
> --- a/tests/generic/077
> +++ b/tests/generic/077
> @@ -49,8 +49,7 @@ rm -f $seqres.full
>  _scratch_unmount >/dev/null 2>&1
>  echo "*** MKFS ***"                         >>$seqres.full
>  echo ""                                     >>$seqres.full
> -SIZE=`expr 50 \* 1024 \* 1024`
> -_scratch_mkfs_sized $SIZE                   >>$seqres.full 2>&1 \
> +_scratch_mkfs_sized $((256 * 1024 *1024))   >>$seqres.full 2>&1 \
>  	|| _fail "mkfs failed"

Hmm, this test copies "/lib/modules/" to fill the original 50M
filesystem (which seems a bad way to me)

"
# Something w/ enough data to fill 50M of fs...
filler=/lib/modules/
...
echo "*** populate filesystem, pass #1" | tee -a $seqres.full
cp -rf $filler $SCRATCH_MNT/subdir >$seqres.full 2>&1
...
"

It works most of the time as "/lib/modules" is usually larger than 50M,
but it may not fullfil the fs with 256M size.

I think we should fix the way to fill the fs too.

Thanks,
Eryu

>  _scratch_mount
>  mkdir $SCRATCH_MNT/subdir
> -- 
> 1.8.3.1
> 
