Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34476 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751254AbbEGDFn (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 6 May 2015 23:05:43 -0400
Date: Thu, 7 May 2015 11:05:38 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH 4/4] filter: inode size output of mkfs.xfs can change
Message-ID: <20150507030538.GH1187@dhcp-13-216.nay.redhat.com>
References: <1430776893-25158-1-git-send-email-david@fromorbit.com>
 <1430776893-25158-5-git-send-email-david@fromorbit.com>
 <20150506071934.GE1187@dhcp-13-216.nay.redhat.com>
 <20150506225627.GJ21261@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150506225627.GJ21261@dastard>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, May 07, 2015 at 08:56:27AM +1000, Dave Chinner wrote:
> On Wed, May 06, 2015 at 03:19:34PM +0800, Eryu Guan wrote:
> > On Tue, May 05, 2015 at 08:01:33AM +1000, Dave Chinner wrote:
> > > From: Dave Chinner <dchinner@redhat.com>
> > > 
> > > With the change to CRCs by default, the mkfs inode size is defaults
> > > to 512 bytes and the minimum block size changes to 1024 bytes. This
> > > causes mismatches with golden output that expects the inode size to
> > > be 256 bytes, and some tests are tailored around the amount of space
> > > inside a 256 byte inode. Fix them with appropriate filtering or mkfs
> > > parameters to allow 256 byte inodes to be used.
> > > 
> > > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > > ---
[snip]
> > > -_scratch_mkfs_xfs -dsize=41m,agcount=2 | _filter_mkfs 2>/dev/null
> > > +_scratch_mkfs_xfs -m crc=0 -dsize=41m,agcount=2 | _filter_mkfs 2>/dev/null
> > 
> > Adding "-m crc=0" to mkfs directly will break testing on older distros
> > where mkfs.xfs doesn't have crc support, e.g. RHEL6
> 
> I know we need to keep older distros working, but right now we need
> to make upstream xfstests work with upstream xfsprogs changes.  Keep
> in mind that we do allow upstream changes for upstream support to
> break older distro support. The responsibility for keeping upstream
> xfstests working on older distros falls to the people running it on
> older distros, not the people who are working on upstream.

Understood, so I'll look into this based on how much work is needed and
how hardly we want it on RHEL6.8/9/etc.

> 
> Of course, people testing older distros always have the option of
> not upgrading xfstests every time a commit is made.... :P

Yes, we use a fixed version of xfstests to test RHEL5, and RHEL6 is
almost reaching that maintaince-only phase too.

> 
> > I haven't figured out a better way, but I was thinking about tweaking
> > _scratch_mkfs_xfs or $MKFS_XFS_PROG based on mkfs.xfs supports crc or
> > not.
> 
> I'd suggest that we should look at filtering this out in
> _scratch_options, based on some environment variable that you set in
> the .config files for the older distros.  e.g.
> 
> 	mkfs)
> +		if [ -n "$MKFS_HAS_NO_META_SUPPORT" ]; then
> +			# strip "-m ..." options
> +			SCRATCH_OPTIONS=`<insert sed magic here>`
> +		fi

I was thinking about _scratch_options too, I'll follow this way and see.

Thanks,
Eryu
