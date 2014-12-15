Return-Path: <fstests-owner@vger.kernel.org>
Received: from imap.thunk.org ([74.207.234.97]:55723 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750702AbaLOAEu (ORCPT <rfc822;fstests@vger.kernel.org>);
	Sun, 14 Dec 2014 19:04:50 -0500
Date: Sun, 14 Dec 2014 19:04:49 -0500
From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH v2] ext4: the _require checks for bigalloc need a larger
 fs size
Message-ID: <20141215000449.GR29787@thunk.org>
References: <1418335880-27252-1-git-send-email-vishal.l.verma@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1418335880-27252-1-git-send-email-vishal.l.verma@linux.intel.com>
Sender: fstests-owner@vger.kernel.org
To: Vishal Verma <vishal.l.verma@linux.intel.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Dec 11, 2014 at 03:11:20PM -0700, Vishal Verma wrote:
> _require_ext4_bigalloc and _require_ext4_mkfs_bigalloc create a
> 200k fs. DAX (as XIP before it) relies on a fs block size ==
> system page size; ie 4k for us.  With a 200k fs size limit,
> mkfs refuses to create a filesystem with a 4k block size, so
> the check fails, but for a bogus reason.
> Increasing the fs size to 512m allows mkfs to create a filesystem
> with 4k block size, so the test passes.
> 
> Signed-off-by: Vishal Verma <vishal.l.verma@linux.intel.com>
> Signed-off-by: Matthew Wilcox <willy@linux.intel.com>

LGTM

Reviewed-by: Theodore Ts'o <tytso@mit.edu>

						- Ted
