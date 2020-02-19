Return-Path: <SRS0=KIFJ=4H=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F6B4C34047
	for <linux-fstests@archiver.kernel.org>; Wed, 19 Feb 2020 11:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDE3C24654
	for <linux-fstests@archiver.kernel.org>; Wed, 19 Feb 2020 11:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E8qrwkCP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgBSLmo (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 19 Feb 2020 06:42:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27711 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726497AbgBSLmo (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 19 Feb 2020 06:42:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582112563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Bamd9BwqtT0HwP6VQbAkIkPUq9oksnyyeDmVV7A443Q=;
        b=E8qrwkCPP+h32oi9k1HIovnsU39pE3NPJY9xJ3V/lXO2BYJTdxEshk9BYiH4+zGZ8Jqc1A
        ENuNSl/ASl0L4CpAea0/T8U2WRwCp8N6lWj8tsxmubTwTWvnuCDuC21G7e9JxE0Y7ngrG5
        lZBIB6ej0DPaIzLrx4mA8LKAjAkyYKc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-MLhSs_OVOPGvywHmmkFWYA-1; Wed, 19 Feb 2020 06:42:38 -0500
X-MC-Unique: MLhSs_OVOPGvywHmmkFWYA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F0B5DB60;
        Wed, 19 Feb 2020 11:42:37 +0000 (UTC)
Received: from localhost (dhcp-12-102.nay.redhat.com [10.66.12.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BDADB89F3B;
        Wed, 19 Feb 2020 11:42:36 +0000 (UTC)
Date:   Wed, 19 Feb 2020 19:52:57 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: add perf to the list of test directories
Message-ID: <20200219115257.GC14282@dhcp-12-102.nay.redhat.com>
Mail-Followup-To: Josef Bacik <josef@toxicpanda.com>,
        fstests@vger.kernel.org
References: <20200218142945.3719579-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218142945.3719579-1-josef@toxicpanda.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Feb 18, 2020 at 09:29:45AM -0500, Josef Bacik wrote:
> I noticed that despite having PERF_CONFIGNAME set I wasn't getting the
> perf/ tests run when I used -g auto.  This is because it's not included
> in the list of directories to look at.  Fix this so that perf tests get
> run as well.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  check | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/check b/check
> index 89f3358a..9e7b6134 100755
> --- a/check
> +++ b/check
> @@ -44,7 +44,7 @@ timestamp=${TIMESTAMP:=false}
>  
>  rm -f $tmp.list $tmp.tmp $tmp.grep $here/$iam.out $tmp.xlist $tmp.report.*
>  
> -SRC_GROUPS="generic shared"
> +SRC_GROUPS="generic shared perf"

Looks good to me, if the maintainer won't prefer moving perf/001 to generic/ :)

Thanks,
Zorro

>  export SRC_DIR="tests"
>  
>  usage()
> -- 
> 2.24.1
> 

