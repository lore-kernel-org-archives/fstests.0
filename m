Return-Path: <SRS0=FsZq=CZ=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C22C43461
	for <linux-fstests@archiver.kernel.org>; Wed, 16 Sep 2020 20:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5610720715
	for <linux-fstests@archiver.kernel.org>; Wed, 16 Sep 2020 20:25:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E1Z0H/rx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbgIPUZR (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 16 Sep 2020 16:25:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39107 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727067AbgIPR1j (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 16 Sep 2020 13:27:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600277245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TcpXfm0TNTF1g84Eqf3UxdKZf2GYA94zn580KQ26wMQ=;
        b=E1Z0H/rxKvGoQ+ptTT/kfqggl+EnMlE/6ZbX0eVeGmEZ2C+czMiPH4C0FXdFfV9sIruUbM
        5jjiEfuvJVL8MuYlcz87Y802lMoti3/pmrHJgoCYOwnjlDBW/PoZnzx4FqNXpqLrVbpIan
        5TrSW/A4sy05IXf8xJfgTa7AFIICZB8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-u8NSzOwlPnenokA06Grfmw-1; Wed, 16 Sep 2020 07:48:53 -0400
X-MC-Unique: u8NSzOwlPnenokA06Grfmw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E14F810BBED5
        for <fstests@vger.kernel.org>; Wed, 16 Sep 2020 11:48:52 +0000 (UTC)
Received: from localhost (dhcp-12-102.nay.redhat.com [10.66.12.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5CE0F1975E
        for <fstests@vger.kernel.org>; Wed, 16 Sep 2020 11:48:52 +0000 (UTC)
Date:   Wed, 16 Sep 2020 20:02:51 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     fstests@vger.kernel.org
Subject: Re: [PATCH 21/24] common/rc: teach _scratch_mkfs_sized to set a size
 on an xfs realtime volume
Message-ID: <20200916120251.GL2937@dhcp-12-102.nay.redhat.com>
Mail-Followup-To: fstests@vger.kernel.org
References: <160013417420.2923511.6825722200699287884.stgit@magnolia>
 <160013430895.2923511.7033338053997588353.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160013430895.2923511.7033338053997588353.stgit@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Sep 14, 2020 at 06:45:08PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <darrick.wong@oracle.com>
> 
> Generally speaking, tests that call _scratch_mkfs_sized are trying to
> constrain a test's run time by formatting a filesystem that's smaller
> than the device.  The current helper does this for the scratch device,
> but it doesn't do this for the xfs realtime volume.
> 
> If fstests has been configured to create files on the realtime device by
> default ("-d rtinherit=1) then those tests that want to run with a small
> volume size will instead be running with a huge realtime device.  This
> makes certain tests take forever to run, so apply the same sizing to the
> rt volume if one exists.
> 
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> ---

Good to me,
Reviewed-by: Zorro Lang <zlang@redhat.com>

>  common/rc |   10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> 
> diff --git a/common/rc b/common/rc
> index f78b1cfc..b2d45fa2 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -976,14 +976,20 @@ _scratch_mkfs_sized()
>  	[ "$fssize" -gt "$devsize" ] && _notrun "Scratch device too small"
>      fi
>  
> +    if [ "$HOSTOS" == "Linux" ] && [ "$FSTYP" = "xfs" ] && [ -b "$SCRATCH_RTDEV" ]; then
> +	local rtdevsize=`blockdev --getsize64 $SCRATCH_RTDEV`
> +	[ "$fssize" -gt "$rtdevsize" ] && _notrun "Scratch rt device too small"
> +	rt_ops="-r size=$fssize"
> +    fi
> +
>      case $FSTYP in
>      xfs)
>  	# don't override MKFS_OPTIONS that set a block size.
>  	echo $MKFS_OPTIONS |egrep -q "b?size="
>  	if [ $? -eq 0 ]; then
> -		_scratch_mkfs_xfs -d size=$fssize
> +		_scratch_mkfs_xfs -d size=$fssize $rt_ops
>  	else
> -		_scratch_mkfs_xfs -d size=$fssize -b size=$blocksize
> +		_scratch_mkfs_xfs -d size=$fssize $rt_ops -b size=$blocksize
>  	fi
>  	;;
>      ext2|ext3|ext4|ext4dev)
> 

