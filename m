Return-Path: <SRS0=26Jc=6B=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDFF5C38A2C
	for <linux-fstests@archiver.kernel.org>; Fri, 17 Apr 2020 17:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B51B02078E
	for <linux-fstests@archiver.kernel.org>; Fri, 17 Apr 2020 17:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T3OV21vv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729290AbgDQRK7 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 17 Apr 2020 13:10:59 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:50356 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729330AbgDQRK4 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 17 Apr 2020 13:10:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587143455;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+N8iSV4CcAixGpnySNgzkeWh3Se0n8oT2tg3cvIwiLU=;
        b=T3OV21vvuFOE57Xx37AuDicLf9OFgjCQkkVHRkhZCwPCc+G+lme679Q9tVBv8AALNo1cN3
        mYly06ztNDJGQp6/Q+Yd7LUCP/Nms5l6+fXDlPhXm1nXe/Af5Q/tJzCbrw2mJcEgXS8eS3
        oxPZ6vLU4skCXDQ9IV7m+HnBqQ+IRfw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-y8LvMLQGOLy0qAmyO13PZg-1; Fri, 17 Apr 2020 13:10:54 -0400
X-MC-Unique: y8LvMLQGOLy0qAmyO13PZg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D0A15107ACC7;
        Fri, 17 Apr 2020 17:10:52 +0000 (UTC)
Received: from bfoster (dhcp-41-2.bos.redhat.com [10.18.41.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4793A116D92;
        Fri, 17 Apr 2020 17:10:52 +0000 (UTC)
Date:   Fri, 17 Apr 2020 13:10:50 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     fdmanana@kernel.org
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH v2 4/4] fsx: move range generation logic into a common
 helper
Message-ID: <20200417171050.GE13463@bfoster>
References: <20200408103627.11514-1-fdmanana@kernel.org>
 <20200408181208.12054-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408181208.12054-1-fdmanana@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Apr 08, 2020 at 07:12:08PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> We have very similar code that generates the destination range for clone,
> dedupe and copy_file_range operations, so avoid duplicating the code three
> times and move it into a helper function.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
> 
> V2: Turned the first parameter of the helper into a boolean as Darrick suggested.
> 
>  ltp/fsx.c | 91 +++++++++++++++++++++++++--------------------------------------
>  1 file changed, 36 insertions(+), 55 deletions(-)
> 
> diff --git a/ltp/fsx.c b/ltp/fsx.c
> index 89a5f60e..9bfc98e0 100644
> --- a/ltp/fsx.c
> +++ b/ltp/fsx.c
...
> @@ -2004,63 +2034,14 @@ test(void)
>  			keep_size = random() % 2;
>  		break;
...
>  	case OP_COPY_RANGE:
> -		{
> -			int tries = 0;
> -
> -			TRIM_OFF_LEN(offset, size, file_size);
> -			offset -= offset % readbdy;
> -			if (o_direct)
> -				size -= size % readbdy;
> -			do {
> -				if (tries++ >= 30) {
> -					size = 0;
> -					break;
> -				}
> -				offset2 = random();
> -				TRIM_OFF(offset2, maxfilelen);
> -				offset2 -= offset2 % writebdy;

It looks like this writebdy bit is lost in the new helper...

Brian

> -			} while (range_overlaps(offset, offset2, size) ||
> -				 offset2 + size > maxfilelen);
> -			break;
> -		}
> +		generate_dest_range(true, maxfilelen, &offset, &size, &offset2);
> +		break;
>  	}
>  
>  have_op:
> -- 
> 2.11.0
> 

