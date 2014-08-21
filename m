Return-Path: <fstests-owner@vger.kernel.org>
Received: from imap.thunk.org ([74.207.234.97]:42771 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754580AbaHUOBQ (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 21 Aug 2014 10:01:16 -0400
Date: Thu, 21 Aug 2014 10:01:06 -0400
From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH 2/6] common: _scratch_mkfs_sized should inherent default
 block size from test_dev
Message-ID: <20140821140106.GH11085@thunk.org>
References: <1408194791-1797-1-git-send-email-dmonakhov@openvz.org>
 <1408194791-1797-2-git-send-email-dmonakhov@openvz.org>
 <20140820231450.GI26465@dastard>
 <87mwayqooo.fsf@openvz.org>
 <20140821092344.GK26465@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140821092344.GK26465@dastard>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: Dmitry Monakhov <dmonakhov@openvz.org>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On that note, what is dbsize supposed to be?  It appears to be set in
_filter_mkfs?  It appears from context that this is supposed to be the
data block size?  Currently this gets hard coded to 4k for non-xfs
file systems, and it assumes a 256 byte inode.

It looks like we should be extracting this information from dumpe2fs
for extN file systems?

					- Ted
