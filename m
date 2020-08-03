Return-Path: <SRS0=C+DF=BN=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D8AC433E0
	for <linux-fstests@archiver.kernel.org>; Mon,  3 Aug 2020 13:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34FD0206D7
	for <linux-fstests@archiver.kernel.org>; Mon,  3 Aug 2020 13:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f1AMr9RN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgHCNSI (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 3 Aug 2020 09:18:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48939 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726130AbgHCNSI (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 3 Aug 2020 09:18:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596460687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uyVMMgWvVzFqUoAca6kHm3Fl88WYHO9NHus7WXtlpnc=;
        b=f1AMr9RNRnSMtQPBAc/4bqjJTORK4K1H0s2LR/f4d/Q3wXuZtDTz20BBKGR3XVEW1WxuvS
        8d13QppBL8jM6zOEBx9jSaC9YB4Kmj359vYwdpELCHRwvX2orXUAKt9LJOqf2KSjZleb+Q
        OFYCyo0RBhdRCkUzpLnIldOeKIf5pyo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-EBT7kzN1OZ-XMO9y-uXz6g-1; Mon, 03 Aug 2020 09:18:05 -0400
X-MC-Unique: EBT7kzN1OZ-XMO9y-uXz6g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 947C21009627;
        Mon,  3 Aug 2020 13:18:04 +0000 (UTC)
Received: from redhat.com (ovpn-116-244.rdu2.redhat.com [10.10.116.244])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 57ED95FC36;
        Mon,  3 Aug 2020 13:18:01 +0000 (UTC)
Date:   Mon, 3 Aug 2020 08:17:59 -0500
From:   Bill O'Donnell <billodo@redhat.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Eryu Guan <guaneryu@gmail.com>, xfs <linux-xfs@vger.kernel.org>,
        fstests <fstests@vger.kernel.org>,
        Eric Sandeen <sandeen@redhat.com>
Subject: Re: [PATCH] xfs/{263,106} erase max warnings printout
Message-ID: <20200803131759.GA574548@redhat.com>
References: <20200730183533.GB67809@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200730183533.GB67809@magnolia>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Jul 30, 2020 at 11:35:33AM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <darrick.wong@oracle.com>
> 
> Both of these tests encode the xfs_quota output in the golden output.
> Now that we've changed xfs_quota to emit max warnings, we have to fix
> the test to avoid regressions.
> 
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>

Looks good.
Reviewed-by: Bill O'Donnell <billodo@redhat.com>

> ---
>  tests/xfs/106 |    3 ++-
>  tests/xfs/263 |    4 +++-
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/xfs/106 b/tests/xfs/106
> index 7a71ec09..e6a9b3d1 100755
> --- a/tests/xfs/106
> +++ b/tests/xfs/106
> @@ -96,7 +96,8 @@ filter_state()
>  {
>  	_filter_quota | sed -e "s/Inode: #[0-9]* (0 blocks, 0 extents)/Inode: #[INO] (0 blocks, 0 extents)/g" \
>  			    -e "s/Inode: #[0-9]* ([0-9]* blocks, [0-9]* extents)/Inode: #[INO] (X blocks, Y extents)/g" \
> -			    -e "/[0-9][0-9]:[0-9][0-9]:[0-9][0-9]/s/ [0-9][0-9]:[0-9][0-9]:[0-9][0-9]//g"
> +			    -e "/[0-9][0-9]:[0-9][0-9]:[0-9][0-9]/s/ [0-9][0-9]:[0-9][0-9]:[0-9][0-9]//g" \
> +			    -e '/max warnings:/d'
>  }
>  
>  test_quot()
> diff --git a/tests/xfs/263 b/tests/xfs/263
> index 578f9ee7..2f23318d 100755
> --- a/tests/xfs/263
> +++ b/tests/xfs/263
> @@ -57,7 +57,9 @@ function option_string()
>  }
>  
>  filter_quota_state() {
> -	sed -e 's/Inode: #[0-9]\+/Inode #XXX/g' | _filter_scratch
> +	sed -e 's/Inode: #[0-9]\+/Inode #XXX/g' \
> +	    -e '/max warnings:/d' \
> +		| _filter_scratch
>  }
>  
>  function test_all_state()
> 

