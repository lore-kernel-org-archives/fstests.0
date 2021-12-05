Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A93DC433EF
	for <linux-fstests@archiver.kernel.org>; Sun,  5 Dec 2021 13:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234466AbhLEOCw (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 5 Dec 2021 09:02:52 -0500
Received: from out20-99.mail.aliyun.com ([115.124.20.99]:34626 "EHLO
        out20-99.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234460AbhLEOCw (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 5 Dec 2021 09:02:52 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08671534|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00859397-0.000146347-0.99126;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047202;MF=guan@eryu.me;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.M3MYm73_1638712763;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.M3MYm73_1638712763)
          by smtp.aliyun-inc.com(10.147.40.7);
          Sun, 05 Dec 2021 21:59:23 +0800
Date:   Sun, 5 Dec 2021 21:59:23 +0800
From:   Eryu Guan <guan@eryu.me>
To:     An Long <lan@suse.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] btrfs/099: Fix qgroupid issue
Message-ID: <YazFu0fDehuQlBUt@desktop>
References: <20211201144610.26002-1-lan@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211201144610.26002-1-lan@suse.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Dec 01, 2021 at 10:46:10PM +0800, An Long wrote:
> The qgroup commands now accepts the level/id format. Use 0/subvolid to
> avoid invalid qgroupid error.
> 
> Signed-off-by: An Long <lan@suse.com>

Thanks for the fix! But this has been fixed by commit e4746f0dcd1e
("btrfs/099: use the qgroupid for qgroup limit"), would you please pull
the latest code and check if that fixes the issue for you?

Thanks,
Eryu

P.S.

Please also cc btrfs list in future for btrfs-specific patches.
Similarly for patches for other filesystems.

> ---
>  tests/btrfs/099 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/btrfs/099 b/tests/btrfs/099
> index 375cc2b9..f3a2002a 100755
> --- a/tests/btrfs/099
> +++ b/tests/btrfs/099
> @@ -29,7 +29,7 @@ _scratch_mount
>  _require_fs_space $SCRATCH_MNT $(($FILESIZE * 2 / 1024))
>  
>  _run_btrfs_util_prog quota enable $SCRATCH_MNT
> -_run_btrfs_util_prog qgroup limit $FILESIZE 5 $SCRATCH_MNT
> +_run_btrfs_util_prog qgroup limit $FILESIZE 0/5 $SCRATCH_MNT
>  
>  # loop 5 times without sync to ensure reserved space leak will happen
>  for i in `seq 1 5`; do
> -- 
> 2.31.1
