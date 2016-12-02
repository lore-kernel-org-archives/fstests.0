Received: from mail-io0-f194.google.com ([209.85.223.194]:34551 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752160AbcLBS1b (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 2 Dec 2016 13:27:31 -0500
Received: by mail-io0-f194.google.com with SMTP id r94so9403678ioe.1
        for <fstests@vger.kernel.org>; Fri, 02 Dec 2016 10:26:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161124104055.GD4609@eguan.usersys.redhat.com>
References: <1479948722-2936-1-git-send-email-deepa.kernel@gmail.com> <20161124104055.GD4609@eguan.usersys.redhat.com>
From: Deepa Dinamani <deepa.kernel@gmail.com>
Date: Fri, 2 Dec 2016 10:26:05 -0800
Message-ID: <CABeXuvpqXHyOwxUveepKTSTYaf2SQSU_TUZEEUZ02JoWBzOGMg@mail.gmail.com>
Subject: Re: [PATCH] generic/390: Add tests for inode timestamp policy
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, y2038 Mailman List <y2038@lists.linaro.org>
List-ID: <fstests@vger.kernel.org>

> Need an entry in .gitignore file too.

Will add this.

>>  SUBDIRS =
>>
>> diff --git a/src/y2038_futimens.c b/src/y2038_futimens.c
>> new file mode 100644
>> index 0000000..291e4fa
>> --- /dev/null
>> +++ b/src/y2038_futimens.c
>> @@ -0,0 +1,61 @@
>> +#include <fcntl.h>
>> +#include <stdio.h>
>> +#include <sys/stat.h>
>> +#include <errno.h>
>> +#include <stdlib.h>
>> +
>> +int
>> +do_utime(int fd, long long time)
>> +{
>> +     struct timespec t[2];
>> +
>> +     /*
>> +      * Convert long long to timespec format.
>> +      * Seconds precision is assumed here.
>> +      */
>> +     t[0].tv_sec = time;
>> +     t[0].tv_nsec = 0;
>> +     t[1].tv_sec = time;
>> +     t[1].tv_nsec = 0;
>> +
>> +     /* Call utimens to update time. */
>> +     if (futimens(fd, t)) {
>> +             perror("futimens");
>> +             return 1;
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +int
>> +main(int argc, char **argv)
>> +{
>> +     int fd;
>> +     long long time;
>> +
>> +     if(argc < 3) {
>> +                     fprintf(stderr, "Usage: %s filename timestamp\n"
>> +                                     "Filename: file to be created or opened in current directory\n"
>> +                                     "Timestamp: is seconds since 1970-01-01 00:00:00 UTC\n", argv[0]);
>> +                     exit(1);
>
> Seems there's no need for an extra level of indention :)

Ok, will fix this.

>> +     }
>> +
>> +     /* Create the file */
>> +     fd = creat(argv[1], 0666);
>> +     if(fd < 0) {
>> +             perror("creat");
>> +             exit(1);
>> +     }
>> +
>> +     /* Get the timestamp */
>> +     time = strtoull(argv[2], NULL, 0);
>> +     if (errno) {
>
> From errno(3), errno is never set to zero by any system call or library
> function, so errno isn't reset to zero on strtoull and this check always
> fails for me, with errno = ENOENT, because:
>
> ...
> access("/usr/share/dracut/modules.d/01fips", F_OK) = -1 ENOENT (No such file or directory)
> ...
> write(4, "strtoull: No such file or direct"..., 36strtoull: No such file or directory
>
> the errno was from access(2) call in my case.

Right. Man page for strtoull() says:

Since strtoul() can legitimately return 0 or ULONG_MAX (ULLONG_MAX for
strtoull()) on both success and failure, the calling program should
set errno to 0 before the call, and then determine if an error
occurred by checking whether errno has a nonzero value after the call.

I will set errno to 0 before strtoull().
Thanks.

>> diff --git a/tests/generic/390 b/tests/generic/390
>> new file mode 100755
>> index 0000000..f069988
>> --- /dev/null
>> +++ b/tests/generic/390
>> @@ -0,0 +1,238 @@
>> +#! /bin/bash
>> +# FS QA Test No. generic/390
>> +#
>> +# Tests to verify policy for filesystem timestamps for
>> +# supported ranges:
>> +# 1. Verify filesystem rw mount according to sysctl
>> +# timestamp_supported.
>> +# 2. Verify timestamp clamping for timestamps beyond max
>> +# timestamp supported.
>> +#
>> +# Exit status 1: either or both tests above fail.
>> +# Exit status 0: both the above tests pass.
>
> Please use "./new" script to generate template, which contains all
> necessary initial setups and the copyright info.

Thanks, will do.

>> +
>> +seq=`basename $0`
>> +seqres=$RESULT_DIR/$seq
>> +echo "QA output created by $seq"
>> +#echo "output in $seqres.full"
>> +here=`pwd`
>> +
>> +# Get standard environment, filters and checks.
>> +. ./common/rc
>> +. ./common/filter
>> +. ./common/attr
>> +
>> +SRC_GROUPS=`find tests -not -path tests -type d -printf "%f "`
>
> What's this for? Seems it's not used in the test.

Yes, this is not required. Leftovers from some previous version of the test.
Thanks.

>> +
>> +# Prerequisites for the test run.
>> +_supported_fs generic
>> +_supported_os Linux
>> +_require_scratch
>
> Need to check the existence of y2038_futimens program, to make sure it's
> really built, e.g.
>
> _require_test_program "y2038_futimens"

Will add this


>> +Y2038_PROG=$here/src/y2038_futimens
>> +
>> +#initialize exit status
>> +status=0
>
> We use 1 as the default value of status, so you can just "exit" on
> failure (because trap will catch the signal and exit with $status again)
> and only set status=0 and exit when test passes. "./new" already sets it
> up for you :)

Will take care of this.

>> +
>> +# Generic test cleanup function.
>> +_cleanup()
>> +{
>> +    # Remove any leftover files from last run.
>> +    rm -f ${SCRATCH_MNT}/test_?
>
> No need to cleanup files on SCRATCH_DEV, it's meant to be mkfs'ed every
> time before using it.

Ok, makes sense. I will remove this clean up.

>> +#unmount and mount  $SCRATCH_DEV.
>> +_umount_mount_scratch_dev()
>
> There's a helper to do this: _scratch_cycle_mount, only that it doesn't
> change PWD. And if you don't want to write $SCRATCH_MNT again, this is
> what we do usually in fstests:
>
> testfile=$SCRATCH_MNT/<somefile>
> ...
> do_test $testfile

Thanks, will change it similar to what you suggest.

>> +{
>> +    #change directory so that you are not using SCRATCH_MNT anymore.
>> +    cd $here
>> +
>> +    # Unmount the ${SCRATCH_DEV}
>> +    _scratch_unmount
>> +    if [ $? != 0 ]; then
>> +     return  $?
>> +    fi
>> +
>> +    # Mount the ${SCRATCH_DEV}
>> +    _scratch_mount
>> +    if [ $? != 0 ]; then
>> +     return  $?
>> +    fi
>> +
>> +    cd ${SCRATCH_MNT}
>> +}
>> +
>> +# Compare file timestamps obtained from stat
>> +# with a given timestamp.
>> +_check_stat() #check_stat(file, timestamp)
>
> Name local functions without the leading underscore, that's usually for
> common helper functions, like functions in common/rc, common/attr.

Will do.

>> +{
>> +    stat_timestamp=`stat -c"%X;%Y" $1`
>
> And please use one tab (8 spaces width) for indention.

Will do.

>> +
>> +    prev_timestamp="$2;$2"
>> +    if [ $prev_timestamp != $stat_timestamp ]; then
>> +     echo "$prev_timestamp != $stat_timestamp" >> $seqres.full
>> +     return 1
>
> No need to return 0 or 1, just echo the "... != ..." to stdout, and
> tee -a the output to $seqres.full if you want verbose debug too.
>
> Because all the outputs, including stdout and stderr, from the test will
> be captured and compared with the .out file at the end of each test, and
> test harness reports failure if the two outputs don't match. That way,
> you don't have to check return value of commands most of the times.

Ok, will fix this.

>> +    else
>> +     return 0
>> +    fi
>> +}
>> +
>> +_run_test_individual() #_run_individual_test(file, timestamp, update_time)
>> +{
>> +    file=$1
>> +    timestamp=$2
>> +    update_time=$3
>> +
>> +    #check if the time needs update
>> +    if [ $update_time -eq 1 ]; then
>> +     echo "Updating file: $file to timestamp `date -d @$timestamp`"  >> $seqres.full
>> +     $Y2038_PROG $file $timestamp  &>> $seqres.full
>> +     if [ $? != 0 ]; then
>> +         echo "Failed to run the y2038 program" >> $seqres.full
>> +         return 1
>> +     fi
>> +    fi
>
> Seems $Y2038_PROG outputs nothing on success, so again, just run the
> program without checking results & redirecting outputs, test harness
> will report failure if there's error messages from this program. e.g.
>
>         $Y2038_PROG $file $timestamp
>
> and just let test run even if something goes wrong.

Will do.

>> +
>> +    tsclamp=$(($timestamp>$tsmax?$tsmax:$timestamp))
>> +    _check_stat $file $tsclamp
>> +    echo "Checking file: $file Updated timestamp is `date -d @$tsclamp`"  >> $seqres.full
>> +
>> +    if [ $? != 0 ]; then
>> +     echo "Failed to set time to $timestamp" >> $seqres.full
>> +     return 1
>> +    fi
>> +
>> +    return 0
>> +}
>> +
>> +_run_test() #_run_test(update_time)
>> +{
>> +    #initialization iterator
>> +    n=1
>> +
>> +    for TIME in "${TIMESTAMPS[@]}"
>> +    do
>> +     #Run the test
>> +     _run_test_individual ${SCRATCH_MNT}/test_$n $TIME $1
>> +
>> +     if [ $? != 0 ]; then
>> +         echo "file timestamp update failed `date -d @$TIME`"  >> $seqres.full
>> +         if [ $n -lt 4 ]; then
>
> This is not obvious to me, need some comments on the magic number 4 :)

This is leftover from a previous version.
Will clean this up. Thanks.

>> +             echo "Test failed"
>> +             return 1
>> +         fi
>> +     fi
>> +
>> +     #update iterator
>> +     ((n++))
>> +    done
>> +
>> +    return 0
>> +}
>> +
>> +#Remove log from last run
>> +rm -f $seqres.full
>> +
>> +#install cleaner
>> +trap "_cleanup; exit \$status" 0 1 2 3 15
>> +
>> +_scratch_mkfs &>> $seqres.full 2>&1 || _fail "mkfs failed"
>> +read tsmin tsmax <<<$(_filesystem_timestamp_range $SCRATCH_DEV)
>> +
>> +if [ $tsmin -eq -1 -a $tsmax -eq -1 ]; then
>> +    _notrun "filesystem $FSTYP timestamp bounds are unknown"
>> +fi
>> +
>> +echo min supported timestamp $tsmin $(date --date=@$tsmin) >> $seqres.full
>> +echo max supported timestamp $tsmax $(date --date=@$tsmax) >> $seqres.full
>> +
>> +#Test timestamps array
>> +
>> +declare -a TIMESTAMPS=(
>> +    $tsmin
>> +    0
>> +    $tsmax
>> +    $((tsmax+1))
>> +    4294967295
>> +    8589934591
>> +    34359738367
>> +)
>> +
>> +# Max timestamp is hardcoded to Mon Jan 18 19:14:07 PST 2038
>> +sys_tsmax=2147483647
>> +echo "min timestamp that needs to be supported by fs for rw mount is $sys_tsmax $(date --date=@$sys_tsmax)" >> $seqres.full
>> +
>> +read ts_check <<<$(cat /proc/sys/fs/fs-timestamp-check-on)
>
> This fails on systems without this procfs entry, so we need another
> _require rule, e.g.
>
> _require_proc_attr sys/fs/fs-timestamp-check-on
>
> So test _notrun if kernel has no such procfs entry.

I realized this after I sent out the test.
Will update this. Thanks.

> Can you please point me a test kernel tree so I can actually run this
> test?

Will post a pointer along with v2.

>> +
>> +_scratch_mount
>> +result=$?
>> +
>> +if [ $ts_check != 0 ]; then
>> +    echo "sysctl filesystem timestamp check is on" >> $seqres.full
>> +    if [ $sys_tsmax > $tsmax ]; then
>> +     if [ $result != -1 ]; then
>> +         echo "mount test failed"  >> $seqres.full
>> +     fi
>> +    else
>> +     if [ $result != 0 ]; then
>> +         echo "mount test failed"  >> $seqres.full
>> +     fi
>> +    fi
>> +else
>> +    echo "sysctl filesystem timestamp check is off" >> $seqres.full
>> +    if [ $result != 0 ]; then
>> +     echo "mount test failed"  >> $seqres.full
>> +    fi
>
> echo error messages to stdout on mount failure, test harness could catch
> the failures.

will do.

>> +fi
>> +
>> +#cd to the SCRATCH_MNT to run the tests
>> +cd $SCRATCH_MNT
>> +
>> +# Begin test case 1
>> +echo "In memory timestamps update test start" >> $seqres.full
>> +
>> +#update time on the file
>> +update_time=1
>> +
>> +#Run test
>> +_run_test $update_time
>> +
>> +if [ $? != 0 ]; then
>> +    echo "In memory timestamps update failed" >> $seqres.full
>> +    status=1
>> +    exit
>> +fi
>> +
>> +echo "In memory timestamps update complete" >> $seqres.full
>> +
>> +echo "Unmounting and mounting scratch $SCRATCH_MNT" >> $seqres.full
>> +
>> +#unmount and remount $SCRATCH_DEV
>> +_umount_mount_scratch_dev
>> +
>> +if [ $? != 0 ];then
>> +    status=1
>> +    exit
>> +fi
>> +
>> +# Begin test case 2
>> +
>> +#re-initialize iterator
>> +n=1
>> +
>> +#Do not update time on the file, just read from disk
>> +update_time=0
>> +
>> +echo "On disk timestamps update test start" >> $seqres.full
>> +
>> +#Re-run test
>> +_run_test $update_time
>> +
>> +if [ $? != 0 ];then
>> +    status=1
>> +    exit
>> +fi
>> +
>> +echo "On disk timestamps update test complete" >> $seqres.full
>> +
>> +echo "y2038 inode filestamp update successful"
>
> I may have more comments after you sent v2 and I can actually run the
> test :)

Sounds good  :)
Thanks for the comments.
Will post v2 addressing the issues.

-Deepa
