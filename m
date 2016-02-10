Received: from bombadil.infradead.org ([198.137.202.9]:52134 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753000AbcBJQ2m (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 10 Feb 2016 11:28:42 -0500
Date: Wed, 10 Feb 2016 08:28:40 -0800
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 01/12] check: avoid error messages of tests/$FS does not
 exist
Message-ID: <20160210162840.GA365@infradead.org>
References: <1455069001-17846-1-git-send-email-tytso@mit.edu>
 <1455069001-17846-2-git-send-email-tytso@mit.edu>
 <20160210054531.GR19486@dastard>
 <20160210153455.GB26922@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160210153455.GB26922@thunk.org>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org, hughd@google.com
List-ID: <fstests@vger.kernel.org>

On Wed, Feb 10, 2016 at 10:34:55AM -0500, Theodore Ts'o wrote:
> It doesn't really cause a problem; it's more of a cosmetic issue, in
> that it prints a harmless/annoying error message during the test
> startup.  It shows up if you specify a group, e.g. "check -g quick":

I found this annoying when testing nfs, and it's been on my todo list
for a while to fix it.  Never high enough to actually do it, but I'd
love to see the fix merged.
