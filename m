Received: from mx1.mpynet.fi ([82.197.21.84]:22877 "EHLO mx1.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751446AbdLUPsD (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 21 Dec 2017 10:48:03 -0500
Subject: Re: [PATCH] generic/399: Use dd instead of xfs_io pwrite to fill
 volume
References: <1513790564-24236-1-git-send-email-ari@tuxera.com>
 <20171221013404.GO5858@dastard>
From: Ari Sundholm <ari@tuxera.com>
Message-ID: <4a7ce674-b257-79fe-26f2-958e63f7ab4a@tuxera.com>
Date: Thu, 21 Dec 2017 17:48:00 +0200
MIME-Version: 1.0
In-Reply-To: <20171221013404.GO5858@dastard>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 12/21/2017 03:34 AM, Dave Chinner wrote:
> On Wed, Dec 20, 2017 at 07:22:44PM +0200, Ari Sundholm wrote:
>> As recently discussed on the fstests mailing list, the way
>> generic/399 checks for the filesystem having become full only
>> works on filesystems that behave like ext4, and even on those,
>> actually only works by accident.
>>
>> The problem is that xfs_io does not give a nonzero exit value
>> when the pwrite operation fails due to ENOSPC. However, if the
>> filesystem also happens to be unable to create new empty files
>> when it is full, the check will do its job because open() fails
>> with ENOSPC. Not all filesystems behave like this, however.
>>
>> As it seems to be nontrivial to get xfs_io fixed for this case,
>> I propose simply replacing the xfs_io pwrite command with dd
>> for now. AFAICS, this works with all filesystems, and should also
>> preserve the nature of the test case.
>>
>> Signed-off-by: Ari Sundholm <ari@tuxera.com>
>> ---
>>   tests/generic/399 | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tests/generic/399 b/tests/generic/399
>> index 8f5fcdc..5056b20 100755
>> --- a/tests/generic/399
>> +++ b/tests/generic/399
>> @@ -101,7 +101,7 @@ total_file_size=0
>>   i=1
>>   while true; do
>>   	file=$SCRATCH_MNT/encrypted_dir/file$i
>> -	if ! $XFS_IO_PROG -f $file -c 'pwrite 0 1M' &> $tmp.out; then
>> +	if ! dd if=/dev/zero of=$file bs=4k count=256 &> $tmp.out; then
>>   		if ! grep -q 'No space left on device' $tmp.out; then
>>   			echo "FAIL: unexpected pwrite failure"
>>   			cat $tmp.out
> 
> NACK.
> 
> Please work to get xfs_io fixed - there's been some discussion, a
> couple of test patches, and a direction has pretty much been decided
> but neither Brian (who is on PTO) or I have had the time to
> implement it. If you need it fixed right away then you need to put
> the work in rather than wait for other people (who are on holiday
> right now) to fit it into their own schedules and priorities.
> 

We are not really in a hurry to get this fixed upstream, as we already 
have a local fix suitable for our purposes. This problem was originally 
reported to get it eventually fixed for everyone in a way deemed 
suitable by upstream. I am not demanding anyone to spend any effort on 
this on any timescale. I am sorry if I have somehow given that 
impression. I am only trying to help.

What I have understood of the discussion on this list is that the work 
to get xfs_io properly fixed is nontrivial and requires quite a lot of 
plumbing, requiring familiarity with xfsprogs. Given that the problem is 
limited to this test case (no one else has complained), it may not be 
necessary to rush to fix it in xfsprogs in the first place. Also, the 
desired semantics for failures when multiple commands have been chained 
do not seem clear to me, so this may need more thought. Thus, I decided 
to suggest to sidestep the problem with a simple change in the test case 
itself as an option to save everyone's efforts until a more pressing 
need to get xfs_io fixed arises.

> Cheers,
> 
> Dave.
> 

Thanks,
Ari Sundholm
ari@tuxera.com
