Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7427C433FE
	for <linux-fstests@archiver.kernel.org>; Thu, 17 Mar 2022 14:38:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235154AbiCQOj3 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 17 Mar 2022 10:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234010AbiCQOj2 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 17 Mar 2022 10:39:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EE0582726
        for <fstests@vger.kernel.org>; Thu, 17 Mar 2022 07:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647527884;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ytWkLUJlQ5JfxdSa9h1h3zvU2Toa1USYumwSF8WoJ/Q=;
        b=YOjQDTQ3ng6y9wz7dn0BwsYJ+paScQeLO9efBkQd38ijab7wcw1Lyb9dOLOqT0cplk7SyC
        l8gmNdZlvPf0yapUXgnIZhKdqHWHbZ31qZPlj/xUJeme5SE8vM+EwyZhLROCj64Apj/f6C
        7Trly9/vGO8IF2349tIh2aRX8TkK/PU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-577-F31jEcr_MaKNjJO0UCtaNQ-1; Thu, 17 Mar 2022 10:38:02 -0400
X-MC-Unique: F31jEcr_MaKNjJO0UCtaNQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6B7AF1066542
        for <fstests@vger.kernel.org>; Thu, 17 Mar 2022 14:38:02 +0000 (UTC)
Received: from work (unknown [10.40.193.231])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DB205C26E85;
        Thu, 17 Mar 2022 14:38:01 +0000 (UTC)
Date:   Thu, 17 Mar 2022 15:37:59 +0100
From:   Lukas Czerner <lczerner@redhat.com>
To:     Andrey Albershteyn <aalbersh@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] ext4/053: check that remount with abort makes fs
 read-only
Message-ID: <20220317143759.trcyjacqj6zt2s3v@work>
References: <20220310111810.14543-1-aalbersh@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310111810.14543-1-aalbersh@redhat.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi Andrey,

sorry I haven't notice it earlier. Feel free to cc me next time.

On Thu, Mar 10, 2022 at 12:18:11PM +0100, Andrey Albershteyn wrote:
> The 6e47a3cc68fc ("ext4: get rid of super block and sbi from
> handle_mount_ops()") broke abort mount option. That problem was not
> detected by ext4/053.
> 
> This addition test checks that during aborted remount, filesystem
> switches into read-only state (enabled by ext4_handle_error()
> causing mount to fail).
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> ---
>  tests/ext4/053 | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/tests/ext4/053 b/tests/ext4/053
> index e1e79592..38f162a9 100755
> --- a/tests/ext4/053
> +++ b/tests/ext4/053
> @@ -360,6 +360,10 @@ not_remount() {
>  	$UMOUNT_PROG $SCRATCH_MNT 2> /dev/null
>  }
>  
> +mnt_not_remount() {
> +	do_mnt
> +	not_remount -r $@

So you're only checking whether the remount failed with abort, but there
are more reasons for it to fail. Maybe we should also check the file
system is actually read only?

-Lukas

> +}
>  
>  do_mkfs() {
>  	$MKE2FS_PROG -T $fstype -Fq $* >> $seqres.full 2>&1 ||
> @@ -450,6 +454,7 @@ for fstype in ext2 ext3 ext4; do
>  	only_ext4 mnt nojournal_checksum
>  	only_ext4 mnt journal_async_commit,data=writeback
>  	mnt abort ignored
> +	mnt_not_remount abort ignored
>  	not_ext2 mnt -t data=journal
>  	not_ext2 mnt -t data=ordered
>  	not_ext2 mnt -t data=writeback
> -- 
> 2.27.0
> 

