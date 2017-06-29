Received: from cn.fujitsu.com ([59.151.112.132]:10935 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751613AbdF2Fri (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 29 Jun 2017 01:47:38 -0400
Message-ID: <59549473.1040400@cn.fujitsu.com>
Date: Thu, 29 Jun 2017 13:47:31 +0800
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH] xfs: test a race between dio reads and mapped writes
References: <1498554232-20777-1-git-send-email-yangx.jy@cn.fujitsu.com> <20170628101329.GH23360@eguan.usersys.redhat.com> <59547B95.9000905@cn.fujitsu.com> <20170629043402.GJ23360@eguan.usersys.redhat.com> <59548E48.5030405@cn.fujitsu.com> <20170629053943.GK23360@eguan.usersys.redhat.com>
In-Reply-To: <20170629053943.GK23360@eguan.usersys.redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 2017/06/29 13:39, Eryu Guan wrote:
> On Thu, Jun 29, 2017 at 01:21:12PM +0800, Xiao Yang wrote:
>> On 2017/06/29 12:34, Eryu Guan wrote:
>>> On Thu, Jun 29, 2017 at 12:01:25PM +0800, Xiao Yang wrote:
>>>> On 2017/06/28 18:13, Eryu Guan wrote:
>>>>> On Tue, Jun 27, 2017 at 05:03:52PM +0800, Xiao Yang wrote:
>>>>>> This regression test reproduces a race between a direct
>>>>>> I/O read and a mapped write to a hole in a file.  If the
>>>>>> race occurs, it will trigger a BUG_ON().  This XFS bug
>>>>>> has been fixed by:
>>>>>>
>>>>>> 04197b3 (xfs: don't BUG() on mixed direct and mapped I/O)
>>>>>>
>>>>>> Signed-off-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
>>>>>> ---
>>>>>>     tests/xfs/422     | 86 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>>>>>     tests/xfs/422.out |  2 ++
>>>>>>     tests/xfs/group   |  1 +
>>>>>>     3 files changed, 89 insertions(+)
>>>>>>     create mode 100755 tests/xfs/422
>>>>>>     create mode 100644 tests/xfs/422.out
>>>>>>
>>>>>> diff --git a/tests/xfs/422 b/tests/xfs/422
>>>>>> new file mode 100755
>>>>>> index 0000000..a57ffab
>>>>>> --- /dev/null
>>>>>> +++ b/tests/xfs/422
>>>>>> @@ -0,0 +1,86 @@
>>>>>> +#! /bin/bash
>>>>>> +# FS QA Test No. 422
>>>>>> +#
>>>>>> +# Regression test for commit:
>>>>>> +# 04197b3 ("xfs: don't BUG() on mixed direct and mapped I/O)
>>>>>                 ^^ missing ending " :)
>>>>>> +#
>>>>>> +# This case tests a race between a direct I/O read and a
>>>>>> +# mapped write to a hole in a file.  If the race occurs,
>>>>>> +# it will trigger a BUG_ON().
>>>>>> +#
>>>>>> +#-----------------------------------------------------------------------
>>>>>> +# Copyright (c) 2017 Fujitsu.  All Rights Reserved.
>>>>>> +# Author: Xiao Yang<yangx.jy@cn.fujitsu.com>
>>>>>> +#
>>>>>> +# This program is free software; you can redistribute it and/or
>>>>>> +# modify it under the terms of the GNU General Public License as
>>>>>> +# published by the Free Software Foundation.
>>>>>> +#
>>>>>> +# This program is distributed in the hope that it would be useful,
>>>>>> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
>>>>>> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>>>>> +# GNU General Public License for more details.
>>>>>> +#
>>>>>> +# You should have received a copy of the GNU General Public License
>>>>>> +# along with this program; if not, write the Free Software Foundation,
>>>>>> +# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
>>>>>> +#-----------------------------------------------------------------------
>>>>>> +
>>>>>> +seq=`basename $0`
>>>>>> +seqres=$RESULT_DIR/$seq
>>>>>> +echo "QA output created by $seq"
>>>>>> +
>>>>>> +here=`pwd`
>>>>>> +tmp=/tmp/$$
>>>>>> +status=1    # failure is the default!
>>>>>> +trap "_cleanup; exit \$status" 0 1 2 3 15
>>>>>> +
>>>>>> +_cleanup()
>>>>>> +{
>>>>>> +	rm -rf $tmp.*
>>>>>> +}
>>>>>> +
>>>>>> +# get standard environment and checks
>>>>>> +. ./common/rc
>>>>>> +
>>>>>> +# real QA test starts here
>>>>>> +_supported_os Linux
>>>>>> +_supported_fs xfs
>>>>> I see nothing xfs specific in this test, I think it can be made generic
>>>>> easily.
>>>> Hi Eryu,
>>>>
>>>> Agreed.  It could be moved into generic.
>>>>>> +_require_scratch
>>>>>> +_disable_dmesg_check
>>>>> Better to add comments on ignoring dmesg check result.
>>>> For xfs filesystem, this race triggers various warnings on some
>>>> distributions(RHEL7) and upstream kernel.
>>>> e.g,
>>>> 1) This race triggers the following warnings on RHEL7.3GA
>>>> -----------------------------------------------------------------------------------------------------------------------------
>>>> [    0.297084] WARNING: at arch/x86/mm/ioremap.c:101
>>>> __ioremap_caller+0x238/0x320()
>>> I'm not sure about this one, but the other xfs or iomap warnings are
>>> "known issues" when mixing direct I/O and mmap I/O on the same file.
>>> We've filtered out these intentional warnings in generic/095, and Brian
>>> has just sent a patch[1] to move this filter to common/xfs and added it
>>> to generic/247. I think you can do the same to this new test, filter out
>>> these known warnings so we won't miss any other potential bug.
>>>
>>> I don't think disable dmesg check only because it triggers warnings is a
>>> good idea :)
>> Hi Eryu
>>
>> It sounds reasonable to me.   I will filter out these known warnings instead
>> of disabling dmesg check.
>>> Thanks,
>>> Eryu
>>>
>>> [1] [PATCH] generic/247: filter out expected XFS warnings for mixed mmap/direct I/O
>>>
>>>> [  648.745481] WARNING: at fs/xfs/xfs_aops.c:1244
>>>> xfs_vm_releasepage+0xcb/0x100 [xfs]()
>>>> [  648.745694] WARNING: at fs/xfs/xfs_file.c:377
>>>> xfs_file_aio_read+0x2dd/0x340 [xfs]()
>>>> -----------------------------------------------------------------------------------------------------------------------------
>>>> 2) It triggers the following warnings on RHEL7.4Beta
>>>> ----------------------------------------------------------------------------------------------------------------------------
>>>> [  497.575319] WARNING: CPU: 0 PID: 26865 at fs/xfs/xfs_file.c:361
>>>> xfs_file_dio_aio_read+0x1ba/0x2a0 [xfs]
>>>> [  497.577651] WARNING: CPU: 0 PID: 26865 at fs/xfs/xfs_aops.c:1285
>>>> __xfs_get_blocks+0x8ca/0x8e0 [xfs]
>> Could we add __xfs_get_blocks into filter_xfs_dmesg? :-)
>>
>> This known warning was introduced by:
>> 04197b3 (xfs: don't BUG() on mixed direct and mapped I/O)
>>
>> It has been removed by:
>> acdda3a (xfs: use iomap_dio_rw)
> Please send another patch with detailed background information to add it
> to the filter and cc linux-xfs list, perhaps after both Brian's patch
> and this new test patch being merged&  pushed out to upstream. Thanks a
> lot!
Hi Eryu

Thanks for your suggestion, I will send another patch as you said. :-)

Thanks,
Xiao Yang.
> Eryu
>
>
> .
>



