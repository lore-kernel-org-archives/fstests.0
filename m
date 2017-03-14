Received: from mx1.redhat.com ([209.132.183.28]:51112 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750806AbdCNNGV (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 14 Mar 2017 09:06:21 -0400
Date: Tue, 14 Mar 2017 21:06:19 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH 2/2] common/config: don't hard-code SELinux context
Message-ID: <20170314130619.GD14226@eguan.usersys.redhat.com>
References: <20170311005048.128477-1-ebiggers3@gmail.com>
 <20170311005048.128477-2-ebiggers3@gmail.com>
 <20170313040226.GV14226@eguan.usersys.redhat.com>
 <20170313175935.GA108079@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170313175935.GA108079@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eric Biggers <ebiggers3@gmail.com>
Cc: fstests@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, Gwendal Grignou <gwendal@chromium.org>, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

On Mon, Mar 13, 2017 at 10:59:35AM -0700, Eric Biggers wrote:
> On Mon, Mar 13, 2017 at 12:02:26PM +0800, Eryu Guan wrote:
> > On Fri, Mar 10, 2017 at 04:50:48PM -0800, Eric Biggers wrote:
> > > From: Eric Biggers <ebiggers@google.com>
> > > 
> > > If SELinux is enabled, xfstests mounts its filesystems with
> > > "-o context=system_u:object_r:nfs_t:s0" so that no SELinux xattrs get
> > > created and interfere with tests.  However, this particular context is
> > > not guaranteed to be available because the context names are a detail of
> > > the SELinux policy.  The SELinux policy on Android systems, for example,
> > > does not have a context with this name.
> > > 
> > > To fix this, just grab the SELinux context of the root directory.  This
> > > is arbitrary, but it should always provide a valid context.  And any
> > > valid context *should* be okay (i.e. we don't necessarily need a
> > > "liberal" one), since one would likely encounter many other problems if
> > > they were to run xfstests in a confined context with SELinux in
> > > enforcing mode.
> > > 
> > > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > 
> > SELINUX_MOUNT_OPTIONS has just been updated to be configurable, you can
> > set your own SELINUX_MOUNT_OPTIONS to override the default one, does
> > this work for you?
> > 
> > d8b1dc1 common/config: make SELinux protection conditional
> > 
> > Thanks,
> > Eryu
> 
> Oh, I didn't notice this.  It looks like Gwendal ran into the same problem, but
> on ChromeOS instead of Android.
> 
> The problem can indeed be solved by overriding SELINUX_MOUNT_OPTIONS.  But I
> think auto-detecting a valid context is better because then xfstests will just
> work without having to override SELINUX_MOUNT_OPTIONS.
> 
> An exception would be that if for some reason someone actually wants to run
> xfstests in some particular SELinux context (maybe one they've set up
> specifically for xfstests), then they'd likely need to specify a particular
> context when mounting.
> 
> How about just doing it both ways: use SELINUX_MOUNT_OPTIONS in the environment
> if set, otherwise mount with an auto-detected valid context?

This looks reasonable to me, and I tested ext4 ext3 and xfs with auto
group tests with selinux mount option set to `stat -c %C /`, and didn't
see any new failures.

Thanks,
Eryu
