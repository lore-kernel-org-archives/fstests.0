Received: from imap.thunk.org ([74.207.234.97]:33739 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751772AbcBJXRO (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 10 Feb 2016 18:17:14 -0500
Date: Wed, 10 Feb 2016 18:17:10 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH 01/12] check: avoid error messages of tests/$FS does not
 exist
Message-ID: <20160210231710.GI26922@thunk.org>
References: <1455069001-17846-1-git-send-email-tytso@mit.edu>
 <1455069001-17846-2-git-send-email-tytso@mit.edu>
 <20160210054531.GR19486@dastard>
 <20160210153455.GB26922@thunk.org>
 <20160210162840.GA365@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160210162840.GA365@infradead.org>
Sender: fstests-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org, hughd@google.com
List-ID: <fstests@vger.kernel.org>

On Wed, Feb 10, 2016 at 08:28:40AM -0800, Christoph Hellwig wrote:
> On Wed, Feb 10, 2016 at 10:34:55AM -0500, Theodore Ts'o wrote:
> > It doesn't really cause a problem; it's more of a cosmetic issue, in
> > that it prints a harmless/annoying error message during the test
> > startup.  It shows up if you specify a group, e.g. "check -g quick":
> 
> I found this annoying when testing nfs, and it's been on my todo list
> for a while to fix it.  Never high enough to actually do it, but I'd
> love to see the fix merged.

Yeah, it triggered my inner OCD, but if it weren't for the fact that I
was making a bunch of other tmpfs changes it probably wouldn't have
risen to the top of my list either.

					- Ted


