Return-Path: <SRS0=vNf0=5C=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E3A9C10F29
	for <linux-fstests@archiver.kernel.org>; Tue, 17 Mar 2020 10:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02EFB20658
	for <linux-fstests@archiver.kernel.org>; Tue, 17 Mar 2020 10:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pej2YiH3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725794AbgCQKoi (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 17 Mar 2020 06:44:38 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:25087 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725730AbgCQKoi (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 17 Mar 2020 06:44:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584441877;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AZJ2FD+pXvfbjkf9zMza/xmJE6rP42y7AT4+bw3BRmU=;
        b=Pej2YiH3hDm4zWy+rnw6W/PU29flwRek/Isr+yDiyzs97q8PUJpUadquWgHdB/xIlGwgPo
        5EmQ/0BKF5dkPRzlFTiICh33ejOkv4pCh/TDoSYSyF4AY5ZrcD0O1QhJUHqesFrg+6arrb
        jaILV37g97Xfr2wW0S4NChvtPDty3d0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-JiDge3kPOX-qMgjZGg22Iw-1; Tue, 17 Mar 2020 06:44:35 -0400
X-MC-Unique: JiDge3kPOX-qMgjZGg22Iw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0E6CF100550D;
        Tue, 17 Mar 2020 10:44:34 +0000 (UTC)
Received: from localhost (dhcp-12-102.nay.redhat.com [10.66.12.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7EF901001DC0;
        Tue, 17 Mar 2020 10:44:32 +0000 (UTC)
Date:   Tue, 17 Mar 2020 18:55:44 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Paulo Alcantara (SUSE)" <pc@cjr.nz>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] generic/310: slightly improve check for dmesg error
Message-ID: <20200317105544.GF14282@dhcp-12-102.nay.redhat.com>
Mail-Followup-To: "Paulo Alcantara (SUSE)" <pc@cjr.nz>,
        fstests@vger.kernel.org
References: <20200317015439.7406-1-pc@cjr.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200317015439.7406-1-pc@cjr.nz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Mar 16, 2020 at 10:54:39PM -0300, Paulo Alcantara (SUSE) wrote:
> The 'grep -c "error"' check was causing false positive results for
> cifs.ko when running it with 'echo 1 > /proc/fs/cifs/cifsFYI'.
> 
> That is, the test would fail when cifs.ko prints out a non-error
> message like this:
> 
>   [ 2320.903987] fs/cifs/smb2maperror.c: Mapping SMB2 status code
>   0x80000006 to POSIX err -61
> 
> Signed-off-by: Paulo Alcantara (SUSE) <pc@cjr.nz>
> ---
>  tests/generic/310 | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/generic/310 b/tests/generic/310
> index 1fcd517e4e6f..504f7c44c177 100755
> --- a/tests/generic/310
> +++ b/tests/generic/310
> @@ -49,7 +49,7 @@ _require_command "$KILLALL_PROG" killall
>  dmesg -c > /dev/null
>  
>  nr_bug=`dmesg | grep -c "kernel BUG"`
> -nr_error=`dmesg | grep -c "error"`
> +nr_error=`dmesg | grep -c "EXT[234]-fs error"`

This's a generic test, which is not only for extN filesystem. If only for
"fs/cifs/smb2maperror.c: Mapping SMB2 status ...", how about:
   grep -wc "error"
or
   grep -c "\berror"

or something better:)

I think it still works for "EXT3-fs error (device loop1): ext3_readdir:
bad entry in ....".

Thanks,
Zorro

>  nr_null=`dmesg | grep -c "kernel NULL pointer dereference"`
>  nr_warning=`dmesg | grep -c "^WARNING"`
>  nr_lockdep=`dmesg | grep -c "possible recursive locking detected"`
> @@ -58,7 +58,7 @@ nr_lockdep=`dmesg | grep -c "possible recursive locking detected"`
>  check_kernel_bug()
>  {
>  	new_bug=`dmesg | grep -c "kernel BUG"`
> -	new_error=`dmesg | grep -c "error"`
> +	new_error=`dmesg | grep -c "EXT[234]-fs error"`
>  	new_null=`dmesg | grep -c "kernel NULL pointer dereference"`
>  	new_warning=`dmesg | grep -c "^WARNING"`
>  	new_lockdep=`dmesg | grep -c "possible recursive locking detected"`
> -- 
> 2.25.1
> 

