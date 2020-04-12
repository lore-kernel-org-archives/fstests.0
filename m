Return-Path: <SRS0=6UmA=54=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87ED6C2BA2B
	for <linux-fstests@archiver.kernel.org>; Sun, 12 Apr 2020 06:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52C1520708
	for <linux-fstests@archiver.kernel.org>; Sun, 12 Apr 2020 06:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jJXS0k3k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725907AbgDLGx0 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 12 Apr 2020 02:53:26 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:45405 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725812AbgDLGx0 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 12 Apr 2020 02:53:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586674405;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3mj5hztC3/qo1QSULcOlmJhQj9vRNw4Ji2P4j8eoDPg=;
        b=jJXS0k3kHHiYnmKA7b9I2nygHo+rxOoQy0zB5SG4DkolGsuFNLiNx7QpMHg1pK+RTetf9l
        FxY6SKX/LxmKnYbMC7cNk9RB07hkSy/ZWi3nJn2fhKqdQ/VWQGviWipEDeKQBmro4XO8MO
        MO29CI8ip6kWu0h3XrZiwxIis4zh0e4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-82-EJgBuA9aM_OKSBIgTfgzTg-1; Sun, 12 Apr 2020 02:53:23 -0400
X-MC-Unique: EJgBuA9aM_OKSBIgTfgzTg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0FD94107ACCA;
        Sun, 12 Apr 2020 06:53:22 +0000 (UTC)
Received: from localhost (dhcp-12-102.nay.redhat.com [10.66.12.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 529A15D9CA;
        Sun, 12 Apr 2020 06:53:18 +0000 (UTC)
Date:   Sun, 12 Apr 2020 15:05:28 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Eric Sandeen <sandeen@redhat.com>
Cc:     fstests <fstests@vger.kernel.org>,
        Namjae Jeon <namjae.jeon@samsung.com>
Subject: Re: [PATCH 2/2] fstests: add _require_hardlinks for all necessary
 tests
Message-ID: <20200412070528.GX14282@dhcp-12-102.nay.redhat.com>
Mail-Followup-To: Eric Sandeen <sandeen@redhat.com>,
        fstests <fstests@vger.kernel.org>,
        Namjae Jeon <namjae.jeon@samsung.com>
References: <83a816c2-fa40-c63f-7709-35863d412ded@redhat.com>
 <39716adc-c4db-65b3-b3c1-866bf3517d7f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39716adc-c4db-65b3-b3c1-866bf3517d7f@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Apr 09, 2020 at 02:10:36PM -0500, Eric Sandeen wrote:
> Add a new _require function for hardlinks, to test hardlink support
> in all tests which need it.
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> ---
> 
> diff --git a/common/rc b/common/rc
> index 476d3d07..8bb9aa1f 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3493,6 +3493,18 @@ _require_symlinks()
>  	rm -f $target $link
>  }
>  
> +_require_hardlinks()
> +{
> +	local target=`mktemp -p $TEST_DIR`
> +	local link=`mktemp -p $TEST_DIR -u`
> +	ln `basename $target` $link

I really doubt if it works. Why we need the basename of the $target? It cause we
create a link in *current* directory, and the current directory isn't the
$TEST_DIR.

The _require_symlinks won't fail due to symlink can be created cross filesystems,
but hardlink can't. But that's not the _require_symlinks want to test, right?

So why we need the basename? Please correct me if I'm wrong.

Thanks,
Zorro

> +	if [ "$?" -ne 0 ]; then
> +		rm -f $target
> +		_notrun "No hardlink support"
> +	fi
> +	rm -f $target $link
> +}
> +
>  _require_test_fcntl_advisory_locks()
>  {
>  	[ "$FSTYP" != "cifs" ] && return 0
> diff --git a/tests/generic/002 b/tests/generic/002
> index 575ac42b..480b77bc 100755
> --- a/tests/generic/002
> +++ b/tests/generic/002
> @@ -28,6 +28,7 @@ _cleanup()
>  _supported_fs generic
>  _supported_os Linux
>  _require_test
> +_require_hardlinks
>  
>  rm -f $seqres.full
>  
> diff --git a/tests/generic/039 b/tests/generic/039
> index daa2e353..27cd6bf5 100755
> --- a/tests/generic/039
> +++ b/tests/generic/039
> @@ -39,6 +39,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>  _supported_fs generic
>  _supported_os Linux
>  _require_scratch
> +_require_hardlinks
>  _require_dm_target flakey
>  
>  rm -f $seqres.full
> diff --git a/tests/generic/040 b/tests/generic/040
> index 712ae595..b69d8127 100755
> --- a/tests/generic/040
> +++ b/tests/generic/040
> @@ -44,6 +44,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>  _supported_fs generic
>  _supported_os Linux
>  _require_scratch
> +_require_hardlinks
>  _require_dm_target flakey
>  
>  rm -f $seqres.full
> diff --git a/tests/generic/041 b/tests/generic/041
> index 8001e8ce..1674d544 100755
> --- a/tests/generic/041
> +++ b/tests/generic/041
> @@ -48,6 +48,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>  _supported_fs generic
>  _supported_os Linux
>  _require_scratch
> +_require_hardlinks
>  _require_dm_target flakey
>  
>  rm -f $seqres.full
> diff --git a/tests/generic/056 b/tests/generic/056
> index 9caf1166..28920d36 100755
> --- a/tests/generic/056
> +++ b/tests/generic/056
> @@ -37,6 +37,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>  _supported_fs generic
>  _supported_os Linux
>  _require_scratch
> +_require_hardlinks
>  _require_dm_target flakey
>  
>  rm -f $seqres.full
> diff --git a/tests/generic/057 b/tests/generic/057
> index ba51dbb9..91e1d98e 100755
> --- a/tests/generic/057
> +++ b/tests/generic/057
> @@ -37,6 +37,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>  _supported_fs generic
>  _supported_os Linux
>  _require_scratch
> +_require_hardlinks
>  _require_dm_target flakey
>  
>  rm -f $seqres.full
> diff --git a/tests/generic/065 b/tests/generic/065
> index d6a1670b..30f3c32e 100755
> --- a/tests/generic/065
> +++ b/tests/generic/065
> @@ -38,6 +38,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>  _supported_fs generic
>  _supported_os Linux
>  _require_scratch
> +_require_hardlinks
>  _require_dm_target flakey
>  
>  rm -f $seqres.full
> diff --git a/tests/generic/089 b/tests/generic/089
> index 3d608269..52649596 100755
> --- a/tests/generic/089
> +++ b/tests/generic/089
> @@ -36,6 +36,7 @@ addentries()
>  _supported_fs generic
>  _supported_os Linux
>  _require_test
> +_require_hardlinks
>  
>  rm -f $seqres.full
>  [ "X$TEST_DIR" = "X" ] && exit 1
> diff --git a/tests/generic/090 b/tests/generic/090
> index bf38d1c8..db1aeef3 100755
> --- a/tests/generic/090
> +++ b/tests/generic/090
> @@ -36,6 +36,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>  _supported_fs generic
>  _supported_os Linux
>  _require_scratch
> +_require_hardlinks
>  _require_dm_target flakey
>  
>  rm -f $seqres.full
> diff --git a/tests/generic/104 b/tests/generic/104
> index d78689f4..4b6256db 100755
> --- a/tests/generic/104
> +++ b/tests/generic/104
> @@ -31,6 +31,7 @@ _cleanup()
>  _supported_fs generic
>  _supported_os Linux
>  _require_scratch
> +_require_hardlinks
>  _require_dm_target flakey
>  
>  rm -f $seqres.full
> diff --git a/tests/generic/106 b/tests/generic/106
> index 74d5dc30..e1c859e5 100755
> --- a/tests/generic/106
> +++ b/tests/generic/106
> @@ -30,6 +30,7 @@ _cleanup()
>  _supported_fs generic
>  _supported_os Linux
>  _require_scratch
> +_require_hardlinks
>  _require_dm_target flakey
>  
>  rm -f $seqres.full
> diff --git a/tests/generic/107 b/tests/generic/107
> index 5c6bbfca..214f3389 100755
> --- a/tests/generic/107
> +++ b/tests/generic/107
> @@ -33,6 +33,7 @@ _cleanup()
>  _supported_fs generic
>  _supported_os Linux
>  _require_scratch
> +_require_hardlinks
>  _require_dm_target flakey
>  
>  rm -f $seqres.full
> diff --git a/tests/generic/236 b/tests/generic/236
> index f207165f..2110b053 100755
> --- a/tests/generic/236
> +++ b/tests/generic/236
> @@ -25,8 +25,8 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>  
>  # real QA test starts here
>  _supported_fs generic
> -# only Linux supports fallocate
>  _supported_os Linux
> +_require_hardlinks
>  _require_test
>  
>  rm -f $TEST_DIR/ouch*
> diff --git a/tests/generic/336 b/tests/generic/336
> index e007552c..6832ccde 100755
> --- a/tests/generic/336
> +++ b/tests/generic/336
> @@ -32,6 +32,7 @@ _cleanup()
>  _supported_fs generic
>  _supported_os Linux
>  _require_scratch
> +_require_hardlinks
>  _require_dm_target flakey
>  
>  rm -f $seqres.full
> diff --git a/tests/generic/343 b/tests/generic/343
> index e35488dd..2034197e 100755
> --- a/tests/generic/343
> +++ b/tests/generic/343
> @@ -32,6 +32,7 @@ _cleanup()
>  _supported_fs generic
>  _supported_os Linux
>  _require_scratch
> +_require_hardlinks
>  _require_dm_target flakey
>  
>  rm -f $seqres.full
> diff --git a/tests/generic/378 b/tests/generic/378
> index 393d1ce7..ea776949 100755
> --- a/tests/generic/378
> +++ b/tests/generic/378
> @@ -39,6 +39,7 @@ _supported_fs generic
>  _supported_os Linux
>  _require_test
>  _require_user
> +_require_hardlinks
>  
>  # Setup testfile and its hardlink
>  testfile=$TEST_DIR/testfile.$seq
> diff --git a/tests/generic/480 b/tests/generic/480
> index ba2c34ad..63a87519 100755
> --- a/tests/generic/480
> +++ b/tests/generic/480
> @@ -32,6 +32,7 @@ _cleanup()
>  _supported_fs generic
>  _supported_os Linux
>  _require_scratch
> +_require_hardlinks
>  _require_dm_target flakey
>  
>  rm -f $seqres.full
> diff --git a/tests/generic/498 b/tests/generic/498
> index 71f5091c..7adf0b32 100755
> --- a/tests/generic/498
> +++ b/tests/generic/498
> @@ -31,6 +31,7 @@ _cleanup()
>  _supported_fs generic
>  _supported_os Linux
>  _require_scratch
> +_require_hardlinks
>  _require_dm_target flakey
>  
>  rm -f $seqres.full
> diff --git a/tests/generic/502 b/tests/generic/502
> index a60ac9a7..a49ee0b3 100755
> --- a/tests/generic/502
> +++ b/tests/generic/502
> @@ -34,6 +34,7 @@ _cleanup()
>  _supported_fs generic
>  _supported_os Linux
>  _require_scratch
> +_require_hardlinks
>  _require_dm_target flakey
>  
>  rm -f $seqres.full
> diff --git a/tests/generic/526 b/tests/generic/526
> index d0b51f87..934d263f 100755
> --- a/tests/generic/526
> +++ b/tests/generic/526
> @@ -32,6 +32,7 @@ _cleanup()
>  _supported_fs generic
>  _supported_os Linux
>  _require_scratch
> +_require_hardlinks
>  _require_dm_target flakey
>  
>  rm -f $seqres.full
> diff --git a/tests/generic/527 b/tests/generic/527
> index 61dd4f0b..4b664da9 100755
> --- a/tests/generic/527
> +++ b/tests/generic/527
> @@ -32,6 +32,7 @@ _cleanup()
>  _supported_fs generic
>  _supported_os Linux
>  _require_scratch
> +_require_hardlinks
>  _require_dm_target flakey
>  
>  rm -f $seqres.full
> 

