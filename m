Return-Path: <SRS0=vVM5=AU=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38247C433DF
	for <linux-fstests@archiver.kernel.org>; Thu,  9 Jul 2020 15:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06D342077D
	for <linux-fstests@archiver.kernel.org>; Thu,  9 Jul 2020 15:40:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AX3LMHoE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgGIPkB (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 9 Jul 2020 11:40:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32538 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726339AbgGIPkB (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 9 Jul 2020 11:40:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594309200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ngeAu4u3++qGhAHcANwYA8BG76ve39q4SngAQaT4vxA=;
        b=AX3LMHoEHPngQGX5ExWmmUsP/xAz9KJA7NdPhyTbRjuh/nk23K6N8+zzWWgRhUycfhk5Q1
        8YGQODbh1gNuey/BMJj9kTDOKYWm+zMx64hHblt97qye0mKIXodsgJBD4NWWJ9ltIErD0U
        HogfG6rYKWabM1SiVTUvlgmcxplEvSs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-5xIMO8U9Naus9fW3CRxsFw-1; Thu, 09 Jul 2020 11:39:58 -0400
X-MC-Unique: 5xIMO8U9Naus9fW3CRxsFw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 825851DE1;
        Thu,  9 Jul 2020 15:39:57 +0000 (UTC)
Received: from redhat.com (ovpn-115-154.rdu2.redhat.com [10.10.115.154])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 127B65BAEA;
        Thu,  9 Jul 2020 15:39:56 +0000 (UTC)
Date:   Thu, 9 Jul 2020 10:39:55 -0500
From:   Bill O'Donnell <billodo@redhat.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Eryu Guan <guaneryu@gmail.com>, fstests <fstests@vger.kernel.org>
Subject: Re: [PATCH] xfs/518: require scratch device
Message-ID: <20200709153955.GA198232@redhat.com>
References: <20200709153655.GG7600@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709153655.GG7600@magnolia>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Jul 09, 2020 at 08:36:55AM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <darrick.wong@oracle.com>
> 
> This test requires the scratch device, so we need to test for it.
> 
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>

Reviewed-by: Bill O'Donnell <billodo@redhat.com>

> ---
>  tests/xfs/518 |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/xfs/518 b/tests/xfs/518
> index 14457978..da39d8dc 100755
> --- a/tests/xfs/518
> +++ b/tests/xfs/518
> @@ -30,6 +30,7 @@ _cleanup()
>  # real QA test starts here
>  _supported_fs xfs
>  _supported_os Linux
> +_require_scratch
>  _require_quota
>  
>  rm -f $seqres.full
> 

