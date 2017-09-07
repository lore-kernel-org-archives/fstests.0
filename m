Received: from mail-yw0-f175.google.com ([209.85.161.175]:35219 "EHLO
        mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754852AbdIGIu0 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 7 Sep 2017 04:50:26 -0400
MIME-Version: 1.0
In-Reply-To: <20170907075019.GN8034@eguan.usersys.redhat.com>
References: <1504638680-25682-1-git-send-email-amir73il@gmail.com>
 <1504638680-25682-11-git-send-email-amir73il@gmail.com> <20170907075019.GN8034@eguan.usersys.redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 7 Sep 2017 11:50:25 +0300
Message-ID: <CAOQ4uxgDMHacq1C0SSnV3t3djSWStu=sQ6zOJB7pqGow0cE3eQ@mail.gmail.com>
Subject: Re: [PATCH v3 10/13] fstests: crash consistency fsx test using dm-log-writes
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Josef Bacik <jbacik@fb.com>, fstests <fstests@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Thu, Sep 7, 2017 at 10:50 AM, Eryu Guan <eguan@redhat.com> wrote:
> On Tue, Sep 05, 2017 at 10:11:17PM +0300, Amir Goldstein wrote:
>> Cherry-picked the test from commit 70d41e17164b
>> in Josef Bacik's fstests tree (https://github.com/josefbacik/fstests).
>> Quoting from Josef's commit message:
>>
>>   The test just runs some ops and exits, then finds all of the good buffers
>>   in the directory we provided and:
>>   - replays up to the mark given
>>   - mounts the file system and compares the md5sum
>>   - unmounts and fsck's to check for metadata integrity
>>
>>   dm-log-writes will pretend to do discard and the replay-log tool will
>>   replay it properly depending on the underlying device, either by writing
>>   0's or actually calling the discard ioctl, so I've enabled discard in the
>>   test for maximum fun.
>>
>> [Amir:]
>> - Removed unneeded _test_falloc_support dynamic FSX_OPTS
>> - Fold repetitions into for loops
>> - Added place holders for using constant random seeds
>> - Add pre umount checkpint
>> - Add test to new 'replay' group
>> - Address review comments by Eryu Guan
>>
>> Cc: Josef Bacik <jbacik@fb.com>
>> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>> ---
>>  tests/generic/500     | 135 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>  tests/generic/500.out |   2 +
>>  tests/generic/group   |   1 +
>>  3 files changed, 138 insertions(+)
>>  create mode 100755 tests/generic/500
>>  create mode 100644 tests/generic/500.out
>>
>> diff --git a/tests/generic/500 b/tests/generic/500
>> new file mode 100755
>> index 0000000..82f7a93
>> --- /dev/null
>> +++ b/tests/generic/500
>> @@ -0,0 +1,135 @@
>> +#! /bin/bash
>> +# FS QA Test No. 500
>> +#
>> +# Run fsx with log writes to verify power fail safeness.
>> +#
>> +#-----------------------------------------------------------------------
>> +# Copyright (c) 2015 Facebook. All Rights Reserved.
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
>> +status=1     # failure is the default!
>> +
>> +_cleanup()
>> +{
>> +     _log_writes_cleanup
>> +}
>> +trap "_cleanup; exit \$status" 0 1 2 3 15
>> +
>> +# get standard environment, filters and checks
>> +. ./common/rc
>> +. ./common/filter
>> +. ./common/dmlogwrites
>> +
>> +# real QA test starts here
>> +_supported_fs generic
>> +_supported_os Linux
>> +_require_test
>> +_require_scratch_nocheck
>> +_require_log_writes
>> +
>> +rm -f $seqres.full
>> +
>> +check_files()
>> +{
>> +     local name=$1
>> +
>> +     # Now look for our files
>> +     for i in $(find $SANITY_DIR -type f | grep $name | grep mark)
>> +     do
>> +             local filename=$(basename $i)
>> +             local mark="${filename##*.}"
>> +             echo "checking $filename" >> $seqres.full
>> +             _log_writes_replay_log $filename
>> +             _scratch_mount
>> +             local expected_md5=$(_md5_checksum $i)
>> +             local md5=$(_md5_checksum $SCRATCH_MNT/$name)
>> +             [ "${md5}" != "${expected_md5}" ] && _fail "$filename md5sum mismatched"
>> +             _scratch_unmount
>> +             _check_scratch_fs
>> +     done
>> +}
>> +
>> +SANITY_DIR=$TEST_DIR/fsxtests
>> +rm -rf $SANITY_DIR
>> +mkdir $SANITY_DIR
>> +
>> +# Create the log
>> +_log_writes_init
>> +
>> +_log_writes_mkfs >> $seqres.full 2>&1
>> +
>> +# Log writes emulates discard support, turn it on for maximum crying.
>> +_log_writes_mount -o discard
>> +
>> +NUM_FILES=4
>> +NUM_OPS=200
>> +FSX_OPTS="-N $NUM_OPS -d -P $SANITY_DIR -i $LOGWRITES_DMDEV"
>> +# Set random seeds for fsx runs (0 for timestamp + pid)
>> +seeds=(0 0 0 0)
>
> Hmm, is this array necessary? Why not pass 0 to -S directly in the
> commandline? And generic/502 follows the same pattern.
>

The reason for the array is trying to follow your guidelines for running
the test:
- Normally test runs with random seed (for which the array is not needed)
  and every fsx process prints out the seed to the full log
- When test detects a failure, you want to retry the test with same seed
  numbers, but those are different seed numbers for every fsx process
- So the array is here to make setting those presets possible
