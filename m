Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:49614 "EHLO
	ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750736AbcERXzh (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 18 May 2016 19:55:37 -0400
Date: Thu, 19 May 2016 09:55:31 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 1/2] common/rc: modify _require_xfs_io_command function
Message-ID: <20160518235531.GB26977@dastard>
References: <1463502981-15593-1-git-send-email-zlang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1463502981-15593-1-git-send-email-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, May 18, 2016 at 12:36:20AM +0800, Zorro Lang wrote:
> 1. This function try to run $XFS_IO_PROG -c "$command help", that's
> wrong. It should be "help $command".

I think there was more to it that than:

$ sudo xfs_io -c "pwrite help"
$ sudo xfs_io -c "help pwrite"
pwrite [-i infile [-d] [-s skip]] [-b bs] [-S seed] [-wW] [-FBR [-Z N]] [-V N] off len -- writes a number of bytes at a specified offset

 writes a range of bytes (in block size increments) from the given offset
[....]
$ sudo xfs_io -c "foo help"
command "foo" not found

i.e. that check simply tells us whether the command exists or not
with an error message that is captured and then tested. If we
actually run the help command, we got lots of output for commands
that exist and that may confuse the error string checking we then
do.

Yes, it's a bit of a hack, and we may not even need the "help"
parameter anymore, but ISTR older versions of xfs_io needed it to
parse the CLI successfully for all the different commands....

> 2. The $param can't be used for all command's options, for example
> "help pwrite" include:
> 
>  -Z N -- zeed the random number generator (used when writing randomly)
>          (heh, zorry, the -s/-S arguments were already in use in pwrite)

This bit is fine.

In general, you should put separate changes into separate patches.
If you find yourself iterating a list of things a patch fixes in the
description, then that's a good sign it should be split into
multiple patches.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
