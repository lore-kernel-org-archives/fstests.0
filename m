Received: from imap.thunk.org ([74.207.234.97]:33366 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965099AbcIZPPJ (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 26 Sep 2016 11:15:09 -0400
Date: Mon, 26 Sep 2016 11:14:31 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] common: add support for the "local" file system type
Message-ID: <20160926151431.uhtny5tx3b436j4i@thunk.org>
References: <20160923200526.29674-1-tytso@mit.edu>
 <20160926132503.GJ27776@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160926132503.GJ27776@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Sep 26, 2016 at 09:25:03PM +0800, Eryu Guan wrote:
> On Fri, Sep 23, 2016 at 04:05:26PM -0400, Theodore Ts'o wrote:
> > It is sometimes useful to be able to test the local file system
> > provided in a restricted execution environment (such as that which is
> > provided by Docker, for example) where it is not possible to mount and
> > unmount the file system under test.
> 
> This looks useful to me. But I'm not sure what other people think.
> 
> I tested this patch a bit (ran auto group), noticed some isuses.
> 
> - Tests call _require_scratch_shutdown would shutdown your root fs, if
>   $SCRATCH_MNT is on root fs and root fs is xfs. e.g. generic/044
> - Tests do freeze/unfreeze would freeze your root fs, e.g. generic/068
> - Tests fulfill $SCRATCH_DEV would eat all free space on root fs,
>   because _scratch_mkfs_sized for "local" only checks for lower boundary
>   but not upper boundary, some tests rely on the upper boundary too,
>   e.g. generic/027
> 
> There might be other issues I didn't notice, since I didn't manage to
> finish a "FSTYP=local ./check -g auto" run because of above issues.

Oops, I was testing on small test devices using ext4, so I didn't
notice these issues.  I'll fix them up.

> > To support this test case, add support for a new file system type
> > called "local".  The TEST_DEV and SCRATCH_DEV should be have a
> > non-block device format (e.g., local:/test or local:/scratch), and the
> 
> It's probably good to have a new fstype, as how we test NFS and overlay.
> i.e. ./check -local, and do all the necessary checks as how we check NFS
> and overlay setups.

Even for NFS and overlayfs there are some tests we do where mounting
and remounting the file system (e.g., with the ro mount option)
probably does make sense.  Although I do agree there are a large
number of the NFS mounts and umounts which are largely pointless.

I was implementing the local file systme type for situations where it
is simply *not* *possible* at all to mount and unmount the underlying
file system because it was operating inside a docker container where
even root didn't have access to modify the supplied file system.
(Yes, in some cases we could test the underlying file system, but not
all, and it is useful to have end-to-end tests.)

> > TEST_DIR and SCRATCH_MNT directories should be pre-existing
> > directories provided by the execution environment.
> 
> Better to have these setups and requirements documented in README.

Agreed, I'll fix this in the next spin of the patch.

	     	      	     	       	      - Ted
