Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43162 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753935AbbESMXy (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 19 May 2015 08:23:54 -0400
Date: Tue, 19 May 2015 08:23:51 -0400
From: Brian Foster <bfoster@redhat.com>
Subject: Re: [PATCH 0/3] generic: fixes for different allocation behaviours
Message-ID: <20150519122351.GA40561@bfoster.bfoster>
References: <1431568417-6462-1-git-send-email-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1431568417-6462-1-git-send-email-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, May 14, 2015 at 11:53:34AM +1000, Dave Chinner wrote:
> Hi folks,
> 
> These 3 patches address failures I found when testing the XFS DAX
> functionality. DAX disables delayed allocation on XFS, so the size
> of the buffer in the write() call determines the size of the
> allocation that is done. Hence tests that expect a specific extent
> layout need to do IO in buffers as large as the extent size they
> expect to be created.
> 
> The other side of this is that some tests also expect partial writes
> to occur, which happened as a side effect of buffered writes being
> broken down into PAGE_SIZE chunks. With DAX, that does not happen -
> the writes tend to either succeed or fail completely, especially if
> it is an ENOSPC condition that is ocurring.
> 
> HEnce these patches address these test assumptions, and now they
> work correctly and pass on both DAX and non-DAX filesystems.
> 

All look fine to me:

Reviewed-by: Brian Foster <bfoster@redhat.com>

> Cheers,
> 
> Dave.
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
