Received: from bombadil.infradead.org ([198.137.202.133]:54888 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbeLKNwc (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 11 Dec 2018 08:52:32 -0500
Date: Tue, 11 Dec 2018 05:52:31 -0800
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 0/7] xfstests: add fs-verity tests
Message-ID: <20181211135231.GA14965@infradead.org>
References: <20181210222142.222342-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181210222142.222342-1-ebiggers@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: Eric Biggers <ebiggers@kernel.org>
Cc: fstests@vger.kernel.org, linux-fscrypt@vger.kernel.org, "Theodore Y . Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Victor Hsieh <victorhsieh@google.com>
List-ID: <fstests@vger.kernel.org>

On Mon, Dec 10, 2018 at 02:21:35PM -0800, Eric Biggers wrote:
> Add tests for fs-verity, a new feature for read-only file-based
> authenticity protection.  fs-verity will be supported by ext4 and f2fs,
> and perhaps other filesystems later.  Running these tests requires:

Seriously, given how broken the current fs-verify support is we should
neither merge it into the kernel nor fstests.

Nothing against the highlevel feature per-se, but the implementation
posted to linux-fsdevel a while ago is simply too broken.
