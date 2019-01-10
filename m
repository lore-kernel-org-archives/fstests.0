Received: from aserp2130.oracle.com ([141.146.126.79]:45812 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbfAJGRl (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 10 Jan 2019 01:17:41 -0500
Subject: Re: [PATCH 1/2] fstests: btrfs: Make seed device test cases into
 their own group
References: <20190110061415.32045-1-wqu@suse.com>
From: Anand Jain <anand.jain@oracle.com>
Message-ID: <bf4b36e4-3ca3-86c9-ff6a-5062b1a13e8b@oracle.com>
Date: Thu, 10 Jan 2019 14:17:27 +0800
MIME-Version: 1.0
In-Reply-To: <20190110061415.32045-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>



On 01/10/2019 02:14 PM, Qu Wenruo wrote:
> btrfs/16[123] are all seed device related test cases, make them into
> 'seed' group.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>

> ---
>   tests/btrfs/group | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/btrfs/group b/tests/btrfs/group
> index b78ed37fd9f1..04c0254aa4bf 100644
> --- a/tests/btrfs/group
> +++ b/tests/btrfs/group
> @@ -163,9 +163,9 @@
>   158 auto quick raid scrub
>   159 auto quick punch log
>   160 auto quick
> -161 auto quick volume
> -162 auto quick volume
> -163 auto quick volume
> +161 auto quick volume seed
> +162 auto quick volume seed
> +163 auto quick volume seed
>   164 auto quick volume
>   165 auto quick subvol
>   166 auto quick qgroup
> 
