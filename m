Return-Path: <SRS0=d97O=BI=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01BBEC433DF
	for <linux-fstests@archiver.kernel.org>; Wed, 29 Jul 2020 04:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C74522076E
	for <linux-fstests@archiver.kernel.org>; Wed, 29 Jul 2020 04:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zma5Vdtb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgG2EwF (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 29 Jul 2020 00:52:05 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:47741 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726203AbgG2EwE (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 29 Jul 2020 00:52:04 -0400
X-Greylist: delayed 541 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 Jul 2020 00:52:03 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595998323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+MYDertaw/t1Ad5hrFJ2BB95C7g0pZ7FJUr+rlyMM8w=;
        b=Zma5VdtbleJoYn4X9iVv9+TAoq1FjKq5fsMi0YSiy6lo3ymZk4ZwWY1fnLoVH6c/neZ+ei
        Kme2GeIihcIgYVSI7xoI29DddQ01+I7ohBF4HtwDhhIVToVlYUwiFoga2MoBwyEcSRVTJn
        RGUZq1U27FXgFyF8e44CWkURyzP4C4Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-478-8OzgUc0oO4Ok3jqFXYTpuQ-1; Wed, 29 Jul 2020 00:41:28 -0400
X-MC-Unique: 8OzgUc0oO4Ok3jqFXYTpuQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7BA32107BEF7
        for <fstests@vger.kernel.org>; Wed, 29 Jul 2020 04:41:27 +0000 (UTC)
Received: from localhost (dhcp-12-102.nay.redhat.com [10.66.12.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EB3628A163
        for <fstests@vger.kernel.org>; Wed, 29 Jul 2020 04:41:26 +0000 (UTC)
Date:   Wed, 29 Jul 2020 12:53:48 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     fstests <fstests@vger.kernel.org>
Subject: Re: [PATCH] generic/603: don't run on XFS v4 filesystems
Message-ID: <20200729045348.GH2937@dhcp-12-102.nay.redhat.com>
Mail-Followup-To: fstests <fstests@vger.kernel.org>
References: <20200729025141.GW7600@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200729025141.GW7600@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Jul 28, 2020 at 07:51:41PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <darrick.wong@oracle.com>
> 
> XFS filesystems require V5 format to support all three quota types at
> the same time, so skip the test if we're testing XFS older than that.
> 
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> ---

Thanks for fixing it!
Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/generic/603 |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tests/generic/603 b/tests/generic/603
> index 54deaf13..fc3df6e5 100755
> --- a/tests/generic/603
> +++ b/tests/generic/603
> @@ -149,6 +149,10 @@ test_grace()
>  _supported_fs generic
>  _supported_os Linux
>  _require_scratch
> +# xfs requires v5 format to support all three quota types at the same time
> +if [ "$FSTYP" = "xfs" ]; then
> +	_require_scratch_xfs_crc
> +fi
>  _require_setquota_project
>  _require_quota
>  _require_user
> 

