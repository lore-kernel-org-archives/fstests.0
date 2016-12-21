Received: from mx2.suse.de ([195.135.220.15]:41158 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753907AbcLUO1q (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 21 Dec 2016 09:27:46 -0500
Date: Wed, 21 Dec 2016 15:27:30 +0100
From: David Sterba <dsterba@suse.cz>
Subject: Re: [PATCH] fstests: btrfs: Remove btrfs/047 since upstream don't
 accept stream-version
Message-ID: <20161221142730.GD12081@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20161220012456.19363-1-quwenruo@cn.fujitsu.com>
 <20161221023355.GM1859@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161221023355.GM1859@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Qu Wenruo <quwenruo@cn.fujitsu.com>, linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Dec 21, 2016 at 10:33:55AM +0800, Eryu Guan wrote:
> On Tue, Dec 20, 2016 at 09:24:56AM +0800, Qu Wenruo wrote:
> > Btrfs upstream doesn't accept stream-version, so the test is never ran
> > on upstream kernel nor btrfs-progs.
> > 
> > Just remove it.
> > 
> > Signed-off-by: Qu Wenruo <quwenruo@cn.fujitsu.com>
> 
> Looks fine to me, but I'd like to see an ack or review from btrfs
> developers.

We don't have ETA when the stream protocol version bump will happen. The
test can be added back later.

Reviewed-by: David Sterba <dsterba@suse.com>
