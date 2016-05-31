Received: from bombadil.infradead.org ([198.137.202.9]:34927 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753014AbcEaMv7 (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 31 May 2016 08:51:59 -0400
Date: Tue, 31 May 2016 05:51:57 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: xfsprogs: Add BUILD_CFLAGS for cross compilation
Message-ID: <20160531125157.GB17018@infradead.org>
References: <1437913255-7524-4-git-send-email-tytso@mit.edu>
 <1454361909-36538-1-git-send-email-gwendal@chromium.org>
 <20160202180828.GA13880@infradead.org>
 <CAMHSBOUQ5eUL+Y+voDCwC9U7gmTsUZu2Oympn+c0=DxaU4egjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMHSBOUQ5eUL+Y+voDCwC9U7gmTsUZu2Oympn+c0=DxaU4egjA@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Gwendal Grignou <gwendal@chromium.org>
Cc: Theodore Ts'o <tytso@mit.edu>, fstests@vger.kernel.org, xfs@oss.sgi.com
List-ID: <fstests@vger.kernel.org>

On Fri, May 27, 2016 at 09:34:50AM -0700, Gwendal Grignou wrote:
> Looking at xfsprogs-4.5.0, that patch has not been applied. Did it not work?
> It still applies cleanly on 4.5.

It probably just got missed by Dave between all the patches on the list.
Can you just resend it with my Reviewed-by tag added?
