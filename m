Received: from bombadil.infradead.org ([198.137.202.9]:52244 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751148AbcJOJLa (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 15 Oct 2016 05:11:30 -0400
Date: Sat, 15 Oct 2016 02:11:26 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 2/2] fstests: run xfs_io as multi threaded process
Message-ID: <20161015091126.GA9631@infradead.org>
References: <1476477810-17478-1-git-send-email-amir73il@gmail.com>
 <1476477810-17478-2-git-send-email-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1476477810-17478-2-git-send-email-amir73il@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: Dave Chinner <david@fromorbit.com>, eguan@redhat.com, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Oct 14, 2016 at 11:43:30PM +0300, Amir Goldstein wrote:
> Try to run xfs_io in all tests with command line option -M
> which starts an idle thread before performing any io.
> 
> The purpose of this idle thread is to test io from a multi threaded
> process. With single threaded process, the file table is not shared
> and file structs are not reference counted.
> 
> So in order to improve the change of detecting file struct reference
> leaks, all xfs_io commands in tests will try to run with this option.

I like the idea behing the -M command, but I'm not sure if we should
always use it.  For one this means we won't test the fget fastpath
any more, and second I'd like to know what the impact on xfstests
runtime is.
