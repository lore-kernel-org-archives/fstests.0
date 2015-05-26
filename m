Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:43827 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753114AbbEZN7D (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 26 May 2015 09:59:03 -0400
Message-ID: <55647C22.6040003@fb.com>
Date: Tue, 26 May 2015 09:58:58 -0400
From: Josef Bacik <jbacik@fb.com>
MIME-Version: 1.0
Subject: Re: [PATCH] generic: add fiemap test that does prealloc
References: <1432055622-8638-1-git-send-email-jbacik@fb.com> <20150526013130.GX4316@dastard>
In-Reply-To: <20150526013130.GX4316@dastard>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 05/25/2015 09:31 PM, Dave Chinner wrote:
> On Tue, May 19, 2015 at 01:13:42PM -0400, Josef Bacik wrote:
>> I noticed that btrfs wasn't setting unwritten on prealloc test, and then
>> subsequently noticed that we weren't testing fiemap on prealloc extents with the
>> fiemap-tester.  This patch adds another test that does the same as generic/225
>> only with prealloc enabled.  Thanks,
>
> Fails on XFS, but that's because XFS is doing things fiemap-tester
> does not understand (speculative prealloc beyond EOF when appending
> writes occur on files larger than 64k) and hence XFS ends up with
> zeroed data on disk in places where fiemaptester is expecting
> preallocated blocks.
>
> i.e. there's not data corruption, and nothing wrong with XFS's
> behaioviour, just a broken assumption that the filesystem will lay
> out data due to buffered writes and delayed allocation exactly as it
> expects.
>
> IOWs, i think that fiemap-tester might need to direct IO to get the
> results it expects, not buffered IO...
>

Huh crap I thought I caught this case, but now I look at it I only 
caught it for the HOLE case not the PREALLOC case, so I'll fix up the 
tester to check if there's 0's where there should be a prealloc.

>> +_scratch_mount > /dev/null 2>&1
>> +
>> +rm -f $seqres.full
>> +fiemapfile=$SCRATCH_MNT/$seq.fiemap
>> +fiemaplog=$SCRATCH_MNT/$seq.log
>
> The log file to use for debug information is $seqres.full.
>

I'll fix it up, thanks,

Josef

