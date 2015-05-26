Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail05.adl6.internode.on.net ([150.101.137.143]:53275 "EHLO
	ipmail05.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751126AbbEZBc3 (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 25 May 2015 21:32:29 -0400
Date: Tue, 26 May 2015 11:31:30 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] generic: add fiemap test that does prealloc
Message-ID: <20150526013130.GX4316@dastard>
References: <1432055622-8638-1-git-send-email-jbacik@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1432055622-8638-1-git-send-email-jbacik@fb.com>
Sender: fstests-owner@vger.kernel.org
To: Josef Bacik <jbacik@fb.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, May 19, 2015 at 01:13:42PM -0400, Josef Bacik wrote:
> I noticed that btrfs wasn't setting unwritten on prealloc test, and then
> subsequently noticed that we weren't testing fiemap on prealloc extents with the
> fiemap-tester.  This patch adds another test that does the same as generic/225
> only with prealloc enabled.  Thanks,

Fails on XFS, but that's because XFS is doing things fiemap-tester
does not understand (speculative prealloc beyond EOF when appending
writes occur on files larger than 64k) and hence XFS ends up with
zeroed data on disk in places where fiemaptester is expecting
preallocated blocks.

i.e. there's not data corruption, and nothing wrong with XFS's
behaioviour, just a broken assumption that the filesystem will lay
out data due to buffered writes and delayed allocation exactly as it
expects.

IOWs, i think that fiemap-tester might need to direct IO to get the
results it expects, not buffered IO...

> +_scratch_mount > /dev/null 2>&1
> +
> +rm -f $seqres.full
> +fiemapfile=$SCRATCH_MNT/$seq.fiemap
> +fiemaplog=$SCRATCH_MNT/$seq.log

The log file to use for debug information is $seqres.full.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
