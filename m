Return-Path: <SRS0=FsZq=CZ=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EEEFC43461
	for <linux-fstests@archiver.kernel.org>; Wed, 16 Sep 2020 03:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E60A0206B6
	for <linux-fstests@archiver.kernel.org>; Wed, 16 Sep 2020 03:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aO6iP+ot"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726093AbgIPDPr (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 15 Sep 2020 23:15:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34699 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726155AbgIPDPr (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 15 Sep 2020 23:15:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600226145;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V9xHxsQ7raS+5hbRLf2Sc2grxmMqbHTauGlg5nNJSjE=;
        b=aO6iP+ot2zo49rlUhyliGz+19KzPwvrJ8JkTiTxhogFdhZzGsmk0Z9U2gn5ZzqWY2KqAKJ
        prpRP1cltNcJYMSOHAdbo3DUOOA/SnemEg0PgHUiV7uEQ/IHobYWj2bNofE58YjdcM2iNO
        P/MeT4WFep/UDrlagnkgayt+89YWEvk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-qfzkVY5UMgCOf99xcmUQ6w-1; Tue, 15 Sep 2020 23:15:43 -0400
X-MC-Unique: qfzkVY5UMgCOf99xcmUQ6w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 58BFF1021D21
        for <fstests@vger.kernel.org>; Wed, 16 Sep 2020 03:15:42 +0000 (UTC)
Received: from localhost (dhcp-12-102.nay.redhat.com [10.66.12.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C8FFE7EB7C
        for <fstests@vger.kernel.org>; Wed, 16 Sep 2020 03:15:41 +0000 (UTC)
Date:   Wed, 16 Sep 2020 11:29:40 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     fstests@vger.kernel.org
Subject: Re: [PATCH 10/24] xfs: add a _require_xfs_copy helper
Message-ID: <20200916032940.GB2937@dhcp-12-102.nay.redhat.com>
Mail-Followup-To: fstests@vger.kernel.org
References: <160013417420.2923511.6825722200699287884.stgit@magnolia>
 <160013423963.2923511.3348023490177095472.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160013423963.2923511.3348023490177095472.stgit@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Sep 14, 2020 at 06:43:59PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <darrick.wong@oracle.com>
> 
> Add a _require helper so that tests can ensure that they're running in
> the correct environment for xfs_copy to work (no external devices).
> 
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> ---

Good to me,
Reviewed-by: Zorro Lang <zlang@redhat.com>

>  common/xfs    |    7 +++++++
>  tests/xfs/032 |    4 +---
>  tests/xfs/073 |    5 +----
>  tests/xfs/077 |    3 +--
>  tests/xfs/284 |    3 +--
>  tests/xfs/503 |    1 +
>  6 files changed, 12 insertions(+), 11 deletions(-)
> 
> 
> diff --git a/common/xfs b/common/xfs
> index eab5e292..f4a47dfb 100644
> --- a/common/xfs
> +++ b/common/xfs
> @@ -945,3 +945,10 @@ _try_wipe_scratch_xfs()
>  	fi
>  	rm -f $tmp.mkfs
>  }
> +
> +_require_xfs_copy()
> +{
> +	[ -n "$XFS_COPY_PROG" ] || _notrun "xfs_copy binary not yet installed"
> +	[ "$USE_EXTERNAL" = yes ] && \
> +		_notrun "Cannot xfs_copy with external devices"
> +}
> diff --git a/tests/xfs/032 b/tests/xfs/032
> index af18f755..8ece957d 100755
> --- a/tests/xfs/032
> +++ b/tests/xfs/032
> @@ -25,9 +25,7 @@ _supported_os Linux
>  
>  _require_scratch
>  _require_test_program "feature"
> -
> -[ "$USE_EXTERNAL" = yes ] && _notrun "Cannot xfs_copy with external devices"
> -[ -n "$XFS_COPY_PROG" ] || _notrun "xfs_copy binary not yet installed"
> +_require_xfs_copy
>  
>  rm -f $seqres.full
>  
> diff --git a/tests/xfs/073 b/tests/xfs/073
> index 6939e102..dc0cde4f 100755
> --- a/tests/xfs/073
> +++ b/tests/xfs/073
> @@ -113,10 +113,7 @@ _supported_fs xfs
>  _supported_os Linux
>  _require_test
>  _require_attrs
> -
> -[ "$USE_EXTERNAL" = yes ] && _notrun "Cannot xfs_copy with external devices"
> -[ -n "$XFS_COPY_PROG" ] || _notrun "xfs_copy binary not yet installed"
> -
> +_require_xfs_copy
>  _require_scratch
>  _require_loop
>  
> diff --git a/tests/xfs/077 b/tests/xfs/077
> index 02bcc9f7..b11b2c07 100755
> --- a/tests/xfs/077
> +++ b/tests/xfs/077
> @@ -35,8 +35,7 @@ _cleanup()
>  
>  _supported_fs xfs
>  _supported_os Linux
> -# xfs_copy does not support realtime devices
> -_require_no_realtime
> +_require_xfs_copy
>  _require_scratch
>  _require_no_large_scratch_dev
>  _require_xfs_crc
> diff --git a/tests/xfs/284 b/tests/xfs/284
> index 7af77634..8f997e17 100755
> --- a/tests/xfs/284
> +++ b/tests/xfs/284
> @@ -34,8 +34,7 @@ rm -f $seqres.full
>  # real QA test starts here
>  _supported_fs xfs
>  _supported_os Linux
> -# xfs_copy does not support realtime devices
> -_require_no_realtime
> +_require_xfs_copy
>  _require_test
>  _require_scratch
>  _require_no_large_scratch_dev
> diff --git a/tests/xfs/503 b/tests/xfs/503
> index 41754353..756bcda3 100755
> --- a/tests/xfs/503
> +++ b/tests/xfs/503
> @@ -33,6 +33,7 @@ testdir=$TEST_DIR/test-$seq
>  _supported_os Linux
>  _supported_fs xfs
>  
> +_require_xfs_copy
>  _require_scratch_nocheck
>  _require_populate_commands
>  
> 

