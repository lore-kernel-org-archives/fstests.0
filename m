Return-Path: <fstests-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:11637 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752096AbaLIUN7 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 9 Dec 2014 15:13:59 -0500
Date: Tue, 9 Dec 2014 15:13:41 -0500
From: Matthew Wilcox <willy@linux.intel.com>
Subject: Re: [PATCH] ext4: the _require checks for bigalloc need a larger fs
 size
Message-ID: <20141209201341.GB2220@wil.cx>
References: <1418149633-26571-1-git-send-email-vishal.l.verma@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1418149633-26571-1-git-send-email-vishal.l.verma@linux.intel.com>
Sender: fstests-owner@vger.kernel.org
To: Vishal Verma <vishal.l.verma@linux.intel.com>
Cc: fstests@vger.kernel.org, tytso@mit.edu, Matthew Wilcox <willy@linux.intel.com>
List-ID: <fstests@vger.kernel.org>

On Tue, Dec 09, 2014 at 11:27:13AM -0700, Vishal Verma wrote:
> _require_ext4_bigalloc and _require_ext4_mkfs_bigalloc create a
> 200k fs, which causes dax to fail with block_size != PAGE_SIZE
> Increasing the fs size to 512m fixes this.

Just to elaborate on this ... DAX (as XIP before it) relies on a fs
block size == system page size; ie 4k for us.  With a 200k fs size limit,
mkfs refuses to create a filesystem with a 4k block size, so the check
fails, but for a bogus reason.

