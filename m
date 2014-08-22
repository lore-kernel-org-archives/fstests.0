Return-Path: <fstests-owner@vger.kernel.org>
Received: from imap.thunk.org ([74.207.234.97]:44662 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932092AbaHVPJZ (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 22 Aug 2014 11:09:25 -0400
Date: Fri, 22 Aug 2014 11:09:15 -0400
From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH 2/6] common: _scratch_mkfs_sized should inherent default
 block size from test_dev
Message-ID: <20140822150915.GN11085@thunk.org>
References: <1408194791-1797-1-git-send-email-dmonakhov@openvz.org>
 <1408194791-1797-2-git-send-email-dmonakhov@openvz.org>
 <20140820231450.GI26465@dastard>
 <87mwayqooo.fsf@openvz.org>
 <20140821092344.GK26465@dastard>
 <877g20r72g.fsf@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877g20r72g.fsf@openvz.org>
Sender: fstests-owner@vger.kernel.org
To: Dmitry Monakhov <dmonakhov@openvz.org>
Cc: Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

The mke2fs command will allow a subsequent -b option to override a
pervious one.  So something like this will work:

mke2fs -t ext4 -b 4096 -b 2048 -b 1024 /tmp/foo.img 100

So you don't really need to do hacks with sed.  Also, if MKFS_OPTIONS
has a -b option, then you shouldn't need to do any -b overrides at
all, since that probably means the person doing the xfstest run
actually specified a block size directly for a Good Reason.  We might
want to issue a warning message if the block size specified by
MKFS_OPTIONS doesn't match what the test file system uses, but that's
more of a sanity check than anything else.

Also, see my comments about dbsize; it might be a good idea if we want
to do this sort of thing to refactor out a standard way of determining
the block size of the test file system.

Cheers,

						- Ted
