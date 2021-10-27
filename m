Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C613C433F5
	for <linux-fstests@archiver.kernel.org>; Wed, 27 Oct 2021 00:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDFA76109D
	for <linux-fstests@archiver.kernel.org>; Wed, 27 Oct 2021 00:26:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233729AbhJ0A3P (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 26 Oct 2021 20:29:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:58380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229914AbhJ0A3P (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 26 Oct 2021 20:29:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B18A161002;
        Wed, 27 Oct 2021 00:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635294410;
        bh=9KDxVGxTVou30BrbPYaHEduOc6Cya9TUb6aCVt45oDI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JYu1vhcxeoKpZpGJMIg+mh4Cn07SSrXWoqtgKOKZpcr5vBySuKEAdIBfbOSG5oYvJ
         kcQ3u/UrNq0xvR6LOCsuIq03kgfDwvONYUOi8YlGADYGZV7A8zZwXIeFdsnUD5qWOI
         M+hElLbnfYcRt+w3DrbNMq4+Ql9R6TFkOscjQwqZiS5BV9KCds5BPKDbC7wqWy/nk6
         zz+XNSlHC7k6fEVcK3i04olUVEp0PZQmlKI+jo8sAaN6oNV/M9lO90+CZWZ0SqWBZe
         GfZy4vQU/qlRoa3gdP9XpmoUQIiVHGRqpUtCIqd08JvHvxUSyEhN89Ml1lzgipyYPn
         3bEhItk6Ssk8Q==
Date:   Tue, 26 Oct 2021 17:26:50 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: _require_dm_target should not always skip DAX
 capable devices
Message-ID: <20211027002650.GF24333@magnolia>
References: <20211026023622.914273-1-david@fromorbit.com>
 <20211026154240.GN24282@magnolia>
 <20211026235058.GB4821@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211026235058.GB4821@dread.disaster.area>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Oct 27, 2021 at 10:50:58AM +1100, Dave Chinner wrote:
> On Tue, Oct 26, 2021 at 08:42:40AM -0700, Darrick J. Wong wrote:
> > On Tue, Oct 26, 2021 at 01:36:22PM +1100, Dave Chinner wrote:
> > > From: Dave Chinner <dchinner@redhat.com>
> > > 
> > > Recent changes have turned off all dm-error, dm-thin and dm-flakey
> > > tests on pmem devices even when we are not explicitly testing DAX.
> > > This is a regression resulting in a large number of log recovery
> > > tests no longer running on my pmem-based test VMs. I added the "-o
> > > dax=never" mount options to these test configs, only to find it
> > > still would not run the dm tests even though the filesystem will
> > > never use DAX.
> > > 
> > > Fix this so that the dm target DAX test explicitly ignores the
> > > the block device DAX capability when the filesystem is mounted with
> > > dax=never and hence we can use all the dm targets when the tests are
> > > being run with FSDAX disabled.
> > > 
> > > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > > ---
> > >  common/rc | 21 +++++++++++++++------
> > >  1 file changed, 15 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/common/rc b/common/rc
> > > index 7f693d39..0cbe8a7d 100644
> > > --- a/common/rc
> > > +++ b/common/rc
> > > @@ -1965,12 +1965,19 @@ _require_sane_bdev_flush()
> > >  }
> > >  
> > >  # Decide if the scratch filesystem is likely to be mounted in fsdax mode.
> > > -# If there's a dax clause in the mount options we assume the test runner
> > > -# wants us to test DAX; or if the scratch device itself advertises dax mode
> > > -# in sysfs.
> > > -__detect_scratch_fsdax()
> > > +# It goes 3 ways based on mount options::
> > > +#	1. "dax" or "dax=always" means always test using DAX
> > > +#	2. "dax=never" means we'll never use DAX
> > > +#	3. "dax=inode" or nothing means "use scratch dev capability" to
> > > +#	    determine whether DAX is going to be used.
> > > +#
> > > +# Returns 0 if DAX will be used, 1 if DAX is not going to be used.
> > > +__scratch_uses_fsdax()
> > >  {
> > > -	_normalize_mount_options | egrep -q "dax(=always| |$)" && return 0
> > > +	local ops=$(_normalize_mount_options)
> > > +
> > > +	echo $ops | egrep -q "dax(=always| |$)" && return 0
> > > +	echo $ops | grep -q "dax=never" && return 1
> > 
> > Question: Do you want grep -w here so that grep won't match on anything
> > that isn't a whole "word"?
> > 
> > e.g. MOUNT_OPTIONS="-o ihatedax=alwaysp*****gmeoff" shouldn't be a
> > match, right?
> 
> At which point fstests will be useless because the scratch device
> won't mount.... :/
> 
> But, sure, if we care about people fuzzing fstests mount options
> that much we can make it "grep -qw"....

I actually meant someone creating a legitimate mount option for another
filesystem that happens to match 'dax=always', not someone feeding bad
options.  Maybe I should have given as an example:

mount -t deepspace9 -o everydax=alwaystrill /dev/sda /mnt

or something...

--D

> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
