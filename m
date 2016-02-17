Received: from mx1.redhat.com ([209.132.183.28]:45619 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161075AbcBQKgd (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 17 Feb 2016 05:36:33 -0500
Date: Wed, 17 Feb 2016 18:36:28 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH 12/16] xfstests: remove dependency on /proc/partitions
 for generic/312
Message-ID: <20160217103628.GO11419@eguan.usersys.redhat.com>
References: <1455385269-26319-1-git-send-email-tytso@mit.edu>
 <1455385269-26319-13-git-send-email-tytso@mit.edu>
 <20160217100603.GK21482@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160217100603.GK21482@infradead.org>
Sender: fstests-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Theodore Ts'o <tytso@mit.edu>, fstests@vger.kernel.org, hughd@google.com
List-ID: <fstests@vger.kernel.org>

On Wed, Feb 17, 2016 at 02:06:03AM -0800, Christoph Hellwig wrote:
> > +# We don't need to do this check for tmpfs because _scratch_mkfs_size
> > +# will validate the size against the available memory
> > +if [ "$FSTYP" != "tmpfs" ]; then
> > +   _scratch_mkfs
> > +   _scratch_mount
> > +   _require_fs_space $SCRATCH_MNT $(($fssize / 1024))
> > +   _scratch_unmount
> > +fi
> >  rm -f $seqres.full
> >  _scratch_mkfs_sized $fssize >>$seqres.full 2>&1
> 
> _scratch_mkfs_size also validates the available space for other
> block based file systems, so I think we should just remove this
> code entirely (assuming I didn't miss something important)

I agreed, not sure why I wrote this check in the first place..

Thanks,
Eryu
