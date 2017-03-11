Received: from imap.thunk.org ([74.207.234.97]:50274 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755330AbdCKB5k (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 10 Mar 2017 20:57:40 -0500
Date: Fri, 10 Mar 2017 20:57:36 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] android-xfstests: allow detection of SELinux
Message-ID: <20170311015736.vl2cj34cfnu34qp4@thunk.org>
References: <20170311005306.129624-1-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170311005306.129624-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eric Biggers <ebiggers3@gmail.com>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

On Fri, Mar 10, 2017 at 04:53:06PM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> xfstests is supposed to disable the creation of SELinux xattrs because
> this interferes with some tests (e.g. generic/062 and generic/377), but
> this was not working on Android.  For the android-xfstests portion of
> the fix, make the following changes:
> 
> 1. To stop the mount program from stripping the 'context' mount option,
> mount selinuxfs and create an empty /etc/selinux/config.  This makes the
> is_selinux_enabled() function from libselinux return true.
> 
> 2. To stop xfstests from thinking that SELinux is disabled, link
> /usr/sbin/selinuxenabled to /bin/true.  (Note: getting the real version
> of selinuxenabled by adding selinux-utils to the chroot tarball would
> also work, though no other programs from it are needed yet, and some
> don't work in the chroot environment yet.)
> 
> In combination with the xfstests patch to stop hard-coding SELinux
> contexts in xfstests, this fixes the failing tests.

Thanks!

I think you're missing the list of tests this fixes here?

  	       	       	   	- Ted
