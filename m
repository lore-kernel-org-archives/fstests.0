Received: from mail-pg0-f68.google.com ([74.125.83.68]:32850 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753266AbdCMR7j (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 13 Mar 2017 13:59:39 -0400
Received: by mail-pg0-f68.google.com with SMTP id 77so18759827pgc.0
        for <fstests@vger.kernel.org>; Mon, 13 Mar 2017 10:59:38 -0700 (PDT)
Date: Mon, 13 Mar 2017 10:59:35 -0700
From: Eric Biggers <ebiggers3@gmail.com>
Subject: Re: [PATCH 2/2] common/config: don't hard-code SELinux context
Message-ID: <20170313175935.GA108079@gmail.com>
References: <20170311005048.128477-1-ebiggers3@gmail.com>
 <20170311005048.128477-2-ebiggers3@gmail.com>
 <20170313040226.GV14226@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170313040226.GV14226@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, Gwendal Grignou <gwendal@chromium.org>, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

On Mon, Mar 13, 2017 at 12:02:26PM +0800, Eryu Guan wrote:
> On Fri, Mar 10, 2017 at 04:50:48PM -0800, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > If SELinux is enabled, xfstests mounts its filesystems with
> > "-o context=system_u:object_r:nfs_t:s0" so that no SELinux xattrs get
> > created and interfere with tests.  However, this particular context is
> > not guaranteed to be available because the context names are a detail of
> > the SELinux policy.  The SELinux policy on Android systems, for example,
> > does not have a context with this name.
> > 
> > To fix this, just grab the SELinux context of the root directory.  This
> > is arbitrary, but it should always provide a valid context.  And any
> > valid context *should* be okay (i.e. we don't necessarily need a
> > "liberal" one), since one would likely encounter many other problems if
> > they were to run xfstests in a confined context with SELinux in
> > enforcing mode.
> > 
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> 
> SELINUX_MOUNT_OPTIONS has just been updated to be configurable, you can
> set your own SELINUX_MOUNT_OPTIONS to override the default one, does
> this work for you?
> 
> d8b1dc1 common/config: make SELinux protection conditional
> 
> Thanks,
> Eryu

Oh, I didn't notice this.  It looks like Gwendal ran into the same problem, but
on ChromeOS instead of Android.

The problem can indeed be solved by overriding SELINUX_MOUNT_OPTIONS.  But I
think auto-detecting a valid context is better because then xfstests will just
work without having to override SELINUX_MOUNT_OPTIONS.

An exception would be that if for some reason someone actually wants to run
xfstests in some particular SELinux context (maybe one they've set up
specifically for xfstests), then they'd likely need to specify a particular
context when mounting.

How about just doing it both ways: use SELINUX_MOUNT_OPTIONS in the environment
if set, otherwise mount with an auto-detected valid context?

Eric
