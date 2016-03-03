Received: from mx2.suse.de ([195.135.220.15]:47431 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757597AbcCCSNY (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 3 Mar 2016 13:13:24 -0500
Date: Thu, 3 Mar 2016 19:13:07 +0100
From: David Sterba <dsterba@suse.cz>
Subject: Re: [PATCH] fstests: remove call to _need_to_be_root from btrfs/118
Message-ID: <20160303181307.GG29310@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <1456990377-2453-1-git-send-email-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1456990377-2453-1-git-send-email-fdmanana@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

On Thu, Mar 03, 2016 at 07:32:57AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The function _need_to_be_root does not exists anymore as of commit
> 56ff01f471c9 ("xfstests: remove _need_to_be_root").
> 
> A v2 of the patch that added test btrfs/118 without calling this
> function was sent but not picked [1], instead v1 was picked.
> 
> So fix this now.
> 
> [1] https://patchwork.kernel.org/patch/8354831/
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>
