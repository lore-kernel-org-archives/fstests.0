Received: from bombadil.infradead.org ([198.137.202.9]:60823 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755040AbbG3RKA (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 30 Jul 2015 13:10:00 -0400
Date: Thu, 30 Jul 2015 10:09:58 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 5/6] xfsprogs: use "unsigned short" instead of ushort
Message-ID: <20150730170958.GB25395@infradead.org>
References: <1437913255-7524-1-git-send-email-tytso@mit.edu>
 <1437913255-7524-6-git-send-email-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1437913255-7524-6-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: xfs@oss.sgi.com, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sun, Jul 26, 2015 at 08:20:54AM -0400, Theodore Ts'o wrote:
> Android's bionic libc doesn't define ushort.  There isn't a real
> benefit (other than perhaps conciseness) to use ushort over "unsigned
> short", and it's only used in a handful of files in xfsprogs.  So
> change over to using unsigned short everywhere.

For the files shared with the kernel this should go into the kernel
first or at least at the same time.  Can you also send
a kernel patch to remove all uses of ushort under fs/xfs?

Otherwise looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>
