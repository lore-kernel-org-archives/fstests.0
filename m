Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BEDDC0015E
	for <linux-fstests@archiver.kernel.org>; Thu, 27 Jul 2023 13:58:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233510AbjG0N6e (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 27 Jul 2023 09:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233507AbjG0N6d (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 27 Jul 2023 09:58:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A59E69
        for <fstests@vger.kernel.org>; Thu, 27 Jul 2023 06:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690466273;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5nEvv7chgyvMCWh3hGhvwnuUtz0kp+RYlbx94w8oY90=;
        b=ciuNKmfYxRLdv2fS+wnHTGNjPa12+9BSrWtwR2YNXopzJc4EjATZyaeH5XhcPgb0UOjRwC
        Mdx3i5xCdFRrVI4tEtP1di7rfiCaJqR41Yt0OWXUTg4i2aXoR/bSNE1HDixhqFJJECOasn
        +6XXR8FpneaEd5pOeCOHbXUbJqohqec=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-9GvA3MWdP9eYF5xXLP0Siw-1; Thu, 27 Jul 2023 09:57:50 -0400
X-MC-Unique: 9GvA3MWdP9eYF5xXLP0Siw-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1bbac333f2cso6036465ad.1
        for <fstests@vger.kernel.org>; Thu, 27 Jul 2023 06:57:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690466269; x=1691071069;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5nEvv7chgyvMCWh3hGhvwnuUtz0kp+RYlbx94w8oY90=;
        b=lPqOBGnI4VsRAfNl5iXMDSxizhUrs+tUp9LRidtnKQBK4UT9wjCaRU4F6+e0N5v8lI
         JPvbgZAv7eHmJ0DbMZAZcBY4LT8A2XThRx7gR2bPzfinlYvSUhAj7TYTQP1Gjs4uAp7B
         6gqnOtHQ9xM1uXfoMhuszF/cIBLVw7xT0BYSh+FaSfqwbDZq7fRMFqx5aacE3JPOCQ8g
         Bnz5KJDp5Aaui3Gn8Fb+qDXoDeQMGTPlb5fvKMgieCgr5FoETjOsfLEEgOhWhkAYnpEP
         QU3E8zyOcsvt4H3DIVBd4crLNuoyfvnRq/bnQ7L7TSY/+L/SuwcIcWcP3Vl4N/+FyRiK
         q0mw==
X-Gm-Message-State: ABy/qLZRO0lQp4B+QmnHj0UrARGQyVuTtSllBwuFFe68rfGLYuvfQgJ3
        8w7pUVK6hYasZQ0nW4l5V+mjuA2gFH9RtZ5290HeevQq2dQXvSy6j1q21Ap05ov78dzLGGHCbrV
        1iTgAjmYQRLv/OhQGdSlbs/x46dQvca4=
X-Received: by 2002:a17:902:e80f:b0:1b8:9ecd:8b86 with SMTP id u15-20020a170902e80f00b001b89ecd8b86mr4848718plg.5.1690466269058;
        Thu, 27 Jul 2023 06:57:49 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHqb3NPuiFjRG7z/G61xsVJ9OWrjesEHJh81WnYqkQ4ayhfGV3wUAd5/pw9boa1gjwKmGJR9Q==
X-Received: by 2002:a17:902:e80f:b0:1b8:9ecd:8b86 with SMTP id u15-20020a170902e80f00b001b89ecd8b86mr4848702plg.5.1690466268741;
        Thu, 27 Jul 2023 06:57:48 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id a9-20020a170902ee8900b001bbd8cf6b57sm1658993pld.230.2023.07.27.06.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 06:57:48 -0700 (PDT)
Date:   Thu, 27 Jul 2023 21:57:44 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 1/1] xfs/122: adjust test for flexarray conversions in 6.5
Message-ID: <20230727135744.nhmwpv7dxt5nvshd@zlang-mailbox>
References: <169033661482.3222297.18190312289773544342.stgit@frogsfrogsfrogs>
 <169033662042.3222297.14047592154027443561.stgit@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169033662042.3222297.14047592154027443561.stgit@frogsfrogsfrogs>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Jul 25, 2023 at 06:57:00PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Adjust the output of this test to handle the conversion of flexarray
> declaration conversions in 6.5.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---

Looks like it's about a49bbce58ea9 ("xfs: convert flex-array declarations
in xfs attr leaf blocks"). If you don't mind, I'd like to mention it in commit
log when I merge it :) This patch looks good to me,

Reviewed-by: Zorro Lang <zlang@redhat.com>

Thanks,
Zorro

>  tests/xfs/122 |    8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> 
> diff --git a/tests/xfs/122 b/tests/xfs/122
> index e616f1987d..ba927c77c4 100755
> --- a/tests/xfs/122
> +++ b/tests/xfs/122
> @@ -26,13 +26,21 @@ _wants_kernel_commit 03a7485cd701 \
>  _type_size_filter()
>  {
>  	# lazy SB adds __be32 agf_btreeblks - pv960372
> +	# flexarray conversion of the attr structures in Linux 6.5 changed
> +	# the sizeof output
>  	if [ "$($MKFS_XFS_PROG 2>&1 | grep -c lazy-count )" == "0" ]; then
>  		perl -ne '
>  s/sizeof\( xfs_agf_t \) = 60/sizeof( xfs_agf_t ) = <SIZE>/;
> +s/sizeof\(struct xfs_attr3_leafblock\) = 80/sizeof(struct xfs_attr3_leafblock) = 88/;
> +s/sizeof\(struct xfs_attr_shortform\) = 4/sizeof(struct xfs_attr_shortform) = 8/;
> +s/sizeof\(xfs_attr_leafblock_t\) = 32/sizeof(xfs_attr_leafblock_t) = 40/;
>  		print;'
>  	else
>  		perl -ne '
>  s/sizeof\( xfs_agf_t \) = 64/sizeof( xfs_agf_t ) = <SIZE>/;
> +s/sizeof\(struct xfs_attr3_leafblock\) = 80/sizeof(struct xfs_attr3_leafblock) = 88/;
> +s/sizeof\(struct xfs_attr_shortform\) = 4/sizeof(struct xfs_attr_shortform) = 8/;
> +s/sizeof\(xfs_attr_leafblock_t\) = 32/sizeof(xfs_attr_leafblock_t) = 40/;
>  		print;'
>  	fi
>  }
> 

