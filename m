Received: from bombadil.infradead.org ([198.137.202.9]:47123 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752120AbbG3ROs (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 30 Jul 2015 13:14:48 -0400
Date: Thu, 30 Jul 2015 10:14:48 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 3/4] xfstests: use the Posix st_mode defines instead of
 the obsolete SysV ones
Message-ID: <20150730171448.GC18185@infradead.org>
References: <1438006967-18815-1-git-send-email-tytso@mit.edu>
 <1438006967-18815-4-git-send-email-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1438006967-18815-4-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Jul 27, 2015 at 10:22:46AM -0400, Theodore Ts'o wrote:
> Instead of S_IEXEC, S_IREAD, and S_IWRITE, use the Posix defines of
> S_I[WRX]{OTH,GRP,USR}.
> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
