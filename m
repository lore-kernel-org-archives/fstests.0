Return-Path: <SRS0=FsZq=CZ=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25FBFC43461
	for <linux-fstests@archiver.kernel.org>; Wed, 16 Sep 2020 15:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF53B22243
	for <linux-fstests@archiver.kernel.org>; Wed, 16 Sep 2020 15:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ArcDWBgF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgIPPa1 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 16 Sep 2020 11:30:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38211 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726285AbgIPPaU (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 16 Sep 2020 11:30:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600270159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O91AcBk+Stsv/EpIfLQmYWxEAtbjvbv3YRg1vLXs/w4=;
        b=ArcDWBgF0Hae6YenLZVI5MnkOUhZHkAgnpUCdzMlWJyd1SUK2Pwk/fMtXP0PQ/Cqqt4C5U
        puTTLq/mSGBJwlFXSTo4PQad97PVqdHaps9MMmdgDr1In1961AbUD/iQjriGwLWZAYaEU9
        yQZj/GppN9mdqbd1egfxnvoK2HpldD8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-e24EcKLsPt65lkt1twXRiA-1; Wed, 16 Sep 2020 07:51:54 -0400
X-MC-Unique: e24EcKLsPt65lkt1twXRiA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 479EC8B7CE2
        for <fstests@vger.kernel.org>; Wed, 16 Sep 2020 11:51:43 +0000 (UTC)
Received: from localhost (dhcp-12-102.nay.redhat.com [10.66.12.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B754319D6C
        for <fstests@vger.kernel.org>; Wed, 16 Sep 2020 11:51:42 +0000 (UTC)
Date:   Wed, 16 Sep 2020 20:05:41 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     fstests@vger.kernel.org
Subject: Re: [PATCH 22/24] xfs/141: run for longer with TIME_FACTOR
Message-ID: <20200916120541.GM2937@dhcp-12-102.nay.redhat.com>
Mail-Followup-To: fstests@vger.kernel.org
References: <160013417420.2923511.6825722200699287884.stgit@magnolia>
 <160013431528.2923511.17636617456077025611.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160013431528.2923511.17636617456077025611.stgit@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Sep 14, 2020 at 06:45:15PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <darrick.wong@oracle.com>
> 
> Allow the test runner to run the crash loop in this test for longer by
> setting TIME_FACTOR.  This has been useful for finding bugs in log
> recovery.
> 
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> ---

Good to me,
Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/xfs/141 |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> 
> diff --git a/tests/xfs/141 b/tests/xfs/141
> index 754ca37a..ef7210ff 100755
> --- a/tests/xfs/141
> +++ b/tests/xfs/141
> @@ -50,7 +50,8 @@ _scratch_mount
>  
>  sdev=$(_short_dev $SCRATCH_DEV)
>  
> -for i in $(seq 1 5); do
> +nr_times=$((TIME_FACTOR * 5))
> +while [ $nr_times -gt 0 ]; do
>  	# Enable error injection. Use a random bad crc factor up to 100
>  	# (increase this value to run fsstress longer).
>  	factor=$((RANDOM % 100 + 1))
> @@ -65,6 +66,7 @@ for i in $(seq 1 5); do
>  	# write.
>  	_scratch_unmount
>  	_scratch_mount
> +	nr_times=$((nr_times - 1))
>  done
>  
>  # success, all done
> 

