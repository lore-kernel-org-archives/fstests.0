Received: from bombadil.infradead.org ([198.137.202.9]:47308 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933451AbcBQKJY (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 17 Feb 2016 05:09:24 -0500
Date: Wed, 17 Feb 2016 02:09:23 -0800
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 16/16] xfstests: remove _need_to_be_root
Message-ID: <20160217100923.GO21482@infradead.org>
References: <1455385269-26319-1-git-send-email-tytso@mit.edu>
 <1455385269-26319-17-git-send-email-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1455385269-26319-17-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, hughd@google.com
List-ID: <fstests@vger.kernel.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

While you're at it it would be nice to also remove the odd instruction
of adding the '123456-fsgqa' test user in README.
