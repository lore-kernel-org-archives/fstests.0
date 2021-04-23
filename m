Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F98C433B4
	for <linux-fstests@archiver.kernel.org>; Fri, 23 Apr 2021 11:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8159261027
	for <linux-fstests@archiver.kernel.org>; Fri, 23 Apr 2021 11:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242152AbhDWLO1 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 23 Apr 2021 07:14:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24689 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229807AbhDWLO1 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 23 Apr 2021 07:14:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619176431;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KyK5x2HI9BnGtcUBCjAZql/acv7bJIvwWa19mgYQ/uM=;
        b=UuBqtFGb6oVk4EqmjBTSmgENWasrTyw2lDpIloSv3QeUsVEpAaJprDA0RoCzoe0socVabl
        bQliFqOqQsjjRWp4YJtfrKo3xbvwpBshLgkj8kr9yCVWD62ZT4TGYW2STha5v2KQdd7856
        F03zSteirRU6R+Mln97PJsL7uI0dsZg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-LzpiVO94ONO_KeU6e_idsw-1; Fri, 23 Apr 2021 07:13:49 -0400
X-MC-Unique: LzpiVO94ONO_KeU6e_idsw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 254EB107ACC7;
        Fri, 23 Apr 2021 11:13:48 +0000 (UTC)
Received: from bfoster (ovpn-112-25.rdu2.redhat.com [10.10.112.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CA6F719D9B;
        Fri, 23 Apr 2021 11:13:47 +0000 (UTC)
Date:   Fri, 23 Apr 2021 07:13:46 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Yang Xu <xuyang2018.jy@fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] xfs/144: Use _qsetup instead of qsetup
Message-ID: <YIKr6oLDlYZMrHwt@bfoster>
References: <1619151838-22476-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1619151838-22476-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Apr 23, 2021 at 12:23:58PM +0800, Yang Xu wrote:
> Since xfstests commit 56908a2eb566c5("common/quota: move _qsetup() helper to common code"),
> we have common _qsetup function. Even this case doesn't use enforce value like xfs/050 and xfs/299,
> using _qsetup is more meaningful. So remove useless qsetup.
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---

Reviewed-by: Brian Foster <bfoster@redhat.com>

>  tests/xfs/144 | 21 +--------------------
>  1 file changed, 1 insertion(+), 20 deletions(-)
> 
> diff --git a/tests/xfs/144 b/tests/xfs/144
> index c5995cc5..74988090 100755
> --- a/tests/xfs/144
> +++ b/tests/xfs/144
> @@ -38,25 +38,6 @@ _require_scratch
>  
>  rm -f $seqres.full
>  
> -qsetup()
> -{
> -	opt=$1
> -	enforce=0
> -	if [ $opt = "u" -o $opt = "uno" ]; then
> -		type=u
> -		eval `_choose_uid`
> -	elif [ $opt = "g" -o $opt = "gno" ]; then
> -		type=g
> -		eval `_choose_gid`
> -	elif [ $opt = "p" -o $opt = "pno" ]; then
> -		type=p
> -		eval `_choose_prid`
> -	fi
> -	[ $opt = "u" -o $opt = "g" -o $opt = "p" ] && enforce=1
> -
> -	echo "Using type=$type id=$id" >> $seqres.full
> -}
> -
>  exercise() {
>  	_scratch_mkfs_xfs | _filter_mkfs 2>$tmp.mkfs
>  	cat $tmp.mkfs >>$seqres.full
> @@ -66,7 +47,7 @@ exercise() {
>  
>  	_qmount
>  
> -	qsetup $1
> +	_qsetup $1
>  
>  	echo "Using type=$type id=$id" >>$seqres.full
>  
> -- 
> 2.23.0
> 

