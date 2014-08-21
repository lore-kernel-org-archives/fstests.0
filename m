Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:47013 "EHLO
	ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753747AbaHUUoo (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 21 Aug 2014 16:44:44 -0400
Date: Fri, 22 Aug 2014 06:44:40 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 2/6] common: _scratch_mkfs_sized should inherent default
 block size from test_dev
Message-ID: <20140821204440.GN26465@dastard>
References: <1408194791-1797-1-git-send-email-dmonakhov@openvz.org>
 <1408194791-1797-2-git-send-email-dmonakhov@openvz.org>
 <20140820231450.GI26465@dastard>
 <87mwayqooo.fsf@openvz.org>
 <20140821092344.GK26465@dastard>
 <20140821140106.GH11085@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140821140106.GH11085@thunk.org>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: Dmitry Monakhov <dmonakhov@openvz.org>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Aug 21, 2014 at 10:01:06AM -0400, Theodore Ts'o wrote:
> On that note, what is dbsize supposed to be?  It appears to be set in
> _filter_mkfs?  It appears from context that this is supposed to be the
> data block size?  Currently this gets hard coded to 4k for non-xfs
> file systems, and it assumes a 256 byte inode.
> 
> It looks like we should be extracting this information from dumpe2fs
> for extN file systems?

*nod*

Most of the special mkfs sauce that is used by XFS specific tests
simply has not been written for other filesystems.  The hard coded
results from _filter_mkfs are just there so that generic tests that
use dbsize/isize mostly work.

So if want you to add this "reflect reality" functionality for ext4
you are more than welcome to do it. :)

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
