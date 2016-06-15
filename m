Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:16319 "EHLO
	ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932235AbcFOW4E (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 15 Jun 2016 18:56:04 -0400
Date: Thu, 16 Jun 2016 08:55:59 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v3] shared: regression test for hang when processing
 corrupted orphaned inode list
Message-ID: <20160615225559.GH12670@dastard>
References: <20160614043942.GN5140@eguan.usersys.redhat.com>
 <1465968091-8912-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1465968091-8912-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Jun 15, 2016 at 01:21:31PM +0800, Guangwen Feng wrote:
> Commit c9eb13a fixed this bug:
> 	ext4: fix hang when processing corrupted orphaned inode list

Unfortunately, I don't know what this bug is, or what the test is
actually doing from this description or from reading the actual
test.  Please assume that not just the reviewer but someone reading
this description 5 yers from now knows *nothing* about the problem
the test addresses. Hence the patch description needs to explain
more fully what the problem is that the test is exercising....

It's also unfortunate that kernel tree commits are being referenced
without saying what tree they belong to. i.e. this should read
"kernel commit ab1234cd" so we know that commit is not something
from the fstests tree, or e2fsprogs, or some other unknown tree.
Again - think about someone reading this in 5 years time and trying
to work out what it means...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
