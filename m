Date: Sun, 31 Dec 2017 13:45:08 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] generic/466: be more precise about which block sizes to
 use
Message-ID: <20171231184508.GA29994@thunk.org>
References: <20171211172742.3490-1-tytso@mit.edu>
 <20171213173629.GG6896@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171213173629.GG6896@magnolia>
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Dec 13, 2017 at 09:36:29AM -0800, Darrick J. Wong wrote:
> > +	get_page_size
> > +	;;
> > +    *)
> > +	echo 512
> 
> FWIW XFS' minimum block size is 1k for v5 filesystems, though you can't
> really tell until you run mkfs.xfs -N.

Ok, but I assume we should keep this at 512 since it could be a v4
file systems that are being tested?

> > +_fs_max_blocksize()
> > +{
> > +    get_page_size
> 
> Also, one can run xfstests against a fuse2fs-mounted 64k-block ext4 fs.

Really?  Does mmap work on a fuse2fs-mounted 64k-block ext4 file system?

I suppose can just force the block size to be 64k for fuse2fs,
although I don't think the using some file system like ext4 for
fuse2fs testing isn't going to work right now anyway, yes?

	      	   	     		     	       - Ted
