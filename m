Return-Path: <SRS0=JoHA=CI=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DEAEC433E6
	for <linux-fstests@archiver.kernel.org>; Sun, 30 Aug 2020 16:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7535220720
	for <linux-fstests@archiver.kernel.org>; Sun, 30 Aug 2020 16:23:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgH3QXc (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 30 Aug 2020 12:23:32 -0400
Received: from out20-49.mail.aliyun.com ([115.124.20.49]:39417 "EHLO
        out20-49.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbgH3QX3 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 30 Aug 2020 12:23:29 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07474444|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.103687-0.00260467-0.893708;FP=0|0|0|0|0|-1|-1|-1;HT=e01a16368;MF=guan@eryu.me;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.IQDinqs_1598804602;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.IQDinqs_1598804602)
          by smtp.aliyun-inc.com(10.147.41.137);
          Mon, 31 Aug 2020 00:23:23 +0800
Date:   Mon, 31 Aug 2020 00:23:22 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Hou Tao <houtao1@huawei.com>
Cc:     guaneryu@gmail.com, richard@nod.at, yuchao0@huawei.com,
        fstests@vger.kernel.org
Subject: Re: [PATCH v2 1/2] generic: add test for race between listxattr and
 setxatr
Message-ID: <20200830162322.GD3853@desktop>
References: <364596a1-c9bb-3a10-a132-0f43907c2241@huawei.com>
 <20200822114132.61227-1-houtao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200822114132.61227-1-houtao1@huawei.com>
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sat, Aug 22, 2020 at 07:41:32PM +0800, Hou Tao wrote:
> Add reproducer for a bug on ubifs where listxattr() copies
> the newly created xattr names regardless of the remaining
> buffer size, fails the assertion of used buffer size,
> and may corrupt buffer memory.
> 
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
> v2: accommodate f2fs by reducing the number of created xattrs for f2fs

Thanks for the test and revision! Is there a fix available for the ubifs
bug? If so would you please mention the kernel commit ID in commit log
as well?

Chao, would you please help check the update regarding to f2fs? Thanks!

Eryu

> 
>  tests/generic/998     | 67 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/998.out |  2 ++
>  tests/generic/group   |  1 +
>  3 files changed, 70 insertions(+)
>  create mode 100644 tests/generic/998
>  create mode 100644 tests/generic/998.out
> 
> diff --git a/tests/generic/998 b/tests/generic/998
> new file mode 100644
> index 00000000..26a5b620
> --- /dev/null
> +++ b/tests/generic/998
> @@ -0,0 +1,67 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2020 Huawei. All Rights Reserved.
> +#
> +# FS QA Test 998
> +#
> +# Test race between listxattr() and setxattr(). It reproduces a bug
> +# on UBIFS where listxattr() copies the newly created xattr names
> +# regardless of the remaining buffer size, fails the assertion of
> +# used buffer size, and may corrupt buffer memory.
> +#
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=`pwd`
> +tmp=/tmp/$$
> +status=1	# failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +	cd /
> +	rm -f $tmp.*
> +	rm -f $TEST_DIR/$seq
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/attr
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +_supported_fs generic
> +_supported_os Linux
> +_require_attrs
> +
> +target=$TEST_DIR/$seq
> +touch $target
> +
> +# start a background listxattr
> +runfile="$tmp.listxattr"
> +touch $runfile
> +while [ -e $runfile ]; do
> +	${GETFATTR_PROG} $target >/dev/null 2>&1
> +done &
> +
> +# add new xattr continuously
> +largename=`for i in $(seq 0 128); do echo -n a; done`
> +cnt=100
> +# f2fs has limited spaces for xattr
> +[ $FSTYP == "f2fs" ] && cnt=30
> +for i in $(seq 1 $cnt); do
> +	${SETFATTR_PROG} -n user.${largename}.$i -v $i $target
> +done
> +
> +rm -f $runfile
> +wait > /dev/null 2>&1
> +rm -f $target
> +
> +echo Silence is golden
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/generic/998.out b/tests/generic/998.out
> new file mode 100644
> index 00000000..d2679ae0
> --- /dev/null
> +++ b/tests/generic/998.out
> @@ -0,0 +1,2 @@
> +QA output created by 998
> +Silence is golden
> diff --git a/tests/generic/group b/tests/generic/group
> index d9ab9a31..62697ac5 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -605,3 +605,4 @@
>  600 auto quick quota
>  601 auto quick quota
>  602 auto quick encrypt
> +998 auto quick attr
> -- 
> 2.25.0.4.g0ad7144999
