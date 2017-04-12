Received: from mx2.suse.de ([195.135.220.15]:56232 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752697AbdDLMw0 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 12 Apr 2017 08:52:26 -0400
Date: Wed, 12 Apr 2017 14:52:23 +0200
From: David Sterba <dsterba@suse.cz>
Subject: Re: [PATCH] fstests: introduce btrfs-map-logical
Message-ID: <20170412125222.GI4781@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <1491960463-28680-1-git-send-email-bo.li.liu@oracle.com>
 <5d7f7d05-b7af-5d8d-93f6-0db2db4ade85@cn.fujitsu.com>
 <20170412123201.GG4781@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170412123201.GG4781@twin.jikos.cz>
Sender: fstests-owner@vger.kernel.org
To: dsterba@suse.cz, Qu Wenruo <quwenruo@cn.fujitsu.com>, Liu Bo <bo.li.liu@oracle.com>, fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Apr 12, 2017 at 02:32:02PM +0200, David Sterba wrote:
> On Wed, Apr 12, 2017 at 09:35:00AM +0800, Qu Wenruo wrote:
> > 
> > 
> > At 04/12/2017 09:27 AM, Liu Bo wrote:
> > > A typical use case of 'btrfs-map-logical' is to translate btrfs logical
> > > address to physical address on each disk.
> > 
> > Could we avoid usage of btrfs-map-logical here?
> 
> Agreed.
> 
> > I understand that we need to do corruption so that we can test if the 
> > repair works, but I'm not sure if the output format will change, or if 
> > the program will get replace by "btrfs inspect-internal" group.
> 
> In the long-term it will be repleaced, but there's no ETA.

Possibly, if fstests maintainer agrees, we can add btrfs-map-logical to
fstests. It's small and uses headers from libbtrfs, so this would become
a new dependency but I believe is still bearable.

I'm not sure if we should export all debuging functionality in 'btrfs'
as this is typically something that a user will never want, not even in
the emergency environments. There's an overlap in the information to be
exported but I'd be more inclined to satisfy user needs than testsuite
needs. So an independent tool would give us more freedom on both sides.
