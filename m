Received: from mail-vk0-f41.google.com ([209.85.213.41]:36016 "EHLO
        mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752504AbdK0OXv (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 27 Nov 2017 09:23:51 -0500
Received: by mail-vk0-f41.google.com with SMTP id p144so17482098vkp.3
        for <fstests@vger.kernel.org>; Mon, 27 Nov 2017 06:23:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAOQ4uxi_SjKCJ97Knvh4S6UiD3jskHEqDja7wwc+-mXp4CNbEw@mail.gmail.com>
References: <1504638680-25682-1-git-send-email-amir73il@gmail.com>
 <1504638680-25682-11-git-send-email-amir73il@gmail.com> <CAOQ4uxi_SjKCJ97Knvh4S6UiD3jskHEqDja7wwc+-mXp4CNbEw@mail.gmail.com>
From: Ashlie Martinez <ashmrtn@utexas.edu>
Date: Mon, 27 Nov 2017 08:23:49 -0600
Message-ID: <CAFk8rvZX3YWoShy2i_Jr+-cGt2bhjDxVRaFHgXQNzbmWAkdcXQ@mail.gmail.com>
Subject: Re: [PATCH v3 10/13] fstests: crash consistency fsx test using dm-log-writes
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: Josef Bacik <jbacik@fb.com>, fstests <fstests@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

Amir,

Just to throw in what I believe I've found about dm-log-writes (though
Josef would know more about this as it's just what I've concluded
after looking at  the code): dm-log-writes logs at IO completion,
meaning disks that ignore flush operations could exhibit bugs where
there are none, and dm-log-writes does synchronous marks though this
may not line up with the stream of IO operations (due to buffering)
unless you just did a sync. The CrashMonkey team wanted to make
something similar to the "mark" operation dm-log-writes has and we
concluded that the only place we could guarantee a mark would line up
with the stream of IO operations the user had performed was right
after a call to sync as that would force cached updates to disk. If
you call mark without a sync, then you could insert a mark after a
write(2) returns, but before the delayed allocation for that write(2)
actually allocates blocks and changes the extent tree on disk.

On Mon, Nov 27, 2017 at 3:56 AM, Amir Goldstein <amir73il@gmail.com> wrote:
> On Tue, Sep 5, 2017 at 10:11 PM, Amir Goldstein <amir73il@gmail.com> wrote:
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
>
>
> Josef,
>
> As you know, this test is now merged to xfstest as generic/455.
> I have been running the test for a while on xfs and it occasionally
> reports inconsistencies which I try to investigate.
>
> In some of the reports, it appears that dm-log-writes may be exhibiting
> a reliability issue (see below).
>
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
>> +status=1       # failure is the default!
>> +
>> +_cleanup()
>> +{
>> +       _log_writes_cleanup
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
>> +       local name=$1
>> +
>> +       # Now look for our files
>> +       for i in $(find $SANITY_DIR -type f | grep $name | grep mark)
>> +       do
>> +               local filename=$(basename $i)
>> +               local mark="${filename##*.}"
>> +               echo "checking $filename" >> $seqres.full
>> +               _log_writes_replay_log $filename
>> +               _scratch_mount
>> +               local expected_md5=$(_md5_checksum $i)
>> +               local md5=$(_md5_checksum $SCRATCH_MNT/$name)
>> +               [ "${md5}" != "${expected_md5}" ] && _fail "$filename md5sum mismatched"
>
> One time, the test reported md5 mismatch on a file, but when I replayed
> the log to the same mark I found that md5 of the file is correct compared to the
> 'snapshot' file in test partition.
>
>> +               _scratch_unmount
>> +               _check_scratch_fs
>> +       done
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
>> +# Run fsx for a while
>> +for j in `seq 0 $((NUM_FILES-1))`
>> +do
>> +       run_check $here/ltp/fsx $FSX_OPTS -S ${seeds[$j]} -j $j $SCRATCH_MNT/testfile$j &
>> +done
>> +wait
>> +
>> +test_md5=()
>> +for j in `seq 0 $((NUM_FILES-1))`
>> +do
>> +       test_md5[$j]=$(_md5_checksum $SCRATCH_MNT/testfile$j)
>> +done
>> +
>> +# Unmount the scratch dir and tear down the log writes target
>> +_log_writes_mark last
>> +_log_writes_unmount
>> +_log_writes_mark end
>> +_log_writes_remove
>> +_check_scratch_fs
>> +
>
> Another time xfs_repair complained about dirty log right after
> _log_writes_remove
> and I wasn't able to seek to the "end" mark. Log entries were valid a
> few entries
> after the "last" mark.
>
> This leads me to believe that perhaps dm-log-writes doesn't flush all
> its pending
> log io before remove? Anyway, I added a "sync $LOGWRITES_DEV" call inside
> _log_writes_remove. Not sure if that helps or if that is required
> before removing the
> target?
>
> I will report if I see that the problem persists.
> Thought? suggestions?
>
> Thanks,
> Amir.
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
