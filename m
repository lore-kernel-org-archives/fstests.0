Return-Path: <SRS0=7bA6=A7=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA761C433DF
	for <linux-fstests@archiver.kernel.org>; Mon, 20 Jul 2020 03:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A595920729
	for <linux-fstests@archiver.kernel.org>; Mon, 20 Jul 2020 03:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726123AbgGTDkI (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 19 Jul 2020 23:40:08 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7786 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726109AbgGTDkI (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 19 Jul 2020 23:40:08 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 5A940B5D02A33615E4EC;
        Mon, 20 Jul 2020 11:40:06 +0800 (CST)
Received: from [10.164.122.247] (10.164.122.247) by smtp.huawei.com
 (10.3.19.205) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 20 Jul
 2020 11:40:00 +0800
Subject: Re: [PATCH 1/2] generic: add test for race between listxattr and
 setxatr
To:     Hou Tao <houtao1@huawei.com>, <guaneryu@gmail.com>,
        Richard Weinberger <richard@nod.at>
CC:     <fstests@vger.kernel.org>
References: <20200717084447.66402-1-houtao1@huawei.com>
 <20200717084447.66402-2-houtao1@huawei.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <364596a1-c9bb-3a10-a132-0f43907c2241@huawei.com>
Date:   Mon, 20 Jul 2020 11:40:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200717084447.66402-2-houtao1@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.164.122.247]
X-CFilter-Loop: Reflected
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi Tao,

On 2020/7/17 16:44, Hou Tao wrote:
> Add reproducer for a bug on ubifs where listxattr() copies
> the newly created xattr names regardless of the remaining
> buffer size, fails the assertion of used buffer size,
> and may corrupt buffer memory.
> 
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>   tests/generic/998     | 64 +++++++++++++++++++++++++++++++++++++++++++
>   tests/generic/998.out |  2 ++
>   tests/generic/group   |  1 +
>   3 files changed, 67 insertions(+)
>   create mode 100644 tests/generic/998
>   create mode 100644 tests/generic/998.out
> 
> diff --git a/tests/generic/998 b/tests/generic/998
> new file mode 100644
> index 00000000..b108a969
> --- /dev/null
> +++ b/tests/generic/998
> @@ -0,0 +1,64 @@
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
> +for i in $(seq 0 99); do
> +	${SETFATTR_PROG} -n user.${largename}.$i -v $i $target

Now, f2fs just supports storing xattr in one 4KB size xattr block +
inline space in inode, so this testcase will always fail with f2fs,
would you please consider adjusting parameter to cover f2fs case?

Thanks,

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
>   600 auto quick quota
>   601 auto quick quota
>   602 auto quick encrypt
> +998 auto quick attr
> 
