Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E012C433F5
	for <linux-fstests@archiver.kernel.org>; Thu, 16 Dec 2021 06:28:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232556AbhLPG2H (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 16 Dec 2021 01:28:07 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:16821 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbhLPG2G (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 16 Dec 2021 01:28:06 -0500
Received: from kwepemi100008.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JF2GD2mTNz91j7;
        Thu, 16 Dec 2021 14:27:16 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 kwepemi100008.china.huawei.com (7.221.188.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 16 Dec 2021 14:28:00 +0800
Received: from [10.174.178.31] (10.174.178.31) by
 kwepemm600010.china.huawei.com (7.193.23.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 16 Dec 2021 14:27:59 +0800
Subject: Re: [PATCH] ext4: test for illegal memory access caused by quota
 index information error
To:     Eryu Guan <guan@eryu.me>
CC:     <fstests@vger.kernel.org>
References: <20211125080036.2211159-1-sunke32@huawei.com>
 <YaOY/GaQzMdCfrrR@desktop>
From:   Sun Ke <sunke32@huawei.com>
Message-ID: <9e1583c1-3d51-0860-f801-933c0ff63018@huawei.com>
Date:   Thu, 16 Dec 2021 14:27:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <YaOY/GaQzMdCfrrR@desktop>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.31]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600010.china.huawei.com (7.193.23.86)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi, Eryu

Sorry for the delay in replaying.

ÔÚ 2021/11/28 22:58, Eryu Guan Ð´µÀ:
> On Thu, Nov 25, 2021 at 04:00:36PM +0800, Sun Ke wrote:
>> The quota index information in the image is tampered, causing illegal
>> memory access.
>> It is a regression test for Kernel commit 9bf3d2033129 quota: check block
>> number when reading the block in quota file and commit d0e36a62bd4c
>> quota: correct error number in free_dqentry().
>>
>> Signed-off-by: Sun Ke <sunke32@huawei.com>
>> ---
>>   tests/ext4/054     | 36 ++++++++++++++++++++++++++++++++++++
>>   tests/ext4/054.out |  1 +
>>   2 files changed, 37 insertions(+)
>>   create mode 100755 tests/ext4/054
>>   create mode 100644 tests/ext4/054.out
>>
>> diff --git a/tests/ext4/054 b/tests/ext4/054
>> new file mode 100755
>> index 00000000..286b5ecb
>> --- /dev/null
>> +++ b/tests/ext4/054
>> @@ -0,0 +1,36 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2021 Huawei.  All Rights Reserved.
>> +#
>> +# FS QA Test 054
>> +#
>> +# Regression test for kernel
>> +# commit 9bf3d2033129 quota: check block number when reading the block in quota file
>> +# commit d0e36a62bd4c quota: correct error number in free_dqentry()
> 
> Better to describe the test in test description as well, e.g. what's the
> bug and summarise how we're going to test it.
> 
>> +#
>> +# The test is based on a testcase from Zhang Yi <yi.zhang@huawei.com>.
>> +#
>> +. ./common/preamble
>> +_begin_fstest auto
> 
> In 'quota' group as well
> 
>> +
>> +# real QA test starts here
>> +
>> +# Modify as appropriate.
>> +_require_scratch
>> +_supported_fs ext4
>> +_require_user fsgqa
>> +_require_user fsgqa2
> 
> _require_command "$DEBUGFS_PROG" debugfs
> 
> and use $DEBUGFS_PRG in the test.
> 
>> +
>> +_scratch_mkfs "-F -O quota -b 1024" > $seqres.full 2>&1
> 
> Is 1k block size a required condition to reproduce the bug? Or the
> following debugfs command requires 1k fs?

the following debugfs command requires 1k fs
> 
>> +debugfs -w -R "zap_block -o 0 -l 1 -p 6 -f <3> 1" $SCRATCH_DEV >> $seqres.full 2>&1
> 
> Some comments are welcomed to describe the detailed test steps, e.g.
> explain what's the purpose of this debugfs command.
> 
>> +_scratch_mount >> $seqres.full 2>&1
>> +chown fsgqa:fsgqa $SCRATCH_MNT >> $seqres.full 2>&1
>> +touch $SCRATCH_MNT/foo >> $seqres.full 2>&1
>> +rm -f $SCRATCH_MNT/foo
>> +chown fsgqa2:fsgqa2 $SCRATCH_MNT >> $seqres.full 2>&1
> 
> And why we need to chown fsgqa:fsgqa first and rm the file and chown to
> fsgqa2 later.
> 
>> +
>> +umount $SCRATCH_MNT
> 
> Is this required to trigger the bug? If not, this could be removed,
> SCRATCH_DEV will be umounted after each test.
> 
>> +
>> +# success, all done
>> +status=0
>> +exit
>> diff --git a/tests/ext4/054.out b/tests/ext4/054.out
>> new file mode 100644
>> index 00000000..03e258bb
>> --- /dev/null
>> +++ b/tests/ext4/054.out
>> @@ -0,0 +1 @@
>> +QA output created by 054
> 
> Need "Silence is golden" to indicate this test doesn't print any output.
> 
> Thanks,
> Eryu
> 
>> -- 
>> 2.13.6
> .
> 
I will improve it in V2.

Thanks,
Sun Ke
