Received: from ipmail05.adl6.internode.on.net ([150.101.137.143]:32913 "EHLO
        ipmail05.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751804AbcH3GG7 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 30 Aug 2016 02:06:59 -0400
Date: Tue, 30 Aug 2016 16:06:29 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v3] Add a test for listxattr syscall with different
 buffer sizes.
Message-ID: <20160830060629.GU22388@dastard>
References: <20160826051819.GQ22388@dastard>
 <1472211074-26464-1-git-send-email-asavkov@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1472211074-26464-1-git-send-email-asavkov@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Artem Savkov <asavkov@redhat.com>
Cc: fstests@vger.kernel.org, Eryu Guan <eguan@redhat.com>, Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

On Fri, Aug 26, 2016 at 01:31:14PM +0200, Artem Savkov wrote:
> Add generic/375 test that calls listxattr syscall with different buffer size
> arguments checking if it fails properly.
> 
> Signed-off-by: Artem Savkov <asavkov@redhat.com>
> ---
>  .gitignore            |  1 +
>  src/Makefile          |  2 +-
>  src/listxattr.c       | 73 ++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/375     | 87 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/375.out | 11 +++++++
>  tests/generic/group   |  1 +
>  6 files changed, 174 insertions(+), 1 deletion(-)
>  create mode 100644 src/listxattr.c
>  create mode 100755 tests/generic/375
>  create mode 100644 tests/generic/375.out
> 
> diff --git a/.gitignore b/.gitignore
> index d84f385..915d2d8 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -66,6 +66,7 @@
>  /src/holes
>  /src/holetest
>  /src/itrash
> +/src/listxattr
>  /src/locktest
>  /src/loggen
>  /src/looptest
> diff --git a/src/Makefile b/src/Makefile
> index 57b0df1..dd51216 100644
> --- a/src/Makefile
> +++ b/src/Makefile
> @@ -21,7 +21,7 @@ LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
>  	stale_handle pwrite_mmap_blocked t_dir_offset2 seek_sanity_test \
>  	seek_copy_test t_readdir_1 t_readdir_2 fsync-tester nsexec cloner \
>  	renameat2 t_getcwd e4compact test-nextquota punch-alternating \
> -	attr-list-by-handle-cursor-test
> +	attr-list-by-handle-cursor-test listxattr
>  
>  SUBDIRS =
>  
> diff --git a/src/listxattr.c b/src/listxattr.c
> new file mode 100644
> index 0000000..da9d163
> --- /dev/null
> +++ b/src/listxattr.c
> @@ -0,0 +1,73 @@
> +/*
> + * Copyright (c) 2016 Artem Savkov <asavkov@redhat.com>

This is somewhat contradictory  and quite ambiguous - a personal
copyright assertion from with your employer's email contact and a
s-o-b from the same address. If it's your own personal copyright,
then please use a private email address. i.e

Copyright (c) 2016 Artem Savkov <personal email address>

And the patch needs to have a S-o-B that matches the copyright
statement.

However, you're doing all this work under a @redhat.com email
address, it tends to mean the work is not owned directly by you
but your employer, and hence the copywrite statement needs to be:

Copyright (c) 2016 Red Hat, Inc. All rights reserved.

I know, I'm being a pendant, but copyright is a legal construct and
we need to be certain that it is correct and unambigious. If you
have any doubt about whether you or your company owns the copyright
for work you do on their behalf, please refer to your company legal
counsel for advice...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
