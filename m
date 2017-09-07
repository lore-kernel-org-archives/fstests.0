Received: from mail-yw0-f171.google.com ([209.85.161.171]:36343 "EHLO
        mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755221AbdIGJfA (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 7 Sep 2017 05:35:00 -0400
MIME-Version: 1.0
In-Reply-To: <20170907075511.GP8034@eguan.usersys.redhat.com>
References: <1504638680-25682-1-git-send-email-amir73il@gmail.com>
 <1504638680-25682-14-git-send-email-amir73il@gmail.com> <20170907075511.GP8034@eguan.usersys.redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 7 Sep 2017 12:34:58 +0300
Message-ID: <CAOQ4uxjbfr1VRw_-NmLVs1Qop8Z+fB1eF5RA1Q0HMamdbND8_g@mail.gmail.com>
Subject: Re: [PATCH v3 13/13] fstests: regression test for xfs leftover CoW
 extent error
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Josef Bacik <jbacik@fb.com>, fstests <fstests@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Theodore Tso <tytso@mit.edu>, "Darrick J. Wong" <darrick.wong@oracle.com>
List-ID: <fstests@vger.kernel.org>

On Thu, Sep 7, 2017 at 10:55 AM, Eryu Guan <eguan@redhat.com> wrote:
> On Tue, Sep 05, 2017 at 10:11:20PM +0300, Amir Goldstein wrote:
>> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>
> Better to have some more descriptions or background information on this
> test, either in commit log or in test description.

Sure, I had this info in the original patch posting, but forgot to
update my branch.

Regarding test 501,503, they are both "dumb" test in the sense
that they don't explain why the specific sequence of events cause
the problem or why the specific set of random offset/length values
are used.

Darrick has already analyzed the report and posted a fix for 503,
which I tested.

Ted has not responded to the bug report yet.

I suggested in original posting that perhaps, more insight about the
cause should be added to the test before merging and possibly
a reference to the fix commit.

You may want to wait on the maintainers input about this bug report
before merging, or not. After all the "dumb" test does fail and it is
possible to "undumb" it after there is a fix upstream.

>
>> ---
>>  tests/generic/503     | 69 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>  tests/generic/503.out |  2 ++
>>  tests/generic/group   |  1 +
>>  3 files changed, 72 insertions(+)
>>  create mode 100755 tests/generic/503
>>  create mode 100644 tests/generic/503.out
>>
>> diff --git a/tests/generic/503 b/tests/generic/503
>> new file mode 100755
>> index 0000000..ebda756
>> --- /dev/null
>> +++ b/tests/generic/503
>> @@ -0,0 +1,69 @@
>> +#! /bin/bash
>> +# FS QA Test No. 503
>> +#
>> +# Regression test for xfs leftover CoW extents error
>> +#
>> +#-----------------------------------------------------------------------
>> +# Copyright (C) 2017 CTERA Networks. All Rights Reserved.
>> +# Author: Amir Goldstein <amir73il@gmail.com>
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
>> +status=1     # failure is the default!
>> +
>> +_cleanup()
>> +{
>> +     cd /
>> +     rm -f $tmp.*
>> +}
>> +trap "_cleanup; exit \$status" 0 1 2 3 15
>> +
>> +# get standard environment, filters and checks
>> +. ./common/rc
>> +. ./common/filter
>> +. ./common/reflink
>> +
>> +# real QA test starts here
>> +_supported_fs generic
>> +_supported_os Linux
>> +_require_scratch_reflink
>> +_require_cp_reflink
>> +
>> +rm -f $seqres.full
>> +
>> +_scratch_mkfs >/dev/null 2>&1
>> +_scratch_mount
>> +
>> +$XFS_IO_PROG -f -c "pwrite 0 0x40000" \
>> +     $SCRATCH_MNT/foo > /dev/null 2>&1
>> +
>> +cp --reflink $SCRATCH_MNT/foo $SCRATCH_MNT/bar
>
> _cp_reflink
>
>> +
>> +$XFS_IO_PROG -f -c "fzero -k 0x169f 0x387c" \
>> +             -c "fcollapse 0x29000 0xd000" \
>> +             -c "finsert 0 0x8000" \
>> +             -c "truncate 0x8000" \
>> +     $SCRATCH_MNT/foo > /dev/null 2>&1
>
> _require_xfs_io_command these commands first, fzero, fcollapse, finsert.
>
> Above two nits apply to generic/502 too.
>

FYI, tests 501 uses fsx to replay events, so it does not require that fs
actually supports fallocate/fcollapse, because fsx automatically disables
fallocate ops that are not supported by fs.

Amir.
