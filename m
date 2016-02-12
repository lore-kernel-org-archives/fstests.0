Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:45513 "EHLO
	ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751279AbcBLD5L (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 11 Feb 2016 22:57:11 -0500
Date: Fri, 12 Feb 2016 14:57:09 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 13/13] common: remove unneeded mount options for ext4
Message-ID: <20160212035709.GY14668@dastard>
References: <1455170182-32587-1-git-send-email-tytso@mit.edu>
 <1455170182-32587-14-git-send-email-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1455170182-32587-14-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, hughd@google.com
List-ID: <fstests@vger.kernel.org>

On Thu, Feb 11, 2016 at 12:56:22AM -0500, Theodore Ts'o wrote:
> Ext4 has turned on acls and xattrs by default for a long, long time
> (even the 3.10 kernel has it on by default).
> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>

Hmmm - aren't these really there for transparent support of older
distros that still require these mount options? e.g. RHEL6, older
SLES kernels, etc?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
