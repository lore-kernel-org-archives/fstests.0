Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:39966 "EHLO
	ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751225AbcCaE1B (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 31 Mar 2016 00:27:01 -0400
Date: Thu, 31 Mar 2016 15:26:44 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] xfs/030: link .out file according to reflink support
 status
Message-ID: <20160331042644.GK30721@dastard>
References: <1459331861-15025-1-git-send-email-eguan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1459331861-15025-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org, darrick.wong@oracle.com, xfs@oss.sgi.com
List-ID: <fstests@vger.kernel.org>

On Wed, Mar 30, 2016 at 05:57:41PM +0800, Eryu Guan wrote:
> Commit 31f48569c353 ("xfs/030: fix output on newer filesystems") added
> more lines to .out file to match the output from XFS with reflink
> support, but it broke test on older XFS.
> 
> Fix it by introducing new .out file 030.out.reflink.linux to match the
> reflink case, so old XFS still compares .out file against 030.out.linux.
> 
> In order to do this, a new helper is introduced, _fs_has_reflink()
> accepts mount point as argument and returns if the underlying fs
> supports reflink or not.

Let's not go down this path. This is a filtering issue, not a
problem we solve by playing "let's add a golden image file for every
different filesystem format we can create".

The problem here is that reflink triggers a change in the initial
population of the AGFL - from 4 blocks to 6 blocks, and so repair
warns 6 times instead of 4. After filtering, that gives 6 indentical
output lines instead of 4.

Doing something as simple as collapsing repeated identical lines
(e.g filtering through uniq) will work for all filesystem formats
and any future changes that modify the initial AGFL population...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
