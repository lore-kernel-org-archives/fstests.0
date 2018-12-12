Received: from imap.thunk.org ([74.207.234.97]:52360 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbeLLDAX (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 11 Dec 2018 22:00:23 -0500
Date: Tue, 11 Dec 2018 22:00:18 -0500
From: "Theodore Y. Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH 0/7] xfstests: add fs-verity tests
Message-ID: <20181212030018.GG4464@thunk.org>
References: <20181210222142.222342-1-ebiggers@kernel.org>
 <20181211135231.GA14965@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181211135231.GA14965@infradead.org>
Sender: fstests-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Eric Biggers <ebiggers@kernel.org>, fstests@vger.kernel.org, linux-fscrypt@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>, Victor Hsieh <victorhsieh@google.com>
List-ID: <fstests@vger.kernel.org>

On Tue, Dec 11, 2018 at 05:52:31AM -0800, Christoph Hellwig wrote:
> On Mon, Dec 10, 2018 at 02:21:35PM -0800, Eric Biggers wrote:
> > Add tests for fs-verity, a new feature for read-only file-based
> > authenticity protection.  fs-verity will be supported by ext4 and f2fs,
> > and perhaps other filesystems later.  Running these tests requires:
> 
> Seriously, given how broken the current fs-verify support is we should
> neither merge it into the kernel nor fstests.
> 
> Nothing against the highlevel feature per-se, but the implementation
> posted to linux-fsdevel a while ago is simply too broken.

What do you think is broken?

					- Ted
