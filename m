Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:49562 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750870AbaLPGcv (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 16 Dec 2014 01:32:51 -0500
Received: by mail-wi0-f178.google.com with SMTP id em10so11350385wid.5
        for <fstests@vger.kernel.org>; Mon, 15 Dec 2014 22:32:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20141216020034.GD2152@dastard>
References: <alpine.LNX.2.00.1412152332120.21847@reiser4.gekom>
	<20141216020034.GD2152@dastard>
Date: Tue, 16 Dec 2014 07:32:50 +0100
Message-ID: <CADW=+3kqxvJh5zAoq-r-mXGShQuBhx233KBvWDD1nWetD+FtuA@mail.gmail.com>
Subject: Re: [PATCH] Check O_DIRECT support before testing direct I/O
From: =?UTF-8?B?RHXFoWFuIMSMb2xpxIc=?= <dusanc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Tue, Dec 16, 2014 at 3:00 AM, Dave Chinner <david@fromorbit.com> wrote:
> On Tue, Dec 16, 2014 at 12:03:35AM +0100, Dushan Tcholich wrote:
>>
>> In december 2013 Juhno Ryu posted a patch xfstests: check O_DIRECT
>> support before testing direct I/O to xfs@oss.sgi.com
>> http://oss.sgi.com/archives/xfs/2013-12/msg00759.html
>>
>> As there are no archives of fstests m-l I couldn't find why his
>> patches weren't applied so apologise if this is innapropriate but
>> I rebased his patch upon current xfstests code:
>>
>> ---
>>
>> Some filesystems do not support O_DIRECT.  Check whether TEST_DIR supports
>> it by running xfs_io with and without -d flag.
>>
>> Signed-off-by: Junho Ryu <jayr@google.com>
>> Signed-off-by: Dushan Tcholich <dusanc@gmail.com>
>>
>> ---
>>
>>
>> --- xfstests.orig/common/rc   2014-12-14 15:17:59.000000000 +0100
>> +++ xfstests/common/rc        2014-12-15 19:40:36.000000000 +0100
>> @@ -1391,6 +1395,7 @@
>>          AIO_TEST=src/aio-dio-regress/$1
>>          [ -x $AIO_TEST ] || _notrun "$AIO_TEST not built"
>>      fi
>> +    _require_odirect
>>  }
>>
>>  # run an aio-dio program
>> @@ -1519,6 +1524,20 @@
>>               _notrun "xfs_io $command failed (old kernel/wrong fs?)"
>>  }
>>
>> +# check that kernel and filesystem support direct I/O
>> +_require_odirect()
>> +{
>> +       testfile=$TEST_DIR/$$.direct
>> +       $XFS_IO_PROG -F -f -c "pwrite 0 20k" $testfile 2>&1
>> +       if [ $? -eq 0 ]; then
>> +               $XFS_IO_PROG -F -f -d -c "pwrite 0 20k" $testfile 2>&1
>> +               if [ $? -ne 0 ]; then
>> +                       _notrun "O_DIRECT is not supported"
>> +               fi
>> +       fi
>> +       rm -f $testfile 2>&1 > /dev/null
>> +}
>
> FWIW, I'd appreciate it if people tested their patches to ensure
> they don't cause test failures before posting them. This causes
> every test that _requires_odirect to fail because the xfs_io output
> is not directed to /dev/null:
>
Happily sending v2 patch ASAP is not as important as checking if patch
really works in all test cases, who would've thought.
My xfstests one patch at a time world domination plans crumbled to the dust :D

I'm grateful for your time and effort to teach me something I
should've thought myself.
Lesson learned.

Thanks
Dushan

> generic/036 11s ... - output mismatch (see /home/dave/src/xfstests-dev/results//generic/036.out.bad)
>     --- tests/generic/036.out   2014-11-13 16:14:32.000000000 +1100
>     +++ /home/dave/src/xfstests-dev/results//generic/036.out.bad        2014-12-16 12:46:53.000000000 +1100
>     @@ -1,2 +1,4 @@
>      QA output created by 036
>     +wrote 20480/20480 bytes at offset 0
>     +20 KiB, 5 ops; 0.0000 sec (3.896 MiB/sec and 997.4067 ops/sec)
>      All tasks are spawned
>     ...
>     (Run 'diff -u tests/generic/036.out /home/dave/src/xfstests-dev/results//generic/036.out.bad'  to see the entire diff)
>
> I've fixed this in v2 of the patch....
>
> Cheers,
>
> Dave.
> --
> Dave Chinner
> david@fromorbit.com
