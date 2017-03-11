Received: from mail-pf0-f193.google.com ([209.85.192.193]:34437 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933425AbdCKDry (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 10 Mar 2017 22:47:54 -0500
Received: by mail-pf0-f193.google.com with SMTP id o126so12737446pfb.1
        for <fstests@vger.kernel.org>; Fri, 10 Mar 2017 19:47:53 -0800 (PST)
Date: Fri, 10 Mar 2017 19:47:50 -0800
From: Eric Biggers <ebiggers3@gmail.com>
Subject: Re: [PATCH] android-xfstests: allow detection of SELinux
Message-ID: <20170311034750.GA619@zzz>
References: <20170311005306.129624-1-ebiggers3@gmail.com>
 <20170311015736.vl2cj34cfnu34qp4@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170311015736.vl2cj34cfnu34qp4@thunk.org>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

On Fri, Mar 10, 2017 at 08:57:36PM -0500, Theodore Ts'o wrote:
> On Fri, Mar 10, 2017 at 04:53:06PM -0800, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > xfstests is supposed to disable the creation of SELinux xattrs because
> > this interferes with some tests (e.g. generic/062 and generic/377), but
> > this was not working on Android.  For the android-xfstests portion of
> > the fix, make the following changes:
> > 
> > 1. To stop the mount program from stripping the 'context' mount option,
> > mount selinuxfs and create an empty /etc/selinux/config.  This makes the
> > is_selinux_enabled() function from libselinux return true.
> > 
> > 2. To stop xfstests from thinking that SELinux is disabled, link
> > /usr/sbin/selinuxenabled to /bin/true.  (Note: getting the real version
> > of selinuxenabled by adding selinux-utils to the chroot tarball would
> > also work, though no other programs from it are needed yet, and some
> > don't work in the chroot environment yet.)
> > 
> > In combination with the xfstests patch to stop hard-coding SELinux
> > contexts in xfstests, this fixes the failing tests.
> 
> Thanks!
> 
> I think you're missing the list of tests this fixes here?
> 
>   	       	       	   	- Ted

They're mentioned at the top: generic/062 and generic/377.  There may be others
among tests not being run, but those were the ones I observed were fixed.

Eric
