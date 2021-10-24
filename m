Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9442C433EF
	for <linux-fstests@archiver.kernel.org>; Sun, 24 Oct 2021 16:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A13FA60724
	for <linux-fstests@archiver.kernel.org>; Sun, 24 Oct 2021 16:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbhJXQDJ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 24 Oct 2021 12:03:09 -0400
Received: from out20-194.mail.aliyun.com ([115.124.20.194]:56647 "EHLO
        out20-194.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbhJXQDJ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 24 Oct 2021 12:03:09 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08419143|-1;BR=01201311R911S10rulernew998_84748_2000303;CH=blue;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.246973-0.00199198-0.751035;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047187;MF=guan@eryu.me;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.Lh21DJH_1635091246;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.Lh21DJH_1635091246)
          by smtp.aliyun-inc.com(10.147.41.137);
          Mon, 25 Oct 2021 00:00:46 +0800
Date:   Mon, 25 Oct 2021 00:00:46 +0800
From:   Eryu Guan <guan@eryu.me>
To:     "Zhu, YifeiX" <yifeix.zhu@intel.com>
Cc:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "Li, Philip" <philip.li@intel.com>,
        "Ma, XinjianX" <xinjianx.ma@intel.com>,
        "Li, ZhijianX" <zhijianx.li@intel.com>
Subject: Re: [PATCH xfstests] btrfs/012: check size after mounted
Message-ID: <YXWDLlCbosV3UWEl@desktop>
References: <DM6PR11MB39324F4B7F5EB9B686DE29B084BF9@DM6PR11MB3932.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB39324F4B7F5EB9B686DE29B084BF9@DM6PR11MB3932.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Oct 21, 2021 at 01:59:04AM +0000, Zhu, YifeiX wrote:
> check the disk size is enougth for test, should move '_require_fs_space'  after mounted.
> fix error:
> btrfs/012       [not run] This test requires at least 0GB free on /fs/scratch to run
> 
>  Signed-off-by: Zhu Yifei <yifeix.zhu@intel.com>
> ---
>  tests/btrfs/012 | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/btrfs/012 b/tests/btrfs/012 index 46341e9..8b11cf9 100755
> --- a/tests/btrfs/012
> +++ b/tests/btrfs/012
> @@ -29,8 +29,6 @@ _require_command "$BTRFS_CONVERT_PROG" btrfs-convert  _require_command "$MKFS_EXT4_PROG" mkfs.ext4  _require_command "$E2FSCK_PROG" e2fsck

This patch doesn't apply, and it seems the above context is somwhow
merged into one line, would you please double check?

>  
> -_require_fs_space $SCRATCH_MNT $(du -s /lib/modules/`uname -r` | ${AWK_PROG} '{print $1}')
> -
>  BLOCK_SIZE=`_get_block_size $TEST_DIR`
>  
>  # Create & populate an ext4 filesystem
> @@ -39,6 +37,8 @@ $MKFS_EXT4_PROG -F -b $BLOCK_SIZE $SCRATCH_DEV > $seqres.full 2>&1 || \  # Manual mount so we don't use -t btrfs or selinux context  mount -t ext4 $SCRATCH_DEV $SCRATCH_MNT
>  
> +_require_fs_space $SCRATCH_MNT $(du -s /lib/modules/`uname -r` | 

Trailing whitespace introduced in above line.

Thanks,
Eryu

> +${AWK_PROG} '{print $1}')
> +
>  cp -aR /lib/modules/`uname -r`/ $SCRATCH_MNT  _scratch_unmount
>  
> --
> 1.8.3.1
