Received: from bombadil.infradead.org ([198.137.202.9]:46145 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933451AbcBQKI1 (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 17 Feb 2016 05:08:27 -0500
Date: Wed, 17 Feb 2016 02:08:26 -0800
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 15/16] xfstests: increase tmpfs memory size
Message-ID: <20160217100826.GN21482@infradead.org>
References: <1455385269-26319-1-git-send-email-tytso@mit.edu>
 <1455385269-26319-16-git-send-email-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1455385269-26319-16-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, hughd@google.com, Junho Ryu <jayr@google.com>
List-ID: <fstests@vger.kernel.org>

On Sat, Feb 13, 2016 at 12:41:08PM -0500, Theodore Ts'o wrote:
> From: Hugh Dickins <hughd@google.com>
> 
> 512M is not enough for generic/129.  Raise default tmpfs size to 1G.

That also means generic/129 should check for the available space.

Otherwise I'm fine with if if you tmpfs testers think 1G is the proper
default.

Reviewed-by: Christoph Hellwig <hch@lst.de>
