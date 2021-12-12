Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA790C433F5
	for <linux-fstests@archiver.kernel.org>; Sun, 12 Dec 2021 14:02:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbhLLOCK (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 12 Dec 2021 09:02:10 -0500
Received: from out20-110.mail.aliyun.com ([115.124.20.110]:47378 "EHLO
        out20-110.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbhLLOCI (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 12 Dec 2021 09:02:08 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.0891674|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00694908-3.02245e-05-0.993021;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047212;MF=guan@eryu.me;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.MAmgkFk_1639317726;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.MAmgkFk_1639317726)
          by smtp.aliyun-inc.com(10.147.41.120);
          Sun, 12 Dec 2021 22:02:06 +0800
Date:   Sun, 12 Dec 2021 22:02:06 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     fstests@vger.kernel.org, Luis Henriques <lhenriques@suse.de>
Subject: Re: [fstests PATCH] ceph: don't run tests if we can't set a custom
 layout
Message-ID: <YbYA3k3osjOy7VZq@desktop>
References: <20211207160437.184145-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207160437.184145-1-jlayton@kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Dec 07, 2021 at 11:04:37AM -0500, Jeff Layton wrote:
> Some of the coming fscrypt patches prohibit non-default layout changes.
> Skip running the tests that set custom layouts if setting the layout fails.
> 
> Cc: Luis Henriques <lhenriques@suse.de>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  common/ceph | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/common/ceph b/common/ceph
> index ca756dda8dd3..31b169af51b8 100644
> --- a/common/ceph
> +++ b/common/ceph
> @@ -19,7 +19,7 @@ _ceph_create_file_layout()
>  	touch $fname
>  	$SETFATTR_PROG -n ceph.file.layout \
>  		-v "stripe_unit=$objsz stripe_count=1 object_size=$objsz" \
> -		$fname
> +		$fname || _notrun "setting ceph.file.layout failed"
>  }

IMO _ceph_create_file_layout() is a helper function that does the real
work, i.e. either prepares the test or does the test, not a function to
check if current env & setup meets what the test needs.

So I think it's better to check the ability to change layout explicitly
in a new _require rule. e.g. something like _require_ceph_change_layout?

Thanks,
Eryu

>  
>  # this test requires to access file capabilities through vxattr 'ceph.caps'.
> -- 
> 2.33.1
