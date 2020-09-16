Return-Path: <SRS0=FsZq=CZ=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A60C43461
	for <linux-fstests@archiver.kernel.org>; Wed, 16 Sep 2020 02:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B8E420936
	for <linux-fstests@archiver.kernel.org>; Wed, 16 Sep 2020 02:07:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bfVBwC7Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgIPCHx (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 15 Sep 2020 22:07:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38230 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726069AbgIPCHx (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 15 Sep 2020 22:07:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600222071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4xYyTyYlH8aP/oQndhWrgvJOcr8HiDIrObAlMAZuFpU=;
        b=bfVBwC7ZYm4snsge/4GHMUXMz9UbxTEVGz9j9BZ1be6OX+ANjk4veRp5gUjd7tS4hEoOQx
        RhwoffwLV6dXgII8EvxsA9LvXQLBD9qkWfS/HUx/8jxvx3/U2vQcbsz5B3nEvKOcTYR34i
        clYXa04It/HgeuIYuLHVCXvGf+ycpSg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-590-e3qogw96Ox-yOYY8tyUUXw-1; Tue, 15 Sep 2020 22:07:49 -0400
X-MC-Unique: e3qogw96Ox-yOYY8tyUUXw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF8071084C86
        for <fstests@vger.kernel.org>; Wed, 16 Sep 2020 02:07:48 +0000 (UTC)
Received: from localhost (dhcp-12-102.nay.redhat.com [10.66.12.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 49BB3610AF
        for <fstests@vger.kernel.org>; Wed, 16 Sep 2020 02:07:48 +0000 (UTC)
Date:   Wed, 16 Sep 2020 10:21:46 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     fstests@vger.kernel.org
Subject: Re: [PATCH 05/24] xfs/031: make sure we don't set rtinherit=1 on mkfs
Message-ID: <20200916022146.GW2937@dhcp-12-102.nay.redhat.com>
Mail-Followup-To: fstests@vger.kernel.org
References: <160013417420.2923511.6825722200699287884.stgit@magnolia>
 <160013420779.2923511.9462939883966946313.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160013420779.2923511.9462939883966946313.stgit@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Sep 14, 2020 at 06:43:27PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <darrick.wong@oracle.com>
> 
> mkfs.xfs does not support setting rtinherit on the root directory /and/
> pre-populating the filesystem with protofiles, so don't run this test if
> rtinherit is in the mkfs options.
> 
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> ---

Good to me,
Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/xfs/019 |    5 +++++
>  tests/xfs/031 |    5 +++++
>  2 files changed, 10 insertions(+)
> 
> 
> diff --git a/tests/xfs/019 b/tests/xfs/019
> index f42b62bb..aa5365e7 100755
> --- a/tests/xfs/019
> +++ b/tests/xfs/019
> @@ -51,6 +51,11 @@ _supported_os Linux
>  
>  _require_scratch
>  
> +# mkfs cannot create a filesystem with protofiles if realtime is enabled, so
> +# don't run this test if the rtinherit is anywhere in the mkfs options.
> +echo "$MKFS_OPTIONS" | grep -q "rtinherit" && \
> +	_notrun "Cannot mkfs with a protofile and -d rtinherit."
> +
>  protofile=$tmp.proto
>  tempfile=$tmp.file
>  
> diff --git a/tests/xfs/031 b/tests/xfs/031
> index 6403fd40..671b6727 100755
> --- a/tests/xfs/031
> +++ b/tests/xfs/031
> @@ -81,6 +81,11 @@ _supported_os Linux
>  _require_scratch
>  _require_no_large_scratch_dev
>  
> +# mkfs cannot create a filesystem with protofiles if realtime is enabled, so
> +# don't run this test if the rtinherit is anywhere in the mkfs options.
> +echo "$MKFS_OPTIONS" | grep -q "rtinherit" && \
> +	_notrun "Cannot mkfs with a protofile and -d rtinherit."
> +
>  # sanity test - default + one root directory entry
>  # Note: must do this proto/mkfs now for later inode size calcs
>  _create_proto 0
> 

