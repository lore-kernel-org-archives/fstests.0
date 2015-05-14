Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:44487 "EHLO
	ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933345AbbENBx6 (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 13 May 2015 21:53:58 -0400
Received: from disappointment.disaster.area ([192.168.1.110] helo=disappointment)
	by dastard with esmtp (Exim 4.80)
	(envelope-from <dave@fromorbit.com>)
	id 1YsiLD-0004WS-D3
	for fstests@vger.kernel.org; Thu, 14 May 2015 11:53:39 +1000
Received: from dave by disappointment with local (Exim 4.82_1-5b7a7c0-XX)
	(envelope-from <dave@disappointment.disaster>)
	id 1YsiLD-0001h0-CK
	for fstests@vger.kernel.org; Thu, 14 May 2015 11:53:39 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: [PATCH 0/3] generic: fixes for different allocation behaviours
Date: Thu, 14 May 2015 11:53:34 +1000
Message-Id: <1431568417-6462-1-git-send-email-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hi folks,

These 3 patches address failures I found when testing the XFS DAX
functionality. DAX disables delayed allocation on XFS, so the size
of the buffer in the write() call determines the size of the
allocation that is done. Hence tests that expect a specific extent
layout need to do IO in buffers as large as the extent size they
expect to be created.

The other side of this is that some tests also expect partial writes
to occur, which happened as a side effect of buffered writes being
broken down into PAGE_SIZE chunks. With DAX, that does not happen -
the writes tend to either succeed or fail completely, especially if
it is an ENOSPC condition that is ocurring.

HEnce these patches address these test assumptions, and now they
work correctly and pass on both DAX and non-DAX filesystems.

Cheers,

Dave.
