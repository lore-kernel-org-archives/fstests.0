Received: from mx2.suse.de ([195.135.220.15]:55520 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727870AbfBFPv3 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 6 Feb 2019 10:51:29 -0500
Date: Wed, 6 Feb 2019 16:50:50 +0100
From: David Sterba <dsterba@suse.cz>
Subject: Re: [PATCH] shared/298: Wire btrfs support in get_free_sectors
Message-ID: <20190206155050.GE2900@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20190206153359.2562-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190206153359.2562-1-nborisov@suse.com>
Sender: fstests-owner@vger.kernel.org
To: Nikolay Borisov <nborisov@suse.com>
Cc: guaneryu@gmail.com, fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Feb 06, 2019 at 05:33:59PM +0200, Nikolay Borisov wrote:
>  [ "$FSTYP" = "xfs" ] && MKFS_OPTIONS="-f $MKFS_OPTIONS"
> +[ "$FSTYP" = "btrfs" ] && MKFS_OPTIONS="-f -dsingle -msingle"

This would drop anything that the original MKFS_OPTIONS had, eg. -O
features or -K, that's an example what I use.
