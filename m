Received: from mx1.redhat.com ([209.132.183.28]:43268 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750740AbdCMEC3 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 13 Mar 2017 00:02:29 -0400
Date: Mon, 13 Mar 2017 12:02:26 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH 2/2] common/config: don't hard-code SELinux context
Message-ID: <20170313040226.GV14226@eguan.usersys.redhat.com>
References: <20170311005048.128477-1-ebiggers3@gmail.com>
 <20170311005048.128477-2-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170311005048.128477-2-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eric Biggers <ebiggers3@gmail.com>
Cc: fstests@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

On Fri, Mar 10, 2017 at 04:50:48PM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> If SELinux is enabled, xfstests mounts its filesystems with
> "-o context=system_u:object_r:nfs_t:s0" so that no SELinux xattrs get
> created and interfere with tests.  However, this particular context is
> not guaranteed to be available because the context names are a detail of
> the SELinux policy.  The SELinux policy on Android systems, for example,
> does not have a context with this name.
> 
> To fix this, just grab the SELinux context of the root directory.  This
> is arbitrary, but it should always provide a valid context.  And any
> valid context *should* be okay (i.e. we don't necessarily need a
> "liberal" one), since one would likely encounter many other problems if
> they were to run xfstests in a confined context with SELinux in
> enforcing mode.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

SELINUX_MOUNT_OPTIONS has just been updated to be configurable, you can
set your own SELINUX_MOUNT_OPTIONS to override the default one, does
this work for you?

d8b1dc1 common/config: make SELinux protection conditional

Thanks,
Eryu
