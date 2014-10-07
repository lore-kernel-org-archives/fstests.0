Return-Path: <fstests-owner@vger.kernel.org>
Received: from imap.thunk.org ([74.207.234.97]:39341 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752094AbaJGAxJ (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 6 Oct 2014 20:53:09 -0400
Date: Mon, 6 Oct 2014 20:53:00 -0400
From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH] generic/017: skip tests with mkfs failures
Message-ID: <20141007005300.GA11741@thunk.org>
References: <1412619830-23088-1-git-send-email-paul.paulson@seagate.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1412619830-23088-1-git-send-email-paul.paulson@seagate.com>
Sender: fstests-owner@vger.kernel.org
To: Paul Paulson <paul.paulson@seagate.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Oct 06, 2014 at 01:23:50PM -0500, Paul Paulson wrote:
> The mkfs command fails to create ext4 filesystems on partition sizes
> greater than 1998080 MiB when using 1024 byte blocks and the default
> calculation for the number of inodes reserved for the filesystem.

I've never noticed a problem because creating a partition that large
makes the xfstests runs take a long, long time.  I typically use a 5
GB or 20GB partition.  Is there a particular reason why you are trying
to do test ext4 using a 1k blocksize for a 2T file system?  We can fix
mke2fs so it doesn't fail when you create a > 2T file system with a 1k
block size, but the bigger question in my mind is why anyone would
ever want to do that?

					- Ted
