Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC4ADC4338F
	for <linux-fstests@archiver.kernel.org>; Wed,  4 Aug 2021 16:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A622A60C41
	for <linux-fstests@archiver.kernel.org>; Wed,  4 Aug 2021 16:48:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239632AbhHDQsw (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 4 Aug 2021 12:48:52 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:32412 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239441AbhHDQsw (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 4 Aug 2021 12:48:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1628095720; x=1659631720;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject;
  bh=GJEhl8NrSKC7AsnGI5BcJJA/vI56xWAbZGPX7Dfev6U=;
  b=faHDPwT+GfTBoWtvG8ndgq1uEUK7HhoJMYnyoFCFuau3XqMtx72aOGQI
   qbux0vTfuUJnN3Vh2GFqD0zPvxa9aNJzdaMQGRJ+TmLuCUGeltA15G8Bm
   h0P3OHBxIybngRr/N/idfwgjjhe8Y1tZi0KMs+HYJrqxTMY0dpJoFNZBX
   g=;
X-IronPort-AV: E=Sophos;i="5.84,295,1620691200"; 
   d="scan'208";a="130161077"
Subject: Re: [PATCH] common/attr: remove the MAX_ATTRS and MAX_ATTRVAL_SIZE for nfs
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2b-5bdc5131.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP; 04 Aug 2021 16:48:33 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2b-5bdc5131.us-west-2.amazon.com (Postfix) with ESMTPS id D5914A1C25;
        Wed,  4 Aug 2021 16:48:31 +0000 (UTC)
Received: from EX13D22UWB004.ant.amazon.com (10.43.161.165) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.23; Wed, 4 Aug 2021 16:48:31 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D22UWB004.ant.amazon.com (10.43.161.165) with Microsoft SMTP Server (TLS)
 id 15.0.1497.23; Wed, 4 Aug 2021 16:48:31 +0000
Received: from dev-dsk-fllinden-2c-d7720709.us-west-2.amazon.com
 (172.19.206.175) by mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP
 Server id 15.0.1497.23 via Frontend Transport; Wed, 4 Aug 2021 16:48:30 +0000
Received: by dev-dsk-fllinden-2c-d7720709.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 4D90DDF7; Wed,  4 Aug 2021 16:48:31 +0000 (UTC)
Date:   Wed, 4 Aug 2021 16:48:31 +0000
From:   Frank van der Linden <fllinden@amazon.com>
To:     Hao Xu <haoxu@linux.alibaba.com>
CC:     <fstests@vger.kernel.org>
Message-ID: <20210804164831.GA23998@dev-dsk-fllinden-2c-d7720709.us-west-2.amazon.com>
References: <20210804074148.203065-1-haoxu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210804074148.203065-1-haoxu@linux.alibaba.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Aug 04, 2021 at 03:41:48PM +0800, Hao Xu wrote:
> The block size of localfs for nfs may be different with nfs itself.
> So it's pointless to test nfs on xattrs size, just remove the special
> judge code.
> 
> Fixes: commit da3cdb3b91ca ("common/attr: set MAX_ATTR values correctly for NFS")
> Signed-off-by: Hao Xu <haoxu@linux.alibaba.com>
> ---
>  common/attr | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/common/attr b/common/attr
> index 42ceab92335a..542dff34bf55 100644
> --- a/common/attr
> +++ b/common/attr
> @@ -253,7 +253,7 @@ _getfattr()
> 
>  # set maximum total attr space based on fs type
>  case "$FSTYP" in
> -xfs|udf|pvfs2|9p|ceph|nfs)
> +xfs|udf|pvfs2|9p|ceph)
>         MAX_ATTRS=1000
>         ;;
>  *)
> @@ -273,7 +273,7 @@ xfs|udf|btrfs)
>  pvfs2)
>         MAX_ATTRVAL_SIZE=8192
>         ;;
> -9p|ceph|nfs)
> +9p|ceph)
>         MAX_ATTRVAL_SIZE=65536
>         ;;
>  bcachefs)
> --
> 2.24.4
> 

That doesn't quite work either, right? You have now removed the specific
values set for NFS, but the defaults will still be used (which may also
be wrong).

It seems to me that there are two ways that this can be dealt with:

1) Find a way to determine the maximum attribute size over an NFS mount,
   possibly by trying different sizes. If it doesn't work out, skip the test
2) Always skip the test.

- Frank
