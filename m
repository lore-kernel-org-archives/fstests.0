Return-Path: <fstests-owner@vger.kernel.org>
Received: from imap.thunk.org ([74.207.234.97]:51091 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754748AbaIZOYR (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 26 Sep 2014 10:24:17 -0400
Date: Fri, 26 Sep 2014 10:24:14 -0400
From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH] fstest: fix dumping of miscompare buffer
Message-ID: <20140926142414.GB21714@thunk.org>
References: <20140926130538.GB9240@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140926130538.GB9240@infradead.org>
Sender: fstests-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Sep 26, 2014 at 06:05:38AM -0700, Christoph Hellwig wrote:
> When fstests finds a miscompare it tries to dump the corrupted
> bytes from the buffer, but due to an incorrect comparism actully
> dumps the correct part of it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Theodore Ts'o <tytso@mit.edu>

