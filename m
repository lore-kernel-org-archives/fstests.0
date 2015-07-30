Received: from bombadil.infradead.org ([198.137.202.9]:48388 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750874AbbG3RPJ (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 30 Jul 2015 13:15:09 -0400
Date: Thu, 30 Jul 2015 10:15:08 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 4/4] xfstests: remove manual declaration of errno
Message-ID: <20150730171508.GD18185@infradead.org>
References: <1438006967-18815-1-git-send-email-tytso@mit.edu>
 <1438006967-18815-5-git-send-email-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1438006967-18815-5-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Jul 27, 2015 at 10:22:47AM -0400, Theodore Ts'o wrote:
> locktest.c has already #included <errno.h>, so remove the unneeded
> (and in some cases, incorrect) manual declaration of errno as an
> integer.  Some C libraries use a macro to provide thread-safety for
> errno, so it's incorrect to try to provide a manual declaration.
> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
