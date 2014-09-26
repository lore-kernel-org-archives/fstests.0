Return-Path: <fstests-owner@vger.kernel.org>
Received: from imap.thunk.org ([74.207.234.97]:51076 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755166AbaIZOWw (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 26 Sep 2014 10:22:52 -0400
Date: Fri, 26 Sep 2014 10:22:43 -0400
From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH] fsx: increase number of logged operations
Message-ID: <20140926142243.GA21714@thunk.org>
References: <20140926130430.GA9240@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140926130430.GA9240@infradead.org>
Sender: fstests-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Sep 26, 2014 at 06:04:30AM -0700, Christoph Hellwig wrote:
> 1000 operations is nearly enough to debug complex data integrity
                 ^^^^^

is not nearly enough?

> issues, so increase the log buffer by an order of magnitude.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Theodore Ts'o <tytso@mit.edu>

