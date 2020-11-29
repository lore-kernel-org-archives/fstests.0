Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A433C64E8A
	for <linux-fstests@archiver.kernel.org>; Sun, 29 Nov 2020 10:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9EFC207BC
	for <linux-fstests@archiver.kernel.org>; Sun, 29 Nov 2020 10:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725839AbgK2KtV (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 29 Nov 2020 05:49:21 -0500
Received: from out20-87.mail.aliyun.com ([115.124.20.87]:42959 "EHLO
        out20-87.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgK2KtU (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 29 Nov 2020 05:49:20 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08081148|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.333217-0.00130951-0.665474;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047188;MF=guan@eryu.me;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.J0bKNw._1606646915;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.J0bKNw._1606646915)
          by smtp.aliyun-inc.com(10.147.40.2);
          Sun, 29 Nov 2020 18:48:36 +0800
Date:   Sun, 29 Nov 2020 18:48:35 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Anju T Sudhakar <anju@linux.vnet.ibm.com>
Cc:     fstests@vger.kernel.org, david@fromorbit.com
Subject: Re: [PATCH] generic/031: Modify fcollapse arguments to work on
 non-4k block sized fs instances
Message-ID: <20201129104835.GR3853@desktop>
References: <20201124083733.1795978-1-anju@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124083733.1795978-1-anju@linux.vnet.ibm.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Nov 24, 2020 at 02:07:33PM +0530, Anju T Sudhakar wrote:
> This write vs fcollapse test does a sequence of operations to create a
> page which has non-contiguous mix of dirty and clean blocks. But when
> running the test with 64k block size, fallocate returns with EINVAL
> error, as the offset and length parameters for fcollapse are not
> multiples of fs blocksize.
> 
> Modify the offset and length arguments for fcollapse in the test, to run
> the test with non-4k block sized fs instances also.
> 
> Without the patch:
> -------------------
> # ./check generic/031
> SECTION       -- ext4_test
> FSTYP         -- ext4
> PLATFORM      -- Linux/ppc64le localhost_ubuntu 4.15.0-15-generic
> MKFS_OPTIONS  -- -b 65536 /dev/loop5
> MOUNT_OPTIONS -- -o acl,user_xattr /dev/loop5 /mnt2/scratch
> 
>      QA output created by 031
>     +fallocate: Invalid argument
>     +fallocate: Invalid argument
>      wrote 55756/55756 bytes at offset 185332
>      XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>      wrote 63394/63394 bytes at offset 133228
>     ...
> 
> (Note: Same failure observed for xfs also)
> 
> With the patch:
> ----------------- 
> v# ./check generic/031
> SECTION       -- ext4_test
> FSTYP         -- ext4
> PLATFORM      -- Linux/ppc64le localhost_ubuntu 4.15.0-15-generic #
> MKFS_OPTIONS  -- -b 65536 /dev/loop5
> MOUNT_OPTIONS -- -o acl,user_xattr /dev/loop5 /mnt2/scratch
> 
> generic/031 2s ...  2s
> Ran: generic/031
> Passed all 1 tests
> 
> SECTION       -- ext4_test
> =========================
> Ran: generic/031
> Passed all 1 tests
> 
> Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com> 
> ---
>  tests/generic/031     |  6 +++---
>  tests/generic/031.out | 14 +++++++-------
>  2 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/tests/generic/031 b/tests/generic/031
> index db84031b..2b253c3c 100755
> --- a/tests/generic/031
> +++ b/tests/generic/031
> @@ -41,9 +41,9 @@ _scratch_mount
>  
>  $XFS_IO_PROG -f \
>  	-c "pwrite 185332 55756" \
> -	-c "fcollapse 28672 40960" \
> -	-c "pwrite 133228 63394" \
> -	-c "fcollapse 0 4096" \
> +	-c "fcollapse 65536 65536" \
> +	-c "pwrite 67692 63394" \
> +	-c "fcollapse 0 65536" \

I'm wondering if the original bug still reproduce after this change? The
test is aimed to execrise partial page writeback in fs blocksize <
pagesize case, so the offsets and lens may be the key to reproduce the
original bug.

Thanks,
Eryu

>  $testfile | _filter_xfs_io
>  
>  echo "==== Pre-Remount ==="
> diff --git a/tests/generic/031.out b/tests/generic/031.out
> index 194bfa45..b096694f 100644
> --- a/tests/generic/031.out
> +++ b/tests/generic/031.out
> @@ -1,19 +1,19 @@
>  QA output created by 031
>  wrote 55756/55756 bytes at offset 185332
>  XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -wrote 63394/63394 bytes at offset 133228
> +wrote 63394/63394 bytes at offset 67692
>  XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  ==== Pre-Remount ===
>  00000000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
>  *
> -0001f860  00 00 00 00 00 00 00 00  00 00 00 00 cd cd cd cd  |................|
> -0001f870  cd cd cd cd cd cd cd cd  cd cd cd cd cd cd cd cd  |................|
> +00000860  00 00 00 00 00 00 00 00  00 00 00 00 cd cd cd cd  |................|
> +00000870  cd cd cd cd cd cd cd cd  cd cd cd cd cd cd cd cd  |................|
>  *
> -0002fdc0
> +0001adc0
>  ==== Post-Remount ==
>  00000000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
>  *
> -0001f860  00 00 00 00 00 00 00 00  00 00 00 00 cd cd cd cd  |................|
> -0001f870  cd cd cd cd cd cd cd cd  cd cd cd cd cd cd cd cd  |................|
> +00000860  00 00 00 00 00 00 00 00  00 00 00 00 cd cd cd cd  |................|
> +00000870  cd cd cd cd cd cd cd cd  cd cd cd cd cd cd cd cd  |................|
>  *
> -0002fdc0
> +0001adc0
> -- 
> 2.15.1
