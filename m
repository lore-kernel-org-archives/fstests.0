Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D81D7C47091
	for <linux-fstests@archiver.kernel.org>; Sun, 30 May 2021 12:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2452610CB
	for <linux-fstests@archiver.kernel.org>; Sun, 30 May 2021 12:54:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbhE3Mzu (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 30 May 2021 08:55:50 -0400
Received: from out20-50.mail.aliyun.com ([115.124.20.50]:52819 "EHLO
        out20-50.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbhE3Mzu (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 30 May 2021 08:55:50 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1011759|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.476762-0.00580034-0.517438;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047199;MF=guan@eryu.me;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.KKvs3vX_1622379250;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.KKvs3vX_1622379250)
          by smtp.aliyun-inc.com(10.147.40.233);
          Sun, 30 May 2021 20:54:11 +0800
Date:   Sun, 30 May 2021 20:54:10 +0800
From:   Eryu Guan <guan@eryu.me>
To:     David Howells <dhowells@redhat.com>
Cc:     fstests@vger.kernel.org, linux-afs@lists.infradead.org
Subject: Re: [PATCH 6/9] Add the ability to require O_TMPFILE to be supported
 for a test
Message-ID: <YLOK8qUjF4Pmw+/Z@desktop>
References: <162194962878.4011860.5561077785368723619.stgit@warthog.procyon.org.uk>
 <162194966940.4011860.15702357969023449902.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162194966940.4011860.15702357969023449902.stgit@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, May 25, 2021 at 02:34:29PM +0100, David Howells wrote:
> Provide a '_require_o_tmpfile' clause so that a test can require than
> O_TMPFILE be supported by the filesystem being tested.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: linux-afs@lists.infradead.org
> ---
> 
>  common/rc                    |    9 +++++++++
>  doc/requirement-checking.txt |    7 +++++++
>  tests/generic/531            |    1 +
>  3 files changed, 17 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index e25967d9..c0659215 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -4640,6 +4640,15 @@ _require_unix_perm_checking()
>  	esac
>  }
>  
> +_require_o_tmpfile()
> +{
> +	case $FSTYP in
> +	afs)
> +		_notrun "O_TMPFILE is not supported on $FSTYP"
> +		;;
> +	esac
> +}
> +

We could use _require_xfs_io_command "-T" to check if O_TMPFILE is
supported or not.

Thanks,
Eryu

>  init_rc
>  
>  ################################################################################
> diff --git a/doc/requirement-checking.txt b/doc/requirement-checking.txt
> index 9be7a84c..b708887b 100644
> --- a/doc/requirement-checking.txt
> +++ b/doc/requirement-checking.txt
> @@ -21,6 +21,7 @@ they have.  This is done with _require_<xxx> macros, which may take parameters.
>  	_require_sgid_inheritance
>  	_require_use_local_uidgid
>  	_require_unix_perm_checking
> +	_require_o_tmpfile
>  
>   (3) System call requirements.
>  
> @@ -129,6 +130,12 @@ _require_unix_perm_checking
>       some alternative distributed permissions model involving authentication
>       tokens rather than the local fsuid/fsgid.
>  
> +_require_o_tmpfile
> +
> +     The test requires that O_TMPFILE is supported by open() on that
> +     filesystem, thereby allowing the creation of temporary files to be used or
> +     tested.
> +
>  
>  ========================
>  SYSTEM CALL REQUIREMENTS
> diff --git a/tests/generic/531 b/tests/generic/531
> index e76418ca..2f3b1dc6 100755
> --- a/tests/generic/531
> +++ b/tests/generic/531
> @@ -32,6 +32,7 @@ _cleanup()
>  _supported_fs generic
>  _require_scratch
>  _require_test_program "t_open_tmpfiles"
> +_require_o_tmpfile
>  
>  rm -f $seqres.full
>  _scratch_mkfs >> $seqres.full 2>&1
> 
