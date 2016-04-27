Received: from mx2.suse.de ([195.135.220.15]:53579 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752403AbcD0QQd (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 27 Apr 2016 12:16:33 -0400
Date: Wed, 27 Apr 2016 18:16:30 +0200
From: Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 2/5] generic/343: Test races between mmap and normal
 writes
Message-ID: <20160427161630.GB2553@quack2.suse.cz>
References: <1461007955-7921-1-git-send-email-jack@suse.cz>
 <1461007955-7921-3-git-send-email-jack@suse.cz>
 <20160427150434.GB44975@bfoster.bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160427150434.GB44975@bfoster.bfoster>
Sender: fstests-owner@vger.kernel.org
To: Brian Foster <bfoster@redhat.com>
Cc: Jan Kara <jack@suse.cz>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed 27-04-16 11:04:35, Brian Foster wrote:
> On Mon, Apr 18, 2016 at 09:32:32PM +0200, Jan Kara wrote:
> > diff --git a/tests/generic/341 b/tests/generic/341
> > index 1fde346adc85..05bd86707592 100644
> > --- a/tests/generic/341
> > +++ b/tests/generic/341
> > @@ -51,10 +51,6 @@ _supported_os Linux
> >  _require_scratch
> >  _require_dm_target flakey
> >  _require_metadata_journaling $SCRATCH_DEV
> > -
> > -rm -f $seqres.full
> > -
> > -_scratch_mkfs >>$seqres.full 2>&1
> >  _init_flakey
> >  _mount_flakey
> >  
> 
> What's this hunk about? FWIW, the rest of the series looks fine to me.

Argh, that sneaked in likely when I was rebasing the series and resolving
conflicts. This hunk should be dropped. Thanks for catching this!

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
