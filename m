Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:33284 "EHLO
	ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751869AbcGABkw (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 30 Jun 2016 21:40:52 -0400
Date: Fri, 1 Jul 2016 11:40:02 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 2/2] tests/xfs: test for post umount readahead completion
 panic
Message-ID: <20160701014002.GY27480@dastard>
References: <1467290974-13203-1-git-send-email-bfoster@redhat.com>
 <1467290974-13203-3-git-send-email-bfoster@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1467290974-13203-3-git-send-email-bfoster@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Brian Foster <bfoster@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Jun 30, 2016 at 08:49:34AM -0400, Brian Foster wrote:
> XFS has a bug where directory readahead completions can occur after
> unmount. This can lead to a crash or panic because metadata read
> verification attempts to access core XFS data structures (e.g., the log)
> after they have been freed and certain pointers have been reset.
> 
> Add a test that triggers directory readahead, delays the readahead I/O
> and immediately unmounts the filesystem. This test is part of the
> dangerous group as it will cause kernels affected by the bug to crash.
.....
> +
> +# create a directory large enough for extent format
> +mkdir $SCRATCH_MNT/dir
> +for i in $(seq 0 999); do
> +	touch $SCRATCH_MNT/dir/$i
> +done

minor quibble - what's an "extent format" directory? I think you
mean a directory inode whose data fork is in extent or btree format,
not inline. i.e. not a short-form directory, but rather a block,
leaf or node format directory.

Yeah, I'm being pedantic, but we should use the correct terminology
so when someone reads it in 5 years time....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
