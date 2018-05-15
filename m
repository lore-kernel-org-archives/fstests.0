Received: from mail-yb0-f195.google.com ([209.85.213.195]:33847 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752129AbeEOFZv (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 15 May 2018 01:25:51 -0400
MIME-Version: 1.0
In-Reply-To: <20180514230130.GD23861@dastard>
References: <1526276991-23897-1-git-send-email-amir73il@gmail.com>
 <1526276991-23897-2-git-send-email-amir73il@gmail.com> <20180514230130.GD23861@dastard>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 15 May 2018 08:25:49 +0300
Message-ID: <CAOQ4uxgEF7cHmb05AxFJyHaV1zWC+Zk08dDNPepfhZ0Foz31Hg@mail.gmail.com>
Subject: Re: [PATCH 1/3] generic/459: use xfs_freeze instead of fsfreeze
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: Eryu Guan <guaneryu@gmail.com>, Theodore Ts'o <tytso@mit.edu>, fstests <fstests@vger.kernel.org>, Ext4 <linux-ext4@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Tue, May 15, 2018 at 2:01 AM, Dave Chinner <david@fromorbit.com> wrote:
> On Mon, May 14, 2018 at 08:49:49AM +0300, Amir Goldstein wrote:
>> This is what all other tests use as well as _require_freeze
>>
>> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>> ---
>>  tests/generic/459 | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/tests/generic/459 b/tests/generic/459
>> index e755cf7..22b8e62 100755
>> --- a/tests/generic/459
>> +++ b/tests/generic/459
>> @@ -113,7 +113,7 @@ $XFS_IO_PROG -f -d -c 'pwrite -b 1m 0 120m' $SCRATCH_MNT/f1 >>$seqres.full 2>&1
>>  # extended. It is expected, and is only used so xfsaild is triggered to
>>  # flush AIL items, other filesystems usually get remounted as read-only during
>>  # the above write process.
>> -fsfreeze -f $SCRATCH_MNT >>$seqres.full 2>&1 &
>> +xfs_freeze -f $SCRATCH_MNT >>$seqres.full 2>&1 &
>>  freezeid=$!
>>
>>  # Wait enough so xfsaild can run
>> @@ -132,7 +132,7 @@ ret=$?
>>  #    - The filesystem stays in Read-Write mode, but can be frozen/thawed
>>  #      without getting stuck.
>>  if [ $ret -ne 0 ]; then
>> -     # fsfreeze failed, filesystem should reject further writes and remount
>> +     # freeze failed, filesystem should reject further writes and remount
>>       # as readonly. Sometimes the previous write process won't trigger
>>       # ro-remount, e.g. on ext3/4, do additional touch here to make sure
>>       # filesystems see the metadata I/O error.
>> @@ -148,7 +148,7 @@ if [ $ret -ne 0 ]; then
>>  else
>>       # Try to thaw the filesystem, and complete test if if succeed.
>>       # NOTE: This will hang on affected XFS filesystems.
>> -     fsfreeze -u $SCRATCH_MNT >>$seqres.full 2>&1
>> +     xfs_freeze -u $SCRATCH_MNT >>$seqres.full 2>&1
>>       echo "Test OK"
>>  fi
>
> Shouldn't these all be converted to XFS_FREEZE_PROG w/ a setup call
> to export XFS_FREEZE_PROG="`set_prog_path xfs_freeze`"?
>

Yeh, I suppose I can take this one as part of the "freeze" cleanup.

Thanks,
Amir.
