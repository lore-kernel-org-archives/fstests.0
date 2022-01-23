Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB402C433F5
	for <linux-fstests@archiver.kernel.org>; Sun, 23 Jan 2022 13:09:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236418AbiAWNJc (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 23 Jan 2022 08:09:32 -0500
Received: from out20-73.mail.aliyun.com ([115.124.20.73]:35134 "EHLO
        out20-73.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236416AbiAWNJb (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 23 Jan 2022 08:09:31 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07486701|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0138616-0.00153715-0.984601;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047201;MF=guan@eryu.me;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.Mh9oRQn_1642943369;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.Mh9oRQn_1642943369)
          by smtp.aliyun-inc.com(10.147.44.118);
          Sun, 23 Jan 2022 21:09:30 +0800
Date:   Sun, 23 Jan 2022 21:09:29 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Yang Xu <xuyang2018.jy@fujitsu.com>
Cc:     djwong@kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH v3] xfs/12[4-6]: Add getfattr operation after xattr
 corrupted
Message-ID: <Ye1TiTOUdGoemiV9@desktop>
References: <20211126232817.GA266000@magnolia>
 <1642407736-3898-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1642407736-3898-1-git-send-email-xuyang2018.jy@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Jan 17, 2022 at 04:22:16PM +0800, Yang Xu wrote:
> Add getfattr operation in these three cases, we can also use xfs/126(corrupt a leaf
> xattr's data extent) to reproduce a deadlock. This deadlock is introduced by kernel
> commit 07120f1abdff ("xfs: Add xfs_has_attr and subroutines") and fixed by kernel

So this was introduced since 5.9 kernel, and

> commit a1de97fe296c ("xfs: Fix the free logic of state in xfs_attr_node_hasname").

fixed in 5.16 kernel.

And adding this regression test in xfs/126, which passed in the past.
probably would cause all the affected kernels in between start to hang,
and trigger a false positive regression alert.

So IMO it'd be better to make a separated & targeted regression test for
this case, as Darrick suggested.

Thanks,
Eryu

> 
> Also making getfattr operation after xattr corrupted is a common part, so we can
> test whether the similar deadlock occurs in the future in xfs/124(corrupt a block xattr)
> and xfs/125(corrupt a leaf xattr's index extent).
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>  tests/xfs/124 | 2 +-
>  tests/xfs/125 | 2 +-
>  tests/xfs/126 | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/xfs/124 b/tests/xfs/124
> index 39307218..c3cccfd5 100755
> --- a/tests/xfs/124
> +++ b/tests/xfs/124
> @@ -64,7 +64,7 @@ _scratch_xfs_db -x -c "inode ${inode}" -c 'ablock 0' -c "stack" -c "blocktrash -
>  
>  echo "+ mount image && modify xattr"
>  if _try_scratch_mount >> $seqres.full 2>&1; then
> -
> +	getfattr "${SCRATCH_MNT}/attrfile" -n "user.x00000000" 2> /dev/null && _fail "got corrupt xattr"
>  	setfattr -x "user.x00000000" "${SCRATCH_MNT}/attrfile" 2> /dev/null && _fail "modified corrupt xattr"
>  	umount "${SCRATCH_MNT}"
>  fi
> diff --git a/tests/xfs/125 b/tests/xfs/125
> index fb5f5695..a7eb51fb 100755
> --- a/tests/xfs/125
> +++ b/tests/xfs/125
> @@ -64,7 +64,7 @@ _scratch_xfs_db -x -c "inode ${inode}" -c 'ablock 0' -c "stack" -c "blocktrash -
>  
>  echo "+ mount image && modify xattr"
>  if _try_scratch_mount >> $seqres.full 2>&1; then
> -
> +	getfattr "${SCRATCH_MNT}/attrfile" -n "user.x00000000" 2> /dev/null && _fail "got corrupt xattr"
>  	setfattr -x "user.x00000000" "${SCRATCH_MNT}/attrfile" 2> /dev/null && _fail "modified corrupt xattr"
>  	umount "${SCRATCH_MNT}"
>  fi
> diff --git a/tests/xfs/126 b/tests/xfs/126
> index c3a74b1c..519d377e 100755
> --- a/tests/xfs/126
> +++ b/tests/xfs/126
> @@ -69,7 +69,7 @@ done
>  
>  echo "+ mount image && modify xattr"
>  if _try_scratch_mount >> $seqres.full 2>&1; then
> -
> +	getfattr "${SCRATCH_MNT}/attrfile" -n "user.x00000000" 2> /dev/null && _fail "got corrupt xattr"
>  	setfattr -x "user.x00000000" "${SCRATCH_MNT}/attrfile" 2> /dev/null && _fail "modified corrupt xattr"
>  	umount "${SCRATCH_MNT}"
>  fi
> -- 
> 2.23.0
