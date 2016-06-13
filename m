Received: from cn.fujitsu.com ([59.151.112.132]:57372 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S965022AbcFMKMq (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 13 Jun 2016 06:12:46 -0400
Message-ID: <575E87B8.4060404@cn.fujitsu.com>
Date: Mon, 13 Jun 2016 18:15:20 +0800
From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH] ext4: regression test for hang when processing corrupted
 orphaned inode list
References: <1465808952-9606-1-git-send-email-fenggw-fnst@cn.fujitsu.com> <20160613093350.GJ5140@eguan.usersys.redhat.com>
In-Reply-To: <20160613093350.GJ5140@eguan.usersys.redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hi!

Thanks for your review and kindly reply.
I will rewrite the patch according to your suggestion.

On 06/13/2016 05:33 PM, Eryu Guan wrote:
> On Mon, Jun 13, 2016 at 05:09:12PM +0800, Guangwen Feng wrote:
>> Commit c9eb13a fixed this bug:
>> 	ext4: fix hang when processing corrupted orphaned inode list
>>
>> Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
>> ---
>>  tests/ext4/022     | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  tests/ext4/022.out |  1 +
>>  tests/ext4/group   |  1 +
>>  3 files changed, 57 insertions(+)
>>  create mode 100755 tests/ext4/022
>>  create mode 100644 tests/ext4/022.out
>>
>> diff --git a/tests/ext4/022 b/tests/ext4/022
>> new file mode 100755
>> index 0000000..a3cc094
>> --- /dev/null
>> +++ b/tests/ext4/022
>> @@ -0,0 +1,55 @@
>> +#! /bin/bash
>> +# FS QA Test 022
>> +#
>> +# Regression test for commit:
>> +# c9eb13a ext4: fix hang when processing corrupted orphaned inode list
>> +#
>> +#-----------------------------------------------------------------------
>> +# Copyright (c) 2016 Fujitsu.  All Rights Reserved.
>> +#
>> +# This program is free software; you can redistribute it and/or
>> +# modify it under the terms of the GNU General Public License as
>> +# published by the Free Software Foundation.
>> +#
>> +# This program is distributed in the hope that it would be useful,
>> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
>> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> +# GNU General Public License for more details.
>> +#
>> +# You should have received a copy of the GNU General Public License
>> +# along with this program; if not, write the Free Software Foundation,
>> +# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
>> +#-----------------------------------------------------------------------
>> +#
>> +
>> +seq=`basename $0`
>> +seqres=$RESULT_DIR/$seq
>> +echo "QA output created by $seq"
>> +
>> +status=1	# failure is the default!
>> +trap "_cleanup; exit \$status" 0 1 2 3 15
>> +
>> +_cleanup()
>> +{
>> +    cd /
> 
> Please use tab not space for indention.
> 
> And I think we need "rm -f $tmp.*" in _cleanup() even if you don't take
> use any $tmp.* files, because helper functions may use the tmp files
> internally, we should remove them as well.
> 
>> +}
>> +
>> +# get standard environment, filters and checks
>> +. ./common/rc
>> +
>> +# remove previous $seqres.full before test
>> +rm -f $seqres.full
>> +
>> +# real QA test starts here
>> +_supported_fs ext4
> 
> It could support ext2/ext3 as well, and move the test to shared
> directory, as what shared/001 does.
> 
>> +_supported_os Linux
>> +_require_scratch
>> +_require_debugfs
> 
> This requires debugfs pseudo filesystem, not debugfs binary. Use
> _require_command "$DEBUGFS_PROG" debugfs
> 
> But you may want to define $DEBUGFS_PROG first in common/config.
> 
>> +
>> +_scratch_mkfs >>$seqres.full 2>&1
>> +debugfs -w -R "ssv last_orphan 5" $SCRATCH_DEV >>$seqres.full 2>&1
> 
> Though the bug only happens when last_orphan is set to 5, I think we can
> test all reserved inode numbers, 1-10, 11 is the first non-reserved
> inode.
> 
>> +_scratch_mount
>> +
>> +# success, all done
>> +status=0
>> +exit
>> diff --git a/tests/ext4/022.out b/tests/ext4/022.out
>> new file mode 100644
>> index 0000000..0266a8a
>> --- /dev/null
>> +++ b/tests/ext4/022.out
>> @@ -0,0 +1 @@
>> +QA output created by 022
> 
> You need a "Silence is golden" in golden image to indicate that this
> test doesn't expect any output.
> 
>> diff --git a/tests/ext4/group b/tests/ext4/group
>> index 9e28159..3e0146b 100644
>> --- a/tests/ext4/group
>> +++ b/tests/ext4/group
>> @@ -23,6 +23,7 @@
>>  018 fuzzers
>>  019 fuzzers
>>  020 auto quick ioctl rw
>> +022 auto quick
> 
> If you're not using big seq number on purpose, pick the smallest
> available sequence number, that's 021 in this case.

I see there is a 021 in the mailing list:
fstests: ext4: regression test for fsync transaction ids initialization

Anyway, I will change it to the smallest available sequence number for now.

Best Regards,
Guangwen Feng

> 
> Thanks,
> Eryu
> 
>>  271 auto rw quick
>>  301 aio auto ioctl rw stress
>>  302 aio auto ioctl rw stress
>> -- 
>> 1.8.4.2
>>
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe fstests" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> .
> 


