Received: from mx1.redhat.com ([209.132.183.28]:37998 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751789AbdBTCiW (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 19 Feb 2017 21:38:22 -0500
Date: Mon, 20 Feb 2017 10:36:46 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] shared/005,7: add check whether debugfs succeeds to set
 a negative i_size or not
Message-ID: <20170220023646.GG24562@eguan.usersys.redhat.com>
References: <1486984910-4623-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <58AA50DA.8080409@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58AA50DA.8080409@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Feb 20, 2017 at 10:13:46AM +0800, Xiao Yang wrote:
> Hi Eryu
> 
> Sorry, The previous patch is defective. Please see the following two points:
> 
> 1) If the kernel bug has been fixed, stat command fails to get i_size and
> reports "Structure needs cleaning".
> 
> 2) shared/007 passed unexpectedly because of invalid argument when debugfs
> fails to set i_size to the highest multiple of 512 below -1. So we need
> to add strict check.

Thanks for the update! I've pushed your patch to upstream yesterday (not
sure why I didn't see the announce email in the list.. I'll resend
shortly, but the upstream repo should have been updated). Please send a
fix based on new master.

Thanks,
Eryu
