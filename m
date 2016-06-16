Received: from sandeen.net ([63.231.237.45]:54986 "EHLO sandeen.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754047AbcFPPKL (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 16 Jun 2016 11:10:11 -0400
Subject: Re: [PATCH v2] xfstests: xfs discontiguous multi-block buffer logging
 test
References: <1464873001-17508-1-git-send-email-bfoster@redhat.com>
 <20160616011349.GM12670@dastard> <20160616114525.GA8342@bfoster.bfoster>
From: Eric Sandeen <sandeen@sandeen.net>
Message-ID: <5f0d9c6d-3950-7e01-35f8-525cb1b6280f@sandeen.net>
Date: Thu, 16 Jun 2016 10:10:09 -0500
MIME-Version: 1.0
In-Reply-To: <20160616114525.GA8342@bfoster.bfoster>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: Brian Foster <bfoster@redhat.com>, Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>



On 6/16/16 6:45 AM, Brian Foster wrote:
> On Thu, Jun 16, 2016 at 11:13:49AM +1000, Dave Chinner wrote:
>> On Thu, Jun 02, 2016 at 09:10:01AM -0400, Brian Foster wrote:
>>> XFS had a bug in the multi-block buffer logging code that caused a NULL
>>> lv panic at log push time due to invalid regions being set in the buffer
>>> log format bitmap. This was demonstrated by modifying a multi-block
>>> directory buffer in a manner that only logs regions beyond the first
>>> FSB-sized mapping of the buffer.
>>>
>>> To recreate these conditions, this test fragments free space and
>>> populates several directories with enough entries to require
>>> discontiguous multi-block buffers. To recreate the problem, we remove
>>> entries from the tail end of the directory and fsync to flush the log.
>>>
>>> Note that this test causes a panic on kernels affected by the bug. As
>>> such, it is included in the 'dangerous' group. The bug is resolved by
>>> kernel commit a3916e528b91 ("xfs: fix broken multi-fsb buffer logging").
>>>
>>> Signed-off-by: Brian Foster <bfoster@redhat.com>
>> .....
>>> +# Create a small fs with a large directory block size. We want to fill up the fs
>>> +# quickly and then create multi-fsb dirblocks over fragmented free space.
>>> +_scratch_mkfs_xfs -d size=20m -n size=64k >> $seqres.full 2>&1
>>> +_scratch_mount
>>> +
>>> +# Fill a source directory with many largish-named files. 1k uuid-named entries
>>> +# sufficiently populates a 64k directory block.
>>> +mkdir $SCRATCH_MNT/src
>>> +for i in $(seq 0 1023); do
>>> +	touch $SCRATCH_MNT/src/`uuidgen`
>>> +done
>>
>> What's 'uuidgen'? Not installed on my test systems, so this needs
>> a requires check, I think....
>>
>> Hmmm - looks like a separate package is needed on debian systems:
>> uuid-runtime. Can you send a followup patch that adds the necesary
>> checks to this test and added the above package to the iniitial list
>> in the README file (for ubunutu, I know, but the package name will
>> be the same).
>>
> 
> Eryu pointed this on on v1 of the test but I didn't think it necessary
> as it's part of a standard package on fedora. I guess that's not true
> for other distros. I'll post something to fix it up...

Yeah, that's surprising, it's been part of util-linux[-ng] on my RHEL &
Fedora distros since 2009.

-Eric
