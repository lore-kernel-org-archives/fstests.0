Received: from imap.thunk.org ([74.207.234.97]:45646 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752118AbdLUPjY (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 21 Dec 2017 10:39:24 -0500
Date: Thu, 21 Dec 2017 10:39:18 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: generic/388 is failed under ext4
Message-ID: <20171221153917.GA27177@thunk.org>
References: <be7e6d14-dcc9-1822-e005-4e779fc97873@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be7e6d14-dcc9-1822-e005-4e779fc97873@intel.com>
Sender: fstests-owner@vger.kernel.org
To: Li Zhijian <zhijianx.li@intel.com>
Cc: fstests@vger.kernel.org, "Li, Philip" <philip.li@intel.com>
List-ID: <fstests@vger.kernel.org>

On Thu, Dec 21, 2017 at 10:38:47AM +0800, Li Zhijian wrote:
> Hi all
> 
> I'm not sure whether the failure is expected or not when i ran generic/388 under ext4
> 
> i ran it from v4.11 to v4.15-rc3, they all failed.

Yes, it's a known problem, and it's on my todo list to investigate and
fix.

The use of this at $WORK is without journalling, and we don't care
about the inconsistent file system for that particular use case.  (In
fact, in this particular case the iSCSI device is *gone*, and we're
using the shutdown to avoid processes to hang for a Very Long Time
after the device goes poof.  At least we're no longer crashing in the
writeback functions in a block device disappears....)

						- Ted
