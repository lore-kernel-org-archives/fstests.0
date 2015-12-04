Received: from bombadil.infradead.org ([198.137.202.9]:50161 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752542AbbLDI2t (ORCPT
	<rfc822;fstests@vger.kernel.org>); Fri, 4 Dec 2015 03:28:49 -0500
Date: Fri, 4 Dec 2015 00:28:43 -0800
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: sys_copy_file_range tests
Message-ID: <20151204082843.GA23145@infradead.org>
References: <20151201181011.GA6202@infradead.org>
 <5660A974.3010200@Netapp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5660A974.3010200@Netapp.com>
Sender: fstests-owner@vger.kernel.org
To: Anna Schumaker <Anna.Schumaker@netapp.com>
Cc: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Dec 03, 2015 at 03:43:32PM -0500, Anna Schumaker wrote:
> Sadly, I don't have very good tests and I was mostly using the example
> program from the man page under various filesystems and setups.  At LPC,
> Darrick made it sound like he was going to work on adding
> vfs_copy_file_range() tests to xfstests but that probably turned into
> the reflink/dedupe ioctl tests.
> 
> I can try to find time to write something for xfstests if that would
> be useful!

Yes, Darrick wrote a lot of clone tests.  Some of the aren't applicable
to a pure copy, but I looking over them anc checking what should apply
would be very useful!
