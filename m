Received: from mx2.suse.de ([195.135.220.15]:48865 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752918AbeF0MKz (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 27 Jun 2018 08:10:55 -0400
Date: Wed, 27 Jun 2018 14:10:54 +0200
From: David Sterba <dsterba@suse.cz>
Subject: Re: [PATCH v2] common: Add _dmsetup_create and _dmsetup_remove
 helpers
Message-ID: <20180627121054.GB2287@suse.cz>
Reply-To: dsterba@suse.cz
References: <20180627075435.GL13748@dastard>
 <1530096852-4165-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530096852-4165-1-git-send-email-yangx.jy@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc: david@fromorbit.com, guaneryu@gmail.com, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Jun 27, 2018 at 06:54:12PM +0800, Xiao Yang wrote:
> Make sure both "$UDEV_SETTLE_PROG" and "mknodes" can always
> be run after a dm create or remove operation.
> 
> Suggested-by: Dave Chinner <david@fromorbit.com>
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>

The helpers are better, thanks.

Reviewed-by: David Sterba <dsterba@suse.com>
