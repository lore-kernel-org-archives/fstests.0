Return-Path: <fstests-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:58554 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754788AbaFPJel (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 16 Jun 2014 05:34:41 -0400
Date: Mon, 16 Jun 2014 02:34:40 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] xfs/279: use MKFS_XFS_PROG, not hardcoded path
Message-ID: <20140616093440.GA26172@infradead.org>
References: <539B68D2.2000300@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <539B68D2.2000300@sandeen.net>
Sender: xfstests-owner@vger.kernel.org
To: Eric Sandeen <sandeen@sandeen.net>
Cc: xfs-oss <xfs@oss.sgi.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Jun 13, 2014 at 04:10:42PM -0500, Eric Sandeen wrote:
> I'm really not sure why this wasn't this way from the start.
> On some systems it's in /usr/sbin, and the test fails.
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
