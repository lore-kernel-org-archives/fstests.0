Received: from mx2.suse.de ([195.135.220.15]:47421 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758290AbeD0Q3K (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 27 Apr 2018 12:29:10 -0400
Date: Fri, 27 Apr 2018 18:26:35 +0200
From: David Sterba <dsterba@suse.cz>
Subject: Re: [PATCH v2] btrfs: Add test that checks rmdir(2) can delete a
 subvolume
Message-ID: <20180427162635.GF21272@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <a7ba61de-3bbc-92fd-68db-2521f4bc8545@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7ba61de-3bbc-92fd-68db-2521f4bc8545@jp.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
Cc: fstests@vger.kernel.org, linux-btrfs <linux-btrfs@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Fri, Apr 27, 2018 at 05:02:45PM +0900, Misono Tomohiro wrote:
> Add btrfs test that checks "rmdir" or "rm -r" command can delete a
> subvolume like an ordinary drectory.
> 
> This behavior has been restricted long time but becomes allowed by
> following patch in the kernel:
>   btrfs: Allow rmdir(2) to delete an empty subvolume

AFAICS this test will fail on older kernels, eg. stable versions, but
this is not a bug that needs to be fixed by backporting patches. The
usual way is to use the expunges, but as this is a feature coverage, I
think the test should detect if the kernel has the feature at all.
Similar to the fallocate modes etc.

For the test itself, the scenarios look sufficient, so
Reviewed-by: David Sterba <dsterba@suse.com>
