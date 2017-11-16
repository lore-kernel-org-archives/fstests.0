Received: from mx1.redhat.com ([209.132.183.28]:34552 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933090AbdKPEA3 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 15 Nov 2017 23:00:29 -0500
Date: Thu, 16 Nov 2017 12:00:24 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH -v3] common: rework _require_ext4_mkfs_feature
Message-ID: <20171116040024.GW17339@eguan.usersys.redhat.com>
References: <20171112133621.2474-1-tytso@mit.edu>
 <20171114114315.GH17339@eguan.usersys.redhat.com>
 <20171114233849.fnbutentfj4i7tcs@thunk.org>
 <20171115003037.wypomnpzxrmwmspd@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171115003037.wypomnpzxrmwmspd@thunk.org>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Nov 14, 2017 at 07:30:37PM -0500, Theodore Ts'o wrote:
> On Tue, Nov 14, 2017 at 06:38:49PM -0500, Theodore Ts'o wrote:
> > 
> > Sure.  How about simply including _require_scratch into the function?
> 
> Nope, that won't work, since we need _require_scratch_nocheck for one
> of the tests.
> 
> OK, here's V3 of the patch.  WDYT?
> 
> 						- Ted
> commit b9d9da8b901acc5b6cb5da7149b7e8ce986e436e
> Author: Theodore Ts'o <tytso@mit.edu>
> Date:   Sat Nov 11 23:28:51 2017 -0500
> 
>     common: rework _require_ext4_mkfs_feature
>     
>     In all of the places where we need check to see if mkfs.ext4 can
>     support a set of file system features, we also should be checking to
>     see if the kernel can support those file system features.  So rename
>     _require_ext4_mkfs_feature to _require_ext4_feature, and actually
>     format the file system in $SCRATCH.  To avoid running mkfs twice in
>     most tests, we will teach the tests to assume that
>     _require_ext4_feature actually leaves $SCRATCH formatted with a file
>     system with those features.

I have to say I still don't like the idea of relying on a _require rule
to do the actual mkfs work, I'd rather run mkfs twice. That way we keep
consistent semantics and usages of all _require rules across fstests (we
already have several other rules do so, like _require_scratch_xfs_crc),
and give people least surprise when reading tests calling such rules.
And we can always create a small filesystem by default, say 512m, in
_require_scratch_ext4_feature to reduce the mkfs time and mitigate the
downside of mkfs twice.

>     
>     Also allow ext4/306 to run on systems where mke2fs doesn't support the
>     "64bit" option.

This part looks good to me. Thanks!

Eryu
