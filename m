Received: from mx2.suse.de ([195.135.220.15]:53236 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753348AbdDLMdC (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 12 Apr 2017 08:33:02 -0400
Date: Wed, 12 Apr 2017 14:32:54 +0200
From: David Sterba <dsterba@suse.cz>
Subject: Re: [PATCH] fstests: remove snapshot aware defrag test
Message-ID: <20170412123254.GH4781@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <1491960438-28375-1-git-send-email-bo.li.liu@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1491960438-28375-1-git-send-email-bo.li.liu@oracle.com>
Sender: fstests-owner@vger.kernel.org
To: Liu Bo <bo.li.liu@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Apr 11, 2017 at 06:27:18PM -0700, Liu Bo wrote:
> Since snapshot aware defrag has been disabled in kernel, and we all have
> learned to ignore the failure of btrfs/010, lets just remove it.
> 
> Signed-off-by: Liu Bo <bo.li.liu@oracle.com>

Reviewed-by: David Sterba <dsterba@suse.com>
