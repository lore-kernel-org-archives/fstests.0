Received: from userp2120.oracle.com ([156.151.31.85]:53180 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752310AbdLFXf1 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 6 Dec 2017 18:35:27 -0500
Date: Wed, 6 Dec 2017 15:35:20 -0800
From: Liu Bo <bo.li.liu@oracle.com>
Subject: Re: [PATCH] fstests: btrfs: reproduce a read failure on raid6 setup
Message-ID: <20171206233520.GB30109@dhcp-whq-twvpn-1-vpnpool-10-159-141-111.vpn.oracle.com>
Reply-To: bo.li.liu@oracle.com
References: <20171204223323.3710-1-bo.li.liu@oracle.com>
 <20171206085611.GT2749@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171206085611.GT2749@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Dec 06, 2017 at 04:56:11PM +0800, Eryu Guan wrote:
> On Mon, Dec 04, 2017 at 03:33:23PM -0700, Liu Bo wrote:
> > This test case is to reproduce a bug of raid6 reconstruction process.
> > 
> > The kernel fix are
> > Btrfs: do not merge rbios if their fail stripe index are not identical
> > Btrfs: make raid6 rebuild retry more
> > 
> > Signed-off-by: Liu Bo <bo.li.liu@oracle.com>
> 
> Test failed as expected with v4.15-rc2 kernel and passed with above
> patches applied.
> 
> I fixed two trailing whitespace issues and some of the indentions to
> avoid too-long line, also replaced 'repair' group with a new 'raid'
> group. I think 'repair' group is meant for testing filesystem repair
> tools, not the internal raid repair mechanism, so a new 'raid' group
> looks better to me, as we're having more raid-specific tests recently.

Sounds good to me, thanks for the efforts.

Thanks,

-liubo
