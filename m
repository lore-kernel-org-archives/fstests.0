Received: from mx2.suse.de ([195.135.220.15]:36762 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725857AbfDCJpv (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 3 Apr 2019 05:45:51 -0400
From: Luis Henriques <lhenriques@suse.com>
Subject: Re: [RFC PATCH 2/2] ceph: test basic ceph.quota.max_bytes quota
References: <20190402103428.21435-1-lhenriques@suse.com>
        <20190402103428.21435-3-lhenriques@suse.com>
        <20190402210931.GV23020@dastard>
Date: Wed, 03 Apr 2019 10:45:48 +0100
In-Reply-To: <20190402210931.GV23020@dastard> (Dave Chinner's message of "Wed,
        3 Apr 2019 08:09:31 +1100")
Message-ID: <87d0m3e81f.fsf@suse.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, "Yan, Zheng" <zyan@redhat.com>, ceph-devel@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Dave Chinner <david@fromorbit.com> writes:

> On Tue, Apr 02, 2019 at 11:34:28AM +0100, Luis Henriques wrote:
>> Simple set of checks for CephFS max_bytes directory quota implementation.
>> 
>> Signed-off-by: Luis Henriques <lhenriques@suse.com>
>> ---
>>  tests/ceph/002     | 147 +++++++++++++++++++++++++++++++++++++++++++++
>>  tests/ceph/002.out |   1 +
>>  tests/ceph/group   |   1 +
>>  3 files changed, 149 insertions(+)
>>  create mode 100755 tests/ceph/002
>>  create mode 100644 tests/ceph/002.out
>> 
>> diff --git a/tests/ceph/002 b/tests/ceph/002
>> new file mode 100755
>> index 000000000000..313865dc639e
>> --- /dev/null
>> +++ b/tests/ceph/002
>> @@ -0,0 +1,147 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2019 SUSE LLC. All Rights Reserved.
>> +#
>> +# FS QA Test No. 002
>> +#
>> +# This tests basic ceph.quota.max_bytes quota features.
>> +#
>> +
>> +seq=`basename $0`
>> +seqres=$RESULT_DIR/$seq
>> +echo "QA output created by $seq"
>> +
>> +testdir=$TEST_DIR/quota-test
>
> Try not to name local variables the same as when known global
> variables. When we talk about "test dir", we mean the mount point
> for the test device, not the local, tests specific work directory.
>  i.e. this is a "work dir", not a "test dir".
>
> And, often, we just name them after the test that is running,
> so we can identify what test left them behind. i.e.
>
> workdir=$TEST_DIR/$seq
>
>> +
>> +tmp=/tmp/$$
>> +status=1    # failure is the default!
>> +trap "_cleanup; exit \$status" 0 1 2 3 15
>> +
>> +_cleanup()
>> +{
>> +	cd /
>> +	rm -rf $tmp.*
>> +	rm -rf $testdir
>
> Leave it behind for post-mortem analysis if necessary, remove it
> before starting this test execution....
>
>> +}
>> +
>> +# get standard environment, filters and checks
>> +. ./common/rc
>> +. ./common/filter
>> +. ./common/attr
>> +
>> +# real QA test starts here
>> +_supported_os Linux
>> +_supported_fs ceph
>> +
>> +_require_attrs
>> +
>> +set_quota()
>> +{
>> +	val=$1
>> +	dir=$2
>> +	$SETFATTR_PROG -n ceph.quota.max_bytes -v $val $dir >/dev/null 2>&1
>> +}
>> +
>> +get_quota()
>> +{
>> +	dir=$1
>> +	$GETFATTR_PROG --only-values -n ceph.quota.max_bytes $dir 2> /dev/null
>> +}
>> +
>> +# function to write a file.  We use a loop because quotas in CephFS is a
>> +# "best-effort" implementation, i.e. a write may actually be allowed even if the
>> +# quota is being exceeded.  Using a loop reduces the chances of this to happen.
>> +#
>> +# NOTE: 'size' parameter is in M
>
> xfs_io accepts "1m" as one megabyte.
>
>> +write_file()
>> +{
>> +	file=$1
>> +	size=$2 # size in M
>> +	for (( i = 1; i < $size; i++ )); do
>> +		$XFS_IO_PROG -f -c "pwrite -W $((i * 1048576)) 1048576" \
>> +			     $file >/dev/null 2>&1
>> +	done
>> +}
>
> Makes no sense to me. xfs_io does a write() loop internally with
> this pwrite command of 4kB writes - the default buffer size. If you
> want xfs_io to loop doing 1MB sized pwrite() calls, then all you
> need is this:
>
> 	$XFS_IO_PROG -f -c "pwrite -w -B 1m 0 ${size}m" $file | _filter_xfs_io
>

Thank you for your review, Dave.  I'll make sure the next revision of
these tests will include all your comments implemented... except for
this one.

The reason I'm using a loop for writing a file is due to the nature of
the (very!) loose definition of quotas in CephFS.  Basically, clients
will likely write some amount of data over the configured limit because
the servers they are communicating with to write the data (the OSDs)
have no idea about the concept of quotas (or files even); the filesystem
view in the cluster is managed at a different level, with the help of
the MDS and the client itself.

So, the loop in this function is simply to allow the metadata associated
with the file to be updated while we're writing the file.  If I use a
single pwrite, the whole file will be written before we get a -EDQUOT.

If an admin wants to really enforce some hard quotas in the filesystem,
there are other means to do that, but not at the filesystem level.
There are some more details on the quota implementation in Ceph here:

  http://docs.ceph.com/docs/master/cephfs/quota/

I hope this makes sense and helps understanding why I need a loop to be
used in this test.

Cheers
-- 
Luis

>> +
>> +# Check a file size
>> +#
>> +# NOTE: 'expected' (size) parameter is in M
>> +check_file_size()
>> +{
>> +	file=$1
>> +	expected=$(($2 * 1048576))
>> +	size=$(stat -c %s $file)
>> +	if [ "$size" -ne "$expected" ]; then
>> +		_fail "Expecting file with $expected got $size"
>> +	fi
>
> Just emit the size into the output, and if it's not the correct size
> the test will fail because of a golden output mismatch.
>
> i.e. just do:
>
> stat -c %s $file
>
> and nothing else.
>
>> +}
>> +
>> +mkdir $testdir
>> +
>> +# test setting quota
>> +set_quota 1000000 $testdir
>> +ret=$(get_quota $testdir)
>> +if [ "$ret" -ne 1000000 ]; then
>> +	_fail "expected max_bytes quota to be 1000000, got '$ret' instead"
>> +fi
>
> Ditto. You should almost never need to use "if [comparison] then _fail
> ...." in fstests, because the golden output matching is precisely
> for this purpose.
>
>> +# set quota to largest acceptable value (0x7FFFFFFFFFFFFFFF)
>> +set_quota 9223372036854775807 $testdir
>> +ret=$(get_quota $testdir)
>> +if [ "$ret" -ne 9223372036854775807 ]; then
>> +	_fail "expected max_bytes quota to be 9223372036854775807, got '$ret' instead"
>> +fi
>> +# test resetting quota
>> +set_quota 0 $testdir
>> +ret=$(get_quota $testdir)
>> +if [ -n "$ret" ]; then
>> +	_fail "expected 0 max_bytes quota, got '$ret' instead"
>> +fi
>> +# set quota to invalid values (0x8000000000000000 and -1)
>> +set_quota 9223372036854775808 $testdir
>> +ret=$(get_quota $testdir)
>> +if [ -n "$ret" ]; then
>> +	_fail "expected max_bytes quota to be 0, got '$ret' instead"
>> +fi
>> +set_quota -1 $testdir
>> +ret=$(get_quota $testdir)
>> +if [ -n "$ret" ]; then
>> +	_fail "expected max_bytes quota to be 0, got '$ret' instead"
>> +fi
>
> But didn't you test these boundary conditions in the last test? Why
> repeat them here?
>
>> +bigfile="$testdir/bigfile"
>> +
>> +# set quota to 10M
>> +set_quota $((10 * 1048576)) $testdir
>> +
>> +# write 9M file
>> +write_file $bigfile 9
>> +check_file_size $bigfile 9
>> +rm $bigfile
>
> which is:
>
> $XFS_IO_PROG -f -c "pwrite -W -B 1m 0 9m" $bigfile | _filter_xfs_io
> stat -c %s $bigfile
> rm -f $bigfile
>
> So no need for functions here...
>
>> diff --git a/tests/ceph/002.out b/tests/ceph/002.out
>> new file mode 100644
>> index 000000000000..c57ca23e5cbe
>> --- /dev/null
>> +++ b/tests/ceph/002.out
>> @@ -0,0 +1 @@
>> +QA output created by 002
>
> An empty golden image file and lots of _fail calls in the test is an
> indication you are probably not quite doing things the right way :P
>
> Cheers,
>
> Dave.
