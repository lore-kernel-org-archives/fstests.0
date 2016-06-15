Received: from cn.fujitsu.com ([59.151.112.132]:25831 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932860AbcFODku (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 14 Jun 2016 23:40:50 -0400
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
	by cn.fujitsu.com (Postfix) with ESMTP id 32BD8409257A
	for <fstests@vger.kernel.org>; Wed, 15 Jun 2016 11:40:40 +0800 (CST)
Message-ID: <5760CEDC.20202@cn.fujitsu.com>
Date: Wed, 15 Jun 2016 11:43:24 +0800
From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2] shared: regression test for hang when processing corrupted
 orphaned inode list
References: <20160613093350.GJ5140@eguan.usersys.redhat.com> <1465873139-8724-1-git-send-email-fenggw-fnst@cn.fujitsu.com> <20160614043942.GN5140@eguan.usersys.redhat.com> <20160615033537.GV5140@eguan.usersys.redhat.com>
In-Reply-To: <20160615033537.GV5140@eguan.usersys.redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

Hi, Eryu.
Thanks for your review and kindly reply!

On 06/15/2016 11:35 AM, Eryu Guan wrote:
> On Tue, Jun 14, 2016 at 12:39:42PM +0800, Eryu Guan wrote:
>> On Tue, Jun 14, 2016 at 10:58:59AM +0800, Guangwen Feng wrote:
>>> Commit c9eb13a fixed this bug:
>>> 	ext4: fix hang when processing corrupted orphaned inode list
>>>
>>> Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
>>
>> Looks good to me overall. Some minor issues inline below
>>
> [snip]
>>
>>> +	debugfs -w -R "ssv last_orphan $i" $SCRATCH_DEV >>$seqres.full 2>&1
>>
>> You defined $DEBUGFS_PROG, use it here :)
>>
>>> +	_scratch_mount
>>> +	_scratch_unmount
>>
>> There's a new helper to do this now, _scratch_cycle_mount
> 
> Sorry, the helper doesn't help here, it umount first then mount.  You're
> doing mount then umount.

Got it.
I was just writing to explain this actually. :)
Thanks again.

> 
> Thanks,
> Eryu
> 
> 
> 


