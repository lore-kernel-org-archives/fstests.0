Return-Path: <fstests-owner@vger.kernel.org>
Received: from imap.thunk.org ([74.207.234.97]:44848 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932244AbaHVQhS (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 22 Aug 2014 12:37:18 -0400
Date: Fri, 22 Aug 2014 12:37:12 -0400
From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH 2/6] common: _scratch_mkfs_sized should inherent default
 block size from test_dev
Message-ID: <20140822163712.GP11085@thunk.org>
References: <1408194791-1797-1-git-send-email-dmonakhov@openvz.org>
 <1408194791-1797-2-git-send-email-dmonakhov@openvz.org>
 <20140820231450.GI26465@dastard>
 <87mwayqooo.fsf@openvz.org>
 <20140821092344.GK26465@dastard>
 <877g20r72g.fsf@openvz.org>
 <20140822150915.GN11085@thunk.org>
 <874mx4r0eg.fsf@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874mx4r0eg.fsf@openvz.org>
Sender: fstests-owner@vger.kernel.org
To: Dmitry Monakhov <dmonakhov@openvz.org>
Cc: Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Aug 22, 2014 at 07:48:07PM +0400, Dmitry Monakhov wrote:
> No, This will not works. Looks like you have missed the point.
> helper has following signature:
> _scratch_mkfs_sized <size in bytes> [optional blocksize]
> But mke2fs accept filesystem size accounted in fs-blocks, so in order
> to convert size in blocks to number of blocks we have to figure out blocksize.

Ah, sorry.  I didn't understand what problem you were trying to solve.

But mke2fs does accept the filesystem size accounted in kilobytes (and
megabytes, gigabytes, etc.).  So you could just take the size in
bytes, divide by 1024, and then append 'k', i.e:

       mke2fs $MKFS_OPTS $DEVICE $(expr $bytes / 1024)k

This will work regardless of the block size.

Cheers,

						- Ted
