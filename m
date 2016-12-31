Received: from mail-io0-f193.google.com ([209.85.223.193]:33820 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754091AbcLaASg (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 30 Dec 2016 19:18:36 -0500
Received: by mail-io0-f193.google.com with SMTP id n85so23120158ioi.1
        for <fstests@vger.kernel.org>; Fri, 30 Dec 2016 16:18:35 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161228110509.GA1859@eguan.usersys.redhat.com>
References: <1482637093-13139-1-git-send-email-deepa.kernel@gmail.com> <20161228110509.GA1859@eguan.usersys.redhat.com>
From: Deepa Dinamani <deepa.kernel@gmail.com>
Date: Fri, 30 Dec 2016 16:18:34 -0800
Message-ID: <CABeXuvpHCbTy6P6HJYw1Un06CnYk5zhp430ZL-ZFWnfDJeiY6g@mail.gmail.com>
Subject: Re: [PATCH v2] generic/390: Add tests for inode timestamp policy
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, y2038 Mailman List <y2038@lists.linaro.org>
List-ID: <fstests@vger.kernel.org>

On Wed, Dec 28, 2016 at 3:05 AM, Eryu Guan <eguan@redhat.com> wrote:
> On Sat, Dec 24, 2016 at 07:38:13PM -0800, Deepa Dinamani wrote:
>> The test helps to validate clamping and mount behaviors
>> according to supported file system timestamp ranges.
>>
>> Note that the test can fail on 32-bit systems for a
>> few file systems. This will be corrected when vfs is
>> transitioned to use 64-bit timestamps.
>>
>> Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
>> ---
>> The branch of the kernel tree can be located at
>>
>> https://github.com/deepa-hub/vfs refs/heads/vfs_timestamp_policy
>>
>> The xfs_io patch to add utimes is at
>>
>> https://www.spinics.net/lists/linux-xfs/msg02952.html
>
> Thanks for this info! I built your test kernel and applied the xfs_io
> patch, and I got test failure on XFS, test passed on ext4 (256 inode
> size) without problems, is this expected?

Yes, this is expected.
Since kernel does not have actual limits for xfs filled in.
Although I need to fix the if condition(-gt needs to change to -ge) to
fail on mount here.

>> +     f2fs)
>> +             echo "-2147483648 2147483647"
>> +             ;;
>> +     *)
>> +             echo "-1 -1"
>> +             _notrun "filesystem $FSTYP timestamp bounds are unknown"
>
> This "_notrun" doesn't belong here. I think we can introduce a
> _require_y2038 rule. e.g.

Ok, I will merge this with require_y2038_sysfs() like what you suggest below.

> _require_y2038()
> {
>         local device=${1:-$TEST_DEV}
>         local sysfsdir=/proc/sys/fs/fs-timestamp-check-on
>         if [ ! -ne $sysfsdir ]; then
>                 _notrun "no kernel support for y2038 sysfs switch"
>         fi
>
>         local tsmin tsmax
>         read tsmin tsmax <<<$(_filesystem_timestamp_range $device)
>         if [ $tsmin -eq -1 -a $tsmax -eq -1 ]; then
>                 _notrun "filesystem $FSTYP timestamp bounds are unknown"
>         fi
> }
>
> Then
>
> _scratch_mkfs
> _require_y2038 $SCRATCH_DEV
>
>> +             ;;
>> +     esac
>> +}
>> +
>>  # indicate whether YP/NIS is active or not
>>  #
>>  _yp_active()
>> @@ -2070,6 +2109,9 @@ _require_xfs_io_command()
>>               echo $testio | egrep -q "Inappropriate ioctl" && \
>>                       _notrun "xfs_io $command support is missing"
>>               ;;
>> +     "utimes" )
>> +             testio=`$XFS_IO_PROG -f -c "utimes" 0 0 0 0 $testfile 2>&1`
>> +             ;;
>>       *)
>>               testio=`$XFS_IO_PROG -c "$command help" 2>&1`
>>       esac
>> diff --git a/tests/generic/390 b/tests/generic/390
>> new file mode 100755
>> index 0000000..8ccadad
>> +     stat_timestamp=`stat -c"%X;%Y" $file`
>> +
>> +     prev_timestamp="$timestamp;$timestamp"
>> +     if [ $prev_timestamp != $stat_timestamp ]; then
>> +             echo "$prev_timestamp != $stat_timestamp" | tee -a $seqres.full
>> +             exit
>
> No need to exit here. We prefer continuing the test in fstests when such
> test failure happens, it enlarges the test coverage and exercises some
> error paths. One exception is that when continuing the test could result
> in blocking all subsequent tests, we should exit early, one example
> provided later.

Ok, will continue here.

>> +{
>> +     file=$1
>> +     timestamp=$2
>> +     update_time=$3
>> +
>> +     #check if the time needs update
>> +     if [ $update_time -eq 1 ]; then
>> +             echo "Updating file: $file to timestamp `date -d @$timestamp`"  >> $seqres.full
>> +             $XFS_IO_PROG -f -c "utimes $timestamp 0 $timestamp 0" $file
>> +             if [ $? -ne 0 ]; then
>> +                     echo "Failed to update times on $file" | tee -a $seqres.full
>> +                     exit
>
> Same here.

Will do.

>> +     #initialization iterator
>> +     n=1
>> +
>> +     for TIME in "${TIMESTAMPS[@]}"
>> +     do
>> +             #Run the test
>> +             run_test_individual ${SCRATCH_MNT}/test_$n $TIME $update_time
>> +
>> +             #update iterator
>> +             ((n++))
>
> Seems the comments here are not necessary, initialize the iterator, run
> the test and update iterator are all obvious.

Will remove comments.

> And we prefer this code style in fstests:
> for TIME in "${TIMESTAMPS[@]}"; do
>         ...
> done
>

Will follow this style.
Is there a coding style guide or some recognized good example test?

>> +     done
>> +}
>> +
>> +_scratch_mkfs &>> $seqres.full 2>&1 || _fail "mkfs failed"
>
> Let test continue here on mkfs and mount failure, test harness will
> capture these failures too, and running tests in these failure
> conditions sometimes reveal interesting bugs :)
>
> One example that we should exit on mkfs & mount failure is that we're
> testing ENOSPC and going to fulfill the test filesystem, and we'll eat
> all free space on root fs if we failed to mount the test device, and all
> subsequent tests are blocked because of ENOSPC on root fs.

In this test, I want to check for mount failure as that is expected behavior.
Continuing on mkfs should be fine.

>> +read tsmin tsmax <<<$(_filesystem_timestamp_range $SCRATCH_DEV)
>> +
>> +echo min supported timestamp $tsmin $(date --date=@$tsmin) >> $seqres.full
>> +echo max supported timestamp $tsmax $(date --date=@$tsmax) >> $seqres.full
>> +
>> +#Test timestamps array
>
> Please add a space after "#" in comments.

Ok, will update.

>
>> +
>> +declare -a TIMESTAMPS=(
>> +     $tsmin
>> +     0
>> +     $tsmax
>> +     $((tsmax+1))
>> +     4294967295
>> +     8589934591
>> +     34359738367
>> +)
>> +
>> +# Max timestamp is hardcoded to Mon Jan 18 19:14:07 PST 2038
>> +sys_tsmax=2147483647
>> +echo "min timestamp that needs to be supported by fs for rw mount is $sys_tsmax $(date --date=@$sys_tsmax)" >> $seqres.full
>
> Meant "max timestamp" here?

No this is a little tricky. It is the minimum supported max timestamp.
Will update wording so that it is not confusing.

>> +
>> +read ts_check <<<$(cat /proc/sys/fs/fs-timestamp-check-on)
>> +
>> +_scratch_mount
>> +result=$?
>> +
>> +if [ $ts_check -ne 0 ]; then
>> +     echo "sysctl filesystem timestamp check is on" >> $seqres.full
>> +     if [ $sys_tsmax -gt $tsmax ]; then
>> +             if [ $result -eq 0 ]; then
>> +                     echo "mount test failed"  | tee -a $seqres.full
>> +                     exit
>> +             fi
>> +     else
>> +             if [ $result -ne 0 ]; then
>> +                     echo "failed to mount $SCRATCH_DEV"  | tee -a $seqres.full
>> +                     exit
>> +             fi
>> +     fi
>> +else
>> +     echo "sysctl filesystem timestamp check is off" >> $seqres.full
>> +     if [ $result -ne 0 ]; then
>> +             echo "failed to mount $SCRATCH_DEV and timestamp check is off"  >> $seqres.full
>> +             exit
>> +     fi
>> +fi
>
> I think we need some comments on this code block to explain the logic
> and expected behavior.

Will add more comments here.

>> +_scratch_cycle_mount
>> +if [ $? -ne 0 ];then
>> +     echo "Failed to remount $SCRATCH_DEV" | tee -a $seqres.full
>> +     exit
>> +fi
>
> No need to exit. Further, no need to check _scratch_cycle_mount status.

Will update accordingly.

Will post a v3 with changes.

Thanks,
Deepa
