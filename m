Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35178 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750915AbaLPD2T (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 15 Dec 2014 22:28:19 -0500
Date: Tue, 16 Dec 2014 11:28:14 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH 1/2] common: return failure if _check_xxx_filesystem
 finds corruption
Message-ID: <20141216032814.GY15495@dhcp-13-216.nay.redhat.com>
References: <1418663367-18755-1-git-send-email-eguan@redhat.com>
 <20141215203129.GR24183@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141215203129.GR24183@dastard>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Dec 16, 2014 at 07:31:29AM +1100, Dave Chinner wrote:
> On Tue, Dec 16, 2014 at 01:09:26AM +0800, Eryu Guan wrote:
> > Tests like xfs/179 depend on the return value of _check_scratch_fs to
> > detect fs corruption, but _check_$FSTYP_filesystem always returns 0.
> 
> which means xfs/179 is wrong, because when _check_scratch_fs fails it
> exits immediately with status = 1, which triggers the test harness
> to record a test failure. (i.e. xfs/179 != check, so exits)
> 
> So this change is not actually going to allow tests to check the
> return value of _check_scratch_fs, and check itself doesn't care if
> the filesystem is corrupt or not - it just reports the state and
> moves on to the next test....

You're right, _check_scratch_fs sets status=1 before exit, this change
mainly benefits _check_{fs,scratch}_fs calls out of tests, like in
check. I'll update the commit message in v2.

> 
> > Also don't exit if these functions called by 'check', like what
> > _check_xfs_filesystem() does.
> 
> That's a separate issue, and should be in it's own patch ;)

Will do in v2.

Thanks for the review!

Eryu
