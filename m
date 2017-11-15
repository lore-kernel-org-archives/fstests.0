Received: from imap.thunk.org ([74.207.234.97]:46160 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757162AbdKOC5J (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 14 Nov 2017 21:57:09 -0500
Date: Tue, 14 Nov 2017 21:57:05 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] common: rework _require_ext4_mkfs_feature
Message-ID: <20171115025705.agxu5v4dmm2ja532@thunk.org>
References: <20171112133621.2474-1-tytso@mit.edu>
 <20171114114315.GH17339@eguan.usersys.redhat.com>
 <20171115005655.GE4094@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171115005655.GE4094@dastard>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: Eryu Guan <eguan@redhat.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Nov 15, 2017 at 11:56:55AM +1100, Dave Chinner wrote:
> Implement, like in mkfs.xfs, the "-N" flag (a.k.a "--dry-run").
> It does option parsing and geometry calculations, outputs the config
> that would be made, then exits before doing any actual IO. Hence we
> can check mkfs feature support on XFS, and only take the time to
> make a filesystem if we need to check that kernel support exists.

mke2fs has a -n option, but that's not what I'm trying to address.

Now that we want to *mount* the file system to check to see if the
kernel can support the file system feature, we can no longer use the
-n option.  And since the tests all need to create the file system
*anyway*, it seemed rather pointless to create it once, then do the
trial mount, and then creating the file system a second time.

      	     	      	       	   	       - Ted
