Return-Path: <SRS0=FsZq=CZ=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B062AC43461
	for <linux-fstests@archiver.kernel.org>; Wed, 16 Sep 2020 20:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5671B20659
	for <linux-fstests@archiver.kernel.org>; Wed, 16 Sep 2020 20:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tai+d2X7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbgIPUka (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 16 Sep 2020 16:40:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26195 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726693AbgIPRFj (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 16 Sep 2020 13:05:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600275919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DnoUCAswOT1lhoGuATaIUHhj2w+b2L+ixCPMl8jz7LA=;
        b=Tai+d2X7oa+sgbIdxhO6MQZQ4GiumEjzKeGVZXySV1Aj+P5s4gg5Bj7veq3EIdOkngMfrU
        Z7y4mvu+yy/Vr2ixECnfj3RPvM3+2ouJTOL70f+F0114opmE2pDQQPiq5+YUns9N6xdEPk
        sSwjsWpzczgA20ngtkG+/77/denIMNc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-513-4vzOm7EJMoWO8nu2Pckg1Q-1; Wed, 16 Sep 2020 07:22:14 -0400
X-MC-Unique: 4vzOm7EJMoWO8nu2Pckg1Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3AC24104D3EB
        for <fstests@vger.kernel.org>; Wed, 16 Sep 2020 11:22:13 +0000 (UTC)
Received: from localhost (dhcp-12-102.nay.redhat.com [10.66.12.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AA8487E731
        for <fstests@vger.kernel.org>; Wed, 16 Sep 2020 11:22:12 +0000 (UTC)
Date:   Wed, 16 Sep 2020 19:36:11 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     fstests@vger.kernel.org
Subject: Re: [PATCH 16/24] xfs/098: adapt to external log devices
Message-ID: <20200916113611.GG2937@dhcp-12-102.nay.redhat.com>
Mail-Followup-To: fstests@vger.kernel.org
References: <160013417420.2923511.6825722200699287884.stgit@magnolia>
 <160013427739.2923511.11743171089779718213.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160013427739.2923511.11743171089779718213.stgit@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Sep 14, 2020 at 06:44:37PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <darrick.wong@oracle.com>
> 
> Teach this test to deal with external log devices correctly.
> 
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> ---

Looks good to me,
Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/xfs/098 |    8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> 
> diff --git a/tests/xfs/098 b/tests/xfs/098
> index c63b9d60..b7d3253e 100755
> --- a/tests/xfs/098
> +++ b/tests/xfs/098
> @@ -76,7 +76,13 @@ echo "+ corrupt image"
>  logstart="$(_scratch_xfs_get_sb_field logstart)"
>  logstart="$(_scratch_xfs_db -c "convert fsblock ${logstart} byte" | sed -e 's/^.*(\([0-9]*\).*$/\1/g')"
>  logblocks="$(_scratch_xfs_get_sb_field logblocks)"
> -$XFS_IO_PROG -f -c "pwrite -S 0x62 ${logstart} $((logblocks * blksz))" "${SCRATCH_DEV}" >> $seqres.full
> +
> +if [ "$USE_EXTERNAL" = yes ] && [ ! -z "$SCRATCH_LOGDEV" ]; then
> +	logdev=$SCRATCH_LOGDEV
> +else
> +	logdev=$SCRATCH_DEV
> +fi
> +$XFS_IO_PROG -f -c "pwrite -S 0x62 ${logstart} $((logblocks * blksz))" $logdev >> $seqres.full
>  
>  echo "+ mount image"
>  _try_scratch_mount 2>/dev/null && _fail "mount should not succeed"
> 

