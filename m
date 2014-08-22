Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:55056 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932159AbaHVPsM (ORCPT
	<rfc822;fstests@vger.kernel.org>); Fri, 22 Aug 2014 11:48:12 -0400
Received: by mail-la0-f41.google.com with SMTP id s18so10266289lam.14
        for <fstests@vger.kernel.org>; Fri, 22 Aug 2014 08:48:10 -0700 (PDT)
From: Dmitry Monakhov <dmonakhov@openvz.org>
Subject: Re: [PATCH 2/6] common: _scratch_mkfs_sized should inherent default block size from test_dev
In-Reply-To: <20140822150915.GN11085@thunk.org>
References: <1408194791-1797-1-git-send-email-dmonakhov@openvz.org> <1408194791-1797-2-git-send-email-dmonakhov@openvz.org> <20140820231450.GI26465@dastard> <87mwayqooo.fsf@openvz.org> <20140821092344.GK26465@dastard> <877g20r72g.fsf@openvz.org> <20140822150915.GN11085@thunk.org>
Date: Fri, 22 Aug 2014 19:48:07 +0400
Message-ID: <874mx4r0eg.fsf@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, 22 Aug 2014 11:09:15 -0400, "Theodore Ts'o" <tytso@mit.edu> wrote:
> The mke2fs command will allow a subsequent -b option to override a
> pervious one.  So something like this will work:
> 
> mke2fs -t ext4 -b 4096 -b 2048 -b 1024 /tmp/foo.img 100
No, This will not works. Looks like you have missed the point.
helper has following signature:
_scratch_mkfs_sized <size in bytes> [optional blocksize]
But mke2fs accept filesystem size accounted in fs-blocks, so in order
to convert size in blocks to number of blocks we have to figure out blocksize.
In fact currently _ALL_ users of _scratch_mkfs_sized skip this optional
parameter, so it is reasonable to use the one from MKFS_OPTIONS instead other
which is hard coded inside helper. And as you can see from my patch logic is follows:
1) Use explicit block size if it was passed as function parameter
2) if not (1) then Use block size defined from MKFS_OPTION
3) if not (2) Use default block size (4096) 
> 
> So you don't really need to do hacks with sed.  Also, if MKFS_OPTIONS
> has a -b option, then you shouldn't need to do any -b overrides at
> all, since that probably means the person doing the xfstest run
> actually specified a block size directly for a Good Reason.  We might
> want to issue a warning message if the block size specified by
> MKFS_OPTIONS doesn't match what the test file system uses, but that's
> more of a sanity check than anything else.
> 
> Also, see my comments about dbsize; it might be a good idea if we want
> to do this sort of thing to refactor out a standard way of determining
> the block size of the test file system.
> 
> Cheers,
> 
> 						- Ted
