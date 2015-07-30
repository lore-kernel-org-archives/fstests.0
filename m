Received: from imap.thunk.org ([74.207.234.97]:59970 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750935AbbG3Rrr (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 30 Jul 2015 13:47:47 -0400
Date: Thu, 30 Jul 2015 13:47:45 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH 2/4] xfstests: Support C libraries that define SIGCHLD
 instead of SIGCLD
Message-ID: <20150730174745.GC3227@thunk.org>
References: <1438006967-18815-1-git-send-email-tytso@mit.edu>
 <1438006967-18815-3-git-send-email-tytso@mit.edu>
 <20150730171428.GB18185@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150730171428.GB18185@infradead.org>
Sender: fstests-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Jul 30, 2015 at 10:14:28AM -0700, Christoph Hellwig wrote:
> On Mon, Jul 27, 2015 at 10:22:45AM -0400, Theodore Ts'o wrote:
> > SIGCLD is the name used by System V; SIGCHLD is the name defined by
> > Posix.  Some C libraries will only define SIGCHLD and not SIGCLD, so
> > accomodate them.
> 
> Please just use SIGCHLD unconditionally, there is no point in supporting
> pre-Posix systems in xfstests.

Ack, will do.

					- Ted
