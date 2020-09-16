Return-Path: <SRS0=FsZq=CZ=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF06C43461
	for <linux-fstests@archiver.kernel.org>; Wed, 16 Sep 2020 20:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C68B121973
	for <linux-fstests@archiver.kernel.org>; Wed, 16 Sep 2020 20:22:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RIKJhCaH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbgIPUVt (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 16 Sep 2020 16:21:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25975 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727142AbgIPRaN (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 16 Sep 2020 13:30:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600277401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z9SGEkl2tJCTg6z808hcratmTXsl/8ZVN6vKTdThQe4=;
        b=RIKJhCaHyx6L/rae58iMrqrkY1Jb8drWleNqevPqSDkiKAeX3exa67GtqhsftdIOYwSBKG
        pS15Zf3CbiJjCgIkLEiGAW5+RHr7tPtpSRY59UIJSptboIYI2sRmQUYvyal6uz2F5nUMI7
        +KV3Ig901uJxgZ5D0cEL/y3QAaEYuC8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-fQuAgGunMZK30vnZHf-wjg-1; Wed, 16 Sep 2020 07:56:13 -0400
X-MC-Unique: fQuAgGunMZK30vnZHf-wjg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6424888EF38
        for <fstests@vger.kernel.org>; Wed, 16 Sep 2020 11:55:46 +0000 (UTC)
Received: from localhost (dhcp-12-102.nay.redhat.com [10.66.12.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D434419D61
        for <fstests@vger.kernel.org>; Wed, 16 Sep 2020 11:55:45 +0000 (UTC)
Date:   Wed, 16 Sep 2020 20:09:45 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     fstests@vger.kernel.org
Subject: Re: [PATCH 23/24] generic/204: sync before scrub hits EIO
Message-ID: <20200916120945.GN2937@dhcp-12-102.nay.redhat.com>
Mail-Followup-To: fstests@vger.kernel.org
References: <160013417420.2923511.6825722200699287884.stgit@magnolia>
 <160013432161.2923511.669329888874845585.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160013432161.2923511.669329888874845585.stgit@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Sep 14, 2020 at 06:45:21PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <darrick.wong@oracle.com>
> 
> Let's see if we can prevent fs corruption warnings by flushing dirty
> data to disk before the test ends.
> 
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> ---

At least it won't break more things:)
Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/generic/204 |    1 +
>  1 file changed, 1 insertion(+)
> 
> 
> diff --git a/tests/generic/204 b/tests/generic/204
> index 7250c00a..22d6fed5 100755
> --- a/tests/generic/204
> +++ b/tests/generic/204
> @@ -18,6 +18,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>  _cleanup()
>  {
>  	rm -f $tmp.*
> +	sync
>  }
>  
>  # get standard environment, filters and checks
> 

