Received: from mx2.suse.de ([195.135.220.15]:60596 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751297AbdJWLbF (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 23 Oct 2017 07:31:05 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 613FEAE49
        for <fstests@vger.kernel.org>; Mon, 23 Oct 2017 11:31:04 +0000 (UTC)
Subject: Re: [PATCH] fstests: btrfs/130: Remove from auto group
References: <20171023014854.24367-1-wqu@suse.com>
From: Nikolay Borisov <nborisov@suse.com>
Message-ID: <4234b5d2-845a-5ee9-02e9-30661f8a2295@suse.com>
Date: Mon, 23 Oct 2017 14:31:03 +0300
MIME-Version: 1.0
In-Reply-To: <20171023014854.24367-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Qu Wenruo <wqu@suse.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>



On 23.10.2017 04:48, Qu Wenruo wrote:
> No agreement on how to fix it in the foreseeable future.
> So remove it from auto group to prevent newbie tester from spending days
> waiting it to finish.
> 
> Reported-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

This test runtime should have been improved with recent work by Edmund
Nadolski but it still leaves a lot to be desired so this change makes
sense.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>

> ---
>  tests/btrfs/group | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/btrfs/group b/tests/btrfs/group
> index a7ff7b06dcae..e17c275e2bb0 100644
> --- a/tests/btrfs/group
> +++ b/tests/btrfs/group
> @@ -132,7 +132,7 @@
>  127 auto quick send
>  128 auto quick send
>  129 auto quick send
> -130 auto clone send
> +130 clone send dangerous
>  131 auto quick
>  132 auto enospc
>  133 auto quick send
> 
