Received: from bombadil.infradead.org ([198.137.202.9]:45088 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933881AbcBQKHK (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 17 Feb 2016 05:07:10 -0500
Date: Wed, 17 Feb 2016 02:07:09 -0800
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 14/16] xfstests: add executable permission to tests
Message-ID: <20160217100709.GM21482@infradead.org>
References: <1455385269-26319-1-git-send-email-tytso@mit.edu>
 <1455385269-26319-15-git-send-email-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1455385269-26319-15-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, hughd@google.com
List-ID: <fstests@vger.kernel.org>

On Sat, Feb 13, 2016 at 12:41:07PM -0500, Theodore Ts'o wrote:
> From: Hugh Dickins <hughd@google.com>
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>

A little changelog would be nice. But if this fixes the changing
permissions after the tests are actually run I'm all for it!
