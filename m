Received: from bombadil.infradead.org ([198.137.202.9]:54438 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752772AbbG3RHf (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 30 Jul 2015 13:07:35 -0400
Date: Thu, 30 Jul 2015 10:07:34 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/6] xfsprogs: define NBBY if not defined by the system
 header files
Message-ID: <20150730170734.GA25395@infradead.org>
References: <1437913255-7524-1-git-send-email-tytso@mit.edu>
 <1437913255-7524-2-git-send-email-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1437913255-7524-2-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: xfs@oss.sgi.com, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sun, Jul 26, 2015 at 08:20:50AM -0400, Theodore Ts'o wrote:
> Android's bionic libc doesn't define NBBY; this isn't a standard
> define, and since all modern/sane platforms have 8 bits per byte, use
> this as a default.
> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>

This looks fine, but it'll clash with my patch that changes
platform_defs.h so that it's not run through autoconfs m4 anymore.

Otherwise:

Reviewed-by: Christoph Hellwig <hch@lst.de>
