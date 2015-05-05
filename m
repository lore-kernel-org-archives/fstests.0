Return-Path: <fstests-owner@vger.kernel.org>
Received: from sandeen.net ([63.231.237.45]:48836 "EHLO sandeen.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752384AbbEECEJ (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 4 May 2015 22:04:09 -0400
Message-ID: <55482517.9090205@sandeen.net>
Date: Mon, 04 May 2015 21:04:07 -0500
From: Eric Sandeen <sandeen@sandeen.net>
MIME-Version: 1.0
Subject: Re: [PATCH 3/4] xfs/045: can't change UUID on v5 filesystems.
References: <1430776893-25158-1-git-send-email-david@fromorbit.com> <1430776893-25158-4-git-send-email-david@fromorbit.com> <5547F73F.2030303@sandeen.net> <20150505005112.GK15810@dastard>
In-Reply-To: <20150505005112.GK15810@dastard>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 5/4/15 7:51 PM, Dave Chinner wrote:
> On Mon, May 04, 2015 at 05:48:31PM -0500, Eric Sandeen wrote:
>> On 5/4/15 5:01 PM, Dave Chinner wrote:
>>> From: Dave Chinner <dchinner@redhat.com>
>>>
>>> So pass "-m crc=0" to the scratch_mkfs command so that we only run
>>> on old v4 format filesystems where the UUID can be changed.
>>>
>>> Signed-off-by: Dave Chinner <dchinner@redhat.com>
>>
>> hm, given that I might "fix" this should we instead trap
>> on an xfs_db uuid failure, and _notrun the test?
>> (oh, but older xfs_db let it go, didn't it.  sigh).
>>
>> I guess nothing about the presence of crc vs. non-crc
>> matters for this test, so turning it off by default is probably ok.
>> It could use a comment about why it's got "-m crc=0" though, at
>> least.
> 
> Added. New patch below.
> 

Thanks.

Reviewed-by: Eric Sandeen <sandeen@redhat.com>
