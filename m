Return-Path: <SRS0=FsZq=CZ=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14614C43461
	for <linux-fstests@archiver.kernel.org>; Wed, 16 Sep 2020 01:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D57A2078D
	for <linux-fstests@archiver.kernel.org>; Wed, 16 Sep 2020 01:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UYwwWaEz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgIPBuL (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 15 Sep 2020 21:50:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32832 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726023AbgIPBuJ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 15 Sep 2020 21:50:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600221007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ibHqQ9FpbcPG1+lWjv2BeWVUkDwDGIjKqGFHlZVLTWw=;
        b=UYwwWaEzlcEjoA3dItCbSAjtWrpqJW/GC8nS4tQRY/a/1DmjIryKgKQ4eNyu9e0OmyOyQy
        1xgjueBQstrpDcr0mLw9xV21Fhc5ensKiuGum5vl87amXARS5UshfdnzU8MU+SV86sh0LL
        n9qel/hwFcWWJSfeN+Robd0N6DdQ2+w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-569-oMH15U-KPhOsq7EMRMRBBA-1; Tue, 15 Sep 2020 21:50:05 -0400
X-MC-Unique: oMH15U-KPhOsq7EMRMRBBA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F203B1074650
        for <fstests@vger.kernel.org>; Wed, 16 Sep 2020 01:50:04 +0000 (UTC)
Received: from localhost (dhcp-12-102.nay.redhat.com [10.66.12.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6AF997513D
        for <fstests@vger.kernel.org>; Wed, 16 Sep 2020 01:50:04 +0000 (UTC)
Date:   Wed, 16 Sep 2020 10:04:02 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     fstests@vger.kernel.org
Subject: Re: [PATCH 04/24] xfs: skip tests that rely on allocation behaviors
 of the data device
Message-ID: <20200916020402.GV2937@dhcp-12-102.nay.redhat.com>
Mail-Followup-To: fstests@vger.kernel.org
References: <160013417420.2923511.6825722200699287884.stgit@magnolia>
 <160013420138.2923511.15786976146213933728.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160013420138.2923511.15786976146213933728.stgit@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Sep 14, 2020 at 06:43:21PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <darrick.wong@oracle.com>
> 
> A large number of xfs-specific tests rely on specific behaviors of the
> data device allocator, such as fragmenting free space, carefully curated
> inode and free space counts, or features like filestreams that only
> exist on the data device.
> 
> These tests fail horribly if the test runner specified rtinherit=1 on
> the mkfs command line, so skip them all.
> 
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> ---

Good to me,
Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/xfs/171 |    1 +
>  tests/xfs/172 |    1 +
>  tests/xfs/173 |    1 +
>  tests/xfs/174 |    1 +
>  tests/xfs/205 |    1 +
>  tests/xfs/306 |    1 +
>  tests/xfs/318 |    1 +
>  tests/xfs/444 |    1 +
>  8 files changed, 8 insertions(+)
> 
> 
> diff --git a/tests/xfs/171 b/tests/xfs/171
> index 050d02ab..a0d6e3f9 100755
> --- a/tests/xfs/171
> +++ b/tests/xfs/171
> @@ -33,6 +33,7 @@ _supported_fs xfs
>  _supported_os Linux
>  
>  _require_scratch
> +_require_no_rtinherit
>  
>  _check_filestreams_support || _notrun "filestreams not available"
>  
> diff --git a/tests/xfs/172 b/tests/xfs/172
> index c100481c..13f1f381 100755
> --- a/tests/xfs/172
> +++ b/tests/xfs/172
> @@ -33,6 +33,7 @@ _supported_fs xfs
>  _supported_os Linux
>  
>  _require_scratch
> +_require_no_rtinherit
>  
>  _check_filestreams_support || _notrun "filestreams not available"
>  
> diff --git a/tests/xfs/173 b/tests/xfs/173
> index 1569146f..47e1d029 100755
> --- a/tests/xfs/173
> +++ b/tests/xfs/173
> @@ -33,6 +33,7 @@ _supported_fs xfs
>  _supported_os Linux
>  
>  _require_scratch
> +_require_no_rtinherit
>  
>  _check_filestreams_support || _notrun "filestreams not available"
>  
> diff --git a/tests/xfs/174 b/tests/xfs/174
> index 781a1967..348f38c3 100755
> --- a/tests/xfs/174
> +++ b/tests/xfs/174
> @@ -33,6 +33,7 @@ _supported_fs xfs
>  _supported_os Linux
>  
>  _require_scratch
> +_require_no_rtinherit
>  
>  _check_filestreams_support || _notrun "filestreams not available"
>  
> diff --git a/tests/xfs/205 b/tests/xfs/205
> index 645e509a..6f1c2058 100755
> --- a/tests/xfs/205
> +++ b/tests/xfs/205
> @@ -24,6 +24,7 @@ _supported_os Linux
>  
>  # single AG will cause xfs_repair to fail checks.
>  _require_scratch_nocheck
> +_require_no_rtinherit
>  
>  rm -f $seqres.full
>  
> diff --git a/tests/xfs/306 b/tests/xfs/306
> index edbb6076..d2a0dd7f 100755
> --- a/tests/xfs/306
> +++ b/tests/xfs/306
> @@ -35,6 +35,7 @@ _supported_fs xfs
>  _supported_os Linux
>  
>  _require_scratch_nocheck	# check complains about single AG fs
> +_require_no_rtinherit
>  _require_xfs_io_command "fpunch"
>  _require_command $UUIDGEN_PROG uuidgen
>  
> diff --git a/tests/xfs/318 b/tests/xfs/318
> index 83b858ea..a45301e2 100755
> --- a/tests/xfs/318
> +++ b/tests/xfs/318
> @@ -33,6 +33,7 @@ _supported_fs xfs
>  _require_scratch
>  _require_error_injection
>  _require_xfs_io_error_injection "rmap_finish_one"
> +_require_no_rtinherit
>  
>  rm -f $seqres.full
>  
> diff --git a/tests/xfs/444 b/tests/xfs/444
> index 6ed88715..e84b2cca 100755
> --- a/tests/xfs/444
> +++ b/tests/xfs/444
> @@ -40,6 +40,7 @@ _require_scratch
>  _require_test_program "punch-alternating"
>  _require_xfs_io_command "falloc"
>  _require_xfs_db_write_array
> +_require_no_rtinherit
>  
>  # This is only a v5 filesystem problem
>  _require_scratch_xfs_crc
> 

