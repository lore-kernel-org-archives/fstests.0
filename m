Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 435E2C433EF
	for <linux-fstests@archiver.kernel.org>; Sun, 19 Dec 2021 15:16:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235980AbhLSPQs (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 19 Dec 2021 10:16:48 -0500
Received: from out20-38.mail.aliyun.com ([115.124.20.38]:43933 "EHLO
        out20-38.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbhLSPQr (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 19 Dec 2021 10:16:47 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08229033|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.401277-0.00339108-0.595332;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047207;MF=guan@eryu.me;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.MJd0uxL_1639927005;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.MJd0uxL_1639927005)
          by smtp.aliyun-inc.com(10.147.40.26);
          Sun, 19 Dec 2021 23:16:45 +0800
Date:   Sun, 19 Dec 2021 23:16:45 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     fstests@vger.kernel.org, Eric Whitney <enwlinux@gmail.com>
Subject: Re: [PATCH] ext4/033: remove a portion of the test assuming
 resize2fs would fail
Message-ID: <Yb9M3aIb9cJGIJaB@desktop>
References: <20211215035409.244674-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215035409.244674-1-tytso@mit.edu>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Dec 14, 2021 at 10:54:09PM -0500, Theodore Ts'o wrote:
> The ext4/033 test tries to test if resize2fs would fail when resizing
> a file system to a size that the number of inodes exceeds the maximum
> allowed inode size, 2**32-1.  This no longer takes place as of
> e2fsprogs commit 623985ed7dd5 ("resize2fs: attempt to keep the # of
> inodes valid by removing the last bg") which will allow resizing a
> file system to 64TB by reducing the last block group so that file
> system will be 64TB - 128MB, which is close enough for government
> work.
> 
> Reported-by: Eric Whitney <enwlinux@gmail.com>
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>  tests/ext4/033     | 8 --------
>  tests/ext4/033.out | 1 -
>  2 files changed, 9 deletions(-)
> 
> diff --git a/tests/ext4/033 b/tests/ext4/033
> index 1bc14c03..0fd0ec90 100755
> --- a/tests/ext4/033
> +++ b/tests/ext4/033
> @@ -66,14 +66,6 @@ _mount $DMHUGEDISK_DEV $SCRATCH_MNT
>  echo "Initial fs dump" >> $seqres.full
>  $DUMPE2FS_PROG -h $DMHUGEDISK_DEV >> $seqres.full 2>&1
>  
> -# This should fail, s_inodes_count would just overflow!
> -echo "Resizing to inode limit + 1..."
> -$RESIZE2FS_PROG $DMHUGEDISK_DEV $((limit_groups*group_blocks)) >> $seqres.full 2>&1
> -if [ $? -eq 0 ]; then
> -	echo "Resizing succeeded but it should fail!"
> -	exit
> -fi

This portion of test is the key of the original regression test, if
we're going to remove this part, does it make sense to remove ext4/033
completely?

Thanks,
Eryu

> -
>  # This should succeed, we are maxing out inodes
>  echo "Resizing to max group count..."
>  $RESIZE2FS_PROG $DMHUGEDISK_DEV $(((limit_groups-1)*group_blocks)) >> $seqres.full 2>&1
> diff --git a/tests/ext4/033.out b/tests/ext4/033.out
> index 24c251cb..183a7492 100644
> --- a/tests/ext4/033.out
> +++ b/tests/ext4/033.out
> @@ -1,6 +1,5 @@
>  QA output created by 033
>  Figure out block size
>  Format huge device
> -Resizing to inode limit + 1...
>  Resizing to max group count...
>  Resizing to device size...
> -- 
> 2.31.0
