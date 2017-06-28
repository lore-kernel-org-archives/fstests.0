Received: from mx2.suse.de ([195.135.220.15]:59942 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751557AbdF1N5K (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 28 Jun 2017 09:57:10 -0400
Date: Wed, 28 Jun 2017 15:55:59 +0200
From: David Sterba <dsterba@suse.cz>
Subject: Re: [PATCH] fstests: btrfs: reorder the arguments of btrfs replace
 in btrfs/027
Message-ID: <20170628135559.GF2866@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20170628054531.17882-1-lufq.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170628054531.17882-1-lufq.fnst@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Lu Fengqi <lufq.fnst@cn.fujitsu.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Jun 28, 2017 at 01:45:31PM +0800, Lu Fengqi wrote:
> The option parser only accept options before non-option argument.
> Although David Sterba has submitted commit df8c7225ba00 ("btrfs: reorder
> arguments so that options come first"), but this case seems to be left out.
> 
> Signed-off-by: Lu Fengqi <lufq.fnst@cn.fujitsu.com>

Thanks for cathing it.

Reviewed-by: David Sterba <dsterba@suse.com>
