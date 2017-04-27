Received: from sandeen.net ([63.231.237.45]:56764 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933442AbdD0MSn (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 27 Apr 2017 08:18:43 -0400
Subject: Re: [PATCH v2] xfs/288: test xfs_growfs to ensure rejection if target
 isn't mounted
References: <20170424150935.28707-1-billodo@redhat.com>
 <20170426220547.28517-1-billodo@redhat.com>
 <20170427120903.GI26397@eguan.usersys.redhat.com>
From: Eric Sandeen <sandeen@sandeen.net>
Message-ID: <6d521d74-3998-5ada-5e60-936fdc469af7@sandeen.net>
Date: Thu, 27 Apr 2017 07:18:41 -0500
MIME-Version: 1.0
In-Reply-To: <20170427120903.GI26397@eguan.usersys.redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>, Bill O'Donnell <billodo@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 4/27/17 7:09 AM, Eryu Guan wrote:
> On Wed, Apr 26, 2017 at 05:05:47PM -0500, Bill O'Donnell wrote:
>> The manpage for xfs_growfs specifies that the file/dir to be
>> grown must be mounted. This is a test to ensure that if the
>> target isn't mounted, the command is rejected. The intention
>> is to test the command response, but not necessarily the
>> functionality of xfs_growfs. Absolute paths and relative paths
>> are covered, including symbolic links and bind mounts.
>>
>> Signed-off-by: Bill O'Donnell <billodo@redhat.com>
>> ---
>> v2: acually grow the fs as test proceeds; add filter, preventing
>>     superfluous stdio verbiage; add test for (unmounted) file; add
>>     description to commit message to clarify that this isn't a test
>>     for xfs_growfs functionality, but rather a test of command
>>     argument accepts and rejections.
>>
>>  tests/xfs/288     | 124 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  tests/xfs/288.out |  23 ++++++++++
>>  tests/xfs/group   |   1 +
>>  3 files changed, 148 insertions(+)
>>  create mode 100755 tests/xfs/288
>>  create mode 100644 tests/xfs/288.out
>>
>> diff --git a/tests/xfs/288 b/tests/xfs/288
>> new file mode 100755
>> index 0000000..51f5c32
>> --- /dev/null
>> +++ b/tests/xfs/288
>> @@ -0,0 +1,124 @@
>> +#! /bin/bash
>> +# FS QA Test 288
>> +#
>> +# Test to ensure xfs_growfs command rejects non-existent mount points
>> +# and accepts mounted targets.
> I noticed Eric's comments to the v3 xfsprogs patch, I think this
> description and commit summary can be updated too :)
> 
>> +#
>> +#-----------------------------------------------------------------------
>> +# Copyright (c) 2017 Red Hat, Inc.  All Rights Reserved.
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
>> +status=1	# failure is the default!
>> +trap "_cleanup; exit \$status" 0 1 2 3 15
>> +
>> +_cleanup()
>> +{
>> +    umount $tmpdir
>> +    umount $tmpbind
> $UMOUNT_PROG
> 
>> +    rmdir $tmpdir
>> +    rm -f $tmpsymlink
>> +    rmdir $tmpbind
>> +    rm -f $tmp
> rm -f $tmp.*
> 
> $tmp itself is not used.
> 
>> +    rm -f $tmpfile
>> +}
>> +
>> +# get standard environment, filters and checks
>> +. ./common/rc
>> +. ./common/filter
>> +
>> +# remove previous $seqres.full before test
>> +rm -f $seqres.full
>> +
>> +# real QA test starts here
>> +
>> +# Modify as appropriate.
>> +_supported_fs xfs
>> +_supported_os Linux
>> +_require_test
>> +_require_loop
>> +
>> +tmpfile=$TEST_DIR/fsfile
>> +tmpdir=$TEST_DIR/tmpdir
>> +tmpsymlink=$TEST_DIR/tmpsymlink.$$
>> +tmpbind=$TEST_DIR/tmpbind.$$
>> +
>> +mkdir -p $tmpdir || _fail "!!! failed to create temp mount dir"
>> +
>> +echo "=== mkfs.xfs ==="
>> +$MKFS_XFS_PROG -d file,name=$tmpfile,size=16m -f | _filter_mkfs 2>$tmp.mkfs >/dev/null
> I don't see how $tmp.mkfs was used in this test, seems we can discard
> mkfs output directly, the _filter_mkfs seems useless.
> 
> $MKFS_XFS_PROG -d file,name=$tmpfile,size=16m -f >/dev/null 2>&1

I had suggested _filter_mkfs at one point but that was bad advice,
sorry.  Yes, by the time all of stdout gets eaten, there's no need
for using the filter at all.

Thanks,
-Eric
 
