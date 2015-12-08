Received: from mail.kernel.org ([198.145.29.136]:58046 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752986AbbLHAIQ (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 7 Dec 2015 19:08:16 -0500
Date: Mon, 7 Dec 2015 16:08:13 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [f2fs-dev] [PATCH 1/3] common/rc: support f2fs for
 _scratch_mkfs_sized
Message-ID: <20151208000813.GA91868@jaegeuk.local>
References: <1449267345-79400-1-git-send-email-jaegeuk@kernel.org>
 <5662E283.6090900@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5662E283.6090900@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: Chao Yu <chao@kernel.org>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-ID: <fstests@vger.kernel.org>

Hi Chao,

On Sat, Dec 05, 2015 at 09:11:31PM +0800, Chao Yu wrote:
> Hi Jaegeuk,
> 
> On 12/5/15 6:15 AM, Jaegeuk Kim wrote:
> > The mkfs.f2fs has an option to build a certain sized filesystem by giving
> > the number of sectors.
> > 
> > So, this patch adds to use that.
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  common/rc | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/common/rc b/common/rc
> > index 4c2f42c..ef913b4 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -739,6 +739,10 @@ _scratch_mkfs_sized()
> >  	$MKFS_REISER4_PROG $MKFS_OPTIONS -y -b $blocksize $SCRATCH_DEV \
> >  			   `expr $fssize / 1024`
> >  	;;
> > +    f2fs)
> > +	# mkfs.f2fs requires # of sectors as an input for the size
> > +	$MKFS_F2FS_PROG $MKFS_OPTIONS $SCRATCH_DEV `expr $fssize / 512`
> 
> In mkfs.f2fs, we will calculate fs size based on real sector size of block
> device and the input sectors, so if sector size of block device is not 512, our
> fs size calculated will be incorrect.
> 
> How about fixing it for supporting different sector size?

Sure, I'll resend v2.

Thanks,

> 
> Thanks,
> 
> > +	;;
> >      *)
> >  	_notrun "Filesystem $FSTYP not supported in _scratch_mkfs_sized"
> >  	;;
> > 
