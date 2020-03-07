Return-Path: <SRS0=YIgP=4Y=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC1CC10F00
	for <linux-fstests@archiver.kernel.org>; Sat,  7 Mar 2020 14:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D308920675
	for <linux-fstests@archiver.kernel.org>; Sat,  7 Mar 2020 14:03:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LnWgAetb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbgCGODj (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 7 Mar 2020 09:03:39 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22627 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726065AbgCGODj (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 7 Mar 2020 09:03:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583589817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G/P85fJKBkQWG81EYwS+mUfLMSlUhLYueqWnlhlMutA=;
        b=LnWgAetbumsZvPR/nzu3ZKARfHmpakO46xw0E4v/xapYT/163PWnRQKqpMvHPnyAgv3M5U
        C/wd+LxCdEEaZfBbq4DZHVlc3dzoKibh/sJtIDgjGFQ06+CFiZkOqM1spBWzlO0g/zi/qc
        DE/zkwmOy0/SN3MP0xjRCwcTTxF8ggw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-E79gUjiSONSvYlNXNUYjDQ-1; Sat, 07 Mar 2020 09:03:35 -0500
X-MC-Unique: E79gUjiSONSvYlNXNUYjDQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 771E9DB61;
        Sat,  7 Mar 2020 14:03:34 +0000 (UTC)
Received: from localhost (dhcp-12-102.nay.redhat.com [10.66.12.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E51695DA82;
        Sat,  7 Mar 2020 14:03:33 +0000 (UTC)
Date:   Sat, 7 Mar 2020 22:14:30 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Anthony Iliopoulos <ailiopoulos@suse.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v2] xfs/513: fix allocsize on archs with pagesize larger
 than blocksize
Message-ID: <20200307141430.GC14282@dhcp-12-102.nay.redhat.com>
Mail-Followup-To: Anthony Iliopoulos <ailiopoulos@suse.com>,
        fstests@vger.kernel.org
References: <20200307105457.24688-1-ailiopoulos@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200307105457.24688-1-ailiopoulos@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sat, Mar 07, 2020 at 11:54:57AM +0100, Anthony Iliopoulos wrote:
> The minimum accepted allocsize mount option value is page size, which
> causes the particular test to fail in architectures where page size >
> block size. Fix it by basing the value on the platform page size rather
> than the block size as obtained from mkfs. In addition add a filter so
> that different values can be used without breaking the golden output.
> 
> Signed-off-by: Anthony Iliopoulos <ailiopoulos@suse.com>
> ---

Looks good to me.

Reviewed-by: Zorro Lang <zlang@redhat.com>

> 
> Changes from v1 -> v2:
> 
> - renamed filter_pagesz to filter_xfs_opt
> - renamed PAGE_SIZE to PAGESIZE
> 
>  tests/xfs/513     | 14 ++++++++++----
>  tests/xfs/513.out |  2 +-
>  2 files changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/tests/xfs/513 b/tests/xfs/513
> index 70bc2f1c..094d0c6c 100755
> --- a/tests/xfs/513
> +++ b/tests/xfs/513
> @@ -68,6 +68,11 @@ filter_loop()
>  	    -e "s,\B$LOOP_SPARE_DEV,LOOP_SPARE_DEV,g"
>  }
>  
> +filter_xfs_opt()
> +{
> +	sed -e "s,allocsize=$pagesz,allocsize=PAGESIZE,g"
> +}
> +
>  # avoid the effection from MKFS_OPTIONS
>  MKFS_OPTIONS=""
>  do_mkfs()
> @@ -165,7 +170,7 @@ do_test()
>  	# Print each argument, include nil ones
>  	echo -n "TEST:" | tee -a $seqres.full
>  	for i in "$@";do
> -		echo -n " \"$i\"" | filter_loop | tee -a $seqres.full
> +		echo -n " \"$i\"" | filter_loop | filter_xfs_opt | tee -a $seqres.full
>  	done
>  	echo | tee -a $seqres.full
>  
> @@ -180,11 +185,12 @@ echo "** start xfs mount testing ..."
>  # Test allocsize=size
>  # Valid values for this option are page size (typically 4KiB) through to 1GiB
>  do_mkfs
> -if [ $dbsize -ge 1024 ];then
> -	blsize="$((dbsize / 1024))k"
> +pagesz=$(get_page_size)
> +if [ $pagesz -ge 1024 ];then
> +	pagesz="$((pagesz / 1024))k"
>  fi
>  do_test "" pass "allocsize" "false"
> -do_test "-o allocsize=$blsize" pass "allocsize=$blsize" "true"
> +do_test "-o allocsize=$pagesz" pass "allocsize=$pagesz" "true"
>  do_test "-o allocsize=1048576k" pass "allocsize=1048576k" "true"
>  do_test "-o allocsize=$((dbsize / 2))" fail
>  do_test "-o allocsize=2g" fail
> diff --git a/tests/xfs/513.out b/tests/xfs/513.out
> index 9be18dd8..6681a7e8 100644
> --- a/tests/xfs/513.out
> +++ b/tests/xfs/513.out
> @@ -5,7 +5,7 @@ QA output created by 513
>  ** start xfs mount testing ...
>  FORMAT: 
>  TEST: "" "pass" "allocsize" "false"
> -TEST: "-o allocsize=4k" "pass" "allocsize=4k" "true"
> +TEST: "-o allocsize=PAGESIZE" "pass" "allocsize=PAGESIZE" "true"
>  TEST: "-o allocsize=1048576k" "pass" "allocsize=1048576k" "true"
>  TEST: "-o allocsize=2048" "fail"
>  TEST: "-o allocsize=2g" "fail"
> -- 
> 2.16.4
> 

