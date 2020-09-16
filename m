Return-Path: <SRS0=FsZq=CZ=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE47C43461
	for <linux-fstests@archiver.kernel.org>; Wed, 16 Sep 2020 05:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DCC720936
	for <linux-fstests@archiver.kernel.org>; Wed, 16 Sep 2020 05:14:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i8zRFif6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbgIPFOQ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 16 Sep 2020 01:14:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57879 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726069AbgIPFOQ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 16 Sep 2020 01:14:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600233253;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eM6r46madIXqBRWq18hAyT7LxY+5cN+7lwbJnBs79DA=;
        b=i8zRFif6uUPLopvtitJLZAHSap7GPULhCA6BQIzp1WjwOG3A8xL7NLDF9GSnE8IdUUVDBz
        J6oodO9cOaAOZ35XGWEUraTZ0rbQi2tcV59C2eeCz30JWM/EvCa7KixivdUbzkcPpnPFVJ
        c0ppqM4+LmPnWJJHEmmzenViwWK4rVA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-WZcLtiOWPDGD5Klggv-kdw-1; Wed, 16 Sep 2020 01:14:09 -0400
X-MC-Unique: WZcLtiOWPDGD5Klggv-kdw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51007107464F
        for <fstests@vger.kernel.org>; Wed, 16 Sep 2020 05:14:08 +0000 (UTC)
Received: from localhost (dhcp-12-102.nay.redhat.com [10.66.12.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C0A8678809
        for <fstests@vger.kernel.org>; Wed, 16 Sep 2020 05:14:07 +0000 (UTC)
Date:   Wed, 16 Sep 2020 13:28:06 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     fstests@vger.kernel.org
Subject: Re: [PATCH 14/24] common/xfs: extract minimum log size message from
 mkfs correctly
Message-ID: <20200916052806.GD2937@dhcp-12-102.nay.redhat.com>
Mail-Followup-To: fstests@vger.kernel.org
References: <160013417420.2923511.6825722200699287884.stgit@magnolia>
 <160013426483.2923511.15242915902031465698.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160013426483.2923511.15242915902031465698.stgit@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Sep 14, 2020 at 06:44:24PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <darrick.wong@oracle.com>
> 
> Modify the command that searches for the minimum log size message from
> mkfs to handle external log devices correctly.
> 
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> ---

Good to me,
Reviewed-by: Zorro Lang <zlang@redhat.com>

>  common/xfs |    8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> 
> diff --git a/common/xfs b/common/xfs
> index f4a47dfb..6520ad29 100644
> --- a/common/xfs
> +++ b/common/xfs
> @@ -103,7 +103,7 @@ _scratch_find_xfs_min_logblocks()
>  	# try again without MKFS_OPTIONS because that's what _scratch_do_mkfs
>  	# will do if we pass in the log size option.
>  	if [ $mkfs_status -ne 0 ] &&
> -	   ! grep -q 'log size.*too small, minimum' $tmp.mkfserr; then
> +	   ! egrep -q '(log size.*too small, minimum|external log device.*too small, must be)' $tmp.mkfserr; then
>  		eval "$mkfs_cmd $extra_mkfs_options $SCRATCH_DEV" \
>  			2>$tmp.mkfserr 1>$tmp.mkfsstd
>  		mkfs_status=$?
> @@ -126,6 +126,12 @@ _scratch_find_xfs_min_logblocks()
>  		rm -f $tmp.mkfsstd $tmp.mkfserr
>  		return
>  	fi
> +	if grep -q 'external log device.*too small, must be' $tmp.mkfserr; then
> +		grep 'external log device.*too small, must be' $tmp.mkfserr | \
> +			sed -e 's/^.*must be at least \([0-9]*\) blocks/\1/g'
> +		rm -f $tmp.mkfsstd $tmp.mkfserr
> +		return
> +	fi
>  
>  	# Don't know what to do, so fail
>  	echo "Cannot determine minimum log size" >&2
> 

