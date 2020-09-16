Return-Path: <SRS0=FsZq=CZ=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD5C1C43461
	for <linux-fstests@archiver.kernel.org>; Wed, 16 Sep 2020 17:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9122D22263
	for <linux-fstests@archiver.kernel.org>; Wed, 16 Sep 2020 17:15:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="esKdqBsg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgIPROy (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 16 Sep 2020 13:14:54 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45493 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726918AbgIPRMz (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 16 Sep 2020 13:12:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600276345;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9YLqjZbQbluq3b80KilT+H7ZG4w6xHsDff36L9vI2iI=;
        b=esKdqBsgAa//JhW57Qg1yjV3nK6+HSCxdFvRoFmZMbz4JQhB9sQE1eTUKr5c3LbOXr7TGv
        dbSg9izWSsshEWQVZrOPUt6P5NuUxhg28kGz8hxuNZqGr73y+H4Q9zxKyoCgiIhseD7NK4
        tleRkiU1vhqSegDtY2JMa3HFITeVZ3M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-w41ZjtiUMneSihr4G8PmsA-1; Wed, 16 Sep 2020 07:36:24 -0400
X-MC-Unique: w41ZjtiUMneSihr4G8PmsA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BB7EA1019624
        for <fstests@vger.kernel.org>; Wed, 16 Sep 2020 11:36:23 +0000 (UTC)
Received: from localhost (dhcp-12-102.nay.redhat.com [10.66.12.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 364D519D61
        for <fstests@vger.kernel.org>; Wed, 16 Sep 2020 11:36:22 +0000 (UTC)
Date:   Wed, 16 Sep 2020 19:50:22 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     fstests@vger.kernel.org
Subject: Re: [PATCH 20/24] xfs/449: fix xfs info report output if realtime
 device specified
Message-ID: <20200916115021.GK2937@dhcp-12-102.nay.redhat.com>
Mail-Followup-To: fstests@vger.kernel.org
References: <160013417420.2923511.6825722200699287884.stgit@magnolia>
 <160013430267.2923511.8202421356162568130.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160013430267.2923511.8202421356162568130.stgit@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Sep 14, 2020 at 06:45:02PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <darrick.wong@oracle.com>
> 
> Modify the mkfs.xfs output so that "realtime =/dev/XXX" becomes
> "realtime =external" so that the output will match xfs_db, which doesn't
> take a rt device argument and thus does not know.
> 
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> ---

Good to me,
Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/xfs/449 |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> 
> diff --git a/tests/xfs/449 b/tests/xfs/449
> index 83c3c493..938dbe28 100755
> --- a/tests/xfs/449
> +++ b/tests/xfs/449
> @@ -46,7 +46,9 @@ cat $tmp.mkfs >> $seqres.full
>  _scratch_xfs_db -c "info" > $tmp.dbinfo
>  echo DB >> $seqres.full
>  cat $tmp.dbinfo >> $seqres.full
> -diff -u $tmp.mkfs $tmp.dbinfo
> +# xfs_db doesn't take a rtdev argument, so it reports "realtime=external".
> +# mkfs does, so make a quick substitution
> +diff -u <(cat $tmp.mkfs | sed -e 's/realtime =\/.*extsz=/realtime =external               extsz=/g') $tmp.dbinfo
>  
>  _scratch_mount
>  
> 

