Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:57979 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755282AbbCRSBK (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 18 Mar 2015 14:01:10 -0400
Date: Wed, 18 Mar 2015 11:01:06 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 1/2] generic/067: add a testcase to check some inline
 truncation behaviors
Message-ID: <20150318180106.GC7461@jaegeuk-mac02>
References: <1426613572-2405-1-git-send-email-jaegeuk@kernel.org>
 <20150318034653.GE10105@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150318034653.GE10105@dastard>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-ID: <fstests@vger.kernel.org>

Hi Dave,

Thank you for the review.
I'll resend this series with precise description and fixes as you pointed.

Thanks,

On Wed, Mar 18, 2015 at 02:46:53PM +1100, Dave Chinner wrote:
> On Tue, Mar 17, 2015 at 10:32:51AM -0700, Jaegeuk Kim wrote:
> > This patch introduces a new testcase, generic/067, to test several truncation
> > cases under the inline feature supported by filesystems.
> 
> "inline feature" means what, exactly?
> 
> > 
> > +_supported_os Linux
> > +_require_scratch
> > +
> > +testfile=$SCRATCH_MNT/testfile
> > +
> > +_scratch_mkfs > /dev/null 2>&1
> > +_scratch_mount
> > +
> > +# aligned inline truncation
> 
> Aligned to what, exactly?
> 
> > +$XFS_IO_PROG -t -f \
> > +-c "pwrite -S 0x58 0 120"       `# write        |XXXXXXXXXXXXXXXXXXXXXXXX|` \
> > +-c "fsync"	\
> > +-c "truncate 0"                 `# truncate     |                        |` \
> > +-c "truncate 160"               `# truncate     |                        |` \
> > +-c "close"      \
> > +$testfile | _filter_xfs_io
> 
> Please indent multiple line xfs_io command a little more clearly,
> and align the "\" so it's clear it's amultiple line command
> 
> $XFS_IO_PROG -t -f								    \
> 	-c "pwrite -S 0x58 0 120"       `# write        |XXXXXXXXXXXXXXXXXXXXXXXX|` \
> 	-c "fsync"								    \
> 	-c "truncate 0"                 `# truncate     |                        |` \
> 	-c "truncate 160"               `# truncate     |                        |` \
> 	-c "close"								    \
> 	$testfile | _filter_xfs_io
> 
> (not sure the comment on the second truncate is correct, either)
> 
> Also, why do you need the "close" command?
> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
