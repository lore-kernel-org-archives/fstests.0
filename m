Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60610 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932313AbbENM3C (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 14 May 2015 08:29:02 -0400
Date: Thu, 14 May 2015 20:28:59 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] fstests: be compatible with older mkfs.xfs which has no
 v5 support
Message-ID: <20150514122858.GE1140@dhcp-13-216.nay.redhat.com>
References: <1431258643-13620-1-git-send-email-eguan@redhat.com>
 <20150514021406.GO15721@dastard>
 <20150514044031.GB1140@dhcp-13-216.nay.redhat.com>
 <20150514102411.GQ15721@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150514102411.GQ15721@dastard>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, May 14, 2015 at 08:24:11PM +1000, Dave Chinner wrote:
> On Thu, May 14, 2015 at 12:40:31PM +0800, Eryu Guan wrote:
> > On Thu, May 14, 2015 at 12:14:06PM +1000, Dave Chinner wrote:
> > > On Sun, May 10, 2015 at 07:50:43PM +0800, Eryu Guan wrote:
> > > > With the change to CRCs by default, some tests are updated to call mkfs
> > > > with "-m crc=0" option directly, and this breaks testings on older
> > > > distros where mkfs.xfs doesn't have crc support.
> > > > 
> > > > Introduce a new variable to tell if mkfs.xfs supports v5 xfs and do
> > > > tweaks in _scratch_mkfs_xfs_opts() based on it.
> > > > 
> > > > Signed-off-by: Eryu Guan <eguan@redhat.com>
[snip]
> > > 
> > > Shouldn't this be somewhere in common/config, not in the check
> > > script itself?
> > 
> > When sourcing common/config, SCRATCH_DEV has not been validated, and
> > things get messier when config sections are used.
> 
> Don't need a scratch dev:
> 
> touch /tmp/foo
> mkfs.xfs -N -d file,name=/tmp/foo,size=32m -m crc=0
> rm /tmp/foo

Ah right, thanks, I'll work on v3.

Thanks,
Eryu
> 
> mkfs will succeed if "-m crc=X" is recognised, fail if it isn't.
> the "-N" means it just does arg parsing and checks geometry, etc but
> does not do try to create the filesystem....
> 
> > I missed it, it's better than _scratch_mkfs, thanks! But it's not
> > available in common/config if we want to do the check there.
> 
> *nod*. In which case you'd just use MKFS_XFS_PROG directly, like
> above.
> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
