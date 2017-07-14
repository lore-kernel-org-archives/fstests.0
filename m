Received: from mx1.redhat.com ([209.132.183.28]:38876 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751101AbdGNEGV (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 14 Jul 2017 00:06:21 -0400
Date: Fri, 14 Jul 2017 12:06:18 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] btrfs: test direct IO write against raid5/6 filesystems
Message-ID: <20170714040618.GL2478@eguan.usersys.redhat.com>
References: <20170713141040.2341-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170713141040.2341-1-fdmanana@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

On Thu, Jul 13, 2017 at 03:10:40PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Test that a direct IO write works against raid5/6 filesystems and that
> after the write operation we are able to read back the correct data
> and scrub operations don't find any errors.
> 
> This test is motivated by a regression introduced in the merge window
> for the 4.13 linux kernel, which was undetected by the current set of
> test cases. The issue is fixed by the following patch:
> 
>   "Btrfs: fix write corruption due to bio cloning on raid5/6"
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Thanks for the test! I did minor updates and committed:

- add _require_odirect in the test
- add rw group

Thanks,
Eryu
