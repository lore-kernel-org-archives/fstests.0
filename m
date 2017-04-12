Received: from mx2.suse.de ([195.135.220.15]:53090 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754128AbdDLMcF (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 12 Apr 2017 08:32:05 -0400
Date: Wed, 12 Apr 2017 14:32:02 +0200
From: David Sterba <dsterba@suse.cz>
Subject: Re: [PATCH] fstests: introduce btrfs-map-logical
Message-ID: <20170412123201.GG4781@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <1491960463-28680-1-git-send-email-bo.li.liu@oracle.com>
 <5d7f7d05-b7af-5d8d-93f6-0db2db4ade85@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d7f7d05-b7af-5d8d-93f6-0db2db4ade85@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Qu Wenruo <quwenruo@cn.fujitsu.com>
Cc: Liu Bo <bo.li.liu@oracle.com>, fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Apr 12, 2017 at 09:35:00AM +0800, Qu Wenruo wrote:
> 
> 
> At 04/12/2017 09:27 AM, Liu Bo wrote:
> > A typical use case of 'btrfs-map-logical' is to translate btrfs logical
> > address to physical address on each disk.
> 
> Could we avoid usage of btrfs-map-logical here?

Agreed.

> I understand that we need to do corruption so that we can test if the 
> repair works, but I'm not sure if the output format will change, or if 
> the program will get replace by "btrfs inspect-internal" group.

In the long-term it will be repleaced, but there's no ETA.
