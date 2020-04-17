Return-Path: <SRS0=26Jc=6B=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2DB0C38A2E
	for <linux-fstests@archiver.kernel.org>; Fri, 17 Apr 2020 17:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFFF92076D
	for <linux-fstests@archiver.kernel.org>; Fri, 17 Apr 2020 17:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AHchUg9u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729283AbgDQRKq (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 17 Apr 2020 13:10:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28903 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729200AbgDQRKp (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 17 Apr 2020 13:10:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587143444;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kTYlNUK8aZh2HZI7/gj8fAi//1r8+x8BoHU4tJzCuHc=;
        b=AHchUg9u7TLJNPrmx5/h5eFi+OJJpncq341F8OQy2rYJM4NTWzf2MwLHzFEsPWLB+hPoD+
        AK3mMYh154OJVaXUC569fMercCL6Fd94VZPyV+rFUhfehxDMoJHrjlZCcoNkm01nkw31eO
        uUIdKV3VkSs7xvbpcO6MEy2cX1YBwII=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-8SSolWJdPeu68yxd88y3EQ-1; Fri, 17 Apr 2020 13:10:40 -0400
X-MC-Unique: 8SSolWJdPeu68yxd88y3EQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F2BC1005513;
        Fri, 17 Apr 2020 17:10:39 +0000 (UTC)
Received: from bfoster (dhcp-41-2.bos.redhat.com [10.18.41.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1665110027B4;
        Fri, 17 Apr 2020 17:10:39 +0000 (UTC)
Date:   Fri, 17 Apr 2020 13:10:37 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     fdmanana@kernel.org
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH 3/4] fsx: fix infinite/too long loops when generating
 ranges for copy_file_range
Message-ID: <20200417171037.GD13463@bfoster>
References: <20200408103616.11458-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408103616.11458-1-fdmanana@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Apr 08, 2020 at 11:36:16AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> While running generic/521 I've had fsx taking a lot of CPU time and not
> making any progress for several hours. Attaching gdb to the fsx process
> revealed that fsx was in the loop that generates the ranges for a
> copy_file_range operation, in particular the loop seemed to never end
> because the range defined by 'offset2' kept overlapping with the range
> defined by 'offset'.
> So far this happened one time only in one of my test VMs with generic/521.
> 
> Fix this by breaking out of the loop after trying 30 times, like we
> currently do for dedupe operations, which results in logging the operation
> as skipped.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---

Reviewed-by: Brian Foster <bfoster@redhat.com>

>  ltp/fsx.c | 30 +++++++++++++++++++-----------
>  1 file changed, 19 insertions(+), 11 deletions(-)
> 
> diff --git a/ltp/fsx.c b/ltp/fsx.c
> index 5949ebf0..89a5f60e 100644
> --- a/ltp/fsx.c
> +++ b/ltp/fsx.c
> @@ -2042,17 +2042,25 @@ test(void)
>  			break;
>  		}
>  	case OP_COPY_RANGE:
> -		TRIM_OFF_LEN(offset, size, file_size);
> -		offset -= offset % readbdy;
> -		if (o_direct)
> -			size -= size % readbdy;
> -		do {
> -			offset2 = random();
> -			TRIM_OFF(offset2, maxfilelen);
> -			offset2 -= offset2 % writebdy;
> -		} while (range_overlaps(offset, offset2, size) ||
> -			 offset2 + size > maxfilelen);
> -		break;
> +		{
> +			int tries = 0;
> +
> +			TRIM_OFF_LEN(offset, size, file_size);
> +			offset -= offset % readbdy;
> +			if (o_direct)
> +				size -= size % readbdy;
> +			do {
> +				if (tries++ >= 30) {
> +					size = 0;
> +					break;
> +				}
> +				offset2 = random();
> +				TRIM_OFF(offset2, maxfilelen);
> +				offset2 -= offset2 % writebdy;
> +			} while (range_overlaps(offset, offset2, size) ||
> +				 offset2 + size > maxfilelen);
> +			break;
> +		}
>  	}
>  
>  have_op:
> -- 
> 2.11.0
> 

