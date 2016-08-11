Received: from bombadil.infradead.org ([198.137.202.9]:38294 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752139AbcHKRsE (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 11 Aug 2016 13:48:04 -0400
Date: Thu, 11 Aug 2016 10:48:02 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] common/defrag: rework _require_defrag for ext4
Message-ID: <20160811174802.GC31540@infradead.org>
References: <20160804200246.GA2208@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160804200246.GA2208@localhost.localdomain>
Sender: fstests-owner@vger.kernel.org
To: Eric Whitney <enwlinux@gmail.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org, tytso@mit.edu
List-ID: <fstests@vger.kernel.org>

On Thu, Aug 04, 2016 at 04:02:46PM -0400, Eric Whitney wrote:
> The existing _require_defrag function rejects ext4 file systems
> mounted with the dax option or constructed without extents.  However,
> there are also a number of other ext4 file system configuration cases
> that do not currently support online defrag, including encryption, data
> journaling, and bigalloc.  In the future, online defrag functionality
> may be implemented for some of these, and new configuration cases
> could be added that don't support it.
> 
> Rather than add a laundry list of mount and file system configuration
> options to the existing _require_defrag function that will need ongoing
> maintenance, use the available src/e4compact program to directly
> determine whether the kernel supports ext4's move extent ioctl on the
> test file system.

This look reasonable - but I wonder if we could just come up with an
even more generic version that uses your approach on all file systems,
so that the only per-fs logic left would be to apply the
DEFRAG_PROG variable.
