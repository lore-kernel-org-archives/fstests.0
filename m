Received: from imap.thunk.org ([74.207.234.97]:45658 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756021AbdKNXiw (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 14 Nov 2017 18:38:52 -0500
Date: Tue, 14 Nov 2017 18:38:49 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] common: rework _require_ext4_mkfs_feature
Message-ID: <20171114233849.fnbutentfj4i7tcs@thunk.org>
References: <20171112133621.2474-1-tytso@mit.edu>
 <20171114114315.GH17339@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171114114315.GH17339@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Nov 14, 2017 at 07:43:15PM +0800, Eryu Guan wrote:
> Hmm, I don't think this the correct usage of _require rules. We use
> _require rule to check if the requirements have been met, but don't
> count on it to do any actual work. And we could always create a small
> filesystem (say 512m) if we want to reduce the mkfs time in the _require
> rule.

I'm trying to avoid duplicating work; in most of the cases where we
call _require_ext4_feature, we immediately create a file system with
the given features.

My original version of the patch to modify an ext4 test simply open
coded the check for the failure and then ran "_notrun".  Which was
criticized because the reviewers thought that it should be factored
out into common code.  That's fine, but if we have to call mke2fs
twice, that would be sad....

> How about naming it as _require_scratch_ext4_feature? So it indicates
> that we assume $SCRATCH_DEV is present here and acts as a reminder to
> _require_scratch first.

Sure.  How about simply including _require_scratch into the function?

> 
> >  {
> > -	local feature=$1
> > -	local testfile=/tmp/$$.ext4_mkfs
> > +	local feature="$1"
> > +	local sz="$2"
> 
> Assign sz=512m unconditionally?

In half of the cases we actually want to format the file system to
take up the whole disk.  So if sz is not specified, we end up omitting
the size parameter to mke2fs, which is by design.

> > +++ b/tests/ext4/306
> > @@ -44,7 +44,6 @@ _supported_fs ext4
> >  _supported_os Linux
> >  
> >  _require_scratch
> > -_require_ext4_mkfs_feature "64bit"
> 
> This is actually for old distros that mkfs.ext4 doesn't support 64bit
> feature, e.g. RHEL6. I think it's still meanful for now.

The funny thing is that ext4/306 is actually formatting the file
system *without* 64-bit feature.  So the _require_ext4_mkfs_feature is
really trying to make sure that this mke2fs doesn't fail:

$MKFS_EXT4_PROG -F -O ^extents,^64bit $SCRATCH_DEV 512m

So what we can probably do is this:

features="^extents"
if grep -q 64bit /etc/mke2fs.conf ; then
    features="^extents,^64bit"
fi
$MKFS_EXT4_PROG -F -O $features $SCRATCH_DEV 512m

						- Ted
