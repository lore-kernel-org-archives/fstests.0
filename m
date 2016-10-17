Received: from mail-qk0-f194.google.com ([209.85.220.194]:36744 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754449AbcJQHBV (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 17 Oct 2016 03:01:21 -0400
Received: by mail-qk0-f194.google.com with SMTP id z190so13112635qkc.3
        for <fstests@vger.kernel.org>; Mon, 17 Oct 2016 00:01:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20161016214608.GC14023@dastard>
References: <1476615222-7804-1-git-send-email-amir73il@gmail.com>
 <1476615222-7804-3-git-send-email-amir73il@gmail.com> <20161016214608.GC14023@dastard>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 17 Oct 2016 10:01:19 +0300
Message-ID: <CAOQ4uxiMKMB2HqKOjJ7b296oX+MvV_OvCDY5h6gz-A9C5a5DBA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] fstests: run xfs_io as multi threaded for 'quick' tests
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: Eryu Guan <eguan@redhat.com>, Christoph Hellwig <hch@lst.de>, "Darrick J . Wong" <darrick.wong@oracle.com>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Mon, Oct 17, 2016 at 12:46 AM, Dave Chinner <david@fromorbit.com> wrote:
> On Sun, Oct 16, 2016 at 01:53:42PM +0300, Amir Goldstein wrote:
>> Try to run xfs_io for tests in group quick with command line
>> option -M which starts an idle thread before performing any io.
>>
>> The purpose of this idle thread is to test io from a multi threaded
>> process. With single threaded process, the file table is not shared
>> and file structs are not reference counted.
>>
>> In order to improve the chance of detecting file struct reference
>> leaks, we should run xfs_io commands with this option as much as
>> possible.
>>
>> Analysis of the effect of xfs_io -M on tests runtime showed that
>> it may lead to slightly longer run times in extreme cases (e.g +3s
>> for generic/132), but has a negligable effect on runtime of tests
>> among the 'quick' group (worst case +0.3s for generic/130).
>>
>> Therefore, we automatically add the -M flags only to tests in the
>> 'quick' group.
>>
>> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>> ---
>>  check     |  2 ++
>>  common/rc | 15 +++++++++++++++
>>  2 files changed, 17 insertions(+)
>>
>> diff --git a/check b/check
>> index 69341d8..e568598 100755
>> --- a/check
>> +++ b/check
>> @@ -574,6 +574,8 @@ for section in $HOST_OPTIONS_SECTIONS; do
>>
>>           mkdir -p $RESULT_DIR
>>
>> +         export TEST_GROUPS=`grep $(basename $seqnum) "$SRC_DIR/$(dirname $seqnum)/group"`
>> +
>
> Do we really want to go down this path of changing behaviours
> of utilities based on what group  they belong to? It means we can no
> longer look at the test code and recreate the command line without
> having to work out what group context the test is running under. And
> how do we tell that it's correct and we don't inadvertantly break
> it? I ask this because.....
>
>>           echo -n "$seqnum"
>>
>>               if $showme; then
>> diff --git a/common/rc b/common/rc
>> index a838750..7c478cf 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -3799,6 +3799,21 @@ init_rc()
>>       $XFS_IO_PROG -c stat $TEST_DIR 2>&1 | grep -q "is not on an XFS filesystem" && \
>>               export XFS_IO_PROG="$XFS_IO_PROG -F"
>>
>> +     if echo $TEST_GROUPS | grep -q quick; then
>> +             # xfs_io -M flag runs xfs_io as multi threaded process
>> +             # in order to catch fdget/fdset reference leaks, because
>> +             # file structs are not reference counted in a single threaded
>> +             # process.
>> +             # Because reference counted fdget/fdset may lead to slightly
>> +             # longer run times in extreme cases (such as generic/132),
>> +             # we limit the use of -M flags to tests with short runtime,
>> +             # where the effect of the flag is negligable.
>> +             #
>> +             # Figure out if xfs_io supports the -M option
>> +             $XFS_IO_PROG -M -c quit 2>/dev/null && \
>> +                     export XFS_IO_PROG="$XFS_IO_PROG -M"
>> +     fi
>> +
>
> .... I can't see how this works - init_rc is
> called and sets $XFS_IO_PROG long before TEST_GROUPS is set and
> exported.

Correct, but common/rc is then included again from every single test,
so XFS_IO_PROG is adjusted to add the -M/i flag per test after
TEST_GROUPS is set for a specific test in ./check.
I saw the -F flag code and figured that's a good place to add -M/i as well.
With a hunch, I would say that if -F where to be added, it where to be
added twice.

> How did you verify that the correct xfs_io command lines
> were being issued?
>

Both by adding debug print and by monitoring ps

> IMO, either turn it on for everything if it is supported, or make it
> an explicit command line option to enable.

If I make the default off, then not enough people will test for reference leaks.
Since leaks may be hard to find, because they may only be on rare error path,
the motivation for a test suit IMO is to enforce this option as much
as possible.

OTOH, if everyone, always run with -i, then the fast path fdget is
never tested with
xfs_io. fast path will get tested with other tools used by tests
though, so maybe
that is not such a big concern.

> A couple of seconds of
> extra runtime here and there means nothing for a typical auto test
> run which can take hours to run....
>

In that case, I think we should turn the flag always if supported.
After all, even it tests take longer to run that's exactly the sort of penalty
that should be acceptable to pay for running with extra debugging options
enabled.

As an extra, I suggested we could turn the flag off for people running the
test with non debug kernel, or say, without CONFIG_PROVE_LOCKING.
If there are people doing that, and I imagine there are, they may care more
about test runtime and less about detecting leaks?

> Cheers,
>
> Dave.
> --
> Dave Chinner
> david@fromorbit.com
