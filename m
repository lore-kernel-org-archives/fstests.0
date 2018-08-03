Received: from mx2.suse.de ([195.135.220.15]:51388 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729841AbeHCPgC (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 3 Aug 2018 11:36:02 -0400
Date: Fri, 3 Aug 2018 15:39:33 +0200
From: David Sterba <dsterba@suse.cz>
Subject: Re: [PATCH] fstests: btrfs/057: Update test case to keep subvolume
 in any kernel version
Message-ID: <20180803133933.GW3218@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1533278551.git.misono.tomohiro@jp.fujitsu.com>
 <4b4e3480-ccb7-d0aa-2a37-ea51699728e8@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b4e3480-ccb7-d0aa-2a37-ea51699728e8@jp.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Aug 03, 2018 at 03:44:37PM +0900, Misono Tomohiro wrote:
> Since commit a79a464d5675 ("btrfs: Allow rmdir(2) to delete an empty
> subvolume"), rm -r can delete a subvolume too.
> 
> This test assumes that rm -r does not delete a subvolume.
> Currently the commit does not affect the test since qgroup items
> still exist after subvolume deletion, but we plan to change the
> behavior and remove them along with subvolume deletion.
> 
> So update the test and keep subvolume (and qgroup item) in any kernel
> version.
> 
> Signed-off-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>

Reviewed-by: David Sterba <dsterba@suse.com>
