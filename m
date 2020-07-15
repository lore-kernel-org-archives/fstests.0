Return-Path: <SRS0=5/bx=A2=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6961C433E0
	for <linux-fstests@archiver.kernel.org>; Wed, 15 Jul 2020 16:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CB3F2075B
	for <linux-fstests@archiver.kernel.org>; Wed, 15 Jul 2020 16:33:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725832AbgGOQdn (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 15 Jul 2020 12:33:43 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:29682 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725861AbgGOQdm (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 15 Jul 2020 12:33:42 -0400
X-IronPort-AV: E=Sophos;i="5.75,355,1589212800"; 
   d="scan'208";a="96401606"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 16 Jul 2020 00:33:38 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 22CC04CE38CB;
        Thu, 16 Jul 2020 00:33:33 +0800 (CST)
Received: from [10.167.220.69] (10.167.220.69) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Thu, 16 Jul 2020 00:33:34 +0800
Message-ID: <5F0F2FDB.5060307@cn.fujitsu.com>
Date:   Thu, 16 Jul 2020 00:33:31 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.2; zh-CN; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
MIME-Version: 1.0
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
CC:     Ira Weiny <ira.weiny@intel.com>, <fstests@vger.kernel.org>
Subject: Re: [PATCH v6 7/7] generic: Verify the inheritance behavior of FS_XFLAG_DAX
 flag in various combinations
References: <20200714094009.8654-1-yangx.jy@cn.fujitsu.com> <20200714094009.8654-8-yangx.jy@cn.fujitsu.com> <20200715024838.GI3008823@iweiny-DESK2.sc.intel.com> <5F0E96A8.2010705@cn.fujitsu.com> <5F0ED015.5090707@cn.fujitsu.com> <20200715161916.GQ7600@magnolia>
In-Reply-To: <20200715161916.GQ7600@magnolia>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.220.69]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206)
X-yoursite-MailScanner-ID: 22CC04CE38CB.AE666
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 2020/7/16 0:19, Darrick J. Wong wrote:
> On Wed, Jul 15, 2020 at 05:44:53PM +0800, Xiao Yang wrote:
>> On 2020/7/15 13:39, Xiao Yang wrote:
>>> On 2020/7/15 10:48, Ira Weiny wrote:
>>>> On Tue, Jul 14, 2020 at 05:40:09PM +0800, Xiao Yang wrote:
>>>>> Signed-off-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
>>>>> ---
>>>>>    tests/generic/605     | 199
>>>>> ++++++++++++++++++++++++++++++++++++++++++
>>>>>    tests/generic/605.out |   2 +
>>>>>    tests/generic/group   |   1 +
>>>>>    3 files changed, 202 insertions(+)
>>>>>    create mode 100644 tests/generic/605
>>>>>    create mode 100644 tests/generic/605.out
>>>>>
>>>>> diff --git a/tests/generic/605 b/tests/generic/605
>>>>> new file mode 100644
>>>>> index 00000000..6924223a
>>>>> --- /dev/null
>>>>> +++ b/tests/generic/605
>>>>> @@ -0,0 +1,199 @@
>>>>> +#! /bin/bash
>>>>> +# SPDX-License-Identifier: GPL-2.0
>>>>> +# Copyright (c) 2020 Fujitsu.  All Rights Reserved.
>>>>> +#
>>>>> +# FS QA Test 605
>>>>> +#
>>>>> +# Verify the inheritance behavior of FS_XFLAG_DAX flag in
>>>>> various combinations.
>>>>> +# 1) New files and directories automatically inherit
>>>>> FS_XFLAG_DAX from their parent directory.
>>>>> +# 2) cp operation make files and directories inherit the
>>>>> FS_XFLAG_DAX from new parent directory.
>>>>> +# 3) mv operation make files and directories preserve the
>>>>> FS_XFLAG_DAX from old parent directory.
>>>>> +# In addition, setting/clearing FS_XFLAG_DAX flag is not
>>>>> impacted by dax mount options.
>>>>> +
>>>>> +seq=`basename $0`
>>>>> +seqres=$RESULT_DIR/$seq
>>>>> +echo "QA output created by $seq"
>>>>> +
>>>>> +here=`pwd`
>>>>> +tmp=/tmp/$$
>>>>> +status=1        # failure is the default!
>>>>> +trap "_cleanup; exit \$status" 0 1 2 3 15
>>>>> +
>>>>> +_cleanup()
>>>>> +{
>>>>> +    cd /
>>>>> +    rm -f $tmp.*
>>>>> +}
>>>>> +
>>>>> +# get standard environment, filters and checks
>>>>> +. ./common/rc
>>>>> +. ./common/filter
>>>>> +
>>>>> +# remove previous $seqres.full before test
>>>>> +rm -f $seqres.full
>>>>> +
>>>>> +_supported_fs generic
>>>>> +_supported_os Linux
>>>>> +_require_scratch
>>>>> +_require_dax_iflag
>>>>> +_require_xfs_io_command "lsattr" "-v"
>>>>> +
>>>>> +check_xflag()
>>>>> +{
>>>>> +    local target=$1
>>>>> +    local exp_xflag=$2
>>>>> +
>>>>> +    if [ $exp_xflag -eq 0 ]; then
>>>>> +        _test_inode_flag dax $target&&   echo "$target has
>>>>> unexpected FS_XFLAG_DAX flag"
>>>>> +    else
>>>>> +        _test_inode_flag dax $target || echo "$target doen't
>>>>> have expected FS_XFLAG_DAX flag"
>>>>> +    fi
>>>>> +}
>>>>> +
>>>>> +test_xflag_inheritance1()
>>>>> +{
>>>>> +    mkdir -p a
>>>>> +    $XFS_IO_PROG -c "chattr +x" a
>>>>> +    mkdir -p a/b/c
>>>>> +    touch a/b/c/d
>>>>> +
>>>>> +    check_xflag a 1
>>>>> +    check_xflag a/b 1
>>>>> +    check_xflag a/b/c 1
>>>>> +    check_xflag a/b/c/d 1
>>>>> +
>>>>> +    rm -rf a
>>>>> +}
>>>>> +
>>>>> +test_xflag_inheritance2()
>>>>> +{
>>>>> +    mkdir -p a/b
>>>>> +    $XFS_IO_PROG -c "chattr +x" a
>>>>> +    mkdir -p a/b/c a/d
>>>>> +    touch a/b/c/e a/d/f
>>>>> +
>>>>> +    check_xflag a 1
>>>>> +    check_xflag a/b 0
>>>>> +    check_xflag a/b/c 0
>>>>> +    check_xflag a/b/c/e 0
>>>>> +    check_xflag a/d 1
>>>>> +    check_xflag a/d/f 1
>>>>> +
>>>>> +    rm -rf a
>>>>> +}
>>>>> +
>>>>> +test_xflag_inheritance3()
>>>>> +{
>>>>> +    mkdir -p a/b
>>>>> +    $XFS_IO_PROG -c "chattr +x" a/b
>>>>> +    mkdir -p a/b/c a/d
>>>>> +    touch a/b/c/e a/d/f
>>>>> +
>>>>> +    check_xflag a 0
>>>>> +    check_xflag a/b 1
>>>>> +    check_xflag a/b/c 1
>>>>> +    check_xflag a/b/c/e 1
>>>>> +    check_xflag a/d 0
>>>>> +    check_xflag a/d/f 0
>>>>> +
>>>>> +    rm -rf a
>>>>> +}
>>>> It really seems like 2 and 3 test the same thing?
>>> Hi Ira,
>>>
>>> 2 constructs the following steps:
>>> 1) a is the parent directory of b
>>> 2) a doesn't have xflag and b has xflag
>>> 3) touch many directories/files in a and b
>>>
>>> 3 constructs the following steps:
>>> 1) a is the parent directory of b and b is the parent directory of c
>>> 2) a and c have xflag, and b doesn't have xflag
>>> 3) touch many directories/files in b and c
>> Hi Ira,
>>
>> Sorry for misreading your comment, above is the difference between 3 and 4.
>> The correct one is:
>> 2 constructs the following steps:
>> 1) a is the parent directory of b
>> 2) a has xflag and b doesn't have xflag
>> 3) touch many directories/files in a and b
>>
>> 3 constructs the following steps:
>> 1) a is the parent directory of b
>> 2) a doesn't have xflag and b has xflag
>> 3) touch many directories/files in a and b
>>
>> Do you think they are same? I can remove one if you think so.
> For an earlier version of this series I thought about recommending that
> each of these functions describe what they aim to test.  Then I realized
> that such descriptions would probably be nearly as long as the function
> body, and said nothing.
>
> But now that Ira's confused, I think that's a stronger argument for each
> of the test functions having a short description.
>
> 	# If a/ is +x and b/ is -x, check that b's new children don't
> 	# inherit +x from a/.
> 	test_xflag_inheritance2() {...}
>
> Put another way, this adds enough redundancy between the comment and the
> code that someone else can feel confident that the code still captures
> the intent of the author.
>
> FWIW I think 2 and 3 test opposite variations of the same thing (a's
> state doesn't somehow override b's), so they're fine.  The xfs
> implementation uses the same inheritance control code for FS_XFLAG_DAX,
> but doesn't mean everyone else will necessarily do that.
Hi Darrck,

Do you prefer to keep both 2 and 3? right? :-)

Thanks,
Xiao Yang
> --D
>
>> Best Regards,
>> Xiao Yang
>>> Do you think they are same? I can remove one if you think so.
>>>
>>>>> +
>>>>> +test_xflag_inheritance4()
>>>>> +{
>>>>> +    mkdir -p a
>>>>> +    $XFS_IO_PROG -c "chattr +x" a
>>>>> +    mkdir -p a/b/c
>>>>> +    $XFS_IO_PROG -c "chattr -x" a/b
>>>>> +    mkdir -p a/b/c/d a/b/e
>>>>> +    touch a/b/c/d/f a/b/e/g
>>>>> +
>>>>> +    check_xflag a 1
>>>>> +    check_xflag a/b 0
>>>>> +    check_xflag a/b/c 1
>>>>> +    check_xflag a/b/c/d 1
>>>>> +    check_xflag a/b/c/d/f 1
>>>>> +    check_xflag a/b/e 0
>>>>> +    check_xflag a/b/e/g 0
>>>>> +
>>>>> +    rm -rf a
>>>>> +}
>>>>> +
>>>>> +test_xflag_inheritance5()
>>>>> +{
>>>>> +    mkdir -p a b
>>>>> +    $XFS_IO_PROG -c "chattr +x" a
>>>>> +    mkdir -p a/c a/d b/e b/f
>>>>> +    touch a/g b/h
>>>>> +
>>>>> +    cp -r a/c b/
>>>>> +    cp -r b/e a/
>>>>> +    cp -r a/g b/
>>>>> +    mv a/d b/
>>>>> +    mv b/f a/
>>>>> +    mv b/h a/
>>>>> +
>>>>> +    check_xflag b/c 0
>>>>> +    check_xflag b/d 1
>>>>> +    check_xflag a/e 1
>>>>> +    check_xflag a/f 0
>>>>> +    check_xflag b/g 0
>>>>> +    check_xflag a/h 0
>>>>> +
>>>>> +    rm -rf a b
>>>>> +}
>>>>> +
>>>>> +do_xflag_tests()
>>>>> +{
>>>>> +    local option=$1
>>>>> +
>>>>> +    _scratch_mount "$option"
>>>>> +    cd $SCRATCH_MNT
>>>>> +
>>>>> +    for i in $(seq 1 5); do
>>>>> +        test_xflag_inheritance${i}
>>>>> +    done
>>>>> +
>>>>> +    cd ->   /dev/null
>>>>> +    _scratch_unmount
>>>>> +}
>>>>> +
>>>>> +check_dax_mountopt()
>>>>> +{
>>>>> +    local option=$1
>>>>> +    local ret=0
>>>>> +
>>>>> +    _try_scratch_mount "-o $option">>   $seqres.full 2>&1 || return 1
>>>>> +
>>>>> +    # Match option name exactly
>>>>> +    _fs_options $SCRATCH_DEV | egrep -q "$option(,|$)" || ret=1
>>>>> +
>>>>> +    _scratch_unmount
>>>>> +
>>>>> +    return $ret
>>>>> +}
>>>> Should this be a common function?
>>> I am not sure if it should be a common function, because it may not be
>>> used by other tests in future.
>>> I also consider to merge the function into
>>> _require_scratch_dax_mountopt().
>>>
>>>>> +
>>>>> +do_tests()
>>>>> +{
>>>>> +    # Mount without dax option
>>>>> +    do_xflag_tests
>>>>> +
>>>>> +    # Mount with old dax option if fs only supports it.
>>>>> +    check_dax_mountopt "dax"&&   do_xflag_tests "-o dax"
>>>> I don't understand the order here.  If we are on an older kernel and
>>>> the FS
>>>> only supports '-o dax' the do_xflag_tests will fail won't it?
>>> With both old dax and new dax, the inheritance behavior of FS_XFLAG_DAX
>>> works well.
>>>
>>>> So shouldn't we do this first and bail/'not run' this test if that
>>>> is the case?
>>>>
>>>> I really don't think there is any point in testing the old XFS
>>>> behavior because
>>>> the FS_XFLAG_DAX had no effect.  So even if it is broken it does not
>>>> matter.
>>>> Or perhaps I am missing something here?
>>> This test is designed to verify the inheritance behavior of
>>> FS_XFLAG_DAX(not related to S_DAX)
>>> so I think it is fine for both old dax and new dax to run the test.
>>>
>>> Best Regards,
>>> Xiao Yang
>>>> Ira
>>>>
>>>>> +
>>>>> +    # Mount with new dax options if fs supports them.
>>>>> +    if check_dax_mountopt "dax=always"; then
>>>>> +        for dax_option in "dax=always" "dax=inode" "dax=never"; do
>>>>> +            do_xflag_tests "-o $dax_option"
>>>>> +        done
>>>>> +    fi
>>>>> +}
>>>>> +
>>>>> +_scratch_mkfs>>   $seqres.full 2>&1
>>>>> +
>>>>> +do_tests
>>>>> +
>>>>> +# success, all done
>>>>> +echo "Silence is golden"
>>>>> +status=0
>>>>> +exit
>>>>> diff --git a/tests/generic/605.out b/tests/generic/605.out
>>>>> new file mode 100644
>>>>> index 00000000..1ae20049
>>>>> --- /dev/null
>>>>> +++ b/tests/generic/605.out
>>>>> @@ -0,0 +1,2 @@
>>>>> +QA output created by 605
>>>>> +Silence is golden
>>>>> diff --git a/tests/generic/group b/tests/generic/group
>>>>> index 676e0d2e..a8451862 100644
>>>>> --- a/tests/generic/group
>>>>> +++ b/tests/generic/group
>>>>> @@ -607,3 +607,4 @@
>>>>>    602 auto quick encrypt
>>>>>    603 auto attr quick dax
>>>>>    604 auto attr quick dax
>>>>> +605 auto attr quick dax
>>>>> -- 
>>>>> 2.21.0
>>>>>
>>>>>
>>>>>
>>>> .
>>>>
>>>
>>>
>>> .
>>>
>>
>>
>
> .
>



