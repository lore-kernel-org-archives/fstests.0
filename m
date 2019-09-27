Received: from mx2.suse.de ([195.135.220.15]:46484 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727076AbfI0NKL (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 27 Sep 2019 09:10:11 -0400
Date: Fri, 27 Sep 2019 15:10:27 +0200
From: David Sterba <dsterba@suse.cz>
Subject: Re: [PATCH 1/2] common/rc: Remove special handing of 'dup' argument
 for btrfs
Message-ID: <20190927131027.GU2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20190927105233.14926-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190927105233.14926-1-nborisov@suse.com>
Sender: fstests-owner@vger.kernel.org
To: Nikolay Borisov <nborisov@suse.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Sep 27, 2019 at 01:52:32PM +0300, Nikolay Borisov wrote:
> _scratch_pool_mkfs special cases the command executed when 'dup' option
> is used when creating a filesystem. This is wrong since 'dup' works
> for all profiles and number of devices. This bug manifested while
> exercising btrfs' balance argument combinations test.

All profile combinations should be valid (mkfs, balance convert) since
4.5-ish, so

Reviewed-by: David Sterba <dsterba@suse.com>
