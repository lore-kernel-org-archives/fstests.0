Received: from aserp2120.oracle.com ([141.146.126.78]:56864 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751166AbeAECMn (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 4 Jan 2018 21:12:43 -0500
Date: Thu, 4 Jan 2018 18:12:27 -0800
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] generic/466: be more precise about which block sizes to
 use
Message-ID: <20180105021227.GA5606@magnolia>
References: <20171211172742.3490-1-tytso@mit.edu>
 <20171213173629.GG6896@magnolia>
 <20171231184508.GA29994@thunk.org>
 <20180102203650.GC5146@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180102203650.GC5146@magnolia>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Jan 02, 2018 at 12:36:50PM -0800, Darrick J. Wong wrote:
> On Sun, Dec 31, 2017 at 01:45:08PM -0500, Theodore Ts'o wrote:
> > On Wed, Dec 13, 2017 at 09:36:29AM -0800, Darrick J. Wong wrote:
> > > > +	get_page_size
> > > > +	;;
> > > > +    *)
> > > > +	echo 512
> > > 
> > > FWIW XFS' minimum block size is 1k for v5 filesystems, though you can't
> > > really tell until you run mkfs.xfs -N.
> > 
> > Ok, but I assume we should keep this at 512 since it could be a v4
> > file systems that are being tested?
> 
> That depends on whether this function returns the smallest blocksize
> guaranteed to pass mkfs given the current set of options or the
> theoretical smallest blocksize supported by that fs given the right set
> of options.  IOWs, if this is a v5 fs being tested, then "mkfs.xfs -b
> size=$(_fs_min_blocksize) -m crc=1" will fail.

...but we /could/ just try the known minimums with "_scratch_mkfs -b
size=XXX -N" because (so long as it doesn't get smart and try to
override our -b setting) it'll fail on any unsupported size.

> > > > +_fs_max_blocksize()
> > > > +{
> > > > +    get_page_size
> > > 
> > > Also, one can run xfstests against a fuse2fs-mounted 64k-block ext4 fs.
> > 
> > Really?  Does mmap work on a fuse2fs-mounted 64k-block ext4 file system?
> 
> Yes:
> 
> # uname -a
> Linux magnolia 4.14.8-67-magnolia #2 SMP PREEMPT Fri Dec 22 17:23:52 PST 2017 x86_64 x86_64 x86_64 GNU/Linux
> # truncate -s 1g /tmp/a
> # mkfs.ext4 -b 65536 -F /tmp/a
> ...
> # fuse2fs /tmp/a /mnt
> /tmp/a: Writing to the journal is not supported.
> # fallocate -l 128k /mnt/a
> # xfs_io -c 'mmap -rw 0 128k' -c 'mwrite -S 0x58 0 6144' /mnt/a
> # od -tx1 -Ad -c /mnt/a
> 0000000  58  58  58  58  58  58  58  58  58  58  58  58  58  58  58  58
>           X   X   X   X   X   X   X   X   X   X   X   X   X   X   X   X
> *
> 0006144  00  00  00  00  00  00  00  00  00  00  00  00  00  00  00  00
>          \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
> *
> 0131072
> 
> > I suppose can just force the block size to be 64k for fuse2fs,
> > although I don't think the using some file system like ext4 for
> > fuse2fs testing isn't going to work right now anyway, yes?
> 
> I haven't tried it in some time, but the last time I ran xfstests
> against fuse2fs it more or less worked (modulo all the fancy fallocate
> stuff that it doesn't support).

(Maybe we should separate out ext4/fuse2fs?)

--D

> --D
> 
> > 
> > 	      	   	     		     	       - Ted
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
