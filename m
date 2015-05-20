Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:55754 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752472AbbETNqz (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 20 May 2015 09:46:55 -0400
Message-ID: <555C9044.3090208@fb.com>
Date: Wed, 20 May 2015 09:46:44 -0400
From: Josef Bacik <jbacik@fb.com>
MIME-Version: 1.0
Subject: Re: [PATCH] fstests: add generic/327 to test fallocate+truncate
References: <1432049382-3700-1-git-send-email-jbacik@fb.com> <20150520110310.GW1140@dhcp-13-216.nay.redhat.com>
In-Reply-To: <20150520110310.GW1140@dhcp-13-216.nay.redhat.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 05/20/2015 07:03 AM, Eryu Guan wrote:
> On Tue, May 19, 2015 at 11:29:42AM -0400, Josef Bacik wrote:
>> There was some confused about what the fs was supposed to do when you truncate
>> at i_size with preallocated space past i_size.  We decided on the following
>> things
>>
>> 1) truncate(i_size) will trim all blocks past i_size.
>> 2) truncate(x) where x > i_size will not trim all blocks past i_size.
>>
>> This test is to make sure we're all acting sanely.  Thanks,
>>
>> Signed-off-by: Josef Bacik <jbacik@fb.com>
>
> Looks good to me overall, tested with ext4, (v4/v5)xfs and btrfs, ext4
> and btrfs failed the test, xfs passed.
>

Yeah there's patches for ext4 and btrfs to make the test pass.

> Just some minor issues inline
>
>> ---
>>   tests/generic/327     | 72 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>   tests/generic/327.out |  6 +++++
>>   tests/generic/group   |  1 +
>>   3 files changed, 79 insertions(+)
>>   create mode 100644 tests/generic/327
>
> changing mode to 755 is better, git diff won't complains about the mode
> change after running the test.
>
>>   create mode 100644 tests/generic/327.out
>>
>> diff --git a/tests/generic/327 b/tests/generic/327
>> new file mode 100644
>> index 0000000..a3eafeb
>> --- /dev/null
>> +++ b/tests/generic/327
>> @@ -0,0 +1,72 @@
>> +#! /bin/bash
>> +# FS QA Test No. 327
>> +#
>> +# fallocate/truncate tests with FALLOC_FL_KEEP_SIZE option.
>> +# Verify if the disk space is released after truncating a file to i_size after
>> +# writing to a portion of a preallocated range.
>> +#
>> +# This also verifies that truncat'ing up past i_size doesn't remove the
>> +# preallocated space.
>> +#
>> +#-----------------------------------------------------------------------
>> +# Copyright (c) 2015 Facebook.  All Rights Reserved.
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
>> +here=`pwd`
>> +tmp=/tmp/$$
>> +status=0	# success is the default!
>> +trap "_cleanup; exit \$status" 0 1 2 3 15
>> +
>> +_cleanup()
>> +{
>> +    cd /
>> +    rm -f $tmp.*
>
> use tab instead of 4 spaces here for indention
>
>> +}
>> +
>> +# get standard environment, filters and checks
>> +. ./common/rc
>> +. ./common/filter
>> +. ./common/punch
>> +
>> +# real QA test starts here
>> +
>> +# Modify as appropriate.
>> +_supported_fs generic
>> +_supported_os Linux
>> +_require_test
>> +_require_xfs_io_command "falloc"
>
> need _require_fiemap too
>
>> +
>> +rm -f $seqres.full
>
> this file is not used, the rm seems unnecessary
>
>> +
>> +# First test to make sure that truncating at i_size trims the preallocated bit
>> +# past i_size
>> +$XFS_IO_PROG -f -c "falloc -k 0 10M" -c "pwrite 0 5M" -c "truncate 5M"\
>> +	$TEST_DIR/testfile.$seq | _filter_xfs_io
>> +sync
>> +$XFS_IO_PROG -c "fiemap -v" $TEST_DIR/testfile.$seq | _filter_fiemap
>> +
>> +# Now verify that if we truncate up past i_size we don't trim the preallocated
>> +# bit
>> +$XFS_IO_PROG -c "falloc -k 5M 5M" -c "truncate 7M" $TEST_DIR/testfile.$seq
>> +$XFS_IO_PROG -c "fiemap -v" $TEST_DIR/testfile.$seq | _filter_fiemap
>> +
>> +# success, all done
>> +exit
>> diff --git a/tests/generic/327.out b/tests/generic/327.out
>> new file mode 100644
>> index 0000000..af35cd2
>> --- /dev/null
>> +++ b/tests/generic/327.out
>> @@ -0,0 +1,6 @@
>> +QA output created by 327
>> +wrote 5242880/5242880 bytes at offset 0
>> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> +0: [0..10239]: data
>> +0: [0..10239]: data
>> +1: [10240..20479]: unwritten
>> diff --git a/tests/generic/group b/tests/generic/group
>> index 927a91a..09bf1a5 100644
>> --- a/tests/generic/group
>> +++ b/tests/generic/group
>> @@ -193,3 +193,4 @@
>>   324 auto fsr quick
>>   325 auto quick data log
>>   326 auto log
>> +327 auto quick
>
> add to prealloc group too? and use first available seq number?

Yup I'll do that, thanks,

Josef
