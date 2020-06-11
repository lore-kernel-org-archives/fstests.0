Return-Path: <SRS0=h6Hu=7Y=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E946C433E0
	for <linux-fstests@archiver.kernel.org>; Thu, 11 Jun 2020 14:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0184F2065C
	for <linux-fstests@archiver.kernel.org>; Thu, 11 Jun 2020 14:21:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgFKOVI (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 11 Jun 2020 10:21:08 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:23787 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726795AbgFKOVI (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 11 Jun 2020 10:21:08 -0400
X-IronPort-AV: E=Sophos;i="5.73,499,1583164800"; 
   d="scan'208";a="94311560"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 11 Jun 2020 22:19:22 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 65B5B4CE26DE;
        Thu, 11 Jun 2020 22:19:20 +0800 (CST)
Received: from [10.167.220.69] (10.167.220.69) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Thu, 11 Jun 2020 22:19:19 +0800
Message-ID: <5EE23D66.7080505@cn.fujitsu.com>
Date:   Thu, 11 Jun 2020 22:19:18 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.2; zh-CN; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
MIME-Version: 1.0
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
CC:     <fstests@vger.kernel.org>, <ira.weiny@intel.com>
Subject: Re: [PATCH 4/4] xfs/260: Move xfs/260 to generic
References: <20200603140115.30392-1-yangx.jy@cn.fujitsu.com> <20200603140115.30392-4-yangx.jy@cn.fujitsu.com> <20200609164218.GB11255@magnolia> <5EE07ACD.3080405@cn.fujitsu.com> <20200610155949.GD11255@magnolia> <5EE1F5BF.8020809@cn.fujitsu.com>
In-Reply-To: <5EE1F5BF.8020809@cn.fujitsu.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.220.69]
X-ClientProxiedBy: G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) To
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206)
X-yoursite-MailScanner-ID: 65B5B4CE26DE.ABEC4
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 2020/6/11 17:13, Xiao Yang wrote:
> On 2020/6/10 23:59, Darrick J. Wong wrote:
>> On Wed, Jun 10, 2020 at 02:16:45PM +0800, Xiao Yang wrote:
>>> On 2020/6/10 0:42, Darrick J. Wong wrote:
>>>> On Wed, Jun 03, 2020 at 10:01:15PM +0800, Xiao Yang wrote:
>>>>> Both ext4 and xfs support per-inode DAX flag now so move it to 
>>>>> generic.
>>>>>
>>>>> Signed-off-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
>>>>> ---
>>>>>    tests/{xfs/260 =>   generic/602} | 12 ++++++++----
>>>>>    tests/generic/602.out          |  2 ++
>>>>>    tests/generic/group            |  1 +
>>>>>    tests/xfs/260.out              |  2 --
>>>>>    tests/xfs/group                |  1 -
>>>>>    5 files changed, 11 insertions(+), 7 deletions(-)
>>>>>    rename tests/{xfs/260 =>   generic/602} (91%)
>>>>>    create mode 100644 tests/generic/602.out
>>>>>    delete mode 100644 tests/xfs/260.out
>>>>>
>>>>> diff --git a/tests/xfs/260 b/tests/generic/602
>>>>> similarity index 91%
>>>>> rename from tests/xfs/260
>>>>> rename to tests/generic/602
>>>>> index fbdc4cd8..0cd20f31 100755
>>>>> --- a/tests/xfs/260
>>>>> +++ b/tests/generic/602
>>>>> @@ -2,7 +2,7 @@
>>>>>    # SPDX-License-Identifier: GPL-2.0
>>>>>    # Copyright (c) 2017 Red Hat Inc.  All Rights Reserved.
>>>>>    #
>>>>> -# FS QA Test 260
>>>>> +# FS QA Test 602
>>>>>    #
>>>>>    # Test per-inode DAX flag by mmap direct/buffered IO.
>>>>>    #
>>>>> @@ -28,7 +28,7 @@ _cleanup()
>>>>>    # remove previous $seqres.full before test
>>>>>    rm -f $seqres.full
>>>>>
>>>>> -_supported_fs xfs
>>>>> +_supported_fs generic
>>>>>    _supported_os Linux
>>>>>    _require_scratch_dax_mountopt "dax"
>>>>>    _require_test_program "feature"
>>>>> @@ -121,8 +121,12 @@ do_tests()
>>>>>        t_dax_flag_mmap_dio $((64 * 1024 * 1024))
>>>>>    }
>>>>>
>>>>> -# make xfs 2Mb aligned for PMD fault testing
>>>>> -_scratch_mkfs "-d su=2m,sw=1">   /dev/null 2>&1
>>>>> +# make 2Mb aligned for PMD fault testing
>>>>> +mkfs_opts=""
>>>>> +[ "$FSTYP" = "ext4" ]&&   mkfs_opts="-E stride=512,stripe_width=1"
>>>>> +[ "$FSTYP" = "xfs" ]&&   mkfs_opts="-d su=2m,sw=1"
>>>> /me wonders if this ought to be smart enough to sniff out the hugepage
>>>> size on the test machine...
>>> Hi Darrick,
>>>
>>> PMD page is always 2M, I am not sure why we need to sniff out the 
>>> hugepage
>>> size?  Could you give me an example?
>> arm64, which can have 512M hugepages.
>> ppc64, which can have 16M huge pages (I think?)
> Hi Darrick,
>
> After reading kernel xfs code, do you mean that PMD page fault is only 
> used by hugepage?
> ----------------------------------------------------------------
> xfs/xfs_file.c:
> ...
> 1223 static vm_fault_t
> 1224 xfs_filemap_fault(
> 1225         struct vm_fault         *vmf)
> 1226 {
> 1227         /* DAX can shortcut the normal fault path on write 
> faults! */
> 1228         return __xfs_filemap_fault(vmf, PE_SIZE_PTE,
> 1229                         IS_DAX(file_inode(vmf->vma->vm_file)) &&
> 1230                         (vmf->flags & FAULT_FLAG_WRITE));
> 1231 }
> 1232
> 1233 static vm_fault_t
> 1234 xfs_filemap_huge_fault(
> 1235         struct vm_fault         *vmf,
> 1236         enum page_entry_size    pe_size)
> 1237 {
> 1238         if (!IS_DAX(file_inode(vmf->vma->vm_file)))
> 1239                 return VM_FAULT_FALLBACK;
> 1240
> 1241         /* DAX can shortcut the normal fault path on write 
> faults! */
> 1242         return __xfs_filemap_fault(vmf, pe_size,
> 1243                         (vmf->flags & FAULT_FLAG_WRITE));
> 1244 }
> ...
> ----------------------------------------------------------------
>
> Another qeustion: ext4 seems not use PMD page fault,does I miss 
> something?
Hi,

Sorry, ext4 actually uses  PMD page fault as the following code does so 
please ignore the naive question. :-(

Thanks,
Xiao Yang
> ----------------------------------------------------------------
> ext4/file.c:
> ...
> 705 static vm_fault_t ext4_dax_fault(struct vm_fault *vmf)
> 706 {
> 707         return ext4_dax_huge_fault(vmf, PE_SIZE_PTE);
> 708 }
> 709
> 710 static const struct vm_operations_struct ext4_dax_vm_ops = {
> 711         .fault          = ext4_dax_fault,
> 712         .huge_fault     = ext4_dax_huge_fault,
> ...
> ----------------------------------------------------------------
>
> Best Regards,
> Xiao Yang
>> --D
>>
>>> Best Regards,
>>> Xiao Yang
>>>> --D
>>>>
>>>>> +
>>>>> +_scratch_mkfs "$mkfs_opts">   /dev/null 2>&1
>>>>>
>>>>>    # mount with dax option
>>>>>    _scratch_mount "-o dax"
>>>>> diff --git a/tests/generic/602.out b/tests/generic/602.out
>>>>> new file mode 100644
>>>>> index 00000000..61976e5e
>>>>> --- /dev/null
>>>>> +++ b/tests/generic/602.out
>>>>> @@ -0,0 +1,2 @@
>>>>> +QA output created by 602
>>>>> +Silence is golden
>>>>> diff --git a/tests/generic/group b/tests/generic/group
>>>>> index c6ce029c..4bda3772 100644
>>>>> --- a/tests/generic/group
>>>>> +++ b/tests/generic/group
>>>>> @@ -604,3 +604,4 @@
>>>>>    599 auto quick remount shutdown
>>>>>    600 auto quick quota
>>>>>    601 auto quick quota
>>>>> +602 auto attr quick dax
>>>>> diff --git a/tests/xfs/260.out b/tests/xfs/260.out
>>>>> deleted file mode 100644
>>>>> index 18ca517c..00000000
>>>>> --- a/tests/xfs/260.out
>>>>> +++ /dev/null
>>>>> @@ -1,2 +0,0 @@
>>>>> -QA output created by 260
>>>>> -Silence is golden
>>>>> diff --git a/tests/xfs/group b/tests/xfs/group
>>>>> index daf54add..71c30898 100644
>>>>> --- a/tests/xfs/group
>>>>> +++ b/tests/xfs/group
>>>>> @@ -257,7 +257,6 @@
>>>>>    257 auto quick clone
>>>>>    258 auto quick clone
>>>>>    259 auto quick
>>>>> -260 auto attr quick dax
>>>>>    261 auto quick quota
>>>>>    262 dangerous_fuzzers dangerous_scrub dangerous_online_repair
>>>>>    263 auto quick quota
>>>>> -- 
>>>>> 2.21.0
>>>>>
>>>>>
>>>>>
>>>>
>>>> .
>>>>
>>>
>>>
>>
>> .
>>
>
>
>
> .
>



