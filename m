Return-Path: <SRS0=FsZq=CZ=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2707AC433E2
	for <linux-fstests@archiver.kernel.org>; Wed, 16 Sep 2020 04:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB56321655
	for <linux-fstests@archiver.kernel.org>; Wed, 16 Sep 2020 04:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dhdWmGzN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbgIPEAQ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 16 Sep 2020 00:00:16 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35282 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726100AbgIPEAP (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 16 Sep 2020 00:00:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600228812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OSQR3xRsI/8C2lLDGmXm0XpDkJyuE0+yE2taiXGlnIM=;
        b=dhdWmGzN7V7Gai39mk894K8Q8vadOEjK3ZLoIdl3iMy8cFX/yk8tl1D/iz8FwSrzENdw38
        MF6yn92gtJfyhmaeCwrfsI/tEcugfKHSbX4DtUDnRnL81uAZCVjLsXojeXKcw1DlqK8uhp
        KOtlgfXX0bOH5HlA2qZh6yhJGavH6N0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-QDhbG2vjPW28HxyMSie7Jg-1; Wed, 16 Sep 2020 00:00:09 -0400
X-MC-Unique: QDhbG2vjPW28HxyMSie7Jg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D06C1006704
        for <fstests@vger.kernel.org>; Wed, 16 Sep 2020 04:00:08 +0000 (UTC)
Received: from localhost (dhcp-12-102.nay.redhat.com [10.66.12.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DA5977514D
        for <fstests@vger.kernel.org>; Wed, 16 Sep 2020 04:00:07 +0000 (UTC)
Date:   Wed, 16 Sep 2020 12:14:06 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     fstests@vger.kernel.org
Subject: Re: [PATCH 13/24] generic/204: don't flood stdout with ENOSPC
 messages on an ENOSPC test
Message-ID: <20200916041406.GC2937@dhcp-12-102.nay.redhat.com>
Mail-Followup-To: fstests@vger.kernel.org
References: <160013417420.2923511.6825722200699287884.stgit@magnolia>
 <160013425839.2923511.10488499486430760605.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160013425839.2923511.10488499486430760605.stgit@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Sep 14, 2020 at 06:44:18PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <darrick.wong@oracle.com>
> 
> This test has been on and off my bad list for many years due to the fact
> that it will spew potentially millions of "No space left on device"
> errors if the file count calculations are wrong.  The calculations
> should be correct for the XFS data device, but they don't apply to other
> filesystems.
> 
> Therefore, filter out the ENOSPC messages when the files are not going
> to be created on the xfs data device (e.g. ext4, xfs realtime, etc.)
> 
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> ---

Good to me,
Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/generic/204 |    8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> 
> diff --git a/tests/generic/204 b/tests/generic/204
> index 349f5eff..7250c00a 100755
> --- a/tests/generic/204
> +++ b/tests/generic/204
> @@ -76,9 +76,13 @@ files=$((space / (direntlen + isize + dbsize)))
>  echo files $files, resvblks $resv_blks >> $seqres.full
>  _scratch_resvblks $resv_blks >> $seqres.full 2>&1
>  
> +filter() {
> +	test $FSTYP != xfs && sed -e '/No space left on device/d'
> +}
> +
>  for i in `seq -w 1 $files`; do
> -    echo -n > $SCRATCH_MNT/$i
> -    echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX > $SCRATCH_MNT/$i
> +	(echo -n > $SCRATCH_MNT/$i;
> +	 echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX > $SCRATCH_MNT/$i) 2>&1 | filter
>  done
>  
>  # success, all done
> 

