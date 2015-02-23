Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:36840 "EHLO
	ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752713AbbBWWqX (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 23 Feb 2015 17:46:23 -0500
Date: Tue, 24 Feb 2015 09:46:20 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] ext4: add regression tests for ^extents punch hole
Message-ID: <20150223224620.GL12722@dastard>
References: <4c557308eb4e62752dc8b513495cb6d46ca5775d.1424730653.git.osandov@osandov.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c557308eb4e62752dc8b513495cb6d46ca5775d.1424730653.git.osandov@osandov.com>
Sender: fstests-owner@vger.kernel.org
To: Omar Sandoval <osandov@osandov.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Feb 23, 2015 at 02:39:36PM -0800, Omar Sandoval wrote:
> Linux commit 6f30b7e37a82 (ext4: fix indirect punch hole corruption)
> fixes several bugs in the FALLOC_FL_PUNCH_HOLE implementation for an
> ext4 filesystem with indirect blocks.
> 
> Signed-off-by: Omar Sandoval <osandov@osandov.com>
> ---
>  tests/ext4/005     | 115 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/ext4/005.out |  29 ++++++++++++++
>  tests/ext4/group   |   1 +
>  3 files changed, 145 insertions(+)
>  create mode 100755 tests/ext4/005
>  create mode 100644 tests/ext4/005.out

What's ext4 specific about this test apart from the mkfs parameter?
Shouldn't it be generic and so test all the filesystems behave the
same?  i.e. when someone then runs

# MKFS_OPTIONS="-b size=1k -O ^extents" ./check -g auto

That will exercise this specific regression fix, not to mention give
much, much better test coverage of that configuration than just
making a single test use that config...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
