Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:30217 "EHLO
	ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751830AbcGABpU (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 30 Jun 2016 21:45:20 -0400
Date: Fri, 1 Jul 2016 11:45:17 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] common: ext4 doesn't support O_DIRECT with encryption
Message-ID: <20160701014517.GZ27480@dastard>
References: <1467163975-11183-1-git-send-email-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1467163975-11183-1-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Jun 28, 2016 at 09:32:55PM -0400, Theodore Ts'o wrote:
> Teach _require_odirect to skip the O_DIRECT tests if the ext4 mount
> option "test_dummy_encryption" is enabled, since O_DIRECT doesen't
> make sense when file system level encryption is enabled, and several
> tests which use O_DIRECT --- ext4/301, ext4/304, generic/250 and
> generic/252 --- fail when encryption is enabled.

Stupid question: why isn't ext4 simply falling back to buffered IO
when encryption is enabled on a file? This seems kind of strange to
have direct IO conditionally supported based on mkfs/mount
parameters (or perhaps even per-file configurations)....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
