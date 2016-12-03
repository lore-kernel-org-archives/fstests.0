Received: from mail-io0-f194.google.com ([209.85.223.194]:36199 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759558AbcLCBnb (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 2 Dec 2016 20:43:31 -0500
Received: by mail-io0-f194.google.com with SMTP id s82so11226243ioi.3
        for <fstests@vger.kernel.org>; Fri, 02 Dec 2016 17:43:31 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161124231558.GV31101@dastard>
References: <1479948722-2936-1-git-send-email-deepa.kernel@gmail.com> <20161124231558.GV31101@dastard>
From: Deepa Dinamani <deepa.kernel@gmail.com>
Date: Fri, 2 Dec 2016 17:43:30 -0800
Message-ID: <CABeXuvp0eT7g_YjCxHV5D2TyH2SB3PwcO3jUmSh-J8Dw7p+iEQ@mail.gmail.com>
Subject: Re: [PATCH] generic/390: Add tests for inode timestamp policy
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, y2038 Mailman List <y2038@lists.linaro.org>
List-ID: <fstests@vger.kernel.org>

>> +_filesystem_timestamp_range()
>> +{
>> +     device=${1:-$TEST_DEV}
>> +     case $FSTYP in
>> +     ext4)   #dumpe2fs
>> +             if [ $(dumpe2fs -h $device 2>/dev/null | grep "Inode size:" | cut -d: -f2) -gt 128 ]; then
>> +                     echo "-2147483648 15032385535"
>> +             else
>> +                     echo "-2147483648 2147483647"
>> +             fi
>> +             ;;
>> +
>> +     xfs)
>> +             echo "-2147483648 2147483647"
>> +             ;;
>> +     jfs)
>> +             echo "0 4294967295"
>> +             ;;
>> +     f2fs)
>> +             echo "-2147483648 2147483647"
>> +             ;;
>> +     *)
>> +             echo "-1 -1"
>> +             ;;
>> +     esac
>> +}
>
> This is better off in common/rc right now - common/attr is for
> extended attribute test code, not generic filesystem stuff.

Ok, will move this to common/rc.

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
>> +             perror("strtoull");
>> +             exit(1);
>> +     }
>> +
>> +     if (do_utime(fd, time))
>> +             return 1;
>> +
>> +     return 0;
>> +}
>
> This might be useful to add to xfs_io rather than a one-off helper
> for xfstest - that avoids the need to create files, and it can be
> used to change times on existing files....

There are other tests doing the same thing.
I will see if using xfs_io here makes more sense.

>> +_run_test_individual() #_run_individual_test(file, timestamp, update_time)
>> +{
>> +    file=$1
>> +    timestamp=$2
>> +    update_time=$3
>
> No need for comments after the function declaration - the prototype
> is obvious from the local variable assignments....

Will remove these comments.

>> +#Remove log from last run
>> +rm -f $seqres.full
>> +
>> +#install cleaner
>> +trap "_cleanup; exit \$status" 0 1 2 3 15
>> +
>> +_scratch_mkfs &>> $seqres.full 2>&1 || _fail "mkfs failed"
>> +read tsmin tsmax <<<$(_filesystem_timestamp_range $SCRATCH_DEV)
>
> This is all test setup preamble, so should be at the top.

Will move this to top.

>> +if [ $tsmin -eq -1 -a $tsmax -eq -1 ]; then
>> +    _notrun "filesystem $FSTYP timestamp bounds are unknown"
>> +fi
>
> This should be in a _requires_timestamp_range() function, I think.

Yes, that makes sense.
Will move this.

Thanks,
Deepa
