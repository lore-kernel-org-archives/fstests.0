Received: from mx1.redhat.com ([209.132.183.28]:39566 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751680AbcGAND2 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 1 Jul 2016 09:03:28 -0400
Date: Fri, 1 Jul 2016 09:03:09 -0400
From: Brian Foster <bfoster@redhat.com>
Subject: Re: [PATCH 2/2] tests/xfs: test for post umount readahead completion
 panic
Message-ID: <20160701130309.GB1098@laptop.bfoster>
References: <1467290974-13203-1-git-send-email-bfoster@redhat.com>
 <1467290974-13203-3-git-send-email-bfoster@redhat.com>
 <20160701014002.GY27480@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160701014002.GY27480@dastard>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Jul 01, 2016 at 11:40:02AM +1000, Dave Chinner wrote:
> On Thu, Jun 30, 2016 at 08:49:34AM -0400, Brian Foster wrote:
> > XFS has a bug where directory readahead completions can occur after
> > unmount. This can lead to a crash or panic because metadata read
> > verification attempts to access core XFS data structures (e.g., the log)
> > after they have been freed and certain pointers have been reset.
> > 
> > Add a test that triggers directory readahead, delays the readahead I/O
> > and immediately unmounts the filesystem. This test is part of the
> > dangerous group as it will cause kernels affected by the bug to crash.
> .....
> > +
> > +# create a directory large enough for extent format
> > +mkdir $SCRATCH_MNT/dir
> > +for i in $(seq 0 999); do
> > +	touch $SCRATCH_MNT/dir/$i
> > +done
> 
> minor quibble - what's an "extent format" directory? I think you
> mean a directory inode whose data fork is in extent or btree format,
> not inline. i.e. not a short-form directory, but rather a block,
> leaf or node format directory.
> 

Indeed. So would you prefer the comment refers to the data fork or
directory format? This really cares more about whether the directory has
an extent count than the format per se, because that's what triggers the
readahead.

Perhaps something like: "insert entries to grow the directory to at
least one extent, which is what triggers readahead on dir open" ?

Eryu,

I'm assuming you can fix this up since you fixed up the previous patch.
Let me know if you want me to send another version.

Brian

> Yeah, I'm being pedantic, but we should use the correct terminology
> so when someone reads it in 5 years time....
> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
