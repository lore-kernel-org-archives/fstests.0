Received: from bombadil.infradead.org ([198.137.202.9]:48783 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754303AbcKYJHJ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 25 Nov 2016 04:07:09 -0500
Date: Fri, 25 Nov 2016 00:05:10 -0800
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 0/4] Add copy_file_range() tests
Message-ID: <20161125080509.GA6082@infradead.org>
References: <20160907195619.25914-1-Anna.Schumaker@Netapp.com>
 <20161026082638.GA19419@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161026082638.GA19419@infradead.org>
Sender: fstests-owner@vger.kernel.org
To: Anna Schumaker <Anna.Schumaker@netapp.com>
Cc: fstests@vger.kernel.org, linux-nfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Oct 26, 2016 at 01:26:38AM -0700, Christoph Hellwig wrote:
> On Wed, Sep 07, 2016 at 03:56:15PM -0400, Anna Schumaker wrote:
> > These tests exercise the copy_file_range() system call, and check copying
> > data to both a new file and overwriting data inside an existing file.  I use
> > the xfs_io "copy_range" command for the actual copies, so running these
> > tests requires an up-to-date version of xfsprogs.
> 
> Hi Anna,
> 
> what's the status of these tests?  Did you get a chance to look
> into xfs_io copyfile support?

Another month, another ping - it would be really sad to not have any
real testing for copy_file_range.  I've been holding a pending change
for it back for month now because I want to verify it more than cursory,
but I guess I'll just have to send it anyway.
