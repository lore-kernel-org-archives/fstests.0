Received: from cn.fujitsu.com ([59.151.112.132]:58326 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752375AbbKYBXA (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 24 Nov 2015 20:23:00 -0500
Subject: Re: [PATCH] fstests: Update generic/077 for newest version of btrfs
 progs
References: <22cee31ea262eb30d3243bcd5bc05dcfe16a9440.1448272550.git.zhaolei@cn.fujitsu.com>
 <20151124044159.GO19199@dastard>
From: Qu Wenruo <quwenruo@cn.fujitsu.com>
Message-ID: <56550D50.3030907@cn.fujitsu.com>
Date: Wed, 25 Nov 2015 09:22:24 +0800
MIME-Version: 1.0
In-Reply-To: <20151124044159.GO19199@dastard>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>, Zhaolei <zhaolei@cn.fujitsu.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>



Dave Chinner wrote on 2015/11/24 15:41 +1100:
> On Mon, Nov 23, 2015 at 05:55:58PM +0800, Zhaolei wrote:
>> From: Zhao Lei <zhaolei@cn.fujitsu.com>
>>
>> generic/077 fails on btrfs progs v4.3:
>>   # ./check generic/077
>>   FSTYP         -- btrfs
>>   PLATFORM      -- Linux/x86_64 lenovo 4.4.0-rc2_HEAD_1ec218373b8ebda821aec00bb156a9c94fad9cd4_
>>   MKFS_OPTIONS  -- /dev/sdb6
>>   MOUNT_OPTIONS -- /dev/sdb6 /var/ltf/tester/scratch_mnt
>>
>>   generic/077 344s ... [failed, exit status 1] - output mismatch (see /var/lib/xfstests/results//generic/077.out.bad)
>>       --- tests/generic/077.out   2015-11-23 17:06:27.144983112 +0800
>>       +++ /var/lib/xfstests/results//generic/077.out.bad  2015-11-23 17:41:25.187062895 +0800
>>       @@ -1,7 +1,5 @@
>>        QA output created by 077
>>        *** create filesystem
>>       -*** set default ACL
>>       -*** populate filesystem, pass #1
>>       -*** populate filesystem, pass #2
>>       -*** all done
>>       +mkfs failed
>>       +(see /var/lib/xfstests/results//generic/077.full for details)
>>        *** unmount
>>   Ran: generic/077
>>   Failures: generic/077
>>   Failed 1 of 1 tests
>>
>> Reason:
>>   btrfs progs v4.3 use non-mixed blockgroup for small volume as default,
>>   it need at least 100M to build a filesystem.
>
> <sigh>
>
> btrfs got broken again.
>
>> Fix:
>>   We can force mixed block group for btrfs, or increase filesystem
>>   size to btrfs's least requirement to make test works, the first
>>   way create a non-common filesystem in btrfs case, so this patch
>>   use the second way.
>
> No. This is a clear mkfs.btrfs regression, so the mkfs.btrfs default
> behaviour needs to be changed back to something that works for small
> filesystems.  Anyone who makes a <100MB btrfs filesytsem is going to
> need to use that mixed block group option, so that needs to be what
> the test uses here.
>
> Cheers,
>
> Dave.
>
Hi Dave,

I'm a little curious about fstests support for make small fs.

It's not strange that all filesystems have a requirement on the 
filesystem size, for btrfs it's a little larger than normal fs anyway.

Yes, this bug reported by Zhao is definitely a regression of mkfs.btrfs, 
and I'll enhance the size checking part of mkfs.btrfs.

But I hope fstests can have a generic API to make small fs other than 
current mkfs_sized without any good check on filesystem size.

What about the following idea?
1) Do normal mkfs_size
    But save the error output (it's saved anyway)

2) If mkfs failed, check mkfs dependent output
    For example, for mkfs.xfs, it will output like "agsize (256 blocks)
    too small, need at least 4096 blocks" and we can calculate the
    fs needs to be at least 16M for xfs.

    For btrfs, mkfs.btrfs will also output things like "Minimum size for
    each btrfs device is 41943040." and we can use it to create a small
    fs. (Although the output is totally wrong for non-mixed-bg case)

3) If mkfs didn't provide that size, use a fallback value
    Like old mkfs.btrfs, which doesn't provide such thing (and will just
    crash), use a per-file-system value as fallback.

Personally speaking, if the filesystem is a little larger than 
mkfs_sized parameter, it should not affect the testcases much, will only 
increase the time needed.

Thanks,
Qu

-- 
This message has been scanned for viruses and
dangerous content by Fujitsu, and is believed to be clean.

