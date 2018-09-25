Received: from mx2.suse.de ([195.135.220.15]:48074 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726435AbeIYRCL (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 25 Sep 2018 13:02:11 -0400
Subject: Re: [PATCH v2 2/9] generic/015 fix to test the default non-mixed mode
References: <1537849462-619-1-git-send-email-anand.jain@oracle.com>
 <1537849462-619-3-git-send-email-anand.jain@oracle.com>
From: Nikolay Borisov <nborisov@suse.com>
Message-ID: <a84533e1-2f93-4b2f-4d20-6a9c6e27aca2@suse.com>
Date: Tue, 25 Sep 2018 13:55:08 +0300
MIME-Version: 1.0
In-Reply-To: <1537849462-619-3-git-send-email-anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Anand Jain <anand.jain@oracle.com>, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>



On 25.09.2018 07:24, Anand Jain wrote:
> commit 97575acd7495 (generic/015: Change the test filesystem size to
> 101mb), created 101mb FS instead of 100mb FS to make sure we create
> a FS which is non mixed mode.
> 
> btrfs-progs commit 18e2663db3e1 (btrfs-progs: Add minimum device size
> check) added a more accurate minimum required space to create the btrfs
> FS in non mixed mode depending on the group profile, and considering
> any group profiles we would need at least 256MB (with upward round off).
> 
> So this patch changes the FS size to be created by _scratch_sized_mkfs()
> to 256MB so that we create the FS in non mixed mode for any group
> profile.
> 
> Mixed blockgroup can be tested using the MKFS_OPTIONS explicitly.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  tests/generic/015 | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/tests/generic/015 b/tests/generic/015
> index 0f4d29800f4f..e6c8d7c37c07 100755
> --- a/tests/generic/015
> +++ b/tests/generic/015
> @@ -37,11 +37,9 @@ _supported_os Linux
>  _require_scratch
>  _require_no_large_scratch_dev
>  
> -# With filesystems less than 100mb btrfs is created in mixed mode
> -# which can lead to slight accounting errors of 1mb. Having the
> -# fs be at least 101 mb ensures those errors are within the error
> -# tolerance of 1%
> -_scratch_mkfs_sized `expr 101 \* 1024 \* 1024` >/dev/null 2>&1 \
> +# btrfs needs at least 256MB (with upward round off) to create a non-mixed mode
> +# fs. Ref: btrfs-progs: btrfs_min_dev_size()
> +_scratch_mkfs_sized $((256 * 1024 * 1024)) >> $seqres.full 2>&1 \

Yeah, this test seems rather flaky with mixed block groups I had fixed
it and then Omar changed the mixed bg threshold to 1g and it started
failing again internally. I'm happy with this change provided the first
patch lands as well.

>      || _fail "mkfs failed"
>  _scratch_mount
>  out=$SCRATCH_MNT/fillup.$$
> 
