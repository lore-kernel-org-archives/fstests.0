Return-Path: <SRS0=+QVP=DT=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC6CC433E7
	for <linux-fstests@archiver.kernel.org>; Mon, 12 Oct 2020 04:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D2ED206DC
	for <linux-fstests@archiver.kernel.org>; Mon, 12 Oct 2020 04:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RHLMdiKQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbgJLERE (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 12 Oct 2020 00:17:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55408 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726706AbgJLERD (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 12 Oct 2020 00:17:03 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09C41pWZ036410;
        Mon, 12 Oct 2020 00:16:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=4K7e/pn/Ugv4bADUOXwFaTWkV7AIfgCYDv3meoOLUfg=;
 b=RHLMdiKQMORjy8xGDjup4wHeFncRF/Pc5hr9SfGVtA6REAwn+9zdm9Q8KCjfCOoI9l+V
 9y/3NyS877zMusnB8vURUwfDJL2OnmywK3z9n1JGbNt8PnSdTxMqVuITVzjP/JLLoScR
 DCJYBQ4zwkp0/iJwJMhVkQjdm/sc0WrTYiXLzspWe4DvYw7SKVqzQw0oflKModQAXFlG
 YjM2SssqOYaKQIsj2Kcbe74c9CuRl2McUyH4pHuX+DUI36aO/q5x/KYKyvto/8dobEEG
 NAMEOHAGauumrV0/cgAvoZjQpWAKxm0GKfsSiGv5jixPYGMLSuvKXotXD69miZHj7CPG 4g== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 344fr5gahy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Oct 2020 00:16:56 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09C47dGv008979;
        Mon, 12 Oct 2020 04:16:55 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 3434k7sm8t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Oct 2020 04:16:54 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09C4Gq3s27591028
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Oct 2020 04:16:52 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9D81C4C040;
        Mon, 12 Oct 2020 04:16:52 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 975284C04A;
        Mon, 12 Oct 2020 04:16:50 +0000 (GMT)
Received: from [9.199.36.105] (unknown [9.199.36.105])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 12 Oct 2020 04:16:50 +0000 (GMT)
Subject: Re: [PATCH 1/1] ext4/046: Add test to verify unwritten extent
 conversion in buff-io
To:     Eryu Guan <guan@eryu.me>
Cc:     fstests@vger.kernel.org, tytso@mit.edu, jack@suse.cz,
        anju@linux.vnet.ibm.com, aneesh.kumar@linux.ibm.com
References: <5baabca9c454e09e796a5a97127ca9d73840d8bd.1602243041.git.riteshh@linux.ibm.com>
 <20201011061153.GX3853@desktop>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Message-ID: <8a6a4bff-8e26-5aaa-e39f-c822b3b6a235@linux.ibm.com>
Date:   Mon, 12 Oct 2020 09:46:49 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201011061153.GX3853@desktop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-12_01:2020-10-12,2020-10-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1011
 adultscore=0 priorityscore=1501 suspectscore=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 impostorscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010120029
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


Thanks Eryu for detailed review.

On 10/11/20 11:41 AM, Eryu Guan wrote:
> On Fri, Oct 09, 2020 at 05:12:24PM +0530, Ritesh Harjani wrote:
>> There was an issue where with with filesize > 4G, map.m_lblk
>> was getting overflow in buff-IO path while converting unwritten to
>> written extent with dioread_nolock mount option with bs < ps.
>> Adding a testcase for the same.
>> This test doesn't force any explicit mount option within the test,
>> as it will be set anyway along with test config, although it does
>> force for blocksize < pagesize config (as this test is specific to
> 
> I don't think we need to force blksize < pagesize either, as testing
> different blocksize configs is a common test setup and is part of
> tester's resposibility.

Right, but generally bs < ps configuration is not tested for every mount 
option. The issue mentioned here happens with bs < ps for dioread_nolock 
mount opt.
So I need to force at least bs < ps or the mount option of dioread_nolock.
I think since it is mainly ext4 specific, maybe I will change the patch 
to enforce this for dioread_nolock mount opt. Then since bs < ps by 
default everyone tests, so this test will get exercised automatically.


> 
>> that). Patch at [1] fixes the issue.
>>
>> [1]: https://patchwork.ozlabs.org/patch/1378632
>>
>> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
>> ---
>>   tests/ext4/046     | 101 +++++++++++++++++++++++++++++++++++++++++++++
>>   tests/ext4/046.out |   2 +
>>   tests/ext4/group   |   1 +
>>   3 files changed, 104 insertions(+)
>>   create mode 100755 tests/ext4/046
>>   create mode 100644 tests/ext4/046.out
>>
>> diff --git a/tests/ext4/046 b/tests/ext4/046
>> new file mode 100755
>> index 000000000000..49de6bbb2c89
>> --- /dev/null
>> +++ b/tests/ext4/046
>> @@ -0,0 +1,101 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2020 IBM Corporation. All Rights Reserved.
>> +#
>> +# FS QA Test No. generic/046
>> +#
>> +# Test writes to falloc file with filesize > 4GB and make sure to verify
>> +# the file checksum both before and after mount.
>> +# This test is to check whether unwritten extents gets properly converted
>> +# to written extent on a filesystem with bs < ps.
> 
> Mention dioread_nolock mount option as well here?

yup, will mention that.

> 
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
>> +}
>> +
>> +# get standard environment, filters and checks
>> +. ./common/rc
>> +. ./common/filter
>> +
>> +# remove previous $seqres.full before test
>> +rm -f $seqres.full
>> +
>> +# Modify as appropriate.
>> +_supported_fs ext4
> 
> I don't see any ext4 specific setups in the test, so it could be a
> generic test.

as mentioned in above comments. Let me enforce the dioread_nolock
ext4 mount opt for this test.

> 
>> +_supported_os Linux
> 
> "_suppored_os" is removed, just drop this line.

ok.

> 
>> +_require_scratch
>> +_require_xfs_io_command "falloc"
>> +
>> +# keep 4k as a blksz for 64k pagesz
>> +pagesz=$(getconf PAGE_SIZE)
>> +if [ $pagesz -eq 65536 ]; then
>> +	blksz=4096
>> +else
>> +	blksz=$(($pagesz/4))
>> +fi
>> +
>> +devsize=`blockdev --getsize64 $SCRATCH_DEV`
>> +if [ $devsize -lt 6442450944 ]; then
>> +	_notrun "Too small scratch device, need at least 6G"
>> +fi
> 
> _require_scratch_size is used to do this check.

ok.

> 
>> +
>> +# Test for bs < ps
>> +export MKFS_OPTIONS="-F -b $blksz"
>> +_scratch_mkfs >> $seqres.full 2>&1
>> +_scratch_mount >> $seqres.full 2>&1
>> +
>> +# check blksz
>> +real_blksz=$(_get_file_block_size $SCRATCH_MNT)
>> +test $real_blksz != $blksz && _notrun "Failed to format with small blocksize."
>> +
>> +testfile=$SCRATCH_MNT/testfile-$seq
>> +
>> +# Fallocate testfile with size > 4G
>> +fsize=$((5 * 1024 * 1024 * 1024))
>> +$XFS_IO_PROG -f -c "falloc 0 $fsize" $testfile >> $seqres.full 2>&1
>> +
>> +# First write at offset < 4G (at few alternative blks)
>> +off=$((3 * 1024 * 1024 * 1024))
>> +for i in 1 2 3 4; do
>> +	$XFS_IO_PROG -f \
>> +		-c "pwrite $off $blksz" \
>> +		$testfile >> $seqres.full 2>&1
>> +	off=$(($off + (2*$blksz)))
>> +done
>> +
>> +# Then write at offset > 4G (at few alternative blks) to check
>> +# any 32bit overflow case in map.m_lblk
>> +off=$((4 * 1024 * 1024 * 1024))
>> +for i in 1 2 3 4; do
>> +	$XFS_IO_PROG -f \
>> +		-c "pwrite $off $blksz" \
>> +		$testfile >> $seqres.full 2>&1
>> +	off=$(($off + (2*$blksz)))
>> +done
>> +
>> +# ==== Pre-Remount ===
>> +md5_pre=`md5sum $testfile | cut -d' ' -f1`
>> +echo "Pre-Remount md5sum of $testfile = $md5_pre" >> $seqres.full
>> +
>> +_scratch_cycle_mount
>> +
>> +# ==== Post-Remount ===
>> +md5_post=`md5sum $testfile | cut -d' ' -f1`
>> +echo "Post-Remount md5sum of $testfile = $md5_post" >> $seqres.full
>> +test $md5_pre != $md5_post && echo "md5sum mismatch"
>> +
>> +# success, all done
>> +echo "Silence is golden"
>> +status=0
>> +exit
>> diff --git a/tests/ext4/046.out b/tests/ext4/046.out
>> new file mode 100644
>> index 000000000000..52c445eb70bb
>> --- /dev/null
>> +++ b/tests/ext4/046.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 046
>> +Silence is golden
>> diff --git a/tests/ext4/group b/tests/ext4/group
>> index 40351fd9ca0c..02a499a9d220 100644
>> --- a/tests/ext4/group
>> +++ b/tests/ext4/group
>> @@ -48,6 +48,7 @@
>>   043 auto quick
>>   044 auto quick
>>   045 auto dir
>> +046 auto quick
> 
> Also add 'prealloc' group

ok.

> 
> Thanks,
> Eryu
> 
>>   271 auto rw quick
>>   301 aio auto ioctl rw stress defrag
>>   302 aio auto ioctl rw stress defrag
>> -- 
>> 2.26.2
