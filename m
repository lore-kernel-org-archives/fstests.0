Return-Path: <SRS0=d97O=BI=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 803A8C433DF
	for <linux-fstests@archiver.kernel.org>; Wed, 29 Jul 2020 04:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44DC720786
	for <linux-fstests@archiver.kernel.org>; Wed, 29 Jul 2020 04:44:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="acBLZR8+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbgG2EoG (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 29 Jul 2020 00:44:06 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:40672 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726286AbgG2EoF (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 29 Jul 2020 00:44:05 -0400
X-Greylist: delayed 385 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 Jul 2020 00:44:05 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595997844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NW8qJxUGD7UOoxfhEb1hJPfq6/hZauH2emJCDf2UkTo=;
        b=acBLZR8+eLgGz/z9zwa/bKZ4GVQxTnXLkXrElgMEl2g5L5hj1YWyPm1/Tc3JINOHmMLbv+
        /pH7rjWRCT782Zf01WVl08retOlpnYd2Je8uK6bi8AMpgWtImpng/v0yt/QVvRDTwpD9rx
        SgrF0oO4+6H7K91gsF44enSDGfEUwr4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-DGHtrdVSMPi3-2hjeSNikg-1; Wed, 29 Jul 2020 00:37:36 -0400
X-MC-Unique: DGHtrdVSMPi3-2hjeSNikg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B7A62107BEF5;
        Wed, 29 Jul 2020 04:37:35 +0000 (UTC)
Received: from localhost (dhcp-12-102.nay.redhat.com [10.66.12.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2F48D69329;
        Wed, 29 Jul 2020 04:37:34 +0000 (UTC)
Date:   Wed, 29 Jul 2020 12:49:56 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Eryu Guan <guaneryu@gmail.com>, fstests <fstests@vger.kernel.org>
Subject: Re: [PATCH] xfs/010,030: filter AG header CRC error warnings
Message-ID: <20200729044956.GG2937@dhcp-12-102.nay.redhat.com>
Mail-Followup-To: "Darrick J. Wong" <darrick.wong@oracle.com>,
        Eryu Guan <guaneryu@gmail.com>, fstests <fstests@vger.kernel.org>
References: <20200729025119.GV7600@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200729025119.GV7600@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Jul 28, 2020 at 07:51:19PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <darrick.wong@oracle.com>
> 
> Filter out the new AG header CRC verification warnings in xfs_repair
> since these tests were built before that existed.
> 
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> ---

Hi Darrick,

I still hit an error[1] on xfs/030 after merge your patch.

Thanks,
Zorro

# diff -u ./tests/xfs/030.out ./results//xfs/030.out.bad                                                          
--- /root/git/xfstests-dev/tests/xfs/030.out    2020-03-12 11:22:50.063148796 +0800
+++ /root/git/xfstests-dev/results//xfs/030.out.bad     2020-07-29 12:33:08.485428533 +0800
@@ -105,6 +105,7 @@
 Phase 2 - using <TYPEOF> log
         - zero log...
         - scan filesystem freespace and inode maps...
+bad agbno AGBNO in agfl, agno 0
         - found root inode chunk
 Phase 3 - for each AG...
         - scan and clear agi unlinked lists...

>  tests/xfs/010 |    7 ++++++-
>  tests/xfs/030 |    2 ++
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/xfs/010 b/tests/xfs/010
> index e220a651..b65dd3ba 100755
> --- a/tests/xfs/010
> +++ b/tests/xfs/010
> @@ -113,7 +113,12 @@ _check_scratch_fs
>  # nuke the finobt root, repair will have to regenerate from the inobt
>  _corrupt_finobt_root $SCRATCH_DEV
>  
> -_scratch_xfs_repair 2>&1 | _filter_repair_lostblocks
> +filter_finobt_repair() {
> +	sed -e '/^agi has bad CRC/d' | \
> +		_filter_repair_lostblocks
> +}
> +
> +_scratch_xfs_repair 2>&1 | filter_finobt_repair
>  
>  status=0
>  exit
> diff --git a/tests/xfs/030 b/tests/xfs/030
> index efdb6a18..ebe4c92a 100755
> --- a/tests/xfs/030
> +++ b/tests/xfs/030
> @@ -42,6 +42,8 @@ _check_ag()
>  			    -e '/^bad agbno AGBNO for finobt/d' \
>  			    -e '/^bad agbno AGBNO for rmapbt/d' \
>  			    -e '/^bad agbno AGBNO for refcntbt/d' \
> +			    -e '/^agf has bad CRC/d' \
> +			    -e '/^agi has bad CRC/d' \
>  			    -e '/^Missing reverse-mapping record.*/d' \
>  			    -e '/^unknown block state, ag AGNO, block.*/d'
>  	done
> 

