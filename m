Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:43148 "EHLO
	ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755417AbaFSG5D (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 19 Jun 2014 02:57:03 -0400
Date: Thu, 19 Jun 2014 16:56:44 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] xfstests: add test for ext4 fallocate collapse range
 check
Message-ID: <20140619065644.GL4453@dastard>
References: <1403157004-25112-1-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1403157004-25112-1-git-send-email-gux.fnst@cn.fujitsu.com>
Sender: xfstests-owner@vger.kernel.org
To: Xing Gu <gux.fnst@cn.fujitsu.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Jun 19, 2014 at 01:50:04PM +0800, Xing Gu wrote:
> This is a test to verify the procedure which checks whether
> offset + len is bigger than i_size is removed from do_fallocate
> in collapse range to the file system, and ensure that i_size is
> not going to change.
> 
> Signed-off-by: Xing Gu <gux.fnst@cn.fujitsu.com>

Does the test really need 3 minutes?

We can't keep adding tests that take minutes to *maybe* hit a
regression. This isn't even testing a regression - the
COLLAPSE_RANGE feature was introduced in 3.15-rc1 and this bug fixed
in 3.15-rc3, so there are no kernels out there that have this
bug in them.

IOWs, I really don't think we should be the runtime of a typical
test cycle by 5% to exercise this non-bug. Maybe 30s at most, but a
shorter, directly targeted test would be better.

And FWIW, there's nothing ext4 specific about this test - it should
be in the generic group if we are going to add it.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
