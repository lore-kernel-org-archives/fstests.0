Return-Path: <SRS0=NoLx=A4=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE1DC433E2
	for <linux-fstests@archiver.kernel.org>; Fri, 17 Jul 2020 05:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6C782071A
	for <linux-fstests@archiver.kernel.org>; Fri, 17 Jul 2020 05:46:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c6Moe9PV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725807AbgGQFqE (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 17 Jul 2020 01:46:04 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:58939 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgGQFqD (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 17 Jul 2020 01:46:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594964762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vq8VhqQgIZxoySgPlRAAF6LgxYCMMx1ItSzpCOtMHuc=;
        b=c6Moe9PVKjcjSMDHt+lKCCfcWpY14YNHL/MUEMJXLzZcvgc8TyaIkc4NGfUQ4Zy7Pcu/au
        m+V9XubDkNZeIWoh535eduKwJ9B7zhNnkuhnjLGuLnUe/TypeMRvAXe//mKz6cIKsyLRUo
        SohME2hGdqqG/Cmrirj3C/evlFwSUOM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-htJbtfZpPumhf6IY6TqPfw-1; Fri, 17 Jul 2020 01:46:00 -0400
X-MC-Unique: htJbtfZpPumhf6IY6TqPfw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B2CD9100A8E8;
        Fri, 17 Jul 2020 05:45:59 +0000 (UTC)
Received: from localhost (dhcp-12-102.nay.redhat.com [10.66.12.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2E57810013C4;
        Fri, 17 Jul 2020 05:45:58 +0000 (UTC)
Date:   Fri, 17 Jul 2020 13:58:53 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Murphy Zhou <jencce.kernel@gmail.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] generic/175, generic/176: cleanup testdir before exit
Message-ID: <20200717055853.GB1938@dhcp-12-102.nay.redhat.com>
Mail-Followup-To: Murphy Zhou <jencce.kernel@gmail.com>,
        fstests@vger.kernel.org
References: <20200717044017.1598-1-jencce.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717044017.1598-1-jencce.kernel@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Jul 17, 2020 at 12:40:17PM +0800, Murphy Zhou wrote:
> Usually the _mkfs helper will cleanup these directories at the
> beginning of testcase. However, when testing on NFS, the cleanup
> could be very slow and it is confusing that: We have already

The _scratch_mkfs logic for NFS is:
  [ -n "$SCRATCH_MNT" ] || return 1
  _scratch_mount
  rm -rf $SCRATCH_MNT/*
  _scratch_unmount

If you feel NFS is 'very slow', and isn't normal, you can check how
NFS is dealing with the reflink file of g/175.

> started to run generic/176 but we get stuck in _mkfs, cleaning
> up files left by the previous testcase generic/175.

Hmm... that makes more sense than above reason, although we generally
don't cleanup SCRATCH_MNT/* at the end of a case. Due to if you need to
cleanup SCRATCH_MNT/* for NFS, why only these 2 cases need to do that?
We might need a better reason/comment to explain, e.g. it cover a issue
of NFS?

BTW, the cleanup operation can be in _cleanup() function, likes:
  [ -d "$testdir" ] && rm -rf $testdir

Thanks,
Zorro

> 
> To be clear, cleanup testdir before exit. Also, deleting files
> should be part of the stress test.
> 
> Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
> ---
>  tests/generic/175 | 1 +
>  tests/generic/176 | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/tests/generic/175 b/tests/generic/175
> index 79e5b3d6..bd966a28 100755
> --- a/tests/generic/175
> +++ b/tests/generic/175
> @@ -61,6 +61,7 @@ bytes=$((blks * blksz))
>  echo "reflinking $blks blocks, $bytes bytes" >> "$seqres.full"
>  _reflink_range "$testdir/file1" 0 "$testdir/file2" 0 $bytes >> "$seqres.full"
>  
> +rm -rf $testdir
>  # success, all done
>  status=0
>  exit
> diff --git a/tests/generic/176 b/tests/generic/176
> index a084578a..bc83762e 100755
> --- a/tests/generic/176
> +++ b/tests/generic/176
> @@ -73,6 +73,7 @@ bytes=$((blocks_needed * blksz))
>  echo "reflinking $((blocks_needed / 2)) blocks, $((bytes / 2)) bytes" >> "$seqres.full"
>  _reflink_range "$testdir/file1" 0 "$testdir/file2" 0 $bytes >> "$seqres.full"
>  
> +rm -rf $testdir
>  # success, all done
>  status=0
>  exit
> -- 
> 2.20.1
> 

