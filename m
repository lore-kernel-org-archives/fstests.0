Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42649 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751220AbbCYXIr (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 25 Mar 2015 19:08:47 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (Postfix) with ESMTPS id 68634C6569
	for <fstests@vger.kernel.org>; Wed, 25 Mar 2015 23:08:47 +0000 (UTC)
Date: Wed, 25 Mar 2015 19:08:45 -0400
From: Brian Foster <bfoster@redhat.com>
Subject: Re: [PATCH 7/9] common: recognise NFS export over IPv6 in
 _require_scratch_nocheck()
Message-ID: <20150325230845.GB13510@bfoster.bfoster>
References: <1426846618-23413-1-git-send-email-eguan@redhat.com>
 <1426846618-23413-8-git-send-email-eguan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1426846618-23413-8-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Mar 20, 2015 at 06:16:56PM +0800, Eryu Guan wrote:
> This commit
> 
> 73dfa4a common: Fixes for testing NFS over IPv6
> 
> adds NFS over IPv6 support, and commit
> 
> 76c5f3c common: re-enable tests that require scratch dev on NFS
> 
> enables NFS tests on scratch device.
> 
> Now do the same updates to _require_scratch_nocheck() to enable NFS over
> IPv6 support on scratch device.
> 
> Signed-off-by: Eryu Guan <eguan@redhat.com>
> ---

Seems fine...

Reviewed-by: Brian Foster <bfoster@redhat.com>

>  common/rc | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index 857308a..fbb19c2 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -1111,10 +1111,12 @@ _require_scratch_nocheck()
>      esac
>  
>      # mounted?
> -    if _mount | grep -q $SCRATCH_DEV
> +    # Note that we use -F here so grep doesn't try to interpret an NFS over
> +    # IPv6 server as a regular expression.
> +    if _mount | grep -F -q $SCRATCH_DEV
>      then
>          # if it's mounted, make sure its on $SCRATCH_MNT
> -        if ! _mount | grep $SCRATCH_DEV | grep -q $SCRATCH_MNT
> +        if ! _mount | grep -F $SCRATCH_DEV | grep -q $SCRATCH_MNT
>          then
>              echo "\$SCRATCH_DEV is mounted but not on \$SCRATCH_MNT - aborting"
>              exit 1
> -- 
> 2.1.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
