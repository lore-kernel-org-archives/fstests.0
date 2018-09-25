Received: from mx2.suse.de ([195.135.220.15]:47974 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726435AbeIYRBY (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 25 Sep 2018 13:01:24 -0400
Subject: Re: [PATCH v2 5/9] generic/102 open code dev_size
 _scratch_mkfs_sized()
References: <1537849462-619-1-git-send-email-anand.jain@oracle.com>
 <1537849462-619-6-git-send-email-anand.jain@oracle.com>
From: Nikolay Borisov <nborisov@suse.com>
Message-ID: <6bdc26df-7beb-53dd-69a2-c3d1789cf3c9@suse.com>
Date: Tue, 25 Sep 2018 13:54:23 +0300
MIME-Version: 1.0
In-Reply-To: <1537849462-619-6-git-send-email-anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Anand Jain <anand.jain@oracle.com>, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>



On 25.09.2018 07:24, Anand Jain wrote:
> Open code helps to grep and find out parameter sent to the
> _scratch_mkfs_sized here.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

IMO this is noise, you can just as simply do
"grep _scratch_mkfs_sized" and then open the file to inspect the actual
argument. But it's up to the xfstest maintainers
> ---
>  tests/generic/102 | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/tests/generic/102 b/tests/generic/102
> index faf940ac5070..aad496a5bc69 100755
> --- a/tests/generic/102
> +++ b/tests/generic/102
> @@ -31,8 +31,7 @@ _require_scratch
>  
>  rm -f $seqres.full
>  
> -dev_size=$((512 * 1024 * 1024))     # 512MB filesystem
> -_scratch_mkfs_sized $dev_size >>$seqres.full 2>&1
> +_scratch_mkfs_sized $((512 * 1024 * 1024)) >>$seqres.full 2>&1
>  _scratch_mount
>  
>  for ((i = 0; i < 10; i++)); do
> 
