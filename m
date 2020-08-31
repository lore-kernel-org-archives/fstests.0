Return-Path: <SRS0=gT4C=CJ=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E5AC433E6
	for <linux-fstests@archiver.kernel.org>; Mon, 31 Aug 2020 03:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 790D1206FA
	for <linux-fstests@archiver.kernel.org>; Mon, 31 Aug 2020 03:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgHaDBU (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 30 Aug 2020 23:01:20 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10737 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726692AbgHaDBT (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 30 Aug 2020 23:01:19 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 03DAFF58F00AAFC64728;
        Mon, 31 Aug 2020 11:01:16 +0800 (CST)
Received: from [10.174.177.167] (10.174.177.167) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Mon, 31 Aug 2020 11:01:05 +0800
Subject: Re: [PATCH v2 1/2] generic: add test for race between listxattr and
 setxatr
To:     Eryu Guan <guan@eryu.me>, <richard@nod.at>
CC:     <guaneryu@gmail.com>, <yuchao0@huawei.com>,
        <fstests@vger.kernel.org>
References: <364596a1-c9bb-3a10-a132-0f43907c2241@huawei.com>
 <20200822114132.61227-1-houtao1@huawei.com> <20200830162322.GD3853@desktop>
From:   Hou Tao <houtao1@huawei.com>
Message-ID: <c41ee2c2-f08f-be1f-b7a3-5cc52b49d29a@huawei.com>
Date:   Mon, 31 Aug 2020 11:01:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200830162322.GD3853@desktop>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.167]
X-CFilter-Loop: Reflected
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi,

On 2020/8/31 0:23, Eryu Guan wrote:
> On Sat, Aug 22, 2020 at 07:41:32PM +0800, Hou Tao wrote:
>> Add reproducer for a bug on ubifs where listxattr() copies
>> the newly created xattr names regardless of the remaining
>> buffer size, fails the assertion of used buffer size,
>> and may corrupt buffer memory.
>>
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>> ---
>> v2: accommodate f2fs by reducing the number of created xattrs for f2fs
> 
> Thanks for the test and revision! Is there a fix available for the ubifs
> bug? If so would you please mention the kernel commit ID in commit log
> as well?
> 
The fixes [1] have not been reviewed yet, so we may need to hold on until the fixes get merged ?

[1]: https://lore.kernel.org/linux-mtd/20200630130438.141649-1-houtao1@huawei.com/

Regards,
Tao

> Chao, would you please help check the update regarding to f2fs? Thanks!
> 
> Eryu
> 
>>
>>  tests/generic/998     | 67 +++++++++++++++++++++++++++++++++++++++++++
>>  tests/generic/998.out |  2 ++
>>  tests/generic/group   |  1 +
>>  3 files changed, 70 insertions(+)
>>  create mode 100644 tests/generic/998
>>  create mode 100644 tests/generic/998.out
>>
>> diff --git a/tests/generic/998 b/tests/generic/998
>> new file mode 100644
>> index 00000000..26a5b620
>> --- /dev/null
>> +++ b/tests/generic/998
>> @@ -0,0 +1,67 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2020 Huawei. All Rights Reserved.
>> +#
>> +# FS QA Test 998
>> +#
>> +# Test race between listxattr() and setxattr(). It reproduces a bug
>> +# on UBIFS where listxattr() copies the newly created xattr names
>> +# regardless of the remaining buffer size, fails the assertion of
>> +# used buffer size, and may corrupt buffer memory.
>> +#
>> +seq=`basename $0`
>> +seqres=$RESULT_DIR/$seq
>> +echo "QA output created by $seq"
>> +
>> +here=`pwd`
>> +tmp=/tmp/$$
>> +status=1	# failure is the default!
>> +trap "_cleanup; exit \$status" 0 1 2 3 15
>> +
>> +_cleanup()
>> +{
>> +	cd /
>> +	rm -f $tmp.*
>> +	rm -f $TEST_DIR/$seq
>> +}
>> +
>> +# get standard environment, filters and checks
>> +. ./common/rc
>> +. ./common/attr
>> +
>> +# remove previous $seqres.full before test
>> +rm -f $seqres.full
>> +
>> +# real QA test starts here
>> +_supported_fs generic
>> +_supported_os Linux
>> +_require_attrs
>> +
>> +target=$TEST_DIR/$seq
>> +touch $target
>> +
>> +# start a background listxattr
>> +runfile="$tmp.listxattr"
>> +touch $runfile
>> +while [ -e $runfile ]; do
>> +	${GETFATTR_PROG} $target >/dev/null 2>&1
>> +done &
>> +
>> +# add new xattr continuously
>> +largename=`for i in $(seq 0 128); do echo -n a; done`
>> +cnt=100
>> +# f2fs has limited spaces for xattr
>> +[ $FSTYP == "f2fs" ] && cnt=30
>> +for i in $(seq 1 $cnt); do
>> +	${SETFATTR_PROG} -n user.${largename}.$i -v $i $target
>> +done
>> +
>> +rm -f $runfile
>> +wait > /dev/null 2>&1
>> +rm -f $target
>> +
>> +echo Silence is golden
>> +
>> +# success, all done
>> +status=0
>> +exit
>> diff --git a/tests/generic/998.out b/tests/generic/998.out
>> new file mode 100644
>> index 00000000..d2679ae0
>> --- /dev/null
>> +++ b/tests/generic/998.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 998
>> +Silence is golden
>> diff --git a/tests/generic/group b/tests/generic/group
>> index d9ab9a31..62697ac5 100644
>> --- a/tests/generic/group
>> +++ b/tests/generic/group
>> @@ -605,3 +605,4 @@
>>  600 auto quick quota
>>  601 auto quick quota
>>  602 auto quick encrypt
>> +998 auto quick attr
>> -- 
>> 2.25.0.4.g0ad7144999
> .
> 
