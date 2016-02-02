Received: from bombadil.infradead.org ([198.137.202.9]:53416 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753274AbcBBSIa (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 2 Feb 2016 13:08:30 -0500
Date: Tue, 2 Feb 2016 10:08:28 -0800
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: xfsprogs: Add BUILD_CFLAGS for cross compilation
Message-ID: <20160202180828.GA13880@infradead.org>
References: <1437913255-7524-4-git-send-email-tytso@mit.edu>
 <1454361909-36538-1-git-send-email-gwendal@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1454361909-36538-1-git-send-email-gwendal@chromium.org>
Sender: fstests-owner@vger.kernel.org
To: Gwendal Grignou <gwendal@chromium.org>
Cc: hch@infradead.org, tytso@mit.edu, fstests@vger.kernel.org, xfs@oss.sgi.com
List-ID: <fstests@vger.kernel.org>

On Mon, Feb 01, 2016 at 01:25:09PM -0800, Gwendal Grignou wrote:
> When cross compiling, CFLAGS may contains option for the cros-compiler the
> host compiler can not handle.
> Add BUILD_CFLAGS variable that does not include $OPTIMIZER options.

I would have expected this to be HOST_CFLAGS, but it seems the
BUILD_ convention already exists in xfsprogs, so sticking to it
looks fine to me.

Reviewed-by: Christoph Hellwig <hch@lst.de>
