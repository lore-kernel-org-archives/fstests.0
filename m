Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:52498 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751599AbbBJVz5 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 10 Feb 2015 16:55:57 -0500
Date: Tue, 10 Feb 2015 13:55:52 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 0/9 v5] make xfs/tests generic by introducing shutdown
 for filesystems
Message-ID: <20150210215552.GC83208@jaegeuk-mac02.mot.com>
References: <1423204633-66673-1-git-send-email-jaegeuk@kernel.org>
 <20150210060414.GN4251@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150210060414.GN4251@dastard>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-ID: <fstests@vger.kernel.org>

On Tue, Feb 10, 2015 at 05:04:14PM +1100, Dave Chinner wrote:
> On Thu, Feb 05, 2015 at 10:37:04PM -0800, Jaegeuk Kim wrote:
> > Thanks to Dave. :)
> > 
> > Change log from v4:
> >  o add mkfs in _require_scratch_shutdown
> >  o add _require_fiemap and _extent_hole_counts
> >  o add _require_logstate
> >  o modify xfs/086,087 output rules for the generic usage
> >  o add _get_log_configs to introduce consistent testing options
> >  o add _get_quota_option to define quota option for each filesystems
> > 
> > This patch-set modifies several existing xfs's tests to be used by generic
> > filesystems.
> 
> This looks pretty good now. There's still a couple of minor things,
> but the rest of it looks pretty good. Just resend the patches that
> need updating - there's no need to resend the entire series at this
> point.
> 
> BTW, many thanks for sending the rename patches in git format - they
> are much easier to read and validate. :)

Thank you very much for the review. :)

> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
